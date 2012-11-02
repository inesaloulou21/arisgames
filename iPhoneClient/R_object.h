/*==============================================================================
Copyright (c) 2012 QUALCOMM Austria Research Center GmbH .
All Rights Reserved.
Qualcomm Confidential and Proprietary
==============================================================================*/


#ifndef _R_OBJECT_H_
#define _R_OBJECT_H_


#define NUM_R_OBJECT_VERTEX 380
#define NUM_R_OBJECT_INDEX 432 * 3


static const float RobjectVertices[NUM_R_OBJECT_VERTEX * 3] =
{
    2.008290, -0.050000, 0.882192,  1.931250, 0.000000, 0.982192,  1.818130, -0.050000, 0.882192,  1.787500, 0.000000, 0.982192,  0.200000, 1.466669, 0.982192,  0.200000, 2.199999, 0.982192,  0.150000, 1.483329, 0.882192,  0.150000, 2.249999, 0.882192,  1.861480, 1.912629, 0.882192,  1.818060, 1.887499, 0.982192,  1.927870, 1.745319, 0.882192,  1.879510, 1.732029, 0.982192,  1.779690, 1.076799, 0.882192,  1.722220, 1.103819, 0.982192,  1.566790, 0.940169, 0.882192,  1.500000, 0.967189, 0.982192,  1.643750, 0.644790, 0.982192,  1.787500, 0.322400, 0.982192,  1.702290, 0.636280, 0.882192,  1.849460, 0.306220, 0.882192,  1.643750, 0.644790, -0.000877,  1.702290, 0.636280, 0.099123,  1.787500, 0.322400, -0.000877,  1.849460, 0.306220, 0.099123,  1.931250, 0.000000, -0.000877,  2.008290, -0.050000, 0.099123,  2.008290, -0.050000, 0.882192,  1.931250, 0.000000, 0.982192,  1.500000, 0.967189, -0.000877,  1.722220, 1.103819, -0.000877,  1.566790, 0.940169, 0.099123,  1.779690, 1.076799, 0.099123,  1.500000, 0.967189, -0.000877,  1.566790, 0.940169, 0.099123,  1.566790, 0.940169, 0.882192,  1.500000, 0.967189, 0.982192,  1.900000, 1.553129, 0.982192,  1.855560, 1.299129, 0.982192,  1.950000, 1.553129, 0.882192,  1.907420, 1.281119, 0.882192,  1.900000, 1.553129, -0.000877,  1.950000, 1.553129, 0.099123,  1.855560, 1.299129, -0.000877,  1.907420, 1.281119, 0.099123,  1.722220, 1.103819, -0.000877,  1.779690, 1.076799, 0.099123,  1.779690, 1.076799, 0.882192,  1.722220, 1.103819, 0.982192,  1.879510, 1.732029, -0.000877,  1.818060, 1.887499, -0.000877,  1.927870, 1.745319, 0.099123,  1.861480, 1.912629, 0.099123,  1.139060, 2.199999, 0.982192,  1.377430, 2.179949, 0.982192,  1.139060, 2.249999, 0.882192,  1.390410, 2.228339, 0.882192,  1.569620, 2.119789, 0.982192,  1.715630, 2.019529, 0.982192,  1.594330, 2.163349, 0.882192,  1.750820, 2.055049, 0.882192,  1.569620, 2.119789, -0.000877,  1.594330, 2.163349, 0.099123,  1.715630, 2.019529, -0.000877,  1.750820, 2.055049, 0.099123,  1.715630, 2.019529, -0.000877,  1.750820, 2.055049, 0.099123,  1.750820, 2.055049, 0.882192,  1.715630, 2.019529, 0.982192,  1.139060, 2.199999, -0.000877,  1.139060, 2.249999, 0.099123,  1.377430, 2.179949, -0.000877,  1.390410, 2.228339, 0.099123,  0.490800, 2.249999, 0.882192,  0.513020, 2.199999, 0.982192,  0.820490, 2.249999, 0.882192,  0.826040, 2.199999, 0.982192,  0.826040, 2.199999, -0.000877,  0.513020, 2.199999, -0.000877,  0.820490, 2.249999, 0.099123,  0.490800, 2.249999, 0.099123,  0.200000, 1.466669, -0.000877,  0.150000, 1.483329, 0.099123,  0.200000, 2.199999, -0.000877,  0.150000, 2.249999, 0.099123,  0.200000, 2.199999, -0.000877,  0.150000, 2.249999, 0.099123,  0.150000, 2.249999, 0.882192,  0.200000, 2.199999, 0.982192,  0.600000, 0.899999, 0.982192,  0.600000, 0.600000, 0.982192,  0.650000, 0.849999, 0.882192,  0.650000, 0.572220, 0.882192,  0.483330, -0.050000, 0.882192,  0.466670, 0.000000, 0.982192,  0.316670, -0.050000, 0.882192,  0.333330, 0.000000, 0.982192,  0.150000, -0.050000, 0.882192,  0.200000, 0.000000, 0.982192,  0.150000, 0.716669, 0.882192,  0.200000, 0.733330, 0.982192,  0.200000, 0.733330, -0.000877,  0.200000, 0.000000, -0.000877,  0.150000, 0.716670, 0.099123,  0.150000, -0.050000, 0.099123,  0.333330, 0.000000, -0.000877,  0.466670, 0.000000, -0.000877,  0.316670, -0.050000, 0.099123,  0.483330, -0.050000, 0.099123,  0.200000, 0.000000, -0.000877,  0.150000, -0.050000, 0.099123,  0.150000, -0.050000, 0.882192,  0.200000, 0.000000, 0.982192,  0.600000, 0.300000, 0.982192,  0.600000, 0.000000, 0.982192,  0.650000, 0.272220, 0.882192,  0.650000, -0.050000, 0.882192,  0.600000, 0.300000, -0.000877,  0.650000, 0.272220, 0.099123,  0.600000, 0.000000, -0.000877,  0.650000, -0.050000, 0.099123,  0.600000, 0.000000, -0.000877,  0.650000, -0.050000, 0.099123,  0.650000, -0.050000, 0.882192,  0.600000, 0.000000, 0.982192,  0.600000, 0.899999, -0.000877,  0.650000, 0.850000, 0.099123,  0.600000, 0.600000, -0.000877,  0.650000, 0.572220, 0.099123,  1.194970, 0.563200, 0.882192,  1.233330, 0.600000, 0.982192,  1.067510, 0.849999, 0.882192,  1.100000, 0.899999, 0.982192,  0.924450, 0.849999, 0.882192,  0.933330, 0.899999, 0.982192,  0.785280, 0.849999, 0.882192,  0.766670, 0.899999, 0.982192,  0.766670, 0.899999, -0.000877,  0.933330, 0.899999, -0.000877,  0.785280, 0.850000, 0.099123,  0.924450, 0.850000, 0.099123,  0.600000, 0.899999, -0.000877,  0.650000, 0.850000, 0.099123,  0.650000, 0.849999, 0.882192,  0.600000, 0.899999, 0.982192,  1.100000, 0.899999, -0.000877,  1.233330, 0.600000, -0.000877,  1.067510, 0.850000, 0.099123,  1.194970, 0.563200, 0.099123,  1.100000, 0.899999, -0.000877,  1.067510, 0.850000, 0.099123,  1.067510, 0.849999, 0.882192,  1.100000, 0.899999, 0.982192,  1.467510, -0.050000, 0.882192,  1.500000, 0.000000, 0.982192,  1.328310, 0.263200, 0.882192,  1.366670, 0.300000, 0.982192,  1.366670, 0.300000, -0.000877,  1.500000, 0.000000, -0.000877,  1.328310, 0.263200, 0.099123,  1.467510, -0.050000, 0.099123,  1.787500, 0.000000, -0.000877,  1.931250, 0.000000, -0.000877,  1.818130, -0.050000, 0.099123,  2.008290, -0.050000, 0.099123,  1.643750, 0.000000, -0.000877,  1.637870, -0.050000, 0.099123,  1.500000, 0.000000, -0.000877,  1.467510, -0.050000, 0.099123,  1.643750, 0.000000, 0.982192,  1.500000, 0.000000, 0.982192,  1.637870, -0.050000, 0.882192,  1.467510, -0.050000, 0.882192,  0.600000, 1.199999, 0.982192,  0.761460, 1.199999, 0.982192,  0.650000, 1.249999, 0.882192,  0.783680, 1.249999, 0.882192,  1.454860, 1.735939, 0.982192,  1.398440, 1.805469, 0.982192,  1.411600, 1.710319, 0.882192,  1.363600, 1.769589, 0.882192,  0.949310, 1.849999, 0.882192,  0.943750, 1.899999, 0.982192,  0.794100, 1.849999, 0.882192,  0.771880, 1.899999, 0.982192,  0.650000, 1.649999, 0.882192,  0.600000, 1.666669, 0.982192,  0.650000, 1.449999, 0.882192,  0.600000, 1.433329, 0.982192,  0.600000, 1.433329, -0.000877,  0.600000, 1.666669, -0.000877,  0.650000, 1.449999, 0.099123,  0.650000, 1.649999, 0.099123,  0.600000, 1.199999, -0.000877,  0.650000, 1.249999, 0.099123,  0.650000, 1.249999, 0.882192,  0.600000, 1.199999, 0.982192,  0.771880, 1.899999, -0.000877,  0.943750, 1.899999, -0.000877,  0.794100, 1.849999, 0.099123,  0.949310, 1.849999, 0.099123,  0.600000, 1.899999, -0.000877,  0.650000, 1.849999, 0.099123,  0.600000, 1.899999, -0.000877,  0.650000, 1.849999, 0.099123,  0.600000, 1.899999, 0.982192,  0.650000, 1.849999, 0.882192,  0.650000, 1.849999, 0.882192,  0.600000, 1.899999, 0.982192,  1.227600, 1.889499, 0.982192,  1.115630, 1.899999, 0.982192,  1.214990, 1.841069, 0.882192,  1.115630, 1.849999, 0.882192,  1.227600, 1.889499, -0.000877,  1.214990, 1.841069, 0.099123,  1.115630, 1.899999, -0.000877,  1.115630, 1.849999, 0.099123,  1.454860, 1.735939, -0.000877,  1.411600, 1.710319, 0.099123,  1.398440, 1.805469, -0.000877,  1.363600, 1.769589, 0.099123,  1.321880, 1.857989, -0.000877,  1.297650, 1.814259, 0.099123,  1.398440, 1.805469, -0.000877,  1.363600, 1.769589, 0.099123,  1.321880, 1.857989, 0.982192,  1.297650, 1.814259, 0.882192,  1.363600, 1.769589, 0.882192,  1.398440, 1.805469, 0.982192,  1.362090, 1.331249, 0.882192,  1.396880, 1.295309, 0.982192,  1.410930, 1.392539, 0.882192,  1.454170, 1.366839, 0.982192,  1.450000, 1.557809, 0.882192,  1.500000, 1.557809, 0.982192,  1.440400, 1.639729, 0.882192,  1.488720, 1.653389, 0.982192,  1.488720, 1.653389, -0.000877,  1.500000, 1.557809, -0.000877,  1.440400, 1.639729, 0.099123,  1.450000, 1.557809, 0.099123,  1.454170, 1.366839, -0.000877,  1.396880, 1.295309, -0.000877,  1.410930, 1.392539, 0.099123,  1.362090, 1.331249, 0.099123,  1.488540, 1.454339, -0.000877,  1.440230, 1.468059, 0.099123,  1.488540, 1.454339, 0.982192,  1.440230, 1.468059, 0.882192,  1.084380, 1.249999, 0.882192,  1.084380, 1.199999, 0.982192,  1.199590, 1.259029, 0.882192,  1.212150, 1.210589, 0.982192,  1.212150, 1.210589, -0.000877,  1.084380, 1.199999, -0.000877,  1.199590, 1.259029, 0.099123,  1.084380, 1.249999, 0.099123,  1.396880, 1.295309, -0.000877,  1.316320, 1.242359, -0.000877,  1.362090, 1.331249, 0.099123,  1.292160, 1.286109, 0.099123,  1.396880, 1.295309, 0.982192,  1.362090, 1.331249, 0.882192,  1.316320, 1.242359, 0.982192,  1.292160, 1.286109, 0.882192,  0.600000, 1.199999, -0.000877,  0.650000, 1.249999, 0.099123,  0.761460, 1.199999, -0.000877,  0.783680, 1.249999, 0.099123,  0.922920, 1.199999, -0.000877,  0.928470, 1.249999, 0.099123,  0.922920, 1.199999, 0.982192,  0.928470, 1.249999, 0.882192,  1.931250, 0.000000, -0.000877,  1.787500, 0.000000, -0.000877,  1.787500, 0.322400, -0.000877,  1.643750, 0.000000, -0.000877,  0.600000, 0.000000, -0.000877,  0.466670, 0.000000, -0.000877,  0.600000, 0.300000, -0.000877,  0.200000, 0.000000, -0.000877,  0.200000, 0.733330, -0.000877,  0.333330, 0.000000, -0.000877,  0.200000, 2.199999, -0.000877,  0.513020, 2.199999, -0.000877,  0.200000, 1.466669, -0.000877,  0.600000, 0.600000, -0.000877,  0.600000, 0.899999, -0.000877,  1.500000, 0.000000, -0.000877,  1.366670, 0.300000, -0.000877,  1.643750, 0.644790, -0.000877,  1.233330, 0.600000, -0.000877,  1.500000, 0.967189, -0.000877,  1.100000, 0.899999, -0.000877,  0.826040, 2.199999, -0.000877,  0.600000, 1.899999, -0.000877,  0.600000, 1.666669, -0.000877,  0.771880, 1.899999, -0.000877,  0.600000, 1.433329, -0.000877,  0.943750, 1.899999, -0.000877,  1.139060, 2.199999, -0.000877,  1.115630, 1.899999, -0.000877,  1.377430, 2.179949, -0.000877,  1.227600, 1.889499, -0.000877,  1.321880, 1.857989, -0.000877,  1.569620, 2.119789, -0.000877,  1.398440, 1.805469, -0.000877,  1.715630, 2.019529, -0.000877,  1.454860, 1.735939, -0.000877,  1.818060, 1.887499, -0.000877,  1.879510, 1.732029, -0.000877,  1.488720, 1.653389, -0.000877,  1.900000, 1.553129, -0.000877,  1.500000, 1.557809, -0.000877,  1.855560, 1.299129, -0.000877,  1.488540, 1.454339, -0.000877,  1.722220, 1.103819, -0.000877,  1.454170, 1.366839, -0.000877,  1.396880, 1.295309, -0.000877,  1.316320, 1.242359, -0.000877,  1.212150, 1.210589, -0.000877,  1.084380, 1.199999, -0.000877,  0.933330, 0.899999, -0.000877,  0.922920, 1.199999, -0.000877,  0.766670, 0.899999, -0.000877,  0.761460, 1.199999, -0.000877,  0.600000, 1.199999, -0.000877,  1.931250, 0.000000, 0.982192,  1.787500, 0.322400, 0.982192,  1.787500, 0.000000, 0.982192,  1.643750, 0.000000, 0.982192,  0.200000, 2.199999, 0.982192,  0.200000, 1.466669, 0.982192,  0.513020, 2.199999, 0.982192,  0.200000, 0.000000, 0.982192,  0.333330, 0.000000, 0.982192,  0.200000, 0.733330, 0.982192,  0.600000, 0.000000, 0.982192,  0.600000, 0.300000, 0.982192,  0.466670, 0.000000, 0.982192,  0.600000, 0.600000, 0.982192,  0.600000, 0.899999, 0.982192,  0.826040, 2.199999, 0.982192,  0.600000, 1.899999, 0.982192,  0.600000, 1.666669, 0.982192,  0.771880, 1.899999, 0.982192,  0.600000, 1.433329, 0.982192,  0.943750, 1.899999, 0.982192,  1.139060, 2.199999, 0.982192,  1.115630, 1.899999, 0.982192,  1.377430, 2.179949, 0.982192,  1.227600, 1.889499, 0.982192,  1.321880, 1.857989, 0.982192,  1.569620, 2.119789, 0.982192,  1.398440, 1.805469, 0.982192,  1.715630, 2.019529, 0.982192,  1.454860, 1.735939, 0.982192,  1.818060, 1.887499, 0.982192,  1.879510, 1.732029, 0.982192,  1.488720, 1.653389, 0.982192,  1.900000, 1.553129, 0.982192,  1.500000, 1.557809, 0.982192,  1.855560, 1.299129, 0.982192,  1.488540, 1.454339, 0.982192,  1.722220, 1.103819, 0.982192,  1.454170, 1.366839, 0.982192,  1.500000, 0.967189, 0.982192,  1.396880, 1.295309, 0.982192,  1.316320, 1.242359, 0.982192,  0.600000, 1.199999, 0.982192,  0.761460, 1.199999, 0.982192,  0.766670, 0.899999, 0.982192,  0.922920, 1.199999, 0.982192,  0.933330, 0.899999, 0.982192,  1.084380, 1.199999, 0.982192,  1.100000, 0.899999, 0.982192,  1.212150, 1.210589, 0.982192,  1.233330, 0.600000, 0.982192,  1.643750, 0.644790, 0.982192,  1.366670, 0.300000, 0.982192,  1.500000, 0.000000, 0.982192
};

