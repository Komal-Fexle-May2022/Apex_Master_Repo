// This class contain description of employee discount through company.
// this class interface with PurchaseInterface
public class EmployeePurchaseOrderController implements PurchaseOrder {
    public Double discount(){
        System.debug('This provide discount to employee::');
        return .10;
    }
}