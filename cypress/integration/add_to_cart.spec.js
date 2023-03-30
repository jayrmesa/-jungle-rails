describe("Testing Home Page", () => {
  before(() => {
    cy.visit("0.0.0.0:3000"); // Visits the Home Page
  })

  it("add product from home page and see cart increase by 1", () => {
    cy.get(".end-0").should(
      "include.text",
      "My Cart (0)"
    );

    cy.contains("button", "Add")
      .first()
      .click({ force: true });
    
    cy.get(".end-0").should(
      "include.text",
      "My Cart (1)"
    );
  });
});