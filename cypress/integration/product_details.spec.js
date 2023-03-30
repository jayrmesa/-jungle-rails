describe("Testing Home Page", () => {
  before(() => {
    cy.visit("0.0.0.0:3000"); // Visits the Home Page
  })

  it("able to visit from product page", () => {
    cy.get(".products article")
      .first()
      .click();

      cy.contains(".product-detail", "Add");
  });
});