Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 00:25:02 +0200 (CEST)
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:30880
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994637AbeHFWY5MOzhz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Aug 2018 00:24:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kH78pPC0dFa7M4mUKLIG8AI8Ss3BT+a1IXI7n628KU=;
 b=ZiEHiX+zZ0K7Ctr5Bj03Jlq1m9VhKW0vFBhFTLxoT8u7FNiCNJjWeUJaEf187F2gmpBWKH4qi0bjaqaQxyz0PxBsyOSqJ8YWQD8meVcT6jYp0nwiBrcK84VC3hQajYkbXUKUo/X3xRW48OvDaOJfLFvrKN5Lt63wj8SDc3zsNC4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 22:24:45 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 0/3] MIPS: clang/LLVM build fixes
Date:   Mon,  6 Aug 2018 15:24:24 -0700
Message-Id: <20180806222427.2834-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0045.namprd20.prod.outlook.com
 (2603:10b6:405:16::31) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79646407-b3a0-43bc-fa4c-08d5fbeb6a5a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:S99s0NsY8KSnjqX+o7IIyMdJdFNuaolPp00ZGE0aDdeeN0UsnCGUR7CmDv14R4Xgh5Xe6Wloe7NhZ8Y/gmD8XrrAV1DXV24FGfdLZbQ6hHZ+gLQpCEXQnFyAhY1BPdfRUbTaQKlEvKHFloZ+A9EL/UIv5lh1UMuS2gvY464Trs1tlpxALicRq+5UMxJTEpga2zifC30oHoMwcCGJfVGUA0sgXzgjcl/DAxYO1IuxwrDRvqyFcXErMvxTRhYj7l4U;25:zBKmuqC/NCD3HGdABQ9lR8Bt5s9TkCYJIfo5A1/bjviESfPyDAvMyRgrrAVnDH4+O8ZLd1iuqRfPXe/29iur5eYRRNsMvJXofeJthRZeeZiAfbmFzBDw/U4Nl0v8vF8vcCbgYiXR2W8q4iJmxgDp4bQG9m9viNDCUHkgZso3K4RNNbWXx9pgQSKe9+3c9mFnht5ketD5AJw3E87Y+XFmNw7T73PgtX90AzBa7IJUV6A45tfZ2XeGSfgv/9InZu0PW7r6O7akrGBkGi1wYTPJcCUb9TfqSc5V9o91NclTltiqmHYn0/JfhgdY6KmHWiowGSVLz8+B+ST+5eMPRZrhTA==;31:0PD28KWc7gBBjhrN63eJi2VCfGvYuv6XTEqMc5vwpArwFqczGczwGcGmK0tjWxT3FaRb3dO1HwpIEk8ciZGmUenTdOnb+U8PoK3cy7QFjbnLtVuaJEhojniKxM2+yIMSI9aOwrFBNFLo7gjTamPZbCRKmp6mbHvCidMMzmMQoVWVVe0DVFFK1lMEMTBjZUpLTxrve+lPnt1nxLsuDrlEYolYVVMA000Ar/uTNa+mljs=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:OHpvIs5xQl5URspxBCCgHd2SVKAh8++KTJutqjquCDmfXN74LtldAxa17zUYSnkO+LH19WwZkBKoHkmX6jnYkHgdCurSHrlJqeW0Z+3UKC5z+jpCfE3Uoix79JyX3R+0zrEqA2mJLJTnmEnSzbFpX2nafowA4N2d1Z4GJ5CvOG1RrUGrNl5aJKprLpnzl5Y7eO2tsx5xMgn/lJotVD2QrSPSaQJCmDHe4UBPcP8zFNvh+zcqv7Bs8Qm5OrEHu8jQ;4:1ABgbwTmsgxQutMzkSOdpnd6yLlN+Ef+5eD6D8lTwEjrbmyZ0z5IXeREnOzRgS8KrtA+ZS6uM5VBmIZIewvTuIlqJTwC5UvjxLJQ8prQahw6kXkoDfCYgpWEx4LNE25HDGVIFZvA8XxASSyuWn1URv4z3Hp5JTthDnjeLqvvZkuCr87jKmFgIubZLobyjwqFSlmSKKVSs73aC3aLMO/zCQdaHgOq3jJZjz5HSzvqqmA6XtpQiCHvEXQUwflxGCmavOc/uwZ46FMMYe8ftmiSRg==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4932482DC0CE73B8ADDF633AC1200@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(376002)(39840400004)(189003)(199004)(97736004)(47776003)(66066001)(42882007)(7736002)(476003)(25786009)(3846002)(1076002)(81156014)(81166006)(4326008)(486006)(956004)(2616005)(305945005)(8676002)(2361001)(478600001)(68736007)(50466002)(6116002)(48376002)(69596002)(5660300001)(6916009)(6666003)(2906002)(16526019)(36756003)(26005)(186003)(6506007)(2351001)(386003)(44832011)(6486002)(316002)(6512007)(16586007)(50226002)(106356001)(8936002)(105586002)(54906003)(53416004)(51416003)(52116002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:0trvWtOFEnBI5NC0TsgAbymfoX1CTCG5lKueC+/8F?=
 =?us-ascii?Q?tlVBrSKloZ++UPdGCoARu0nk6fzmYzo9E0lF3NPy67ljaFwjZWi+pbVxgMAV?=
 =?us-ascii?Q?9M2aav/cQ0+gvI6zuecYQ48BHnFA869uJkG1rra7PgfGY5tJM50Xy+BpF69D?=
 =?us-ascii?Q?yXzCAXnZ/gYfevF0TUkyMYyQg3x+oSq+QOljQPxKL8ABkxYCI2inKUAo1Iyb?=
 =?us-ascii?Q?rpwIup6I3+dOxjC3PtQcDYTWlCFbnt8oY9nn8ym1xtTPzZjAC2Lsns+pfjUB?=
 =?us-ascii?Q?YPiA7jO/ysUL+au4yWSlPbsMpuODB4bmg3BRRUgfixrOg032vTdfBQxF2+6X?=
 =?us-ascii?Q?SsQhzS0aHtDg9Ic5UUr4IjP8QmyhWOkJkBooBjMDW6IV55A9B8dYV7h96/JQ?=
 =?us-ascii?Q?NJrRn2qoYt3KLqXdN6WIPLfA2rWmsbo6uWtGi0U/KIz8BerMAZWvMrDMsiSF?=
 =?us-ascii?Q?+VSpcCZFplCidUN5cri4beKXi7mIpM+G8tIxh5aTVbs633JU0k79VXaE8wkT?=
 =?us-ascii?Q?hq9YidL4fJZswRzZaHM5FAk39ct8cEb1t/c3oC3WJ3e9kdO4CRSkqtj3sIvN?=
 =?us-ascii?Q?AV3iYt52L4jugl+Hf04CUcLtYuespGYBAYOfXIoFGY4p4eXuq5uyZMHXOavH?=
 =?us-ascii?Q?+ipcbPDAnWdDutzp8SF9VyL+Z1w04xqnBJSFOOTt519X1CmhqAq8+b+gU84z?=
 =?us-ascii?Q?fuq6KXw4nm9ADB/XMZkr8k5j+M/fGh4mKTv7co1YLJjxmEUFKCh2rdSLJq3r?=
 =?us-ascii?Q?dyNDsKxbhAId9//S1Q0hVn17JHp67EOX5g84jvBwC9TiiLQZOBwnC0vkZSiI?=
 =?us-ascii?Q?Yia3dsqal2cOxYxorOL4NWZamy+Pg4GRxiuMSNaQV97SFmB4ItVJAF9OOBLZ?=
 =?us-ascii?Q?cV3EV4EnhRnJ3AY4vyvzNlT+7zzqRIVAJTE+xGe2UOvIo3mWx3PQVIqohfzr?=
 =?us-ascii?Q?V+ZNyRto3snUpVRFBpPRs0DV2ifFnxSLyniviS79zuAgHzubFvnkCKxGzMMh?=
 =?us-ascii?Q?4/jgCIK+QOTAVywHFLIsV6WL2xbdbbEhrYfXyPchD12SbdRlwXENHTA0ZbAS?=
 =?us-ascii?Q?meS17A+kwYElsNXODRh6dwmhSJkhLRbl1ESjXoDzSn5xgcnBBQNOJEgU5WLf?=
 =?us-ascii?Q?2Hf0U7c2R/jy4HKqx/DZu2MRupj8zvDNZTFYin6CXv8WD/wNfGdLfVJrpD65?=
 =?us-ascii?Q?hA2IhL9yrk8Sa9iYbfziWXEsfp2iBhTAVkxS7Bc7KQeo+17WxWoL39FBnsg+?=
 =?us-ascii?Q?6u//N0Bmg1R/AzMpJY=3D?=
X-Microsoft-Antispam-Message-Info: rOcC9HG6eo/KNvcB2C8D8gm8Nda3h9XmD673aNxywhFUR20DWOJfjj/uoUn0LnLJEW/LnhTyh9y8XPAvq+FDGD2uzLFEpC8Je8f/z4xGh7/4B3kGh/mjV5aSgNhLRd31+V87Nrujm8KJhp0/s0wlYT8ZC19EW8Fqc3K7Q6yjb5dISOLy4lysK4uRVY0C6V3pZzeq6yqQJPeRmlOOXLyjFI9iP7cjkj40/bOSYoxBSteFT0gnVrAQcnZfSxCM5elMkTG1zcOvzR3v31Y9QxVKKL0tSRhVTdYfTiytxDeeHWNNHVdn6N4USGuOtiMQ7LUu0ilpVffx2ULkIR65jCkcvjrtiBbj4PNhwUxtmFVlAoM=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:wz0X6tjZnpSRd30uwamvenY6hbzvWxOPPJnXi6qLFV4plJf8NG/ogje+dzQ+pU2s8y9soFG1/D+Hu4nj5ZJymw6tbu/j9RoieUUgwya57XuzSAHFW+6hoF7iq4vs6z2yxKFaUXo/xlAATdC0aA5L7Ag5xayjnqqH6VZCt6T/TsNG67770dmkrWOY6C1vSm6HTLmUy0Gn/9CDPQjkRpc/P7wxJsfaE+9F+nP78/2wvFX9y3hgnLL6XlHnFcuTH7wN/zGImMNt/OBOLUzZSHP4kJ8S4gdjtWx1vscBS6dtTPvZ6eGxjMw58dtfpEczA+8Hixjkys5Za1Uiv+rpCWGTKIgQjaoyKOsSJFQ6tvvfaEBJeyP3m2+ZnoA1lpqfvN1YclLzn+tprm7XifrA14VE+wQmnbMDWwlbg3uSqGTwU/vhg4hUSflk+mJdKtdE8PI2MA8MnqUi2ea+vhVaDD/RSg==;5:OD01gXGuJC+YuZxDuQ4nvB1OCWuM+MlW8nQBeqDNTeLN/ZojFF066oFyRrQZ28rJWA2xjPwmufGq9Ur0s4/MhkiTeI/zmg9yoYI3d13N4cJJgLqC/bpcX2xTntm52uyWA1jZLrpvikE1OilcSbz1BDrijkVsYkvXUZeCS2cekCs=;7:iZFx6+EpPQ9CpXWvg3AzwC6LouKoqsp2EBek7uiojM73o/Eq0+gPNN2aiZ+bEPISxmIGp17nxwV8oVB2bBsw5WQX4qFPu1NYJCu3MGD254HKI8UhyRULBautvFh4EnngpA3X5ZU25VKZG1br/LWD6taRTbk9F71pdOlnd2pWbgoMG6hRvMngnTGN/HyI2UilBTZbOioMOvO3H51r86I0dfwAZtK+54rhJQ2i398oo9UaKVWTzyGRJIRfOc5ZkwXi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 22:24:45.8393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79646407-b3a0-43bc-fa4c-08d5fbeb6a5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

This series contains a few fixes for build failures when using clang &
lld to compile & link the kernel.

Thanks,
    Paul

Paul Burton (3):
  MIPS: genvdso: Remove GOT checks
  MIPS: Fix __write_64bit_c0_split() constraints for clang
  MIPS: vdso: Allow clang's --target flag in VDSO cflags

 arch/mips/include/asm/mipsregs.h |  4 +--
 arch/mips/vdso/Makefile          |  5 ++++
 arch/mips/vdso/genvdso.h         | 51 --------------------------------
 3 files changed, 7 insertions(+), 53 deletions(-)

-- 
2.18.0
