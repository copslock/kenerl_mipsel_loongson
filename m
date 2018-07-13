Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2018 15:52:23 +0200 (CEST)
Received: from mail-eopbgr10126.outbound.protection.outlook.com ([40.107.1.126]:41822
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990397AbeGMNwQaobxc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2018 15:52:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTf79SQnnMC/rjlGKq/B9gfqGwk9hJwRqteZDIFg85U=;
 b=gchniRA2LcBbDmrsIqMczGLYpnsBYdv8/QQQWZr6JZ0SpdvfvWt9j1KO6J5fwGIHhk9/igrs9RfI1/Tvuv0zgrMYdtYLbAoamhHk25YZ02ioeQDHYDgo+10+39G4zzEI8cZzAbxb6tQYeMLu/jUoh3t3N8Ruy33lKdqjdMp/7aw=
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.2.20) by
 VI1PR0701MB1887.eurprd07.prod.outlook.com (2603:10a6:800:39::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.7; Fri, 13 Jul
 2018 13:52:05 +0000
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mips@linux-mips.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Subject: [PATCH] mips: rapidio: Drop dependency on PCI
Date:   Fri, 13 Jul 2018 15:51:32 +0200
Message-Id: <20180713135132.1066-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: AM5PR0701CA0001.eurprd07.prod.outlook.com
 (2603:10a6:203:51::11) To VI1PR0701MB1887.eurprd07.prod.outlook.com
 (2603:10a6:800:39::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fb420b9-b344-417f-98e1-08d5e8c7d1ef
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:VI1PR0701MB1887;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1887;3:H3BnLPgMObfnmgyWcz/UzVsIZP5dGhOwOMGyreO2Pz5rmrACwcgSNYTTtabBygREeT2qewKod+vk9ePMZapvW2jwpasBHd+0/2FFaSZCUSuXlgKoox0dj3Dyn6L7yhot47vUflv4PPO0/yCI1oeWhsTllWFI61Sx9DVeurlkxinO++LmlqsCg9rpGLnZWQTcbqz7BvHMLUypNcc4wXCAD3i/QHXUsw9j19d6xgXcVJ44lYVzoC9rCRyQkCE64QtwjnrbHe+/EhOD4iXnuI9p3jd8mLkWo1VGXtO2p1jBYNM=;25:oyuuijpiZSNHIEQvrqHyv4FDIQtQhG6U2Kx86ma5Hpfj+IT67FaZZLGFrs5yrYOiso7BGTDTLdwVjq0zUMYM8f8bJAWh6ROtPhuVV9rmJKAkv1BhaTlHqLE+RGq6bbyCD9aeFhREe3n7glsr+exNt77t8UQTxzEKyfdPqZvxA3WiaDRiJoFVzLctjw5+Ikz5Q4hF/zKoH//Ir/5U/fV6azvOMx11QOHS29EAazwUBiEn6QGmbsgBpArHiW1OLVqEEIlDHV9ryBuhdnNnX8gKp3NSDDECbqryx1zT2LWegGt1mchmXwPJ0dWSP4PT6ardDquJqUduMohxXw17YfZdOA==;31:cSBT/HNtaLOyC5KSnJtX1JoLtsnljX7rDXuHaafZAwtjlg9VooVo7j3hjcEozp4pHb7BAknF5S6u3KD8CQplnrU8FS2p0A/EygzsGywSZM3HAqmcCgMtRfQu1ubdPUO1bjvpPBN9GjAHncynrSNxYJAtlBTYrgDwbcqoRuHWjeM3W0LwVLD9POoXCk1CUi2pX4T3xSho3T1MlaRCaVya7HhykaVg+D7xPVExjbGwgl4=
X-MS-TrafficTypeDiagnostic: VI1PR0701MB1887:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1887;20:LoV7e7VWPGwQEZmMWzxmemvV6djoaLCQ+cXfevGO+FIBGKuikIT0gvfycFNvUkKK2Sc4gTBPTat8UYrYEvxW8Ug8F3txjD/G7cv9P7VMIlftUAKFTAmEbMI1fAlUlAQNzvb1T240Y8u3ghXUinFCIImQA/uQ62rOHd9mc6qIihbbGjy+5c5jcJmsEnl3tkvw3Mx9cJxHo8BVcnA1ZnW+nUjNyUFLNgTkvYGcR8M7GNyEEPl8y1gq171FQM/3MvFah76zN7j6eygK+1xPmR1w73O/ZKApAHJ8k3ASkBn+w4Us5SSzN3sanv29tFSl5vyGP3dTrZSkbTEVACw/Slh+9X+BD90SchMSyGAz8p5YYPnKvbt3C69rhYrcIw3Yj8oZF0Di4rjpDlaeMrBiUpyuk8tx+i1aXC443s5nenDt4TKJX/KU9J+LYjj8grhxceCeUgxek3vZV6D//ih0cWx0QMXRzp8dy0aBwvQ0Oh9LQtiGDbHZJk92FrCc1RekChwbI3nUpnsAw2pbPqtPq/h5GvAO4Pr4ipId0mO6Sn7WzeJ4wFuxwjWMQ1JC1CyLoQYrwejfXQ0uhL8qIeDrhmx9Hrw3FfXR2Gq2i7IqC8aNxGg=
X-Microsoft-Antispam-PRVS: <VI1PR0701MB1887CADCB4AE86DD463E162388580@VI1PR0701MB1887.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(806099)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0701MB1887;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0701MB1887;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1887;4:9KrrZd7i1Eu+CXIrKydmic5kGz6SRyj1Qb6xo/hOjmWnKTKegWNIbO1DPYIuXAJCs5IaWdKVgG+Iym3P/KUjeq7baTtS2rtFGF6fKxzMQf81vNwk3/U/hwDup1hy6uC06VT+V30+oVNcGhgTC4ek6sUoUdRAGJYcWRilPjV/HuIXvQxjtRES4Esk4MUnbUlQ4nE86wyD/b1rZ3MCQOKYwKUfju/gVrQsjtemuHNSYM5m8QZOeYGNPPwr+/A2m+cBX08na6jyi9tt9x1R5cVUt8PMsIDsZH6RB1rKymMRHl3mHbN2QEzDEHqy+mYP0/dddhACSAFmhv0mS/dKkI+eCKJKU7VomY9NNb+98VoIdHE=
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(3846002)(6116002)(47776003)(2906002)(97736004)(66066001)(2616005)(476003)(956004)(6506007)(386003)(2361001)(51416003)(48376002)(486006)(50466002)(52116002)(26005)(44832011)(105586002)(106356001)(1076002)(86362001)(68736007)(6486002)(305945005)(6916009)(4326008)(7736002)(25786009)(14444005)(39060400002)(50226002)(53936002)(6666003)(36756003)(478600001)(5660300001)(54906003)(6512007)(81156014)(16586007)(316002)(2351001)(81166006)(8676002)(16526019)(186003)(1857600001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB1887;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0701MB1887;23:5lSkEPc5YJQz6X0Kk9S9IweVwA5fbPln4I5gm8S?=
 =?us-ascii?Q?A3Zw21c39qeN8GCnaHPNBmlBdMYBVUisyvSXLniYuY3B87KGlRRdwj+w5SfZ?=
 =?us-ascii?Q?pBydX6SVUrL4vvZ3DZbwYWbl/A9JL5y3cjYbdClLAXhUn5+ZuA0B6yooBiCl?=
 =?us-ascii?Q?3Vts82ghrq+eQ0W4FceI4FRMYHFEd5eiz8gYGeFsXEfgcIVxtalSC8ANPGPJ?=
 =?us-ascii?Q?bNPnEqEcbPBF2/RIqN77XwXdxg8sUp81+eCYPenTl/iarsTfRsR1kaORnJIY?=
 =?us-ascii?Q?zWN8IJNNgTKyr3aPTEnjbFEZ5rsS5ZOx4SMx0u8sUV/EhXhDKAPS6pKjFRal?=
 =?us-ascii?Q?ztDvkvEMOi3EDnE8Ogk06jjcXc5iSXHmThctkJMGOSNeO3Y5snYL2zLAygoy?=
 =?us-ascii?Q?3QoUqcHmAEX4kAv9CRAJe0Tjn4vipT/PjBvBv6slGpk0DyAxbuFpSzlJzjOU?=
 =?us-ascii?Q?MObYFlDkAcn7qUHl1+yqCRtjHMpbXbX+ucM/vykHqoMd2FscC7e6gXh17/n5?=
 =?us-ascii?Q?PIdm+yhI9JUYjVK5Lsyux3nykeQLfN3cTtFDCLwR3DqzyRRmsXId1x0+tA54?=
 =?us-ascii?Q?ua6DxMC2rYthgPmPEjx/uQ+H/FeRPAnr9AZ7ZWYSYUtsbhfuTXQyk8ohlnEn?=
 =?us-ascii?Q?Auz66/LFUozBFfFedjZitGfthhZGDHuIdzFn3ldb1ZJDeBaiYUQ+CxcoHBLZ?=
 =?us-ascii?Q?YEReyn2lDHuGMqBb/LpN/SSLQuVqyjo40rxWgaiGtswR9BBkLl8YALYHkgV6?=
 =?us-ascii?Q?lrlOjOTQaYUorth0BZDRbqzUSey0zsEiuSWvyNPYE8JHJVyXhSapIqMyyFCq?=
 =?us-ascii?Q?dWqaZgpt/VVN1Bp9FqWZfeVImTzexMdeHtt6NcMHoUP5eKqym4kX0KivzRLi?=
 =?us-ascii?Q?b01xieIOwu2NQhM3Fr89TxG99vL1vgMwiS5tFIFra6Maam3n9gw42Qefo6+Y?=
 =?us-ascii?Q?yHaiUzYzlIv1piuvC4ItqIiNZOWfOLaDya5M/vvaqVtgJz668skcctl3OAke?=
 =?us-ascii?Q?7N2I7bfe5tckECqJccpGrFoP3UD8nlGF7qeRa56w27sL6DI6rIYCtqSY5652?=
 =?us-ascii?Q?ypTgospp3NynGNYEdS+DWksBRrkk7jx/FIPctpmYWtcxFjhEnV2o0QbY5mfF?=
 =?us-ascii?Q?VO/xcBagKkVxFAV21Wab+vAt7a5e33oN2oMyiq858uVQo8R8xiDFKh57HZIQ?=
 =?us-ascii?Q?5ICMXbjPRPNRfZbG5ppPHewAFpFRWFzuAFhusrW99bohWDPnSjWz94tN6ir1?=
 =?us-ascii?Q?a2Y64Qdc1zBzV7FNCl2nqmVGM7z0LyPRUsP2B2YYP?=
X-Microsoft-Antispam-Message-Info: YnZK63WdBV+IxU02wYBQ6xijsXnO9qqh87g/Li/4UY2PHF9IWCZ17H2Rwf1Pm8xNpZbx2vbSHAuUKTWculclxFjLl3k5/09kGgaVokFM8e7IuU17goVqGtsoMKLXrlcTblWUF8q0WlX4MdqKespQNZcAsZ4TqjpmN/rPjtP5fLjW5Jd4pGC9EqetGolp9Nw0ASNE9SI/PklC9yssat3aaFo3XIJKtmH9rpps/iv7PKuLqKIrhLHJ/L1saNpTjYJU3Nhx1IWMEhp+JpwxksGbzjIFGJhSpTkKyYWjZ21a05F2w0xkGmFACXmZZ6GCehPu/6u7socgBcbM6VQ7Oz6ykWcBoRWgsp9Yd4b9FGdOEf1t89I/FlSIAGt7UuZEA8vl2WUVUar2dAx58esQ+agSNQ==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1887;6:72tnLr6DNXWkmJdEzpUQk4JijaFPA09AcVZkl1XYzD1Nw5DflvAKzNKRoATzLPqI+5L5FduYLzF5CK9daEhJmOn90psrXANTEDxz1rhS14yb0RTh7Syt/ck1A6it1/X0iDx/KAg1j+T9E6LYsoMp0jGHV87oMzYAIk8r2X7v/nFChpTN8tPziAHi8q4c9VfUw3nFjKVKz46ZeAC+B5TU8rXcsQcqKdfD99ak0xSJYlZzr60NZNNPnSrzS82+0/hD9pwIyAry14T8KTS/0Dg1ZDEimKWGTZMCtBJ60naFmOPD3aC9jGtAM/K4KVN4sWJ/ySl/m0BHRGFQcCB/tkBwTqosNBJng6wUqXbnqdCAWZVXyfJt8pAC4Z7UQOrcfIdDSrcZW+YdJxdRG8MnXe+Hl6R/6mcNxNhvogR9ZbJqP3atnTewaVbdEYlq+xvvpfnPRLuZjEjjfKSKrxMnLmWDUQ==;5:AUskcQIdLoKSMoOJKzfpuDgwx58GDir7lELGMj05PyxxJRVZ3iPXDgtbErmgYlC9TYiZWTuFAd6cKb4bY9UQ0MUyexXSw+l4BbpLALKHnHuhQtsYIdXRRGaegsWeuW0gZyUI/krZlZCyWy5afgcI76v/I+sI/hM3PKgsFAmKexE=;24:Us+HZYynz2DdhxGYO64+xWl9ghDT2lPVHWJQoB5xvHCKIc/+ZcDtMATgXdU0GLpzMTLda+eHWPjCock3jcTBDtu/gmckYiazEz0xF7pEizo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1887;7:cHD5I2t8HPbpo2QGveBGT2mOIWLTI+0Bpr+OA2WjLp95FcwRBplaUu8J6eRdjcDdN4vJRkfm2O3HB/ycArlImswokDIkk6zE7L639o37RjDq836iEPDuxVe1xOe9iPfVCnJwBE/omfPcB8BlebISHaC3ovnIwGqsZj0YYK5HvMvkNdHjm+e8pMa3DT8DtUEFFdioSwlJS9Y3PAuLwSeb35r2zKLLv3RqT90aTU5Xs1hF5Id0rnkMEh2FFvzKZJDl
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 13:52:05.2412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb420b9-b344-417f-98e1-08d5e8c7d1ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB1887
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
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

Cavium Octeon is an example of the SoC where RAPIDIO works without PCI.
So drop the unnecessary dependency.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 08c10c518f83..ac8a63d02391 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3117,7 +3117,6 @@ source "drivers/pcmcia/Kconfig"
 
 config RAPIDIO
 	tristate "RapidIO support"
-	depends on PCI
 	default n
 	help
 	  If you say Y here, the kernel will include drivers and
-- 
2.18.0
