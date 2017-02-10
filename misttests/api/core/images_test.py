from misttests.api.helpers import *
from misttests import config


############################################################################
#                             Unit Testing                                 #
############################################################################


def test_add_cloud_ok(pretty_print, cache, mist_core, owner_api_token):
    response = mist_core.add_cloud('Linode', 'linode', api_token=owner_api_token,
                                   api_key=config.CREDENTIALS['LINODE']['api_key']).post()
    assert_response_ok(response)
    response = mist_core.list_clouds(api_token=owner_api_token).get()
    assert_response_ok(response)
    assert len(response.json()) == 1
    cache.set('cloud_id', response.json()[0]['id'])
    print "Success!!!"


# needs to change in the backend
def test_list_images(pretty_print, mist_core, owner_api_token, cache):
    response = mist_core.list_images(cloud_id=cache.get('cloud_id',''), api_token=owner_api_token).post()
    assert_response_ok(response)
    print "Success!!!"


def test_list_images_wrong_api_token(pretty_print, mist_core, cache, owner_api_token):
    response = mist_core.list_images(cloud_id=cache.get('cloud_id', ''), api_token=owner_api_token + 'dummy').post()
    assert_response_unauthorized(response)
    print "Success!!!"


def test_list_images_no_api_token(pretty_print, cache, mist_core):
    response = mist_core.list_images(cloud_id=cache.get('cloud_id', '')).post()
    assert_response_forbidden(response)
    print "Success!!!"


# def test_list_images_wrong_cloud_id(pretty_print, mist_core, owner_api_token):
#     response = mist_core.list_images(cloud_id='dummy', api_token=owner_api_token).post()
#     assert_response_not_found(response)
#     print "Success!!!"

