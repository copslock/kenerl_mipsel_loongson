Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2017 07:44:02 +0200 (CEST)
Received: from mail-sn1nam02on0080.outbound.protection.outlook.com ([104.47.36.80]:64027
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991601AbdGJFnyLLYWm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jul 2017 07:43:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=X9D/FQrpncC6wIRo49nezOI8qXBLScH1+lElhXeJdhM=;
 b=vGvebkH2QfpT+iJA9rvtyJN2JIXI8VIqSKVAwjM304/EUpKMKf8HFJLWuqegDtoh1J6/W3Q05y2Ojpwc0ado1YqrBZi1HGM3G7K6DNusbesr3lePDIpLfWSxWbqRhCBNbjSfKPFTLjJZFJvnVJYcnZLmFnIR00oqWNSbQ6YIWEw=
Received: from DM5PR02CA0052.namprd02.prod.outlook.com (10.168.192.14) by
 MWHPR02MB2734.namprd02.prod.outlook.com (10.175.49.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1240.13; Mon, 10 Jul 2017 05:43:44 +0000
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by DM5PR02CA0052.outlook.office365.com
 (2603:10b6:3:39::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1240.13 via
 Frontend Transport; Mon, 10 Jul 2017 05:43:44 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1220.9
 via Frontend Transport; Mon, 10 Jul 2017 05:43:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1dURTz-0007c2-1g; Sun, 09 Jul 2017 22:43:43 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1dURTy-0006mM-W0; Sun, 09 Jul 2017 22:43:43 -0700
Received: from [172.22.159.25] (helo=XAP-PVEXCAS01.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharatku@xilinx.com>)
        id 1dURTy-0006lm-LK; Sun, 09 Jul 2017 22:43:42 -0700
Received: from XAP-PVEXMBX02.xlnx.xilinx.com ([fe80::6c95:7dae:8014:5ca1]) by
 XAP-PVEXCAS01.xlnx.xilinx.com ([::1]) with mapi id 14.03.0319.002; Mon, 10
 Jul 2017 13:43:40 +0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     Paul Burton <paul.burton@imgtec.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Ley Foon Tan <ley.foon.tan@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ley Foon Tan" <lftan@altera.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: RE: [PATCH v5 1/4] PCI: xilinx: Create legacy IRQ domain with size 5
Thread-Topic: [PATCH v5 1/4] PCI: xilinx: Create legacy IRQ domain with size
 5
Thread-Index: AQHS56QUuWBY7BZ1xU6hZJOH0z8zQKIsV1UAgAAORwCAABPJgIAABQqAgB86PYCAAPTm4A==
Date:   Mon, 10 Jul 2017 05:43:39 +0000
Message-ID: <8520D5D51A55D047800579B094147198264882EE@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <20170617195741.12757-1-paul.burton@imgtec.com>
 <20170620014903.GI554@bhelgaas-glaptop.roam.corp.google.com>
 <1626229.99f7PaUVIa@np-p-burton> <1832687.ISliS9vHg3@np-p-burton>
In-Reply-To: <1832687.ISliS9vHg3@np-p-burton>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.94.93]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.1.0.1062-23184.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(39850400002)(39400400002)(39450400003)(39410400002)(39840400002)(39860400002)(2980300002)(438002)(377454003)(377424004)(199003)(24454002)(13464003)(189002)(8936002)(5660300001)(356003)(2906002)(8676002)(63266004)(7736002)(189998001)(5890100001)(81166006)(53546010)(8666007)(2920100001)(2900100001)(5250100002)(38730400002)(8746002)(55846006)(6306002)(305945005)(7696004)(45080400002)(50466002)(54906002)(55016002)(6116002)(3846002)(33656002)(966005)(47776003)(626005)(46406003)(102836003)(97756001)(50986999)(76176999)(54356999)(478600001)(4326008)(93886004)(23726003)(229853002)(106466001)(2950100002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2734;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;MLV:sfv;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT005;1:weqAEatgE7lGcz6LwaCe655fHKxIOUBVwAIAdE8ORxppzqgFKTP2i0hDirUcPK8XXrZ7QTt7kK6bx4NfXUedCl7DFFQxvO2yaYTywAJ7X/2D0ZidgSvQ/cuIJKIcfbKj8P/B5vn4qKozyq+fIzWDzkFI41JdOVCyLwz5yXECRouDjOjSdtzjDVzx0V1AtBtavrUbTChsPYpWlKPXzqFawyEoiEbqRWfy1OZUyE2uTkYdxztKpSNcctbM+WkzxsM3Lpez5UZsV67EtssRNdOHUmgTOAbvk0DOobSsLMC7GtdUuIyz6rTHA8Ad5MyChKaPFt/aGQrUpFtc95qdhn2hJV6UTW/OP3VRsOAuqdA3tNTnNzT1d3dI6pO4qBtVxI4wACiMPAhinqTxF04dFO1MxItA4K1kDFHsn6o1QVVvFHDrliskMfJwwNPc3oXhTx3a1Oz/IQavsIbBeZRpFOGKsjznFMcEAayXHcCS4hCk+ZfKecRJgYAzYVwBkl1rHgAxGKZSjl3QSRGe9vV/9keHv/UW8NKSzf5Ys9k2SLHiRt8hFolPuXG9QQn1m8uogaRaUHgefB0v8cQUqa/8D+J6y5j4sSlth13YLqV3DoOFt2lnJcRVqCkPlY+zWh0YMtLmLNL1oHscQCELsttc60go086h/zJ8x8kZ4UsrsirOCznQ26FESAtOK6iJwkppsLJzxH95+2PARRGsw/RgT+dLcsacaJzG0y+WllBQhakoLkDiQiL2yDfo0MKhRS6HCVJk1vSUM/NWW30yEie65PaTQdWgIsZDwUKMphghq1eGoTanLwR+jtCuOCSmeC/N7SMPGDAx60cKGv+XPVxf3c59E3Nd6xDF2oUKbuDscSCc5r0MnXvMzA/gxujKVuY3ieRVFXMyffOGGlYGxOvC+pW5Ii/rbGi0FoIUsf656g68UQ4LemsjN1d7BSheLf92xfSB
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cac89b44-d1c5-461d-b51a-08d4c756a0b3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(8251501002)(2017030254075)(300000503095)(300135400095)(2017052603031)(201703131423075)(201703031133081)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR02MB2734;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2734;3:Coe8Jp8ACpV3BHM4kZGU9LddoViv7dKVHlaJWF21G5NcTUbXIWM6p1zUg3YHPXPll/5Ivzyc0JHnmbNseapUwKm+e2Pawn3FJlrxzAeXZSuhiIhXxgFTaDon/C1rHrMiQYNi23Ky9YxgSDUCWiaTi+J+bitIMN4aM5n7rMh/+d4y6LtLZtrGcDRExa42fcWCtTNvhwZW55aCgPhMI2NWiWCAzEzA3n2kqifiISTJR5OS44G+L1xo5WKOU7NZikaBHi+brXsJhK59BwnZnnXWNvkAyISsv1qYXMzdYmPPtlyu+4Wxw/Fi9KFpts+QT7j8CtQXAe+ozVCvlimP8GHyLorQHDoUrjUpbL+hmpE5JCZahiT9H+DDdCNRGoX9iyO38M9h1EniQB+bfVfBPX20m8my4FwciXTtl1yMIWrUZ1d09NdraP19171EkP7SZ7qMXjhTrmfVZv2r+h2QHLQ26cL+ebHcg/0CV/D65xH6WOPrXpdIkXaggmAXdlmhy34OXmfSaF035bCoAvnx4u4AHDTGHTAUXbrp3CMdgXWNHNllOQ28XJFD/wm94mWSRpwG4nOJcNSqE1aZ78J8AlUki/iSf65s2tqRx/KImN8ErUvQAReZooZz0b/fNuwtjB8sTUEuMDH5xuSs7sE4mtvhUw6loYRuhVDwPAaJJKHaERbkl9cXS5EQ7NeBRc8VkPo4S35DLQY731r4KmyLHQaK6fObUiH1m1a2UN7gSBLrrFpwpgIzVX6TExuKWOCayY4n6fo6FnoUePhEvDNuFNayob1IG9ruiIyOSMTBaleW/w28HeS237KWe3+KvvsyblXR2Mjfu/pKCxkRWgyZD/On1aMOWxPw2epdq06M7vlE6q7sWekS1c9JLBwn/l5KDVuavNFBgLHx7hgMfdvSJFoNfsVmEs8DrOmu/FBItsvJPtk=
X-MS-TrafficTypeDiagnostic: MWHPR02MB2734:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2734;25:R0kMthzYbLm/4IzhadYqsbXVr1AFYh5iPIz1l9gjvCKVchKmdRhMIy92xsbYVnEcaNFTQ3d22vvzDgEoG5fMkMy8Y2s9AU5n8DgxvDH5bwYX32r3eGMZ2byW2w91CTxvogaii2oqc7K8E5N9FHE88RDReyDbjrmuudogWr6dQlfg5N6bAgVtAE8AS9v9IxNzFR0d81nwwO9AMvSFOM5oQIfVuXUYLqGqn5WDRb7z+WoihuS/thnwFWqv7rgpJhJ7hZz2IYbl7eGkTV/Gb8HmIbR51lsFwtRNRDVUkuj8zBnlCkBSVTrZL4JV4xezR0n6iq2/U8rxBQAjB5cC70iqO59OzIGbWc6CF9bL+arp5hxbDdcSHKUDsTtx1sXh16W/CtOaaUTxtWAzj81npyve101Jv5AD3XdRhCWoXKjPp3PovldkLqpIPORskox9X8Nhex/OTBYHyCEtkL4vOfLa/WOQbXYiZqYK0PjLMoWuL5vdM8FAr5pnebuQk1AHMe5xN1NxYz573uAUs3AwpZi6aTWxVyX6K8zmTet6gPdIwPQLRpnat//a7KBQHuhBHFmw2YnMalC+XLgjsn/4ROMh2M3U+brXFd2Yt2nsqC/sKFG4F7UOd0j+trREg5OhsPlOnShcnOUAkMOnnkIre9xtVJw79NJGQMuZYx24yg4xbSVGk1RUEDulxMoPxWvOn6VFhxzXHzU0dZSvDF8LlZtoNhJTpuDkySWHXj+J4DsO+bHHlNlBFWgkcbB1XAWCpcZCrOa5K21z2kN+FaIbP2s86qttH1dyI4n31EQ2UHMgXRiSuhAudYy7eTAmVBYNqpr0/O1EKxdJIGaANRORt4S0498Oo3spPJpjLbyNV3PqCqHkTCKkpO8hgbRq1AIGGQEuD/GB7gaGjJfhAFQnF/6U+Y0WvOINOogKhRd4Vug7OI4=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2734;31:iS2xKWZRZY0cE+HsOH3T2HVqaASPGSs8S73VEDPVYqW33aDUFlAhurVE1+STL0g/4licaHRF3OvkAgfGc7zv2GYfSEwQngXA9cu8GHU83MWeaekoYRtPz9qdUi7PYPT7A+6l9Ac2jpctr5xYPeRSt/Eq5R3oOllJOY+PmO+eQ72QdHvlwwH1xZ7uXvfZDtO88d/j3VUc67a6iF1FKKsUJwI81DF8ErVB3auymKxFR1IVdEqfRQpPWF7iBNFD9bKO/tncSitG45hLMLuFvKRpAjw5wbAeEVbzO0caG9Dx4qVvlfsfNOiexVD4mryzOk7qXzuduCrse6Ofp7S7TDxUFSFuSVujst3ikQqxq+B/tBm4H0tAAvHXPKTIjihvbWKVkdRQ2J+WyEInWnsEJv1oLSfDxPR8OnrJezYznmCXw0s5GhGw4q4J9n24wY+A7lI1GiQJhSZ/otXy2fpFvxuYj0U2I6LMB1Cu2kVkRDqNC1wA987+FcYi/cfwhxJf//TTNxT5f2A3FISAmud8pXAihyBtANM0pbGJx7jSgstqHpTIMqvgW8rTQ+lURYCSmlW2SbdMPm/fjChWYX83VCuIjQCEcO4mCPOq3fh0Z6eTg224mr7Dj7bVJTMHFRPv2ZKjoS4YEmwuFDdBRrgSOQwWBnnuxVECTbQCvZskBjHvZLCuloEV2+LRPbr5r+bzFxkwmkeJzgpr0Hh0RDFvDPBx/g==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2734;20:DEsRTDigixIp2T8aDhGBc21N2Z4bx1OeltaIvUZ6eDHC00N9uOaNl1ojPHAUbXesAYSIVipoYqRjiYGRiefJc1NcL1rYULuYxpGYHNbm++Dn3/KvQYmh0WrlSHdvztTs3nbiCMNXcs2WMwF0YMyDYXbWBFlNwyl8/rcFys97rIorLr+xf0FyOz8+QA051LWXsVnSp0JjZyTurq9hqDo73+6dTxxHFvhpYqUX4IdzkckwMQ2Gd+GrUg09x5Oysz6KrMZlB1ojEg9kWmapr5sfXLai9lw5oerjb3j5HVWabpHQlwpk8dyqbnIaZK1wbkGoLOzvfpBMKJEb7NMl8rI/4HIj9SWzHfl6OEQrhQhKGremcM8b1fHD83dulqM8l0bmTtDkwD5CLRKlfKFUlsTCVSgC4E3mQpiFY64UX9rhKCCOLH6YTsFuwIdnqKiDMeoINBTQ4XufaBF4NfN8i+VdLTLt13ATpvR6F7sZueaL16MiPDkLkIJ4i8SqbSSmspfm
X-Microsoft-Antispam-PRVS: <MWHPR02MB27345215E669FFFB6D2F0AB9A5A90@MWHPR02MB2734.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(236129657087228)(9452136761055)(80048183373757)(48057245064654)(192813158149592)(211936372134217)(148574349560750)(228905959029699)(247924648384137);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(13016025)(8121501046)(2017060910075)(13018025)(93006095)(93004095)(100000703101)(100105400095)(3002001)(10201501046)(6055026)(6041248)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(20161123562025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR02MB2734;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR02MB2734;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2734;4:fEdDQhJvZsoQeaKMGvqjqdcjoFJRrfYu8QEA23kYUT?=
 =?us-ascii?Q?mtsx0J7KZsF3l2iS4HBMA/R1TapD4M3y+0KSX8pYRznTsCmERyoUCESuP7iJ?=
 =?us-ascii?Q?wpWOoXPLu2o+RvQWiSxqAZz8HGKVIp5T8VIc8POPiEI5pasqMXSlDuKepGCy?=
 =?us-ascii?Q?KhEnGQjZHodS9zaGQCRx/tR3Ntm7Hnra6XLghiM60oIf1ah6/XkBaaAI7bqZ?=
 =?us-ascii?Q?dqv8N1RYEFWRE+Ne6v/ivbphM6LUeelbmdQQa7MrM2WbGhMnPjsakI15TKZ2?=
 =?us-ascii?Q?jU6Zqws8hsWBSUFYn4fHRQ7WcH+9glkmVtdBNbkwarzOcgExFRE1xzHOXRlX?=
 =?us-ascii?Q?kH7X+Or7lyX3O5Su7MVoJhyj/cFYdRnPyyJizQUwHzGrWSMr87oCLGRIdfpo?=
 =?us-ascii?Q?hhCF42rVgoQ/0UCTSHwdUpM1TPZdk2g1XjyonOxKUdZxFZI41Ym7vXaqapFC?=
 =?us-ascii?Q?XM4Zwms7qvLOodLqtYDtTgsPBv6mEbN8EHh47BTAZpwKhr+T0u+JpX2iMFV2?=
 =?us-ascii?Q?ik3DyIBClXn0lg25/UAN8KsN4z6Uprrweaz+k/v3rU0iJ9rPULEx4cZMGan2?=
 =?us-ascii?Q?WI/5fIwkVbemdvYc8F/5z+pZYJ3s1f/r5Yp5PKw6NNBcCFSZu/kYre+A2a7P?=
 =?us-ascii?Q?xO/FVi+zv/ozLumtzc0Jm0tsxt/afq6kyGdh/jrFR66hfiCXPsU16ftP8t9z?=
 =?us-ascii?Q?EQnILzuo96rTHzVNZg4xbpsw1isQTCCIIr2JzkDigOZhJARNNrsePp7dmTLs?=
 =?us-ascii?Q?Hrw6XQCSd5zHMV4FtbWxTULvr3ltppCTCGUQ3ruX6iqKbR2hehmBxlqyIHke?=
 =?us-ascii?Q?y/69zebrdEL3dp9Ixggjrf1euyLz3GBcmGjb+frGtca85lky9KNWjpPDn8v2?=
 =?us-ascii?Q?PbxiNJ0VdaFZnfq9kNcp21vXibIU9Qdicebxcp9lJ3xwqshYvKo/R5tvikSb?=
 =?us-ascii?Q?3cb26KrfMcMmKQPI7S3A7VryX4ng9BtVDLJERw/b/q8dkC8XiS4g+3cRaw8z?=
 =?us-ascii?Q?huct4I6rIi54raQ7ZMiX2Ebim4szhbSauhlUtp3GdPQqPiUSlKw9JHdCHMYk?=
 =?us-ascii?Q?I8OdSwCwL159I0OCgBYq8DPNdrY0cUfE4cmM6qi5AOoSfvSnmmDv2o4rj36A?=
 =?us-ascii?Q?SNtU0JqgKOT96CE4vhqnHnAZwnHi1UX3Qo+HdU8NQI4Rhsafe53Z0YV67Bnq?=
 =?us-ascii?Q?G2HI62lb82W7JvYg37zl0wO+ZXUDXgZdKEzYbWS8MMuUfNygM2MB9qcQqon0?=
 =?us-ascii?Q?s7lzc6JcRpVd/+88k4JkVQm54h7s1RivnVNxGL0Wfx2x4h1NmoJYHYSWzkOd?=
 =?us-ascii?Q?FQ7sinmnVKfA30MVehyvqmnYMDlGtn5JzEQVI/4OlN0S3V6TqLbRfymSNDVU?=
 =?us-ascii?Q?fGKUb4gzNIz79Sz4sEsxjT9QfwAd/Hu7XI2WaFnxIp/OXlvn1SZ/pFlVSCne?=
 =?us-ascii?Q?sI7GsXf8gWpZmrL8R+8bSesmuzzeAK2cAL7S1XVp2Z0MsxWZXHoPLRRl6woZ?=
 =?us-ascii?Q?/X5R5QDPoahbNXOr0dOvBuZPHqXVVjlmmScgy9HvJxOcCvPgIKXDUUX9Y4S8?=
 =?us-ascii?Q?gO51KNAJ2tyoRGYTexQy79BBwScG5nC9odTt8sml5IqBTRCKrqL9sy7FUR?=
X-Forefront-PRVS: 03648EFF89
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2734;23:PJXUC6A1SEGRjDGmIQwmw+ByIVMHDQp1xy6MEs3Qo?=
 =?us-ascii?Q?RYlL/pjcDbBGtj1kUQu3NdNEm+IwxBgBT6kjIZuo9h0/BetAR1ZKIf9Z2sS+?=
 =?us-ascii?Q?Vzbf1a2WDOan6ZH0QCfQukWEFYhr8vyHQaeG5Wx5X0g2YYUFMd4vwopIPa0/?=
 =?us-ascii?Q?vsmlNlabHZy7S/bpUpq21ViWnhYexfbvgPdg6vCokKdBe7b1GGyMsNq9fkUW?=
 =?us-ascii?Q?6L0m2cmf500q9GjSqyP+9vMOcjl/60bSfFNoNM4QI6WufsFcU3xyC0vzFOXq?=
 =?us-ascii?Q?rXgamHEJ+Zq/SAlFqItpDaaRC5Ir46zUL2wnRfd3QFbDL8GmcFi/MeUCH6Vv?=
 =?us-ascii?Q?AcgPZ5qYiscZgNx5XxP+a0sexbV17WAZm73fBO8C6s1lkIy8HRPp7IsD3D7b?=
 =?us-ascii?Q?c9dtxGUVr70driDDFDDMijB9+93wmew5n5dtJYyx8Fn2fcgEjNNfHHJbwRAb?=
 =?us-ascii?Q?PXFLNf4WxQ2EMkWJEPmJmU712VdB66+UfHayklKuy+XMmUOstdwIhpg9HNxO?=
 =?us-ascii?Q?4TRstKN/FiLtiwq2zB84CXfNRQv3UD2+uOiG0hY/gOGlheR+k+yHxe0pBv7i?=
 =?us-ascii?Q?LfTyiU6SiNZwSQn8O6w/Fm6lrXmzyHK7eydnDnFY69oaFdaF3JII4Bd2iiDy?=
 =?us-ascii?Q?KNNuyG0/KSYRmlUCJFQjkFiclFVYWFr9XR7beRP58R7WVzdKm1qJyadN//4r?=
 =?us-ascii?Q?0k48H31Ul7ORO44fRBPxDyoSXRcCDmYsIBtGZo1CzEUw65X1lEP+WcV4O391?=
 =?us-ascii?Q?XQP/gsIL/RFJ+HK8FnOViwmMcPrSE4L2IWB0NZjdT6lnlEla+7yWM5EyaoEJ?=
 =?us-ascii?Q?ogMjo3aygg6soaR7GU+zgyk05lilyMV0ujaZ45dqU/s1N99EwwiZoiYXiTDA?=
 =?us-ascii?Q?BVoVUX0x1VYDQSLQjAZPyOAdkxRPh7EZLEc+HfyFQiIhVmp69Fmdyd3IeMDb?=
 =?us-ascii?Q?uiIEOgLeP0tA2Ji29s8MUujJDI9k+KkmGg9YluYLVDhwxT20ymKl3pHI6NuB?=
 =?us-ascii?Q?exUowVFYIxRCwWjZzvVfXvCCQlIb5xbkOxVmmvboGvAFD6qrss8E4Q/RI+zN?=
 =?us-ascii?Q?uwbugiZsrd44qSWCbgUcnrZZ9w03ynFa9fOlVWRGxQ0JnP8sqGkDN0qFqqOr?=
 =?us-ascii?Q?mXSLWBHLtA/kr499QwOpuA+HxkGGhkKbwBvk43CU88/jqOLHtd89se81HATU?=
 =?us-ascii?Q?0PtZIkN3mKAyI+eLMiow/GuK+MEklzUCVaG5VUynHLD+zKj5/ihx6TAWrXTx?=
 =?us-ascii?Q?e+0XCqsuUodH3eeSx1wZvQFZk3t3U9WFx+JALFGIQgPOetQvSkV9fJOh0TZw?=
 =?us-ascii?Q?8NbNM+275FJEP5cpk9OYTbgsi9ITEp/7qaFodUmvfsTRAhvpW/t9UrDV548s?=
 =?us-ascii?Q?FH+/yGEF8JBKadBQo0c9rsQGaCIXyGlJ/o8T52UU+jF+eWk6hDbWyL7bYKyO?=
 =?us-ascii?Q?RYC0IgzZeb0pmOyauoNmR3ySoNHPME=3D?=
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2734;6:slGIWIE8E5Xz0JK52a15a126pC6gdRq8SRBv5rkM2U?=
 =?us-ascii?Q?HH1ncwo+9TBJvqD1BNrJKpGJqfkeUxv05ib9MxycMWliNQN0spVq591kyibb?=
 =?us-ascii?Q?+3hx3+fEkkChIPKRkhp+hKI3D9o/cI4venOV5pF90uQ7cFTvynoueKVk6XYQ?=
 =?us-ascii?Q?gfjPuiDJTccXXTdF7FKB1nJg83F66ZQUKa4RvE2OPgGNxufz5vG2qIJdFF8l?=
 =?us-ascii?Q?/Dmdua+RvkVUvUst2AOhQvRQx3SO276310hJnwwd3w58YJRbKozD28uqLzzf?=
 =?us-ascii?Q?lTpy78RnJOmuLYwO8jcD6LzK70odYjrjFdUKFkXz7mYcrLeuDJ5BHJmQSgMV?=
 =?us-ascii?Q?cOUQ0PPbXxISWYT8vzS0If762euEBEOenPkeuGlwVyyGZN9awPC50EwOEuSJ?=
 =?us-ascii?Q?ZNTpPdRNnOlSR4PLSVwevYcZ81HABKtLQ8YeUK+MdDS9ldodg0md3vtfuxYG?=
 =?us-ascii?Q?UMNrzNMpCQnL7BPHe0Ul7/U9Ia6rri04cClelZR1Bks9F7fbeQeu8z6Myj1p?=
 =?us-ascii?Q?c6X1gSZCuyZlZZNLKrtUthNdLEjgLZRR9BbspLpl3lo87/xi0ESix4HMaDud?=
 =?us-ascii?Q?KuVgNWgwmHNewwOBda2Vk6+Eh3gqNPSL2uomjoff1GbfWD/q1/UGghHu0UYf?=
 =?us-ascii?Q?YeoDdtuukQWKmudMofpM2fj/QW4dZWbhM5lYMWNrlJa4K48KXaKztAQUj3JS?=
 =?us-ascii?Q?wGmNVMd44hkZTJEll+a0FUZwLuHsTbXtNtP4p9lXTxwfYf6bM3Ri6oPmTqFu?=
 =?us-ascii?Q?Vw6NZ1io3o4cY2PFqxn9WxUh+AVxoD8+D71UXyHr8HeoL/7CXdpJ3wNchBVX?=
 =?us-ascii?Q?vMBBXohMeF+ViM7C7PvbfUJHTf26S8AyJCTrWEH9jO0O0swGzHgSJxE4WzRX?=
 =?us-ascii?Q?23YX4OmvStLjNEr7oB2hR0E0WHtMPqPHKR1ABGepaOLm+2QQ1FKgMWr3YsZG?=
 =?us-ascii?Q?K17fX4j5S+67z0XFk58uLpTn0X5C8EOTfC3O8zdN52TSSwkHdN9gg6ZiN0Ti?=
 =?us-ascii?Q?IAJbVKe6jH48xLFz1A5Nnm?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2734;5:u5w/R1vc5qJ4Ykq+zecZGG4dXPDZseiPS1uw/uwxsUfx7xwVK2zH+AY4ZOBZPAj5uNB3lZeI6c/drU5p5w6/epGe+NfULE6qKpZj1wKFPnAoqITeaFTl5oD4n5+NGFTibeAuEITUaZ/qwKKYqzGiWVHIvIX+LMCWiIZ0vZ4OAqhrvOEDB3AJC+mhJf8JgQlyHpRRYmuDELSOW2hr575qL5PZEkqtH2lWGMQntgYbB9kvibAvFHzmFLruKC+d5WbIn5H1CRRkf9+ni1Fb8gwpel2N+AoEYn9p1wpSgmBfH/L2suSY8RtaLzeJmgW3tKlWuMESqodVNemM9PXgB8w+cY/nDVbtETOsp6oYHZyZq+uyLfZZ2SDyVs2MswEyGdp7XkAMZAJyXi+g4YmA1C/Bz0hRYG1VkwaC7HWISKzrVNJ50GMdW8u/jj+86VOqGFMkQZizsElu7jXyVGdxetjqjfnSfYPafBb0uQc51TKQfX+SOCaceQJKO9tTD7RdeZGx;24:XBg4QiiQnAK/1bA2cpov/E16jBbPcn2jQ32gAys6xblVnB6qWV9bD+sLL7y3s8ZxMBpWVppRbs4RIfGxws5/Ve7Y8+bjTfkbxst4O2liJcE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2734;7:1rxibN2Ts3DvZBJu9BYBYEMw/Nqwx2S5E8THdeWHtiFPku5gIDKXnAMaCpFnMW/DcrVKKptsz07+9IjWQE15LIeR3F1J8auta5R+iXv2TEQoDqJRDsoAXsgcdYuGaHpPWoYlIv6KLksJ7Hop7HnpkgOUNXuMvRv/FpK8PRLeHavXbuH2Ua3/03TjCCEXL4O2WZIrO7pueq3lSj8D9n2AeHT/JYmB1fpWwhHvwmEzIllFGXKLW3gCX2I55uOw4k78qsz5on0aXkfQN+RgK91I6Nv1PF8kbBp/VzA+UnpTNNkT2oXOk68gBQ63QVeT6xdNVY7q9ctGHpuGUU0e1RMxSThIO/CLd81hL5iHoL5F4JN+70xNx3AT2QeoDdmIi3LcOZ47Irxu0ggEFnmeuX1le9TQvBY0AUjnnh055FZ/5os587zIJR/Rqh4TwvwymI+H3SppkxDv3zigzIgaBpmTOmGoMrri/KbNtxKyfPAuz+4diEplDOwmtvYklMWTCaiX9E9H6yMkKu8sd5XHNdRzWqQ1FlLzeroAoXlOqRZfWr2SZ7Ua4LmJrv+hKLTkDTvwJNFN3RDXigIg6P3HHfzym+UDRCEmSleD0MrAH6ZMwm9FXszfkIpdmcY8gEQZ7PgEqiHTcOtdFKvDNMBlu/bwAy08Wk+RabMTPh0u+iAoeKBRp8rdH21rMkHCYxlgAjiHTePjri9Msu557W+fp0JeTiBjzhJKhvbJoePCJ7Nzl7Mga73nlil/0bnDZL1bH4XH2hRpdBZ07NLHrll0ECdf0d3gR74SoccAtn37LEWOB2A=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2017 05:43:43.7079
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2734
Return-Path: <bharatku@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bharat.kumar.gogada@xilinx.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Paul Burton
> Sent: Monday, July 10, 2017 4:30 AM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>; linux-pci@vger.kernel.org; Bharat
> Kumar Gogada <bharatku@xilinx.com>; Ravikiran Gummaluri
> <rgummal@xilinx.com>; Bjorn Helgaas <bhelgaas@google.com>; Michal Simek
> <michal.simek@xilinx.com>; linux-mips@linux-mips.org; Thomas Gleixner
> <tglx@linutronix.de>; Ley Foon Tan <lftan@altera.com>; Marc Zyngier
> <marc.zyngier@arm.com>
> Subject: Re: [PATCH v5 1/4] PCI: xilinx: Create legacy IRQ domain with size 5
> 
> Hi Bjorn,
> 
> On Monday, 19 June 2017 19:07:05 PDT Paul Burton wrote:
> > Hi Bjorn,
> >
> > On Monday, 19 June 2017 18:49:03 PDT Bjorn Helgaas wrote:
> > > [+cc Marc]
> > >
> > > On Tue, Jun 20, 2017 at 08:38:14AM +0800, Ley Foon Tan wrote:
> > > > On Mon, 2017-06-19 at 18:47 -0500, Bjorn Helgaas wrote:
> > > > > [+cc Thomas, Ley Foon]
> > > > >
> > > > > On Sat, Jun 17, 2017 at 12:57:38PM -0700, Paul Burton wrote:
> > > > > > The driver expects to use hardware IRQ numbers 1 through 4 for
> > > > > > INTX interrupts, but only creates an IRQ domain of size 4 (ie.
> > > > > > IRQ numbers 0 through 3). This results in a warning from
> > > > > > irq_domain_associate when it
> > > > > >
> > > > > > is called with hwirq=4:
> > > > > >      WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:365
> > > > > >
> > > > > >          irq_domain_associate+0x170/0x220
> > > > > >
> > > > > >      error: hwirq 0x4 is too large for dummy
> > > > > >      Modules linked in:
> > > > > >      CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
> > > > > >
> > > > > >          4.12.0-rc5-00126-g19e1b3a10aad-dirty #427
> > > > > >
> > > > > >      Stack : 0000000000000000 0000000000000004
> > > > > > 0000000000000006
> > > > > >
> > > > > > ffffffff8092c78a
> > > > > >
> > > > > >              0000000000000061 ffffffff8018bf60
> > > > > > 0000000000000000
> > > > > >
> > > > > > 0000000000000000
> > > > > >
> > > > > >              ffffffff8088c287 ffffffff80811d18
> > > > > > a8000000ffc60000
> > > > > >
> > > > > > ffffffff80926678
> > > > > >
> > > > > >              0000000000000001 0000000000000000
> > > > > > ffffffff80887880
> > > > > >
> > > > > > ffffffff80960000
> > > > > >
> > > > > >              ffffffff80920000 ffffffff801e6744
> > > > > > ffffffff80887880
> > > > > >
> > > > > > a8000000ffc4f8f8
> > > > > >
> > > > > >              000000000000089c ffffffff8018d260
> > > > > > 0000000000010000
> > > > > >
> > > > > > ffffffff80811d18
> > > > > >
> > > > > >              0000000000000000 0000000000000001
> > > > > > 0000000000000000
> > > > > >
> > > > > > 0000000000000000
> > > > > >
> > > > > >              0000000000000000 a8000000ffc4f840
> > > > > > 0000000000000000
> > > > > >
> > > > > > ffffffff8042cf34
> > > > > >
> > > > > >              0000000000000000 0000000000000000
> > > > > > 0000000000000000
> > > > > >
> > > > > > 0000000000040c00
> > > > > >
> > > > > >              0000000000000000 ffffffff8010d1c8
> > > > > > 0000000000000000
> > > > > >
> > > > > > ffffffff8042cf34
> > > > > >
> > > > > >              ...
> > > > > >
> > > > > >      Call Trace:
> > > > > >      [<ffffffff8010d1c8>] show_stack+0x80/0xa0
> > > > > >      [<ffffffff8042cf34>] dump_stack+0xd4/0x110
> > > > > >      [<ffffffff8013ea98>] __warn+0xf0/0x108
> > > > > >      [<ffffffff8013eb14>] warn_slowpath_fmt+0x3c/0x48
> > > > > >      [<ffffffff80196528>] irq_domain_associate+0x170/0x220
> > > > > >      [<ffffffff80196bf0>] irq_create_mapping+0x88/0x118
> > > > > >      [<ffffffff801976a8>] irq_create_fwspec_mapping+0xb8/0x320
> > > > > >      [<ffffffff80197970>] irq_create_of_mapping+0x60/0x70
> > > > > >      [<ffffffff805d1318>] of_irq_parse_and_map_pci+0x20/0x38
> > > > > >      [<ffffffff8049c210>] pci_fixup_irqs+0x60/0xe0
> > > > > >      [<ffffffff8049cd64>] xilinx_pcie_probe+0x28c/0x478
> > > > > >      [<ffffffff804e8ca8>] platform_drv_probe+0x50/0xd0
> > > > > >      [<ffffffff804e73a4>] driver_probe_device+0x2c4/0x3a0
> > > > > >      [<ffffffff804e7544>] __driver_attach+0xc4/0xd0
> > > > > >      [<ffffffff804e5254>] bus_for_each_dev+0x64/0xa8
> > > > > >      [<ffffffff804e5e40>] bus_add_driver+0x1f0/0x268
> > > > > >      [<ffffffff804e8000>] driver_register+0x68/0x118
> > > > > >      [<ffffffff801001a4>] do_one_initcall+0x4c/0x178
> > > > > >      [<ffffffff808d3ca8>] kernel_init_freeable+0x204/0x2b0
> > > > > >      [<ffffffff80730b68>] kernel_init+0x10/0xf8
> > > > > >      [<ffffffff80106218>] ret_from_kernel_thread+0x14/0x1c
> > > > > >
> > > > > > This patch avoids that warning by creating the legacy IRQ
> > > > > > domain with size 5 rather than 4, allowing it to cover the
> > > > > > hwirq=4/INTD case.
> > > > > >
> > > > > > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > > > > > Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
> > > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > > Cc: Michal Simek <michal.simek@xilinx.com>
> > > > > > Cc: Ravikiran Gummaluri <rgummal@xilinx.com>
> > > > > > Cc: linux-pci@vger.kernel.org
> > > > > >
> > > > > > ---
> > > > > >
> > > > > > Changes in v5:
> > > > > > - New patch; replacing "PCI: xilinx: Fix INTX irq dispatch".
> > > > > >
> > > > > > Changes in v4: None
> > > > > > Changes in v3: None
> > > > > > Changes in v2: None
> > > > > >
> > > > > >  drivers/pci/host/pcie-xilinx.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/host/pcie-xilinx.c
> > > > > > b/drivers/pci/host/pcie-xilinx.c index
> > > > > > 2fe2df51f9f8..94c71fb91648 100644
> > > > > > --- a/drivers/pci/host/pcie-xilinx.c
> > > > > > +++ b/drivers/pci/host/pcie-xilinx.c
> > > > > > @@ -524,7 +524,7 @@ static int
> > > > > > xilinx_pcie_init_irq_domain(struct
> > > > > > xilinx_pcie_port *port)
> > > > > >
> > > > > >               return -ENODEV;
> > > > > >
> > > > > >       }
> > > > > >
> > > > > > -     port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
> > > > > > +     port->leg_domain = irq_domain_add_linear(pcie_intc_node,
> > > > > > + 1 +
> > > > > > 4,
> > > > >
> > > > > I don't understand this.  Several drivers call
> > > > > irq_domain_add_linear() with
> > > > >
> > > > > a size of 4:
> > > > >   dra7xx_pcie_init_irq_domain
> > > > >   ks_dw_pcie_host_init
> > > > >   advk_pcie_init_irq_domain
> > > > >   faraday_pci_setup_cascaded_irq
> > > > >   rockchip_pcie_init_irq_domain
> > > > >   nwl_pcie_init_irq_domain
> > > > >
> > > > > Only one other in drivers/pci uses a size of 5:
> > > > >   altera_pcie_init_irq_domain
> > > > >
> > > > > Why can't we use a size of 4 for all of them?  We only have
> > > > > INTA- INTD.  Are altera and xilinx missing something to apply an
> > > > > offset from the 0-3 space to the 1-4 space?
> > > >
> > > > We have the same discussion before in 2016:
> > > > https://lkml.org/lkml/2016/
> > > > 8/30/198
> > >
> > > Thanks for digging that out.  I knew we'd discussed this before, but
> > > I couldn't find it in the archives.  I don't think anybody was
> > > really satisfied with the outcome, but we accepted it to make
> > > forward progress.
> > >
> > > > This is because legacy interrupt is start with index 1 instead of 0.
> > >
> > > I'm not buying this.  Your argument was that "the hwirq for legacy
> > > interrupts will start at 0x1 to 0x4 (INTA to INTD) and these values
> > > are as per PCIe specification for legacy interrupts.  So these
> > > cannot be numbered from 0."
> > >
> > > But all the other drivers I mentioned get along with the 0-3 range
> > > somehow.  If there's something different about altera and xilinx
> > > that means they can't use the same solution the others do, I'd like
> > > to know what it is.
> >
> > Note that with v4 of this patchset[1] I was using hwirq numbers 0-3
> > with
> > pcie- xilinx just fine, however:
> >
> > 1) Bharat complained.
> >
> > 2) It does require that the DT interrupt-map property be set
> > accordingly, which I guess may mean we're stuck with hwirq 1-4 for
> > drivers that already use them.
> >
> > Thanks,
> >     Paul
> >
> > [1] https://patchwork.kernel.org/patch/9763191/
> 
> I see this series wasn't included in your pull request for v4.13 - is there anything
> you're waiting on?
> 
> I've produced revisions of the series that work both ways now (0<=hwirq<=3 in
> v4, 1<=hwirq<=4 in v5) so I'm not sure what more I can do.
> 

Hi Bjorn,

I will test and give ack on paul's final series of patches.
I'm waiting for you to respond on this particular patch.

Regards,
Bharat