static const float RobjectTexCoords[NUM_R_OBJECT_VERTEX * 2] =
{
    0.790001, 0.795853,  0.771362, 0.773301,  0.746388, 0.834364,  0.736582, 0.773301,  0.255825, 0.005894,  0.377102, 0.005894,  0.258580, 0.108994,  0.385370, 0.029244,  0.151218, 0.368698,  0.152988, 0.262385,  0.118863, 0.341286,  0.124608, 0.262385,  0.609761, 0.929175,  0.633076, 0.942701,  0.609761, 0.979281,  0.633076, 0.995000,  0.383450, 0.336853,  0.383450, 0.412132,  0.302851, 0.344950,  0.334023, 0.422020,  0.203997, 0.336853,  0.253424, 0.344950,  0.203997, 0.412132,  0.284596, 0.422020,  0.203997, 0.487414,  0.222251, 0.499090,  0.365196, 0.499090,  0.383450, 0.487414,  0.403874, 0.995000,  0.403874, 0.942701,  0.427189, 0.979281,  0.427189, 0.929175,  0.203997, 0.261571,  0.222251, 0.267880,  0.365196, 0.267880,  0.383450, 0.261571,  0.091951, 0.262385,  0.045585, 0.262385,  0.084739, 0.341286,  0.044869, 0.327581,  0.091951, 0.499090,  0.084739, 0.420188,  0.045585, 0.499090,  0.044869, 0.392776,  0.009932, 0.499090,  0.005000, 0.475011,  0.005000, 0.286463,  0.009932, 0.262385,  0.124608, 0.499090,  0.152988, 0.499090,  0.118863, 0.420188,  0.151218, 0.433894,  0.863788, 0.526370,  0.913105, 0.526370,  0.849629, 0.600269,  0.901249, 0.600269,  0.952867, 0.526370,  0.983075, 0.526370,  0.945804, 0.625943,  0.990355, 0.548921,  0.952867, 0.748069,  0.945804, 0.687006,  0.983075, 0.748069,  0.990355, 0.725517,  0.177089, 0.499090,  0.183573, 0.475011,  0.183573, 0.286463,  0.177089, 0.262385,  0.863788, 0.748069,  0.849629, 0.674169,  0.913105, 0.748069,  0.901249, 0.674169,  0.722658, 0.625943,  0.734267, 0.526370,  0.786146, 0.600269,  0.799028, 0.526370,  0.799028, 0.748069,  0.734267, 0.748069,  0.786146, 0.674169,  0.722658, 0.687006,  0.255825, 0.235445,  0.258580, 0.172220,  0.377102, 0.235445,  0.385370, 0.212095,  0.669506, 0.748069,  0.659162, 0.725517,  0.659162, 0.548921,  0.669506, 0.526370,  0.383495, 0.773170,  0.383495, 0.843222,  0.365281, 0.784846,  0.334177, 0.854897,  0.530132, 0.824393,  0.633076, 0.828314,  0.569947, 0.863618,  0.633076, 0.859696,  0.005000, 0.029244,  0.013269, 0.005894,  0.131790, 0.069119,  0.134546, 0.005894,  0.134546, 0.235445,  0.013269, 0.235445,  0.131790, 0.132345,  0.005000, 0.212095,  0.403874, 0.859696,  0.403874, 0.828314,  0.506817, 0.863618,  0.467003, 0.824393,  0.403874, 0.891075,  0.427189, 0.902843,  0.609761, 0.902843,  0.633076, 0.891075,  0.383495, 0.913273,  0.383495, 0.983325,  0.303073, 0.924949,  0.365281, 0.995000,  0.204437, 0.913273,  0.253755, 0.924949,  0.204437, 0.983325,  0.222651, 0.995000,  0.403874, 0.796935,  0.427189, 0.785168,  0.609761, 0.785168,  0.633076, 0.796935,  0.204437, 0.773170,  0.222651, 0.784846,  0.204437, 0.843222,  0.284859, 0.854897,  0.303073, 0.606942,  0.383495, 0.595267,  0.365281, 0.536891,  0.383495, 0.525215,  0.472062, 0.631385,  0.472836, 0.527470,  0.443527, 0.591195,  0.438356, 0.527470,  0.438356, 0.758836,  0.472836, 0.758836,  0.443527, 0.654920,  0.472062, 0.695110,  0.403874, 0.758836,  0.414218, 0.735301,  0.414218, 0.551005,  0.403874, 0.527470,  0.204437, 0.525215,  0.204437, 0.595267,  0.222651, 0.536891,  0.253755, 0.606942,  0.507319, 0.758836,  0.500597, 0.735301,  0.500597, 0.551005,  0.507319, 0.527470,  0.365281, 0.747045,  0.383495, 0.735370,  0.334177, 0.676993,  0.383495, 0.665318,  0.204437, 0.665318,  0.204437, 0.735370,  0.284859, 0.676993,  0.222651, 0.747045,  0.736582, 0.995000,  0.771362, 0.995000,  0.746388, 0.895426,  0.790001, 0.972448,  0.701802, 0.995000,  0.702775, 0.933937,  0.667023, 0.995000,  0.659162, 0.972448,  0.701802, 0.773301,  0.667023, 0.773301,  0.702775, 0.872875,  0.659162, 0.795853,  0.184058, 0.995000,  0.184058, 0.950984,  0.165844, 0.981369,  0.134740, 0.941896,  0.621629, 0.527470,  0.636014, 0.527470,  0.618679, 0.631385,  0.628591, 0.551005,  0.124372, 0.649002,  0.184058, 0.653546,  0.134740, 0.691314,  0.184058, 0.700400,  0.926955, 0.834364,  0.929980, 0.773301,  0.879574, 0.834364,  0.873524, 0.773301,  0.873524, 0.995000,  0.929980, 0.995000,  0.879574, 0.895426,  0.926955, 0.895426,  0.817071, 0.995000,  0.829168, 0.972448,  0.829168, 0.795853,  0.817071, 0.773301,  0.005000, 0.700400,  0.005000, 0.653546,  0.085422, 0.691314,  0.064686, 0.649002,  0.986433, 0.995000,  0.974336, 0.972448,  0.005000, 0.747257,  0.023214, 0.733627,  0.986433, 0.773301,  0.974336, 0.795853,  0.165844, 0.733627,  0.184058, 0.747257,  0.184058, 0.576165,  0.184058, 0.606689,  0.124372, 0.594034,  0.124372, 0.621513,  0.005000, 0.576165,  0.064686, 0.594034,  0.005000, 0.606689,  0.064686, 0.621513,  0.621629, 0.758836,  0.618679, 0.695110,  0.636014, 0.758836,  0.628591, 0.735301,  0.005000, 0.550462,  0.054318, 0.566557,  0.005000, 0.529591,  0.023214, 0.539089,  0.184058, 0.550462,  0.103636, 0.566557,  0.165844, 0.539089,  0.184058, 0.529591,  0.537902, 0.551005,  0.530467, 0.527470,  0.548570, 0.591195,  0.545266, 0.527470,  0.584008, 0.604592,  0.584775, 0.527470,  0.601343, 0.604592,  0.604550, 0.527470,  0.604550, 0.758836,  0.584775, 0.758836,  0.601343, 0.681714,  0.584008, 0.681714,  0.545266, 0.758836,  0.530467, 0.758836,  0.548570, 0.654920,  0.537902, 0.735301,  0.563368, 0.758836,  0.566673, 0.681714,  0.563368, 0.527470,  0.566673, 0.604592,  0.124372, 0.873620,  0.184058, 0.862951,  0.124372, 0.844823,  0.184058, 0.828119,  0.005000, 0.828119,  0.005000, 0.862951,  0.064686, 0.844823,  0.064686, 0.873620,  0.005000, 0.777759,  0.005000, 0.799721,  0.023214, 0.787243,  0.054318, 0.816030,  0.184058, 0.777759,  0.165844, 0.787243,  0.184058, 0.799721,  0.103636, 0.816030,  0.005000, 0.995000,  0.023214, 0.981369,  0.005000, 0.950984,  0.085422, 0.941896,  0.005000, 0.906967,  0.064686, 0.902424,  0.184058, 0.906967,  0.124372, 0.902424,  0.690185, 0.501138,  0.666412, 0.501138,  0.666412, 0.428431,  0.642639, 0.501138,  0.470025, 0.501138,  0.447975, 0.501138,  0.470025, 0.433483,  0.403874, 0.501138,  0.403874, 0.335759,  0.425924, 0.501138,  0.403874, 0.005000,  0.455641, 0.005000,  0.403874, 0.170379,  0.470025, 0.365828,  0.470025, 0.298172,  0.618866, 0.501138,  0.596816, 0.433483,  0.642639, 0.355727,  0.574764, 0.365828,  0.618866, 0.283020,  0.552714, 0.298172,  0.507407, 0.005000,  0.470025, 0.072655,  0.470025, 0.125275,  0.498450, 0.072655,  0.470025, 0.177897,  0.526874, 0.072655,  0.559174, 0.005000,  0.555299, 0.072655,  0.598595, 0.009522,  0.573817, 0.075023,  0.589409, 0.082129,  0.630379, 0.023089,  0.602070, 0.093973,  0.654526, 0.045699,  0.611401, 0.109654,  0.671466, 0.075474,  0.681629, 0.110535,  0.617000, 0.128270,  0.685017, 0.150880,  0.618866, 0.149825,  0.677668, 0.208162,  0.616971, 0.173159,  0.655616, 0.252207,  0.611286, 0.192892,  0.601812, 0.209023,  0.588489, 0.220964,  0.571262, 0.228129,  0.550131, 0.230517,  0.525151, 0.298172,  0.523429, 0.230517,  0.497589, 0.298172,  0.496727, 0.230517,  0.470025, 0.230517,  0.995000, 0.501138,  0.971227, 0.428431,  0.971227, 0.501138,  0.947454, 0.501138,  0.708689, 0.005000,  0.708689, 0.170379,  0.760455, 0.005000,  0.708689, 0.501138,  0.730739, 0.501138,  0.708689, 0.335759,  0.774840, 0.501138,  0.774840, 0.433483,  0.752790, 0.501138,  0.774840, 0.365828,  0.774840, 0.298172,  0.812222, 0.005000,  0.774840, 0.072655,  0.774840, 0.125275,  0.803265, 0.072655,  0.774840, 0.177897,  0.831689, 0.072655,  0.863989, 0.005000,  0.860114, 0.072655,  0.903410, 0.009522,  0.878631, 0.075023,  0.894223, 0.082129,  0.935194, 0.023089,  0.906885, 0.093973,  0.959341, 0.045699,  0.916215, 0.109654,  0.976281, 0.075474,  0.986443, 0.110535,  0.921815, 0.128270,  0.989832, 0.150880,  0.923681, 0.149825,  0.982482, 0.208162,  0.921785, 0.173159,  0.960431, 0.252207,  0.916101, 0.192892,  0.923681, 0.283020,  0.906627, 0.209023,  0.893304, 0.220964,  0.774840, 0.230517,  0.801542, 0.230517,  0.802404, 0.298172,  0.828244, 0.230517,  0.829966, 0.298172,  0.854946, 0.230517,  0.857529, 0.298172,  0.876076, 0.228129,  0.879579, 0.365828,  0.947454, 0.355727,  0.901631, 0.433483,  0.923681, 0.501138
};

