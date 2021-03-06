# The controller defined below is the attribute controller,
#
#  Some methods are stubbed out for you to implement them from scratch
# while others may contain one or two bugs
#
# NB: Check the BACKEND CHALLENGE TEMPLATE DOCUMENTATION linked in the readme of this repository
# to see our recommended endpoints, request body/param, and response object for each of these method

class AttributeController < ApplicationController
  # get all attributes
  def get_all_attributes
    attribute = Attribute.all()
    json_response(attribute)
  end

  # get a single attribute using the attribute_id in the request parameter
  def get_single_attribute
    single_attribute = Attribute.find(params[:attribute_id])
    if single_attribute
      json_response(single_attribute)
    else
      json_response({message: "Attribute not found"}, 404)
    end
  end

  # get all attribute values of a single attribute using the attribute id
  def get_attribute_values
    attribute_value = AttributeValue.where("attribute_id = ? ", params[:attribute_id] )
    if attribute_value
      json_response(attribute_value)
    else
      json_response({message: "Attribute value not found"}, 404)
    end
  end

  # get all the attributes for a product
  def get_product_attributes
    
    attribute_value = StoredProcedureService.new.execute("catalog_get_product_attributes", "'#{params[:product_id]}'")
    if attribute_value
      json_response(attribute_value)
    else
      json_response({message: "Attribute value not found"}, 404)
    end
  end

end
