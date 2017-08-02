Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 19:39:51 +0200 (CEST)
Received: from mail-bl2nam02on0050.outbound.protection.outlook.com ([104.47.38.50]:14496
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994848AbdHBRjnKPDc0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Aug 2017 19:39:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Y7cEaVkpceq8QjVKr8/tp6dqtfW9XDBdw8rQ0SFnD60=;
 b=k2FtRZYgbueCLPlKPCIFAb6NlvRj8o03NW2HHD1FCZB+zqBh5yEJYnNihl+8taOXWiyPXzoooGkicZ1gfIsgARe/LhyTDQwUNT/2BkP4UGb7sZIdeBIub5Zwt9aZgNRBLUlUOsPrnQEXGQA9LQAb0CpaXV3teTpMKKcOUR84MyY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 BN3PR0701MB1220.namprd07.prod.outlook.com (10.160.115.139) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1304.22; Wed, 2
 Aug 2017 17:39:31 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v3] MIPS: Octeon: Fix broken EDAC driver.
Date:   Wed,  2 Aug 2017 12:39:28 -0500
Message-Id: <1501695568-26051-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0030.namprd07.prod.outlook.com (10.166.202.40) To
 BN3PR0701MB1220.namprd07.prod.outlook.com (10.160.115.139)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d61c62-3662-45d6-80b0-08d4d9cd6f0d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN3PR0701MB1220;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1220;3:qNnBPSxjGRVhBUYtsy+wiaiC2yy59KXw/aGRiMMiq4QoLW9ztAQamjcwNmmYkWnzbMZpI+hY2ITxw2qxGCnspagOKUoM21Tgj4Dl2WSOH3p30mcXgZMtYEBntI4zBUaj+FyNsfGQtNSHKtab8mszxFaSGExdZwPDRRlQc62TorS6iTCdXS3LIIPH1FcO+8OALK8tt5B8lT3st0RvpUU48LSpPv7HIV6s+0bhRdkkYKxQ/T6SHnzbcDTOC7qWJwOD615QXIZTnM/8hw1EF5snQBo3NManjFm6Rnx7+34XWRI1fxC/5biaORYAiYWrG8IiYfkbGeKVKYJq9XIJuXYncLMDQ3Bg63oQz9eBoFhnV40dl5KNjSC1vC6vPMBufYSk+M6i8gv8JRj00SUX4HQ5lS20Uu1UJ/dcsO7BRggYuyZwz5Zca4hDsvcCuVThVPjAJUvHtdOoQRwGoCXNF9rqEovcDKgNjYVQcodjDkNoIMPkfSO3MJFI9yINvlaFcH4U0yiTHPjVpmmfCP1blizfTzJ4PUi9DrE4whBjC+S1DcI7R8Ba4LhW8uDW4n1vdh0O0smnAw635SOid0b+P2rDlhaW6BVExZxiK5WsqQpFzGxXfkex8ARku8tQKdW7c8a+oIDYSgZTNImpu8WiXk94hVL686wX4N2icCaHL32CkLfV1Sp2aQjjs5PXJAgKtGcUr3X/btxVFTVUpAeaVAySTrU5f+MH5M8QghcgGFEHZUC1wPTHM7DqVGw/k6IKcweCGw4nW1eovi0wRx86L5MDVks7iPSAfcMIVh8ZMjFO/S0DWkMiV6AajIoT21s3e5bl
