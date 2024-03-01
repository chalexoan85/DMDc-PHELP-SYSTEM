DMDc-PHELP-SYSTEM

The identiﬁcation of multivariable systems can be challenging due to the complex and coupled dynamics between system inputs and outputs. Thus, traditional system identiﬁcation like multivariable transfer function may not capture the overall system dynamics relevant for an adequate controller design. This paper presents the use of Dynamic Model Decomposition with Control (DMDc) to identify a model for a high-order multivariable system corresponding to a 16x16 multivariable thermal system with coupled dynamics. The system is controlled using a Linear Quadratic Regulator (LQR) with the ν-gap metric controller. Obtained results show that the model obtained using DMDc corresponds to an accurate representation of the system and contributes to performing suitable temperature control.

The paper related to this data will available soon...

PHELP_DMDc.m contain all the code

Inside this code, you will run the identification of the PHELP system with and without know the B matrix of the model. For DMDc with B matrix unknown, the script calls the function DMDc_B_unknown, passing the identification data (output, input). The function DMDc_B_known is called passing (output, input, matrix B) variables for B known.