static const float RobjectNormals[NUM_R_OBJECT_VERTEX * 3] =
{
    0.806947, -0.523728, 0.273029,  0.617799, -0.400959, 0.676429,  0.000000, -0.961330, 0.275400,  0.000000, -0.894429, 0.447210,  -0.894429, -0.000000, 0.447209,  -0.577350, 0.577350, 0.577350,  -0.980440, -0.000000, 0.196820,  -0.670717, 0.670716, 0.316668,  0.857972, 0.490280, 0.153330,  0.776188, 0.443048, 0.448598,  0.926017, 0.257489, 0.276029,  0.876071, 0.178890, 0.447770,  0.709349, -0.668679, 0.222919,  0.550641, -0.661291, 0.509401,  0.875818, -0.258199, 0.407769,  0.779814, -0.228821, 0.582693,  0.816903, 0.364241, 0.447211,  0.816903, 0.364241, 0.447211,  0.895459, 0.399269, 0.196820,  0.878005, 0.391488, 0.275398,  0.816903, 0.364241, -0.447211,  0.878005, 0.391488, -0.275398,  0.816903, 0.364241, -0.447211,  0.895459, 0.399269, -0.196820,  0.617799, -0.400959, -0.676429,  0.769579, -0.499479, -0.397829,  0.806947, -0.523728, 0.273029,  0.617799, -0.400959, 0.676429,  0.779814, -0.228821, -0.582693,  0.550641, -0.661291, -0.509401,  0.911197, -0.269609, -0.311499,  0.698108, -0.644748, -0.311359,  0.779814, -0.228821, -0.582693,  0.911197, -0.269609, -0.311499,  0.875818, -0.258199, 0.407769,  0.779814, -0.228821, 0.582693,  0.894109, -0.026590, 0.447059,  0.814011, -0.314330, 0.488450,  0.971948, -0.021630, 0.234199,  0.907416, -0.338548, 0.248959,  0.894109, -0.026590, -0.447059,  0.950098, -0.021810, -0.311189,  0.814011, -0.314330, -0.488450,  0.924006, -0.344708, -0.165499,  0.550641, -0.661291, -0.509401,  0.698108, -0.644748, -0.311359,  0.709349, -0.668679, 0.222919,  0.550641, -0.661291, 0.509401,  0.876071, 0.178890, -0.447770,  0.776188, 0.443049, -0.448598,  0.946434, 0.255561, -0.197361,  0.844837, 0.482758, -0.230639,  0.037540, 0.893797, 0.446898,  0.140311, 0.883354, 0.447212,  0.041610, 0.972508, 0.229120,  0.207590, 0.938948, 0.274379,  0.351501, 0.821921, 0.448211,  0.579859, 0.680558, 0.447889,  0.449650, 0.871259, 0.196780,  0.680910, 0.678390, 0.275950,  0.351501, 0.821921, -0.448211,  0.447998, 0.850635, -0.275168,  0.579859, 0.680558, -0.447889,  0.688377, 0.697996, -0.197329,  0.579859, 0.680558, -0.447889,  0.688377, 0.697996, -0.197329,  0.680910, 0.678390, 0.275950,  0.579859, 0.680558, 0.447889,  0.037540, 0.893797, -0.446898,  0.040640, 0.951629, -0.304550,  0.140311, 0.883354, -0.447212,  0.205850, 0.958722, -0.196160,  0.000000, 0.980440, 0.196820,  0.000000, 0.894429, 0.447210,  0.000000, 0.961330, 0.275400,  0.000000, 0.894429, 0.447210,  0.000000, 0.894429, -0.447210,  0.000000, 0.894429, -0.447210,  0.000000, 0.980440, -0.196820,  0.000000, 0.961330, -0.275400,  -0.894429, 0.000000, -0.447209,  -0.952228, 0.000000, -0.305389,  -0.577350, 0.577350, -0.577350,  -0.690808, 0.690808, -0.213469,  -0.577350, 0.577350, -0.577350,  -0.690808, 0.690808, -0.213469,  -0.670717, 0.670716, 0.316668,  -0.577350, 0.577350, 0.577350,  0.577350, -0.577350, 0.577350,  0.894429, -0.000000, 0.447209,  0.670717, -0.670716, 0.316668,  0.961330, -0.000000, 0.275400,  0.000000, -0.980440, 0.196820,  0.000000, -0.894429, 0.447210,  0.000000, -0.952228, 0.305389,  0.000000, -0.894429, 0.447210,  -0.690808, -0.690808, 0.213469,  -0.577350, -0.577350, 0.577350,  -0.952228, -0.000000, 0.305389,  -0.894429, -0.000000, 0.447209,  -0.894429, 0.000000, -0.447209,  -0.577350, -0.577350, -0.577350,  -0.980440, 0.000000, -0.196820,  -0.670717, -0.670716, -0.316668,  0.000000, -0.894429, -0.447210,  0.000000, -0.894429, -0.447210,  0.000000, -0.973250, -0.229750,  0.000000, -0.961330, -0.275400,  -0.577350, -0.577350, -0.577350,  -0.670717, -0.670716, -0.316668,  -0.690808, -0.690808, 0.213469,  -0.577350, -0.577350, 0.577350,  0.894429, -0.000000, 0.447209,  0.577350, -0.577350, 0.577350,  0.980440, -0.000000, 0.196820,  0.670717, -0.670716, 0.316668,  0.894429, 0.000000, -0.447209,  0.961330, 0.000000, -0.275400,  0.577350, -0.577350, -0.577350,  0.690808, -0.690808, -0.213469,  0.577350, -0.577350, -0.577350,  0.690808, -0.690808, -0.213469,  0.670717, -0.670716, 0.316668,  0.577350, -0.577350, 0.577350,  0.577350, -0.577350, -0.577350,  0.643966, -0.643966, -0.413057,  0.894429, 0.000000, -0.447209,  0.980440, 0.000000, -0.196820,  -0.895939, -0.398189, 0.196820,  -0.817340, -0.363260, 0.447210,  -0.508951, -0.783161, 0.357250,  -0.468021, -0.720172, 0.512161,  0.000000, -0.988273, 0.152700,  0.000000, -0.894429, 0.447210,  0.000000, -0.961330, 0.275400,  0.000000, -0.894429, 0.447210,  0.000000, -0.894429, -0.447210,  0.000000, -0.894429, -0.447210,  0.000000, -0.980440, -0.196820,  0.000000, -0.973250, -0.229750,  0.577350, -0.577350, -0.577350,  0.643966, -0.643966, -0.413057,  0.670717, -0.670716, 0.316668,  0.577350, -0.577350, 0.577350,  -0.468021, -0.720172, -0.512161,  -0.817340, -0.363260, -0.447210,  -0.524523, -0.807114, -0.271002,  -0.878474, -0.390432, -0.275401,  -0.468021, -0.720172, -0.512161,  -0.524523, -0.807114, -0.271002,  -0.508951, -0.783161, 0.357250,  -0.468021, -0.720172, 0.512161,  -0.637380, -0.739790, 0.215540,  -0.468021, -0.720172, 0.512161,  -0.878474, -0.390432, 0.275401,  -0.817340, -0.363260, 0.447210,  -0.817340, -0.363260, -0.447210,  -0.468021, -0.720172, -0.512161,  -0.895939, -0.398189, -0.196820,  -0.417170, -0.882900, -0.215540,  0.000000, -0.894429, -0.447210,  0.617799, -0.400959, -0.676429,  0.000000, -0.980440, -0.196820,  0.769579, -0.499479, -0.397829,  0.000000, -0.894429, -0.447210,  0.000000, -0.952228, -0.305389,  -0.468021, -0.720172, -0.512161,  -0.417170, -0.882900, -0.215540,  0.000000, -0.894429, 0.447210,  -0.468021, -0.720172, 0.512161,  0.000000, -0.973250, 0.229750,  -0.637380, -0.739790, 0.215540,  0.577350, 0.577350, 0.577350,  0.000000, 0.894429, 0.447210,  0.670717, 0.670716, 0.316668,  0.000000, 0.961330, 0.275400,  -0.768386, -0.455847, 0.449207,  -0.637610, -0.627140, 0.447380,  -0.837279, -0.495509, 0.231160,  -0.630498, -0.725437, 0.276069,  0.000000, -0.980440, 0.196820,  0.000000, -0.894429, 0.447210,  0.000000, -0.961330, 0.275400,  0.000000, -0.894429, 0.447210,  0.983001, -0.000000, 0.183600,  0.894429, -0.000000, 0.447209,  0.961330, -0.000000, 0.275400,  0.894429, -0.000000, 0.447209,  0.894429, 0.000000, -0.447209,  0.894429, 0.000000, -0.447209,  0.980440, 0.000000, -0.196820,  0.983001, 0.000000, -0.183600,  0.577350, 0.577350, -0.577350,  0.643960, 0.643970, -0.413060,  0.670717, 0.670716, 0.316668,  0.577350, 0.577350, 0.577350,  0.000000, -0.894429, -0.447210,  0.000000, -0.894429, -0.447210,  0.000000, -0.980440, -0.196820,  0.000000, -0.961330, -0.275400,  0.577350, -0.577350, -0.577350,  0.643960, -0.643970, -0.413060,  0.577350, -0.577350, -0.577350,  0.643960, -0.643970, -0.413060,  0.577350, -0.577350, 0.577350,  0.670717, -0.670716, 0.316668,  0.670717, -0.670716, 0.316668,  0.577350, -0.577350, 0.577350,  -0.215700, -0.868838, 0.445639,  -0.041010, -0.894018, 0.446149,  -0.159610, -0.960047, 0.229859,  -0.043630, -0.972311, 0.229580,  -0.215700, -0.868838, -0.445639,  -0.197410, -0.952958, -0.230000,  -0.041010, -0.894018, -0.446149,  -0.044300, -0.987296, -0.152589,  -0.768386, -0.455847, -0.449207,  -0.818929, -0.484789, -0.307139,  -0.637604, -0.627144, -0.447383,  -0.649083, -0.734653, -0.197421,  -0.434250, -0.782631, -0.446000,  -0.399869, -0.874008, -0.276069,  -0.637604, -0.627144, -0.447383,  -0.649083, -0.734653, -0.197421,  -0.434249, -0.782627, 0.446008,  -0.414610, -0.888329, 0.197410,  -0.630498, -0.725437, 0.276069,  -0.637610, -0.627140, 0.447380,  -0.655991, 0.718631, 0.230750,  -0.636372, 0.628182, 0.447681,  -0.824593, 0.474961, 0.307341,  -0.773163, 0.447601, 0.449302,  -0.982607, -0.027240, 0.183689,  -0.894642, -0.003470, 0.446771,  -0.936603, -0.215471, 0.276311,  -0.854439, -0.262640, 0.448279,  -0.854441, -0.262630, -0.448280,  -0.894642, -0.003470, -0.446771,  -0.953603, -0.227171, -0.197571,  -0.982798, 0.019110, -0.183690,  -0.773163, 0.447602, -0.449301,  -0.636372, 0.628182, -0.447681,  -0.843170, 0.485340, -0.231320,  -0.613630, 0.755219, -0.230440,  -0.857982, 0.251430, -0.447940,  -0.939063, 0.204511, -0.276291,  -0.857982, 0.251430, 0.447940,  -0.956268, 0.215699, 0.197549,  -0.046450, 0.981923, 0.183491,  -0.036020, 0.894312, 0.445991,  -0.155469, 0.948675, 0.275399,  -0.196521, 0.873874, 0.444662,  -0.196521, 0.873874, -0.444662,  -0.036020, 0.894312, -0.445991,  -0.164040, 0.966607, -0.196879,  -0.030400, 0.982551, -0.183490,  -0.636372, 0.628182, -0.447681,  -0.416420, 0.792661, -0.445290,  -0.613630, 0.755219, -0.230440,  -0.377208, 0.884056, -0.275969,  -0.636372, 0.628182, 0.447681,  -0.655991, 0.718631, 0.230750,  -0.416420, 0.792661, 0.445290,  -0.391622, 0.898715, 0.197341,  0.577350, 0.577350, -0.577350,  0.643960, 0.643970, -0.413060,  0.000000, 0.894429, -0.447210,  0.000000, 0.980440, -0.196820,  0.000000, 0.894429, -0.447210,  0.000000, 0.961330, -0.275400,  0.000000, 0.894429, 0.447210,  0.000000, 0.980440, 0.196820,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, 0.000000, -1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000,  0.000000, -0.000000, 1.000000
};