X-MS-TrafficTypeDiagnostic: BN3PR0701MB1220:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1220;25:zdy8KBOMGw7knGG/YzO4HM+P4ITMMVsps4LqQLLf5BbkcL4SmnSODM27WEL2+75hxY4jARPAbtF7BR/p7HAE9mLR3gj+1TLbLxujHwYFksIeKACZSlRkdN4tgIXjm7Y/rcBEXn1MAbSHbmlMALJWnmtdhL+J5ZQw7RrLhfLFQu5dDjVoB32oIQnO1nBgT1tBg1g87+jey73d8uaNLJZ4caTuFLn+bdGR7iy3Ic9hGhhBl7EWaAe3i4Tjll68aS38hlDBGWjdQGViKs2bSkJAeUiOgC6BPHXGcz/2GgGCI9bdCUJZRF8uDAw21UXV5VPykWLO6lZHPDnhzvVlad959TjIIjOOSRo4jNODcTmMdyoIfYkPMqskoHSxyYTmjVRU8Prg4p3NH+J1cnO2dCAlhxsp2VJVqMOQ6Lcr68ZD+W2/Qg0JvtSKttkSuNflo3c5QLO7MRmMMnV/qRlUSv9rMW7ry3TYID8kU43jo81fziF8hsVPDcQSNt239yFr+JTiubpdq1L9PWdh0VHpYd3qCn027cLsT6qirA7PMZuxKfZx/emriYvrESXsCT6wdrnWDLpiPXhpebs3fp0hwwK1wJomDFArVxb2LW+0I1nHq6NT8IttovxePIR9qIMvYyD/4qQTx09xdR6XRV9LAGJXbTxMd1HtmDVivN1U/nQjFDZGrZQyPSzQU8YF8C8yRbhMWdomz17W0RL+hQoosqxegpSc0nzqh62iYVqQREOK+S6/Ak8RfEAr7qLPVnmzQa6os4kM4h+hnzl7xbxNfdBI7h5gz41+TN1fVDzHwJ8dMV3NoKDy+JaHpW1ins+FiK2cQ/I5oHjzArY1MZIW3H0HIIHdxYUSngv9Yx7W/vU2H+zPsDCvPHzTGpaxVom1a+Q+Vl9DqzkBPdpsVcSjTPjTYQ54zPNCpZyVzGrqayad8FI=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1220;31:zHlL/5SgkH9RRh0uuCzKKc7J4jTjorIXYMl0+YHwGwvtQqzBi1wsNhD0vG2cuEGxq3tk/A2H0JFwNouhJcf4I9HBQWCtf81u32npEz35ChkGZhp4AVRZ5qFoozFJSGqUe1KIgEdVvB3pMC9ibd9bYxh0DzQOJKrpOrmqxhFBhEcnR+vajM/1Jf+B7zQWXtrkXYObQKNmwFXbI8ioxnQRibbnbQVCvAbLdFGZLeVP6eg7CtJtNd+ATMRYP795gV2i14mqvsYDHf8WTD7zaoRvJxXm018W4a1+fT04Gh5buuvPHxzK9fAAZvUsAC1pUhX6juJCHEgJ8yjRXphOPTv1kXusEW94tMLMcpo0rdRCFGAKoOsOFYbZiIf03fTUlXXkdHQexxusYgrqIVCiHeeU0DvxvESc6AcEE/kpebLVQssVaXrrjuhzIAdPWZ62bOfUztEJzSpI6sZTJep+97hoqetORvYFhWM3M5P3o55Fp8p8hw9lfs/D1RXud/PCJzmgg8y0RdTiwxWYDD4Exc5JvcF+xGBxvnM/3v8i0PckaOn26R4cRi9rUlq7em6b2JPb50Ras8NjG3jTjdin28Wmo+C3/uNhjM+00uF13mBDrg8CMuS5ChKKBgUnDLi3j9qxRLP4gBugF+L8qc//aXYxtn8DJzB/PKpUeFAE+9ekzzKU1T7IciXkRdHhuQW7LXy8
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1220;20:aKKamzyOxyU7/MMDeUq2TqQ5EZd1yvbgeOt/oZj3BCO+OBlAhV7kgCP7aAFPs+2wso3tPtZpw3roPQdbmGYE4U+CfRPAgPi+iL9RvxD/+fXAcvgvdqRMyVrVDbhkAD8E9A3HF8ZGknHTdWN7gt5uWe2YaeBlHPDYCoxkE4E9afbcwhPp7ovJrWgEoxdWASfvP+CSOq6r87yAzYsyWvYAIe9K+WRfsM3sLEbY7MB+dqN8b1w4p8aKaxPJ50JlKxQhGUB8wWacMVIKP/4QG/GAKPPys+06wUUoJeiog6piylgBQbYnrnykcVdTOCYLeRf59i00LTh2l01FrfqklIzE3alwl5vCLvfY+8gTWRHbOWKBEIj6jB8PbUvSNc1FG660gFn+dGxsphb+mBZGB2Gj1Qd1rJiFrwyyiE0ZmFDVRVd6cHcmiXLZtLa1UeSKnL3q+5QqKnC+LUNpLyupRVMSjSn4mmDQHhC3gv/spIU9VwNlDjbtsuAzLNkgXZEZVd3b
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030);
X-Microsoft-Antispam-PRVS: <BN3PR0701MB1220DBB3356BA0C8FB21C04B80B00@BN3PR0701MB1220.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(20161123558100)(20161123560025)(20161123564025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN3PR0701MB1220;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN3PR0701MB1220;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1220;4:F16o7s1pksq0tayrUa6Z41JREAfnuzkpJB4teSo0?=
 =?us-ascii?Q?/8F6NfOUYhXxYSoT0CM6A3vuECk39d8HZp/KluRfQFgf2cYclnj3ETkmw52O?=
 =?us-ascii?Q?buElf0SWB/sq9Of2bLu7koPucIbnRpsQ24W8rvKqxAm7TZnr3T89DN5pZ6UV?=
 =?us-ascii?Q?c1bfWcpTDpoYdgIcY93JUWXfmbwt8DAOy1dqbFUfz+E0iYW8Bi3QohqrIz+j?=
 =?us-ascii?Q?PYxVVS6P2vcFJuXjHQBHxnRGXvC4IuOtsUfpNrTDdYxkm4BMBKRo/0MPGsKr?=
 =?us-ascii?Q?V3CA6Z7X4SqKe/khu7rTPhRFf9xYFyFgpL2xUcxgGmhq70EsuOUmVoh/Wz8N?=
 =?us-ascii?Q?puy84UTwakPGWNiMxcvk2q92eS56787FwXPPBCDSfrJ+Vq/o8//yOiyvdo4N?=
 =?us-ascii?Q?+FJhmw3eIBEX7vy1orwHwKtT9uj8oC28GgdxTT5JFBwU48E+94ApAlZJcRR7?=
 =?us-ascii?Q?6emBEImWFS0xdy9l5P+Ozx4VRCC3g7h9Rmz+R5y4d7SQZiOHucGb92IXa+8k?=
 =?us-ascii?Q?58LkeYuR98X6iUB0OcBx2WXjzVw/kYZn8t6NfY6dBbfLFEALHj1/6/+gidxb?=
 =?us-ascii?Q?WB1Pe+vEELeVH3gKDXiIUf1IVPgXnZzAVLKcarFFi9c8Ti7AaGbppm7rWq1H?=
 =?us-ascii?Q?LoyVQ7AuuG73J0Az9X7IImOI95aiX58R2tzzPqwWkkB91mgry1Xv16sbUvpe?=
 =?us-ascii?Q?3YRnOTxbMenlyvMGGXEL0IOHW4qOHdmy8WHyNrmq2sLGQDm2IuObDjsqzMT8?=
 =?us-ascii?Q?vDJltqGWTaXK7BVTT3ohD92DbaaaqJoebIluJSxo2SZppTs2uDvyEkGryzsS?=
 =?us-ascii?Q?FkdO71u1hAV+Id4flG1fm40FyPQCOIZArip12t92uoAxPOb+udUECRxh9Ftk?=
 =?us-ascii?Q?lrI201m4SXilsBV6ups/TGnkX20TiTisU+352OhFIGUFDT5nRXPshEC7Y4ec?=
 =?us-ascii?Q?63G7X00+j7W/hUzywJDK4AK7Qnjavxi94ceBdl2qYfT0INO4QDdm8bWavJD5?=
 =?us-ascii?Q?sD6XHrn6rEVpUcHfk4BANk55UInEJ0sU5UenVbRfGaiO6in3/018TKftPcHo?=
 =?us-ascii?Q?LLGV2+2YZ1gQgZ/6W9pB1Mv/66mGTxmOs968eJrPaPgJf4ee6LMH3kvhLVbu?=
 =?us-ascii?Q?lpKEVFZDAwWYfZPMH9/GeKSKbAdfnHlO9NHvBtLYnjNK9D693LnyRgc5PLJI?=
 =?us-ascii?Q?noD/YNqadX0qRw6gBecdq06y+sXihE92hxzuH5Yut97i3navHYh0t8ZrCA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(7370300001)(6009001)(39400400002)(39450400003)(39840400002)(39410400002)(39850400002)(189002)(199003)(101416001)(5660300001)(305945005)(7350300001)(7736002)(2351001)(50986999)(5003940100001)(68736007)(105586002)(2906002)(69596002)(97736004)(189998001)(6512007)(6306002)(38730400002)(110136004)(66066001)(47776003)(42186005)(86362001)(72206003)(106356001)(36756003)(53936002)(966005)(33646002)(575784001)(25786009)(3846002)(6116002)(6666003)(81166006)(81156014)(2361001)(6916009)(53416004)(6486002)(8676002)(50226002)(450100002)(478600001)(4326008)(6506006)(48376002)(50466002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1220;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1220;23:YlWhWZB3yIc9GfS87uSptOl5ubGXAzAy+45Eym0?=
 =?us-ascii?Q?gqCREyObb8U/VU0nglC7Zi7rZA5fnsBTVZUjec9kTM43A2ww2+8Usq4tMmRC?=
 =?us-ascii?Q?Y4yuXYW4u7s2HY9df/C4xCPatGI35iT9IQd6rRCy+hVFe5N48Do/Sf2ZitG7?=
 =?us-ascii?Q?NYoRPvZEseuD9prGnnJJ458ZMHwJspwvfMBpRDHwjoIvs0Aruwcj2qPQXMyG?=
 =?us-ascii?Q?xXOu1q4BFOBMeYfqop/BDizXnDfSALYCGvqSi1W9gQLfWtHteFDbXpbmGIYW?=
 =?us-ascii?Q?MuZNqKEcV/DyEEfqkWTPrRdiy0xCQDqHvmT2sge0fj1LxHOeJ/N20EWAIJUi?=
 =?us-ascii?Q?7DFymv5Mp5az7/UHM6ODNQsfvVCKgwPO2q2/7uc16rHBhk/SwaJnRAuX1C1k?=
 =?us-ascii?Q?Vbgo31rN+sRI7nhNVQUbu15H8hZ5PjmnWY6X3GqwcJU/s5u442VrssmJpHZ4?=
 =?us-ascii?Q?KTuari1Q2UwsC/LZSFS/cZf0+mhog3G+rgT3LQ/XBR9WrQIy5hR459d17GYm?=
 =?us-ascii?Q?/6ECc4oKycyzP1miSSWYMxA7pckku1W26x773iY0mkDd/fFV2WZmMeTqRsg+?=
 =?us-ascii?Q?L27NWm5jJUX1igpznxFscMuxs3nOVT8Lnh4v1dPF/E5lD7wma4gI/Bu5jH0W?=
 =?us-ascii?Q?AbKynLhfB5GAJkx80b8QdzXVtvOTNZeDwcPc/bpFeOfFdwCKtB75cLkytLZw?=
 =?us-ascii?Q?Mn+lJJ0snC4fRsKvQOxEAgbvGeuLKNjwYboGlXyp3U5NgS8jN5IqimKvFCGN?=
 =?us-ascii?Q?94DXK65OeYiQl42hZhmEyf/jNrJEByGFDr7lD1adAqLWJYOVmjuOJ0LRVccw?=
 =?us-ascii?Q?yuQKmHI8RsXU6LDvx3f1TGVuPD/vQTpkPm+KAme0AWQTL4Zsz5REfKOEcxrl?=
 =?us-ascii?Q?c6vZZDiuExvbbHtj2U57lJjoU+gl1zt/thAin7thQxqNPiLlTpwjN9Bym2A6?=
 =?us-ascii?Q?8YbQV8u0KbSV9HjeapzwODDAb3AcVRHtMAyDvaPluKx2v6OKowpUiG7Wn7Q6?=
 =?us-ascii?Q?xbhwKWDTU1ZJAcGrb1mVzdvEwSLnpfaXWVaHsv95kZ9mX6CGPTZ5FqDT0Ohw?=
 =?us-ascii?Q?bBwIFqyn9w80bdD5dV6AOwekaRwmg4QGPAsV7CsHyDlvLTQqt38zfFpRKiSL?=
 =?us-ascii?Q?S0ffIPxYa3Qhbd3ZiRMPpVIYDHFvCuMh46klwkjqDixDfrWDCNZfMrTvAu3H?=
 =?us-ascii?Q?sEXwdPI2nZ21IcGIlYcFY9l3l6/4umgKFTrctidqRdUQofmEndtgcOhzku5A?=
 =?us-ascii?Q?Y/JKb1O2DekfLoijHJAJe9gVCVgA8bn5JboatlxswmnBKnWVmXQTrxaN9s92?=
 =?us-ascii?Q?sdOy6kj36zyeP0F2tYcLuTAKXDNA2T1Cfg0GGYLbcXpF5SxDl3NXq9X/Ord/?=
 =?us-ascii?Q?YzoboyOogp146hGNYbvjLg1jv6p9K69Z9WZ9+Q75VnOZCCw/T?=
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1220;6:16FQ2yk3Vj7pJQQu1WPhW2cDp6ZkDi+xkZwS13m4?=
 =?us-ascii?Q?eIxGdEEJ7kPLeINhTXHFY2lyZ1HjzH1IiJ6XKVWI1jLbsfaM6LItZ2kFuEy5?=
 =?us-ascii?Q?GiaLsT2lYnPJ+vP2JBvAfMlWMH79OIqkc/iH6C6+PWgW2ZlX/4rdMG3wf0z0?=
 =?us-ascii?Q?DaQ4u3YWfMWKnTPXQynrkX3+uIgSjzw5QMJufvT4viSImO2t6JcFcZpENGVB?=
 =?us-ascii?Q?Mtc0p1/g9esAeRpssFginAW3JuqHJPMMc7NT4w4F9nuFAZrAH608XjAXatVa?=
 =?us-ascii?Q?kN7qUa28df8Pp0Ae+oWyIryAh7V4OQLhWUT79jd7DTIjCKmOhiJl0aff82qV?=
 =?us-ascii?Q?heSshER+CPN5xuOGo0EBZbFwh+OtUWTR5UUYhHkXjae0XFy2yXZi0zkbzFv1?=
 =?us-ascii?Q?/FQxRs/Jal7skmVxaeKgpEzcAueKVoeFtEx/bRiVM9UglNRE7e2LUddlaYMc?=
 =?us-ascii?Q?pEUV8lVAUCWwEpuD/IgnBtEvNH3UGlTsHIh0KMI5Qs0WkfofO7Q7R+zw/nMS?=
 =?us-ascii?Q?Q5YXBTJrbcbWPNc86qdskfSn+EhzZkvbSTyGF6VbNlOWa0EW3py2XG+E6XCA?=
 =?us-ascii?Q?xb92wNGtEKQG02dpYrY+4SSeV5NMXKjkghJqxN2Pq0yXIwd1PGSHInQYnajS?=
 =?us-ascii?Q?2yezu4CqsCIUlve0oMFmLs/0F7sRk4IEzLDs4uaMkypMsjc1PAQHuPyiohmE?=
 =?us-ascii?Q?edyalomM7pvtBjrSXY3IzceVNaDcoVlREDPUimE5GAl2owQz3NRQEqUllFf5?=
 =?us-ascii?Q?XAIQh2OJB3hBndvEYULHpFO1Goq4e/LJjGHM0lBtm19k6J6SC6znJvDqawgU?=
 =?us-ascii?Q?++0InLaEclvWWeSYJ5Ft3Nokk4tKJ7EFFvGlt1msTBtci4c4ZwtfgBQafIlp?=
 =?us-ascii?Q?lDMD0Wcl9XqvPaMJ5At8SahlaTqzApgQOPpHgloWjQZHeDwU2cEUf7aqLgdq?=
 =?us-ascii?Q?3yFcBoHP5IkP+2HwV2vv3afuIhv96AiXYf9YiB6+0qybTbqi2X9D+TSeR5r9?=
 =?us-ascii?Q?NiE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1220;5:6NmF+ca1dOYi1AEtOHgkvMpbTqYhxLgUodyALR8viOAt5l7jTt4yXK1cipTfjjcx9CBikDjZ4k5wKcorYakNHjkSam2FJmlmRbLMoiOnNY6/jZ70JexPMOoonc0OYzWAIca+Xzp3H6+vyWQhfnVaaUiJ0yTZnT0RE5PjvUUH5cGKBm29+H1u/pYPqsHFoMooKXdIhQL+HumVNJidZylFF0mAh0LBWsf9oX0imFv9+Ryp4EEttxu7h+S33ZsK9d8r12cUSCMtf/UZS0N4NZDa+bYarONslRd74FaaqQ+xSUizs6CKfOu6NYoFGubMcR5+DvjNZo0CvMhjiVcC0l41lst8f8VcoEXzRG/6daE/Xvcp5O1PbsKAP6zjmrumc2DmRcDwx6CzaLZS5EvgEAV6Q7jNLimAZoV9ENa8NSpj3Wu/JoNuyyYKy0ZkVIG60vAlfV28uqXR85+q0UtMLwiPRcYccczzxry3U9p9hFlE78V24hj1+CX4uauHuyDceyT8;24:g/4psSmFOtemj0CLYRooNfZoufB6jQjmBhw21NALkenY+rCU5rG+AoFhd9OrMO1rpsvm6OTu7bHzAIq6wXKC2RR0/jFqO2WxmQrDg0Uv3zE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1220;7:/o4eDf8jVe7gWFtQgt0iYU/x0SFPStdiV6V+jQA1aJi19m/tAR4gch0DH1VRGSaGHc1zpdPkRo1lmFTP/bJkLVMk+ZX5CURCI1vvDk90MpideXldh/6l/ayuDYzXvAkN0sTkpx7XXE1M24OVRmRVK3TRVwhqh0TXGOlZdLhL4/8ap2MsJ2c+w+Y7Y5COnctJGEJT6GaJ/+fFw5KYrPACqoW8ExuoJ/BFJln2RIyUJewDWjRjXPeeKJJ3fHj71hAHrZdL4Dn1BunpfA5d3WCUYoqTbdo7GNmOVQuxqD89jRlY1Kmlui4U1EofiZPzYahTRVeQFZMuo4D0p5i+RefBso2ljAk4wFS4PVxejDWGN+huvy87L/0eR35P0LbTVvIUURTqVYeR/cb5GSVZIpt6z248bENJhWX3XyBk4WYaqwFZPtCAEC/v4JOoOgm+xxYyJLiBldOAFJtoMUGyvxpOx73RBF52lRPVWB7FezvdjoBPFa189woyl7HTB/TbsDMH7GNOXQyuhJe6h1AY3db5tO24GUwZlKAkjNMkk4ypVVLq1evlh4OxvzXlAb1ejJx8XPJvkUudJPUvlIWjqwmU3eBnT5CZbQjzucCmb0mT6/2hwdrm6mBZ3o1HHlIMBhKdWq7MPbfSk+LYGwCEngwQf8bwuJCJwNrqhev9aucFrL6AvkjO8ah/CDVDiNDvf83QzRO9Y7HqzpFAkwt38exMTxSEcJ1EkD57+Vgs7aGXrrbVcHcwC+SCfrTThCPa0m9teqKIbUPRseJ7/7Id7M4tUucB6x8l6mGXKurJrcRGH2I=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2017 17:39:31.6698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1220
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Commit "MIPS: Octeon: Remove unused L2C types and macros." broke the
the EDAC driver. Bring back 'cvmx-l2d-defs.h' file and the missing
types for L2C. Fixes: 15f6847923a8 ("MIPS: Octeon: Remove unused L2C
types and macros.")

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/include/asm/octeon/cvmx-l2c-defs.h | 37 ++++++++++++++++-
 arch/mips/include/asm/octeon/cvmx-l2d-defs.h | 60 ++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx.h          |  1 +
 3 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2d-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
index d045973..3ea84ac 100644
--- a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
@@ -33,6 +33,10 @@
 #define CVMX_L2C_DBG (CVMX_ADD_IO_SEG(0x0001180080000030ull))
 #define CVMX_L2C_CFG (CVMX_ADD_IO_SEG(0x0001180080000000ull))
 #define CVMX_L2C_CTL (CVMX_ADD_IO_SEG(0x0001180080800000ull))
+#define CVMX_L2C_ERR_TDTX(block_id)					       \
+	(CVMX_ADD_IO_SEG(0x0001180080A007E0ull) + ((block_id) & 3) * 0x40000ull)
+#define CVMX_L2C_ERR_TTGX(block_id)					       \
+	(CVMX_ADD_IO_SEG(0x0001180080A007E8ull) + ((block_id) & 3) * 0x40000ull)
 #define CVMX_L2C_LCKBASE (CVMX_ADD_IO_SEG(0x0001180080000058ull))
 #define CVMX_L2C_LCKOFF (CVMX_ADD_IO_SEG(0x0001180080000060ull))
 #define CVMX_L2C_PFCTL (CVMX_ADD_IO_SEG(0x0001180080000090ull))
@@ -66,9 +70,40 @@
 		((offset) & 1) * 8)
 #define CVMX_L2C_WPAR_PPX(offset) (CVMX_ADD_IO_SEG(0x0001180080840000ull)    + \
 		((offset) & 31) * 8)
-#define CVMX_L2D_FUS3 (CVMX_ADD_IO_SEG(0x00011800800007B8ull))
 
 
+union cvmx_l2c_err_tdtx {
+	uint64_t u64;
+	struct cvmx_l2c_err_tdtx_s {
+		__BITFIELD_FIELD(uint64_t dbe:1,
+		__BITFIELD_FIELD(uint64_t sbe:1,
+		__BITFIELD_FIELD(uint64_t vdbe:1,
+		__BITFIELD_FIELD(uint64_t vsbe:1,
+		__BITFIELD_FIELD(uint64_t syn:10,
+		__BITFIELD_FIELD(uint64_t reserved_22_49:28,
+		__BITFIELD_FIELD(uint64_t wayidx:18,
+		__BITFIELD_FIELD(uint64_t reserved_2_3:2,
+		__BITFIELD_FIELD(uint64_t type:2,
+		;)))))))))
+	} s;
+};
+
+union cvmx_l2c_err_ttgx {
+	uint64_t u64;
+	struct cvmx_l2c_err_ttgx_s {
+		__BITFIELD_FIELD(uint64_t dbe:1,
+		__BITFIELD_FIELD(uint64_t sbe:1,
+		__BITFIELD_FIELD(uint64_t noway:1,
+		__BITFIELD_FIELD(uint64_t reserved_56_60:5,
+		__BITFIELD_FIELD(uint64_t syn:6,
+		__BITFIELD_FIELD(uint64_t reserved_22_49:28,
+		__BITFIELD_FIELD(uint64_t wayidx:15,
+		__BITFIELD_FIELD(uint64_t reserved_2_6:5,
+		__BITFIELD_FIELD(uint64_t type:2,
+		;)))))))))
+	} s;
+};
+
 union cvmx_l2c_cfg {
 	uint64_t u64;
 	struct cvmx_l2c_cfg_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-l2d-defs.h b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
new file mode 100644
index 0000000..a951ad5
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
@@ -0,0 +1,60 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2017 Cavium, Inc.
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_L2D_DEFS_H__
+#define __CVMX_L2D_DEFS_H__
+
+#define CVMX_L2D_ERR	(CVMX_ADD_IO_SEG(0x0001180080000010ull))
+#define CVMX_L2D_FUS3	(CVMX_ADD_IO_SEG(0x00011800800007B8ull))
+
+
+union cvmx_l2d_err {
+	uint64_t u64;
+	struct cvmx_l2d_err_s {
+		__BITFIELD_FIELD(uint64_t reserved_6_63:58,
+		__BITFIELD_FIELD(uint64_t bmhclsel:1,
+		__BITFIELD_FIELD(uint64_t ded_err:1,
+		__BITFIELD_FIELD(uint64_t sec_err:1,
+		__BITFIELD_FIELD(uint64_t ded_intena:1,
+		__BITFIELD_FIELD(uint64_t sec_intena:1,
+		__BITFIELD_FIELD(uint64_t ecc_ena:1,
+		;)))))))
+	} s;
+};
+
+union cvmx_l2d_fus3 {
+	uint64_t u64;
+	struct cvmx_l2d_fus3_s {
+		__BITFIELD_FIELD(uint64_t reserved_40_63:24,
+		__BITFIELD_FIELD(uint64_t ema_ctl:3,
+		__BITFIELD_FIELD(uint64_t reserved_34_36:3,
+		__BITFIELD_FIELD(uint64_t q3fus:34,
+		;))))
+	} s;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 9742202..e638735 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -62,6 +62,7 @@ enum cvmx_mips_space {
 #include <asm/octeon/cvmx-iob-defs.h>
 #include <asm/octeon/cvmx-ipd-defs.h>
 #include <asm/octeon/cvmx-l2c-defs.h>
+#include <asm/octeon/cvmx-l2d-defs.h>
 #include <asm/octeon/cvmx-l2t-defs.h>
 #include <asm/octeon/cvmx-led-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
-- 
2.1.4
