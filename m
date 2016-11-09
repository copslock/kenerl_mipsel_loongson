Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 14:41:35 +0100 (CET)
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com ([104.47.36.51]:43431
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992688AbcKINl2Sc-j0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2016 14:41:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HPd3TZZByu/Xc9FCA1BOLKz9tBihH6tFReYl+zTWV5U=;
 b=Qm9nEUvka9HBX+NUMvcM6/gheOA5d2R78geLZNbPlewbNzrTrwFw9edysJbTe+A7wMV0HDhZC639YQSxRW3qovJq1KZhnFQzx8VzVqV0z3rfifsWC2XM/LOTfgapO1h95bHAMOSPGHGCKb6B+kj1Q5qMEfxBAjAJNnl6zag6eDc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (88.66.102.28) by
 CO2PR07MB2583.namprd07.prod.outlook.com (10.166.201.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.649.16; Wed, 9 Nov 2016 13:41:17 +0000
Date:   Wed, 9 Nov 2016 14:41:03 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Peter Swain <pswain@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
Message-ID: <20161109134103.GC2960@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161107200921.30284-2-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20161107200921.30284-2-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [88.66.102.28]
X-ClientProxiedBy: HE1P192CA0010.EURP192.PROD.OUTLOOK.COM (10.171.121.148) To
 CO2PR07MB2583.namprd07.prod.outlook.com (10.166.201.22)
X-MS-Office365-Filtering-Correlation-Id: b5d087ab-cd0c-4679-ad69-08d408a61667
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB2583;2:X5bmoX6D1RDEIFjq/nw25DOZR9poiNcFoRRDn7UATeFHuSXx/mMwxqpVuseJ2XuoL8CB8OfJpRgnGyq1HTWgu74X4zUZ3bMadUcsmXo/odclpKVMZDO340UahNFaPce8znOdxwoOn/NnbhqhSfTAru0iNSs8cipS4bXb3Q7EcnRJKzSL+0xCSCc4yPfmrUUXcWxka8o0vakSMPn6nRTHfg==;3:0tOe48KTgeo/U0RJYvXY3EpPTy2NQ3Ycuo/wZwPHK+aaqM8Cx0VwbBfcQS+szJknAYWMsvDXweW4Iw/AK0/Wf++WkFYoZCkwMe1XNDSq1u8bz4uawGVMqO56tpqTm60twiB36JTcwqf2M3/bhLEi3g==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2583;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB2583;25:JKOabteZKYSUIyKU0lEccuUgSOHlUNOUFyPJ2J7sz6fsPmowYa9/lVlkb7nxasTjMV0NHE7Nquaw9zUGt89tJksmVBsZCSGf9pQcfTTmhlzW/y/rRG8lRxjycG6a6IBHZueoqxnCx6g+8ySzqzJzQScO1YHlT1j2Lc1HBM/sANIwApLd+31dtPYlSogVifBCnMarkRO3LbEj78/qWImyQnL7fjg1wfHXLkylYE8Veg1lOpbdSvMkmfvOoPVkupDayv7dkFsIJrktEPg5ypvC8B9mAHgrv0LlBp6F/dMaRXOx6JkACNyu1KJCoQwvARgyeHH8D4WUvBfAof9am315D7XuaU4Nn2fVQbJT1ghX9DTL3JNHFvqSg4f+uQBP1vDPyEXG/7SVRwlKqUNdw/WJuBPQjodVYyyUaAF52/tteF/2XvWGMYqDfrxygz5VeeepQNc6ouM3amDJ4HUcwyQr3uBTd40FNsh+G/ui5S7YZXJ/EyuM4fdxP7wzE7dIi2ZDQO69Yb0MeYajmQu82Fw001idTRvjBH5WcilOnNWL+FYh8UQmqLh1ZnR5S21tOb/FcWU5D2jes6VeMvk1lMF3xNg7DeGW9Coboh7eeJ2IM9TrNZFPQyzX5HX7nnN+VX4/Oomi1y8AcCM4W+Q9ntbFazTHBxYz704lRbTgI0SyzS31i4LChb0Pg0R7my2G0gFLQDxAYxeceqA4RE0I7us5w/WLycnw4rA4nfVG0av+lJkvBYJUTgxTdkfNLxTmzo33D1OgJ0r2bko7UbN0koYO84p7FS97eE5RwAzEMhh5+1A7Ot4X6/iMfSfR8xjN3jldcLjb0bspJ0kpXVloN46aNg==
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB2583;31:9+jPy7vKmlqqZizP4BopFHtkmBNo9lICVc73rueL3KUp9aL3iFd9Bm9ruAcNZyLBr6OHnndMkWN6WmIOVFNXBQVIJEZNNyv0UZZJk6y2mbhDx1TCPHZa9+w4rCMI6OPQVaipbTzkkKquyg02AT7cpBWLD0ORYIvcfIJ59FUDriwut4MJAyaCdGN11XfSg96yr4sVg08b1kK4Upz4HNYjbXoP9bNtVhYKufmNV/Q8MPEu313o7ALibXodiPrwtrJi;20:Lwa4xlkNpA24c0Q2+Qw/+/27X2OyoESf/U9B5pRs+kvUnQsi+Mp8Qnfq33hfXaut9uwlQKr2+TrMYIeoqZ0ec8QemZg9SrDbTY19Pxc07EVISJlLuClbfO1CZqbX3JmmNv+t2V9OSjZw8YLafy+28IENRL2Q+FXvVGNXQ0SsSZdy6xSOa8/yLZLx+bLPE9BnuOBq83GTsazcY11Q7hhuha1Vom63YMhDYBY+j7DIEpnTxpPU7DpraZuTTqgDg1bK4NwbmSI4vHiS4HthnPKNQ6nZ9U/L1DsuQWVHBDCKwI6KEQfFLE7Uy1LqO3nHV/P0ZUU4kvXYgvikEssSoHctOiZlpgHzeMIEC9XSRYbe0GEkhIKxbA2DPLKR1Yr6sSCIeo+jSXbXbFUg3o8omV17f8Ilw7I/Z1hQJp+RstS7d8nizhh8J31U9tJnmaGIpz9kLxUkY4EjEON9R2l7l4hCPAtBPKnvCS4zZjjsTxsCRlXkI/9PbXif7Pu68JU1i/9Hlbmp+9kgk5V2p3fw0eVFPFAnpIYrXSeQDNAq2GgUoh3yT1quZgtLDlUG8tCtEMyRu/Qrd3NFHuW8geoQk1pWo0f58Yz+pNBDqu6bgqy8g+A=
X-Microsoft-Antispam-PRVS: <CO2PR07MB2583FD046EC0E23C999E1CE591B90@CO2PR07MB2583.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:CO2PR07MB2583;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2583;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB2583;4:1yiySi2V8A07kH+6xrBWiP5VxuRpqWnXAzmhiOMDf/KaWwsl6MwRZbFkI7SUIGa61ABbPwhl8pGwqf1OOD4jqSBuVR+5H6K0jWvrU8/nHHkF0GOXvTLrdRyYNbmSGWvh5MBrc0kvmaTVhirNv19G7mcSD5ECkThz0zuMwoqex7DDspckNfKyP6qZpro35BGrw9VL8PxEuUFNAWjtdhnSosNoA3tQAMVaPldbKWtHxUx1FxLNipaPXCcI6Km15xGKUP6eSAGCmn3XKchtC+mn9b4fd9z+jUwQaQP/LO6aHRSoP3xQyEZbgAcRnStpUR/dSGziQpB1t06SXsmX6cIaUWnLV4CclM4EfZijehtjuWAUFvPj98GVcqIbmvEVNohS56T4AEqFkZ6U9Rg6mnyOKSf9pIGfTclWU5/sGlZd/GeaFDj2fiq6LdF5XVHlyyuU
X-Forefront-PRVS: 0121F24F22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(189002)(92566002)(4001350100001)(305945005)(7846002)(15974865002)(23726003)(50986999)(6666003)(6116002)(66066001)(2950100002)(9686002)(46406003)(83506001)(1076002)(105586002)(2906002)(3846002)(7736002)(42186005)(33716001)(50466002)(5660300001)(586003)(76176999)(101416001)(97756001)(77096005)(106356001)(54356999)(4326007)(8676002)(189998001)(33656002)(110136003)(6916009)(81156014)(47776003)(97736004)(68736007)(81166006)(42882006)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2583;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR07MB2583;23:Cm6C0BJ2MXIc1ShWSWz4nDpMfNR62i71SNEm60UBA?=
 =?us-ascii?Q?M8gFXhaksf1pY4i8hQhF22uAJLFPYoHMHjDlhFOJdP8u+GnMis6zSQFQcrhj?=
 =?us-ascii?Q?93HtkdF/KOUGyhkltXT0GpFZJ8xu3lVCCF3xM42jAVHLrqXRS02TSmbbQpGV?=
 =?us-ascii?Q?r1KooT+a/x0O3lNI3Vg3QxdAYS6s1MiZTnIduPvJoa1gl8ZWE/IdgkhEyiOx?=
 =?us-ascii?Q?tLFUe/6+vopUPpZArnN2Ftv6IiTPrNuA9kFUxXyL0BgyUUBp2U18Ev+Ljtpm?=
 =?us-ascii?Q?5lAQ5eAnx3YbR3BcfR7d5bHNNP3vxeX2soe7SNLLbSqrjYCUqe3I7N3wcCxQ?=
 =?us-ascii?Q?76bhLGCBSkmfiU86+Fc5nmB2rCq5D50855G1bJu+EW3YGUNJ66wQg9Z/hoYW?=
 =?us-ascii?Q?1dhRMa3rXDgopq3xU+QK37DR02HWkte2yWPatLQTU91qb5tsa46s3dxGwyeO?=
 =?us-ascii?Q?48Wv62R+HCVXvwlh+td3GxO5WierjugHy3V3d0RDwHGYlcGCZsa3Bl6cqamq?=
 =?us-ascii?Q?HZ1fY+ZnCKZIy60TEmXGEoSw3BjNfThEjHMG4tpMb12ngmLjXWiUFHwmFJoI?=
 =?us-ascii?Q?Psfqy95O3s/8weJ6DeGLINNh8iLi9TZTZipxcSuJsmfl1aVYA1n5OAbKkCJU?=
 =?us-ascii?Q?dx0FVptDV9woiIa9H2vgNAX+Hd6EXW6mWn3BPWrKp6hUxnuuO+FTFxnlaVWb?=
 =?us-ascii?Q?4J3BC7qW4YYQ1eVx+9m5mtPepj/TuGfUxU1yWNux+UGdRpedTqz27s5E2iP0?=
 =?us-ascii?Q?0gEl6fjOVEJ0yhaf+jEW4TiDRe0gmr8qLzcWkuGpP0J4UufWJTYo65uB3wJL?=
 =?us-ascii?Q?7ZUA71sApjb0z3eIfaJwfXshDPGcIgkmGSRahRxSoc6+i9tkuV/akQRtoEZS?=
 =?us-ascii?Q?F2pwhvM634eB3fBWl5PLfq7XDCAjqSWUB8lVD/JMqvUKBOOXp26Z4nJssh8+?=
 =?us-ascii?Q?CuKnWs4hQqRfqVF3vrRip3UZF1QLLe4wKL6/f/Eg18IOgmq1IGRmyP2xj12T?=
 =?us-ascii?Q?y+kRkdimU1NzsUlMJ3OravkFp+XHetq9kTlBtjDF7agop4+I3XBtZotOhE9r?=
 =?us-ascii?Q?PV+sF6cICWsodLlocb7U4ZcPRo9KsSiCCSwkiQj358/ZQCGC1Im9QHeoQVas?=
 =?us-ascii?Q?NHyH2CsjzKlnmcaacrAD/FOsL/L3xmrD0xK7jUwRLFWSJPgZC21iGtQHyoJ8?=
 =?us-ascii?Q?Kc2Spop9ZBvKDM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB2583;6:aUQQ1Bbq+rRtocBBt/iO+3xfYkIvJWl1yj0tjCdk4UX+DJzp7ijnLqJ5eaa1F/76UryKsPx34rDSHnEJxBjLVqHxUCOGsa4YB6l5e6ayti+jk30KpVR9Vu/sA5+sogSZlQpMabeU8jvThy6IMF0YrsqXP4QvGyu/OQjnXV9OIPPVyObVs5amOvK/YGk6olDFEzvSVQLOz2UMFW08mLvZHrWJm3aMCEPnLQPPRcLD6q08LY8SK5tY9s9uGNJsopKYId7iigkfbr4tNFHOtGrljgx9qJZS8xDwafRlFMI5VLYVUUgV9ODPjGBuhMAVLAGx;5:GP7HtAYfpP1+xcAftQB1EhK9CQGLyRwej8jAsYHtM03vZN/4NZF0fXQAUzh/3K2WyelThBK6/6BLnVu6iiXNOUFrP8MsLc88eRkQZkJNfoWoFuhZ76FW96eCL97e/fBVi8p90fmKbOqY5GNIml+/ntr/K9nyG7w8Vzoj1y0a9MQ=;24:fgJe/EfSwvUWbr4BciYYQH0ZS/9msvbORk4oJI63Hs8/v77vss8qb5ewddCbQPO+SrthK3zfLy55hkPdoQpOhw529hAzrAmkREVoyiCnYLk=;7:8bvAKh0evPatORSJswCuKDsLaFMUe5VUFspNgUFNj0A0fAUeTTz9DKznzZ0zULUpBYd/hWsYjPUHbpdFzgHVe4FFXI7Jun1RGuF4Df0jbRm879ugSZJfgvQ4EDvU9IUkkhvdXBazrqMV/jA7RyJ2PqSJ1uIGYZ31CBK6liITWS/d3NiklnV+VOv4Pz8Qjp9FokTHlgvpfmuNFLBIhBS5PwLebAg8nOwQfd2Wnk+fyuKKPRPdmjh5AW+YuzpkpdwVMhG/EBT+jVlogN/TcAXFPB1/HbzGgsNeMjNqvDmVO217ciMOm9sugA+cnuhsxEJqJL9q5dJMc7kIfC6jqPO8uk8PsyBaD0AhUzzNzadCfx8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2016 13:41:17.4412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2583
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.glauber@caviumnetworks.com
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

Hi Paul,

I think we should revert commit "70121f7 i2c: octeon: thunderx: Limit
register access retries". With debugging enabled I'm getting:

[   78.871568] ipmi_ssif: Trying hotmod-specified SSIF interface at i2c address 0x12, adapter Cavium ThunderX i2c adapter at 0000:01:09.4, slave address 0x0
[   78.886107] do not call blocking ops when !TASK_RUNNING; state=2 set at [<fffffc00080e0088>] prepare_to_wait_event+0x58/0x10c
[   78.897436] ------------[ cut here ]------------
[   78.902050] WARNING: CPU: 6 PID: 2235 at kernel/sched/core.c:7718 __might_sleep+0x80/0x88
[   78.910218] Modules linked in: ipmi_ssif i2c_thunderx i2c_smbus nicvf nicpf thunder_bgx thunder_xcv mdio_thunder

[   78.921916] CPU: 6 PID: 2235 Comm: bash Tainted: G        W       4.9.0-rc3-jang+ #17
[   78.929737] Hardware name: www.cavium.com ThunderX CRB-1S/ThunderX CRB-1S, BIOS 0.3 Aug 24 2016
[   78.938426] task: fffffe1fdd554500 task.stack: fffffe1fe384c000
[   78.944338] PC is at __might_sleep+0x80/0x88
[   78.948601] LR is at __might_sleep+0x80/0x88
[   78.952863] pc : [<fffffc00080c3aac>] lr : [<fffffc00080c3aac>] pstate: 80000145
[   78.960250] sp : fffffe1fe384f600
[   78.963557] x29: fffffe1fe384f600 x28: fffffe1fe384f860
[   78.968875] x27: fffffe1fd07fa018 x26: fffffe1fe384f968
[   78.974193] x25: fffffc0009a2b000 x24: 00000000ffff26d6
[   78.979510] x23: fffffe1fe384f860 x22: fffffe1fe384f860
[   78.984827] x21: 0000000000000000 x20: 00000000000000b1
[   78.990144] x19: fffffc0000e330b8 x18: 0000000000005bb0
[   78.995461] x17: fffffc0009669ca8 x16: 0000000000000000
[   79.000779] x15: 0000000000000539 x14: 66663c5b20746120
[   79.006097] x13: 74657320323d6574 x12: 617473203b474e49
[   79.011415] x11: 4e4e55525f4b5341 x10: 5421206e65687720
[   79.016732] x9 : 73706f20676e696b x8 : 0000000000000000
[   79.022049] x7 : fffffc00080f5740 x6 : fffffc00080f5740
[   79.027367] x5 : ffffffffffffff80 x4 : 0000000000000060
[   79.032684] x3 : 0000000000000000 x2 : 0000000000000001
[   79.038001] x1 : 0000000000000000 x0 : 0000000000000071

[   79.044803] ---[ end trace d8af6005f683d444 ]---
[   79.049413] Call trace:
[   79.051853] Exception stack(0xfffffe1fe384f420 to 0xfffffe1fe384f550)
[   79.058287] f420: fffffc0000e330b8 0000040000000000 fffffe1fe384f600 fffffc00080c3aac
[   79.066109] f440: 0000000080000145 000000000000003d 0000000000000000 fffffc0008853920
[   79.073931] f460: 0000040000000000 0000000100000001 fffffe1fe384f520 fffffc00080f60d8
[   79.081752] f480: fffffc0000e330b8 00000000000000b1 0000000000000000 fffffe1fe384f860
[   79.089574] f4a0: fffffe1fe384f860 00000000ffff26d6 fffffc0009a2b000 fffffe1fe384f968
[   79.097396] f4c0: fffffe1fd07fa018 fffffe1fe384f860 0000000000000071 0000000000000000
[   79.105218] f4e0: 0000000000000001 0000000000000000 0000000000000060 ffffffffffffff80
[   79.113040] f500: fffffc00080f5740 fffffc00080f5740 0000000000000000 73706f20676e696b
[   79.120861] f520: 5421206e65687720 4e4e55525f4b5341 617473203b474e49 74657320323d6574
[   79.128683] f540: 66663c5b20746120 0000000000000539
[   79.133553] [<fffffc00080c3aac>] __might_sleep+0x80/0x88
[   79.138862] [<fffffc0000e30138>] octeon_i2c_test_iflg+0x4c/0xbc [i2c_thunderx]
[   79.146077] [<fffffc0000e30958>] octeon_i2c_test_ready+0x18/0x70 [i2c_thunderx]
[   79.153379] [<fffffc0000e30b04>] octeon_i2c_wait+0x154/0x1a4 [i2c_thunderx]
[   79.160334] [<fffffc0000e310bc>] octeon_i2c_xfer+0xf4/0xf60 [i2c_thunderx]

This is not caused by the usleep inside the wait_event but by readq_poll_timeout().
Could you try if it works for you if you only revert this patch?

Thanks,
Jan