static const unsigned short RobjectIndices[NUM_R_OBJECT_INDEX] =
{
    0,1,2, 2,1,3, 4,5,6, 6,5,7, 8,9,10, 10,9,11, 12,13,14, 14,13,15, 16,17,18, 18,17,19, 20,21,22, 22,21,23, 22,23,24, 24,23,25, 21,18,23, 23,18,19, 19,26,23, 23,26,25, 17,27,19, 19,27,26, 28,29,30, 30,29,31, 32,33,20, 20,33,21, 31,12,30, 30,12,14, 34,18,33, 33,18,21, 35,16,34, 34,16,18, 36,37,38, 38,37,39, 40,41,42, 42,41,43, 44,42,45, 45,42,43, 41,38,43, 43,38,39, 39,46,43, 43,46,45, 47,46,37, 37,46,39, 48,49,50, 50,49,51, 40,48,41, 41,48,50, 51,8,50, 50,8,10, 10,38,50, 50,38,41, 36,38,11, 11,38,10, 52,53,54, 54,53,55, 56,57,58, 58,57,59, 60,61,62, 62,61,63, 64,65,49, 49,65,51, 61,58,63, 63,58,59, 66,8,65, 65,8,51, 67,9,66, 66,9,8, 68,69,70, 70,69,71, 70,71,60, 60,71,61, 69,54,71, 71,54,55, 55,58,71, 71,58,61, 53,56,55, 55,56,58, 72,73,74, 74,73,75, 76,77,78, 78,77,79, 68,76,69, 69,76,78, 79,72,78, 78,72,74, 74,54,78, 78,54,69, 52,54,75, 75,54,74, 80,81,82, 82,81,83, 77,84,79, 79,84,85, 81,6,83, 83,6,7, 86,72,85, 85,72,79, 73,72,87, 87,72,86, 88,89,90, 90,89,91, 92,93,94, 94,93,95, 96,97,98, 98,97,99, 100,101,102, 102,101,103, 80,100,81, 81,100,102, 103,96,102, 102,96,98, 98,6,102, 102,6,81, 99,4,98, 98,4,6, 104,105,106, 106,105,107, 104,106,108, 108,106,109, 107,92,106, 106,92,94, 94,110,106, 106,110,109, 95,111,94, 94,111,110, 112,113,114, 114,113,115, 116,117,118, 118,117,119, 105,120,107, 107,120,121, 117,114,119, 119,114,115, 122,92,121, 121,92,107, 93,92,123, 123,92,122, 124,125,126, 126,125,127, 126,127,116, 116,127,117, 125,90,127, 127,90,91, 91,114,127, 127,114,117, 89,112,91, 91,112,114, 128,129,130, 130,129,131, 132,133,134, 134,133,135, 136,137,138, 138,137,139, 140,136,141, 141,136,138, 139,132,138, 138,132,134, 134,142,138, 138,142,141, 143,142,135, 135,142,134, 144,145,146, 146,145,147, 148,149,137, 137,149,139, 147,128,146, 146,128,130, 150,132,149, 149,132,139, 151,133,150, 150,133,132, 152,153,154, 154,153,155, 156,157,158, 158,157,159, 145,156,147, 147,156,158, 159,152,158, 158,152,154, 154,128,158, 158,128,147, 129,128,155, 155,128,154, 160,161,162, 162,161,163, 164,165,166, 166,165,167, 164,160,165, 165,160,162, 168,169,170, 170,169,171, 171,167,170, 170,167,165, 163,0,162, 162,0,2, 2,170,162, 162,170,165, 168,170,3, 3,170,2, 172,173,174, 174,173,175, 176,177,178, 178,177,179, 180,181,182, 182,181,183, 184,185,186, 186,185,187, 188,189,190, 190,189,191, 192,188,193, 193,188,190, 191,184,190, 190,184,186, 186,194,190, 190,194,193, 195,194,187, 187,194,186, 196,197,198, 198,197,199, 200,201,189, 189,201,191, 202,196,203, 203,196,198, 204,185,205, 205,185,184, 184,191,205, 205,191,201, 199,180,198, 198,180,182, 182,206,198, 198,206,203, 207,206,183, 183,206,182, 208,209,210, 210,209,211, 212,213,214, 214,213,215, 197,214,199, 199,214,215, 213,210,215, 215,210,211, 211,180,215, 215,180,199, 181,180,209, 209,180,211, 216,217,218, 218,217,219, 220,221,212, 212,221,213, 222,223,220, 220,223,221, 224,208,225, 225,208,210, 210,213,225, 225,213,221, 217,178,219, 219,178,179, 226,225,223, 223,225,221, 227,224,226, 226,224,225, 228,229,230, 230,229,231, 232,233,234, 234,233,235, 236,237,238, 238,237,239, 216,236,217, 217,236,238, 239,232,238, 238,232,234, 234,178,238, 238,178,217, 176,178,235, 235,178,234, 240,241,242, 242,241,243, 244,245,237, 237,245,239, 240,242,244, 244,242,245, 246,233,247, 247,233,232, 232,239,247, 247,239,245, 243,228,242, 242,228,230, 230,247,242, 242,247,245, 231,246,230, 230,246,247, 248,249,250, 250,249,251, 252,253,254, 254,253,255, 256,257,258, 258,257,259, 257,252,259, 259,252,254, 260,261,262, 262,261,263, 261,258,263, 263,258,259, 255,248,254, 254,248,250, 250,263,254, 254,263,259, 262,263,251, 251,263,250, 264,265,266, 266,265,267, 268,269,253, 253,269,255, 266,267,268, 268,267,269, 270,249,271, 271,249,248, 248,255,271, 271,255,269, 265,174,267, 267,174,175, 175,271,267, 267,271,269, 173,270,175, 175,270,271, 272,273,274, 273,275,274, 276,277,278, 279,280,281, 282,283,284, 281,280,277, 277,280,278, 278,280,285, 285,280,286, 280,284,286, 287,288,275, 275,288,274, 274,288,289, 288,290,289, 289,290,291, 290,292,291, 283,293,284, 284,293,294, 294,295,284, 294,293,296, 295,297,284, 296,293,298, 293,299,298, 298,299,300, 299,301,300, 300,301,302, 302,301,303, 301,304,303, 303,304,305, 304,306,305, 305,306,307, 306,308,307, 308,309,307, 307,309,310, 309,311,310, 310,311,312, 311,313,312, 312,313,314, 313,315,314, 314,315,316, 315,291,316, 316,291,317, 317,291,318, 291,292,318, 318,292,319, 319,292,320, 292,321,320, 320,321,322, 321,323,322, 322,323,324, 323,286,324, 324,286,325, 286,284,325, 284,297,325, 326,327,328, 328,327,329, 330,331,332, 333,334,335, 336,337,338, 334,338,335, 338,337,335, 337,339,335, 339,340,335, 335,340,331, 332,331,341, 331,342,341, 342,331,343, 342,344,341, 343,331,345, 344,346,341, 341,346,347, 346,348,347, 347,348,349, 348,350,349, 350,351,349, 349,351,352, 351,353,352, 352,353,354, 353,355,354, 354,355,356, 356,355,357, 355,358,357, 357,358,359, 358,360,359, 359,360,361, 360,362,361, 361,362,363, 362,364,363, 363,364,365, 364,366,365, 366,367,365, 345,331,368, 331,340,368, 368,340,369, 340,370,369, 369,370,371, 370,372,371, 371,372,373, 372,374,373, 373,374,375, 367,375,365, 375,374,365, 374,376,365, 365,376,377, 376,378,377, 377,378,327, 378,379,327, 327,379,329
};


#endif // _R_OBJECT_H_
