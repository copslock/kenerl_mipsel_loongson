Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 00:31:07 +0200 (CEST)
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:23616
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994629AbdFMW3CRSltu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 00:29:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FcvbfbcC2O/b8f9D2Rg5X51KZb+CJIeg1DSTDho1frU=;
 b=I3zpeRw2rbuW1WykhNUuP/SmKJ05VRJhZ3HGZZFFZ/hDbqHrOw7A6JTXKV+WLBj2Zqlb30SwL+SIl2kE8holS+ayDiO1VuaoaxCKoLaF3HdgRMdYvdDmzfgdMhWlXBIeKsnfASKQAiKJSKip4u7O03xvnhoD7gceTpXfqEvREOs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Tue, 13 Jun 2017 22:28:54 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 4/5] MIPS: Add support for eBPF JIT.
Date:   Tue, 13 Jun 2017 15:28:46 -0700
Message-Id: <20170613222847.7122-5-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170613222847.7122-1-david.daney@cavium.com>
References: <20170613222847.7122-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0048.namprd07.prod.outlook.com (10.174.192.16) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-MS-Office365-Filtering-Correlation-Id: 0d0e7173-1b6d-4ed7-0ded-08d4b2ab9355
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:xgAQlxCmBq3e1rJt149+doH9aZ8qaku3Z6felRsq4HRncKwvli9AbLpyg6KZrZsSgeW1zG7yrHsBms2kGnlt18R93ZV4xCA6MLkQ0Yuz5NSSXsBLKrklKpEcIj0O/aluJgiaIzof3vYMn8BqF18tp88i/ZF8lFK84CKkDfZHOUVrvXt76NDAIs4SmGVteEyI3zjkMDEckVo43pgWyYp0Moj6c0FWffADjgUOwvREW2MAZ4UyCL4GKxOLTszc7tlFryS6fb0OIsQqWYnC0iZON9x0qnHz/ohXCT70d0csbKEddiL33OQzy+CGKxlTpBCzkSlgB2aF0XG1pO1AnB+b6g==;25:FENkFza0TZExyQfLqGC9l0P7RyF92EQxCzJ6ti7Hvd+naW5f4oOBrqaFNoJL8bokr32wgioqAAbSsL4HIuUpDCzBoWZ72iOgjuRqndxtuHd+T9xDGLfieMU1rA8RNokey5z2D6UkgxDxhOWBA6+AJk1BLQ1b7PE9E6RuA2HjlSuuzTEx3amhfoBN0/sB0m5UO7oFbd0WaCiMS34utYndGuoR0P4R+r1gliEwjxt6tC3llAyTawU7GMG4MP4Iyh8WqAzyChTatMvCKbExj4fdXncBJaVXNx6/fksVjh1iKiRMSUkfmDmT7610ay2i+cBSHy4dSHtgDFZSsLD3juD2S+LitcwTAEE7cfVPUVx1u3gj00x6BQsVokrMIeZnz6jGr4Uo/xzHWPC8d6eYD+fzZNtXaNV0v8sTjgF/Gu5HvjHDPpno8cMgrBwcGc8GUr4D3fTwFYblOmkScg5KPscU9R1bcvFmgchOA3kEm/GfZ5w=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;31:bXSqzZ/yGVF3UFtmLk++eXZLGflyb98rZ+avqFX5nocW0qYUfYir4vvvYscC0PWAHBWcYnplZLMXLUpdtheNZUuVzvks8GQn+BYAuKtvgkSrPQC7+1I9oMwvyojhZXvua4rp25AoEBJd33Df0G7cLEz2E0LTw5ZAKzU6T+zOiSntxOv+hS8op2iwKilpV74Jp2TLTuR9QhwgjZ2bTbcAtfUHlEdxapUmtnmykGGWD4Q=;20:rvUfkPWEXWituXNEVvGnqFX68neSW7AfJZusgnM4CaXuUTqgFlUJF+byuj16G4l53fYS0+gcsczyvztt00LKjVMq/P7pqRQkbR8sYKghMvPTb9PRciNcGUvfUoZyZOTilHWFtkjX5sbe4fOyRZjgeUt0tReu0Ure4c6tGoYDv8R5+GaJApR77/gX3RIaVsDdXWOIHmOkPwYpdlE7BDKB5eRTHqFREO6Cyd/f6EPDiH4PHDyLo7U2R0lyJOlU7/Rs7Fg7NgRTdq8uyI7YU6OwzGRXM97jJUhgz0/Ru7Z57WOdArpHsxrtKgEQHt1QCeSvwlnMnFkNqDQFwG/2EOQIKZbpuArJaXlfpvM31Ql+KOEZzJeYvldVVoOiqJMObuzOGrL/IZ/80aU6kJlWCU2fbnKSOAshL7rrq8l+4DmxAQgjp02CY9cItkavRbpQ/2cA1PkXi98KmQFAshBuqLedcQ8xD7GpihBrwc/S/5xlRjlclTC5TfSguxBbrxNN7eOr
X-Microsoft-Antispam-PRVS: <CY4PR07MB34962B4007E641CD6E36A42697C20@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190461294614860);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6041248)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;4:q/l2pl2wJGdSxxAqhFG1+09QcMszu+lH5gPB1IWMXl?=
 =?us-ascii?Q?OBZ0aJOgX1GGqy8HdPa3xOMx8TIpIsIY/x0yqd3cBho0j2tc8pA5wn1Jd1QH?=
 =?us-ascii?Q?+585X5ajaojFk0XW0nHtfmd1pFIFac1i/eLKaqw03ukw9SrKYVdh+2vVfp2x?=
 =?us-ascii?Q?NJGO1xvaakb+OQDOGxslklj4kzvTkMW6ggBQsFjHua+Rk3NxumlG4of2gHPh?=
 =?us-ascii?Q?Hn5RyOL8qr+8N98CnKPS6bht4uymYGvwr1CLToKIbkLeH0351oMLmTv7tO5J?=
 =?us-ascii?Q?VZwYzaJ064UkIVmjFCNlrBW5yhW3nI8JKr5YegEkWtG46mdbQjV7cdtcAznx?=
 =?us-ascii?Q?paBF3FHtJqB+zC8qkIdV4mGu2GkSr1NDtRMNarYSEwlmJ/2oUiyN4xtkIXNF?=
 =?us-ascii?Q?MokuYs7QaaoQA6l6amS9oYvRY7rV56Ptl05v/bXeLn4oBcQ1oSikSRzAqBd8?=
 =?us-ascii?Q?J4ukEyrshMDjV5ROXZb8dJMgA3WWcSi39EGUBphHZqElt8vmBlIIa+dOxPwI?=
 =?us-ascii?Q?P6oEj/Fv4HNFowoY2/Sbvj9cHfLYggTuoNWaj1d+ILXs//Tooh7ZL99f+n9B?=
 =?us-ascii?Q?FRRdag2aoPs/y27OgWOwM6f86eeMY+8/vTOqhzaPqzbHnRvcTHy5LitbiLBz?=
 =?us-ascii?Q?ndT68JLmGniQGtKnIilRJxECWIer79mc/tfPrElbw4C1OpuHxSu6pkDLj4nz?=
 =?us-ascii?Q?qRG22zgkh5EDTtKkT4BhD7Zsy4Eu9LVYbvxsSvTZAL5TWe+Pgst+837cf6xQ?=
 =?us-ascii?Q?X4Kxi8eZz6GfMMOAEqzOvwdMCQRkUhD7Pu+bocaZDEViwxmcBY4tk6CI2BHl?=
 =?us-ascii?Q?nlMw3DQm58/3uFqpjlue+eEY/r/hPlZT8HRGWhhBKrp3Xo1txJ3cEvk+FbFi?=
 =?us-ascii?Q?MSSaefX8Xd4c7YZadSfYMiXSMFWZnsOpE1/NRLfVtXQiW+22wjr/BFhsC5ZI?=
 =?us-ascii?Q?gXowGKy7Til9G78dhjdqHtUuEoj14IjVPBn7riQ3MleRt8LVyLe7NYT5/L6k?=
 =?us-ascii?Q?QsOycS+5/vbX1LzQ0zFERzSqUMsAXSeFTfz3TO13/ciFXbjAJnXs+rPoleCC?=
 =?us-ascii?Q?sxM+BwnLRdAwdlHGPHlFI03DtANeLwZ0XmkRt1hNZWhuIJYXZcCDQhZFekHj?=
 =?us-ascii?Q?kVv+89Xed4ud3skG5WZz1CHxfMx2VLpQTSspCBXho4bWqgPOqZ5LH8IgldPA?=
 =?us-ascii?Q?DoAcxHyGa7PWo=3D?=
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39410400002)(39400400002)(39850400002)(39840400002)(39450400003)(199003)(189002)(6486002)(1076002)(6666003)(2950100002)(36756003)(6506006)(105586002)(53416004)(42186005)(33646002)(106356001)(101416001)(50466002)(48376002)(76176999)(50986999)(72206003)(6116002)(5003940100001)(3846002)(50226002)(305945005)(97736004)(7736002)(189998001)(81156014)(8676002)(53946003)(68736007)(53936002)(86362001)(575784001)(69596002)(16200700003)(38730400002)(4326008)(54906002)(47776003)(25786009)(6512007)(81166006)(5660300001)(66066001)(107886003)(478600001)(2906002)(2004002)(559001)(569005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:XHumAM8dETofCycauHtcVqukeeBMECuDiVYrsLvxX?=
 =?us-ascii?Q?OAtqH0Q7aqKk1tH8ZVtb//LHZteQpb0uU3w9cvSekc9vPytP7GoVzfU2rCyt?=
 =?us-ascii?Q?x5uHWOUJMGP3p7XRKDzuLpTCUenGUZWtvh7htZj3vk83lWw3AHfl3oMl2naR?=
 =?us-ascii?Q?RU4bNbUVXMa4JuWP4nwmo8EWnS9E7kkZCOpJHH5M9vwr7gT1T6I5lRKWfSsM?=
 =?us-ascii?Q?FQy6GTLWiVqr9vSZCHOjncgl66k8NEjvNrymRWaVM6F3eNWD58vZa9xvvbkQ?=
 =?us-ascii?Q?oXcC1ytpZLTGFPPyqS9Ve13tw0nyXDVSMUY9c66JSLBaZK0D+vhhzKW3jmDW?=
 =?us-ascii?Q?UyoWVSip7rvVgoXxdzzNQ/Oq18Ej6rqccnerDS8MYZP3/TgwGgPLF8Zg09AV?=
 =?us-ascii?Q?jDxIHvfpOluW27RQ5vmoyvm8BPwvZcY6fI4opvozCVc15bv9T9kOC+ozsGKc?=
 =?us-ascii?Q?bPbTOAhWa2Hxn41+2JUptXPuTOL+faC1IzjW3HYKPQ4b7C5xra0NZHVvI35O?=
 =?us-ascii?Q?sj8E/Um7Q/Wun5RljYGuREIyePTpQ77Isd3zskpXwa5WIwz2QS27yS8NmLjt?=
 =?us-ascii?Q?4rKVIz5YY18dWAYxWf9BmQ41JoD7/eSRhKinJISHGB+xIgYBz7essy75QA3d?=
 =?us-ascii?Q?Xg3dntU8AzGetm/Gab90v+0pzSN+tB2WNFKFki2eV+V+3Zjr1v6oDbpZFVzT?=
 =?us-ascii?Q?b3Pxoyc7vUz7noJxo35NmgBesR4CES4yDjDx9nzsPg9l1lDoU0ILsVHO+juX?=
 =?us-ascii?Q?f3qTNNDCOUIINCNHaewcUhIhAJUVTsJ2DhjPaUL0TRJkwHCJ0MQvoh4B2hQX?=
 =?us-ascii?Q?QbZ8dR0azoFg995ETQ88lt9bz3ux/GgtxKk2+YVwP7AtygHcfmLNhBjFGGU4?=
 =?us-ascii?Q?6/trdWYdWscpXZ38zojNhRWNQeXQcSNMM5M61aztxAnUBgRkB7745+f61nZu?=
 =?us-ascii?Q?uzRWxmetHjiNzWAtzzWjS78TsgP2mj2pqa07KJh+lzqAndZfJn3P2TfLRjY8?=
 =?us-ascii?Q?EhCxgcNEMJqi+iGwbhT4hFixHdMUZji0ZV2B/QDk2wSyhvV62DLkxHH+tqGH?=
 =?us-ascii?Q?Ue1JT5wWoJjzTYNLCyMeB6MnOzlvm9lVr2aGSHlaZg4jgGb5GvKPosmaFv1h?=
 =?us-ascii?Q?zFUpL5IBU79pUtbVUeV7TH8thZCAzHFoTSfDTmrvk86qhvWmQIhFCRLAuol9?=
 =?us-ascii?Q?U6wn7zXlC1QbaC4tiQOh6eE0tT/CH/XbWN1/SYRs8CJhnD+wpHCWpMtF1H0Y?=
 =?us-ascii?Q?cjRwpoxQdkDZ6Qke/+jGy/1ny3B9yVDhDkfscHGFbP0TGSTGllS10Lojy+2I?=
 =?us-ascii?Q?wXKV51OqK0Lk7OhK6kaGD8AodNfOcFU8kOS1y5Z3BeBcNAkiWCp6oXLOmWXQ?=
 =?us-ascii?Q?8Y+dYi2sjPQAbNxWp20AXzP192CoXA+wt8+0JCTMD+Yx1UX?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:vsWQIyFRUzuf5Xu91JvAocn8L7SOxkSZHPyTj11RngeVvnn1ymH3Ohqg6z9xSvXhzTwmxgeIK3an2b/cyZQBnnO28P32Yg8mfCwUsbA2zw1UqPDHzd8Z0xdJXOjttz3XvYydCaIgKaEty1qILRD38naoNi0tA5skpF6zVfJq4KXm+kHYG6gNEpGdHw0Algx17vBeykB9QNK8R1bv0P2pxGme9yr0m51aIOvy/c24Xpu6KGg63YG6HGV/2xufvL1mvyDnTbLdqeVV9NVjAgZF+RUpYZmbQ9wB8SML0lsVHQxvLAg5KxLVYIgaD5aXLAwrst3nbBSYtlQOQWgKXvKgd0UxbuS5rZ5cVUxuA27uKqwpzXAWJ2DZzbkD/BMYWsVQCHd7F0zSmAK1+HWCZJkNd6HzCJMP+yIj0eqJT1IyVQPUAAMCZMV/mERLaB2oNuVmVLbp1u/WxGDBXgLdcK34bKB6rjIYMkmEC6iocdNreHNizKjtPju4OCrId0yzYfVHUAyESscCXjW4IoC1/rxrMA==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;5:q4lUvCYDyPwmQHTfF/TMTepB2tc8CWTTcya5qw4nVJqnryinmkC0fwTajFQZ04LsyG6uoFT5YY8ybg2DeHAyk3VHp4u029V3aTsb/qgovMaKP5Jc/XDEc/qvKoNreGPKHOFrt+L/fea+dpNbMf5PnNNvjOknipUkqc13WPrf+cMjcHplxivSK/RWDAhOfW9gFeEe5Ewmbj+820S/1k3fDV3vuDRw0ghnUifv3J03oMqrOeVz8Tgb9N+m0F0JkpH7A/2cWUyEOBYg3vsK+o5IGcJVaORyB3hfMtUaUA3G5OiN+KLygCuqSeO7T/abOCrCWHvIjJJEQX4rafzsS/m/iOU2ADm8bhm5qpfVtu6QN1XgWTiYtJgPAQJP0unZ34BuQQda+BtbKDk2GBV9DsrAioC9ddMPaVjO+GTVjWhvZr4jpmu+u7zB3aCC21KP7RR7OzN23x94v9If5wlwFHukHL+5VUtCA8oxgUAUNSgT+fhm4rz9Njpxo1ZPnbqvs8Iw;24:7gVUWLTdrr2KV1THcscH/dH0FHyp9RWLX9Vu2fYP0HEsyv77QH2Sxbsom7QcstOetN058ZFSNpqdNdwv0Sr3vmPavBx67rfgwZVLIoZjYuo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;7:GkdYa8QkSI/oDVQ7i8fQaURMMt6IMca8mKe+W9Y5fIUWiBVl86fVfZwGvhv50Dc7QED2mL0mpTTlclYXInEEzSRim9yK8TzTob15nItc0ttMO74LGeOyQLdv2wX+tDEZfCCO9qOwb/W9Qh26wqR7VQ+OTanckidSFdqPbrmWa8EdGC2FuKxJKmSJf3YOUnjMunK8Q4h8cjQsgmanqpAUOaxpejqjQDSpK/Gm/daQfcGodfgFbvjnzEsvJyKlpnHi7OlgBcMlxNLS0x9ZiqFi+yhzfa2VNjSI8EFFgCk5h+c3hWYPRVTPY179SwtxLHsjnorVtXNha0QJjaI1mIFyxA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2017 22:28:54.1902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

Since the eBPF machine has 64-bit registers, we only support this in
64-bit kernels.  As of the writing of this commit log test-bpf is showing:

  test_bpf: Summary: 316 PASSED, 0 FAILED, [308/308 JIT'ed]

All current test cases are successfully compiled.

Many examples in samples/bpf are usable, specifically tracex5 which
uses tail calls works.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig        |   12 +-
 arch/mips/net/Makefile   |    3 +-
 arch/mips/net/ebpf_jit.c | 1949 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1962 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/net/ebpf_jit.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecd..f4cf11e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -18,7 +18,8 @@ config MIPS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if MMU && COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_CBPF_JIT if !CPU_MICROMIPS
+	select HAVE_CBPF_JIT if (!64BIT && !CPU_MICROMIPS)
+	select HAVE_EBPF_JIT if (64BIT && !CPU_MICROMIPS)
 	select HAVE_FUNCTION_TRACER
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
@@ -1178,6 +1179,15 @@ config SYS_SUPPORTS_RELOCATABLE
 	 The platform must provide plat_get_fdt() if it selects CONFIG_USE_OF
 	 to allow access to command line and entropy sources.
 
+config MIPS_CBPF_JIT
+	def_bool y
+	depends on BPF_JIT && HAVE_CBPF_JIT
+
+config MIPS_EBPF_JIT
+	def_bool y
+	depends on BPF_JIT && HAVE_EBPF_JIT
+
+
 #
 # Endianness selection.  Sufficiently obscure so many users don't know what to
 # answer,so we try hard to limit the available choices.  Also the use of a
diff --git a/arch/mips/net/Makefile b/arch/mips/net/Makefile
index 8c27714..47d6784 100644
--- a/arch/mips/net/Makefile
+++ b/arch/mips/net/Makefile
@@ -1,3 +1,4 @@
 # MIPS networking code
 
-obj-$(CONFIG_BPF_JIT) += bpf_jit.o bpf_jit_asm.o
+obj-$(CONFIG_MIPS_CBPF_JIT) += bpf_jit.o bpf_jit_asm.o
+obj-$(CONFIG_MIPS_EBPF_JIT) += ebpf_jit.o
diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
new file mode 100644
index 0000000..19af13f
--- /dev/null
+++ b/arch/mips/net/ebpf_jit.c
@@ -0,0 +1,1949 @@
+/*
+ * Just-In-Time compiler for eBPF filters on MIPS
+ *
+ * Copyright (c) 2017 Cavium, Inc.
+ *
+ * Based on code from:
+ *
+ * Copyright (c) 2014 Imagination Technologies Ltd.
+ * Author: Markos Chandras <markos.chandras@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/filter.h>
+#include <linux/bpf.h>
+#include <linux/slab.h>
+#include <asm/bitops.h>
+#include <asm/byteorder.h>
+#include <asm/cacheflush.h>
+#include <asm/cpu-features.h>
+#include <asm/uasm.h>
+
+/* Registers used by JIT */
+#define MIPS_R_ZERO	0
+#define MIPS_R_AT	1
+#define MIPS_R_V0	2	/* BPF_R0 */
+#define MIPS_R_V1	3
+#define MIPS_R_A0	4	/* BPF_R1 */
+#define MIPS_R_A1	5	/* BPF_R2 */
+#define MIPS_R_A2	6	/* BPF_R3 */
+#define MIPS_R_A3	7	/* BPF_R4 */
+#define MIPS_R_A4	8	/* BPF_R5 */
+#define MIPS_R_T4	12	/* BPF_AX */
+#define MIPS_R_T5	13
+#define MIPS_R_T6	14
+#define MIPS_R_T7	15
+#define MIPS_R_S0	16	/* BPF_R6 */
+#define MIPS_R_S1	17	/* BPF_R7 */
+#define MIPS_R_S2	18	/* BPF_R8 */
+#define MIPS_R_S3	19	/* BPF_R9 */
+#define MIPS_R_S4	20	/* BPF_TCC */
+#define MIPS_R_S5	21
+#define MIPS_R_S6	22
+#define MIPS_R_S7	23
+#define MIPS_R_T8	24
+#define MIPS_R_T9	25
+#define MIPS_R_SP	29
+#define MIPS_R_RA	31
+
+/* eBPF flags */
+#define EBPF_SAVE_S0	BIT(0)
+#define EBPF_SAVE_S1	BIT(1)
+#define EBPF_SAVE_S2	BIT(2)
+#define EBPF_SAVE_S3	BIT(3)
+#define EBPF_SAVE_S4	BIT(4)
+#define EBPF_SAVE_RA	BIT(5)
+#define EBPF_SEEN_FP	BIT(6)
+#define EBPF_SEEN_TC	BIT(7)
+#define EBPF_TCC_IN_V1	BIT(8)
+
+/*
+ * For the mips64 ISA, we need to track the value range or type for
+ * each JIT register.  The BPF machine requires zero extended 32-bit
+ * values, but the mips64 ISA requires sign extended 32-bit values.
+ * At each point in the BPF program we track the state of every
+ * register so that we can zero extend or sign extend as the BPF
+ * semantics require.
+ */
+enum reg_val_type {
+	/* uninitialized */
+	REG_UNKNOWN,
+	/* not known to be 32-bit compatible. */
+	REG_64BIT,
+	/* 32-bit compatible, no truncation needed for 64-bit ops. */
+	REG_64BIT_32BIT,
+	/* 32-bit compatible, need truncation for 64-bit ops. */
+	REG_32BIT,
+	/* 32-bit zero extended. */
+	REG_32BIT_ZERO_EX,
+	/* 32-bit no sign/zero extension needed. */
+	REG_32BIT_POS
+};
+
+/*
+ * high bit of offsets indicates if long branch conversion done at
+ * this insn.
+ */
+#define OFFSETS_B_CONV	BIT(31)
+
+/**
+ * struct jit_ctx - JIT context
+ * @skf:		The sk_filter
+ * @stack_size:		eBPF stack size
+ * @tmp_offset:		eBPF $sp offset to 8-byte temporary memory
+ * @idx:		Instruction index
+ * @flags:		JIT flags
+ * @offsets:		Instruction offsets
+ * @target:		Memory location for the compiled filter
+ * @reg_val_types	Packed enum reg_val_type for each register.
+ */
+struct jit_ctx {
+	const struct bpf_prog *skf;
+	int stack_size;
+	int tmp_offset;
+	u32 idx;
+	u32 flags;
+	u32 *offsets;
+	u32 *target;
+	u64 *reg_val_types;
+	unsigned int long_b_conversion:1;
+	unsigned int gen_b_offsets:1;
+};
+
+static void set_reg_val_type(u64 *rvt, int reg, enum reg_val_type type)
+{
+	*rvt &= ~(7ull << (reg * 3));
+	*rvt |= ((u64)type << (reg * 3));
+}
+
+static enum reg_val_type get_reg_val_type(const struct jit_ctx *ctx,
+					  int index, int reg)
+{
+	return (ctx->reg_val_types[index] >> (reg * 3)) & 7;
+}
+
+/* Simply emit the instruction if the JIT memory space has been allocated */
+#define emit_instr(ctx, func, ...)			\
+do {							\
+	if ((ctx)->target != NULL) {			\
+		u32 *p = &(ctx)->target[ctx->idx];	\
+		uasm_i_##func(&p, ##__VA_ARGS__);	\
+	}						\
+	(ctx)->idx++;					\
+} while (0)
+
+static unsigned int j_target(struct jit_ctx *ctx, int target_idx)
+{
+	unsigned long target_va, base_va;
+	unsigned int r;
+
+	if (!ctx->target)
+		return 0;
+
+	base_va = (unsigned long)ctx->target;
+	target_va = base_va + (ctx->offsets[target_idx] & ~OFFSETS_B_CONV);
+
+	if ((base_va & ~0x0ffffffful) != (target_va & ~0x0ffffffful))
+		return (unsigned int)-1;
+	r = target_va & 0x0ffffffful;
+	return r;
+}
+
+/* Compute the immediate value for PC-relative branches. */
+static u32 b_imm(unsigned int tgt, struct jit_ctx *ctx)
+{
+	if (!ctx->gen_b_offsets)
+		return 0;
+
+	/*
+	 * We want a pc-relative branch.  tgt is the instruction offset
+	 * we want to jump to.
+
+	 * Branch on MIPS:
+	 * I: target_offset <- sign_extend(offset)
+	 * I+1: PC += target_offset (delay slot)
+	 *
+	 * ctx->idx currently points to the branch instruction
+	 * but the offset is added to the delay slot so we need
+	 * to subtract 4.
+	 */
+	return (ctx->offsets[tgt] & ~OFFSETS_B_CONV) -
+		(ctx->idx * 4) - 4;
+}
+
+int bpf_jit_enable __read_mostly;
+
+enum which_ebpf_reg {
+	src_reg,
+	src_reg_no_fp,
+	dst_reg,
+	dst_reg_fp_ok
+};
+
+/*
+ * For eBPF, the register mapping naturally falls out of the
+ * requirements of eBPF and the MIPS n64 ABI.  We don't maintain a
+ * separate frame pointer, so BPF_REG_10 relative accesses are
+ * adjusted to be $sp relative.
+ */
+int ebpf_to_mips_reg(struct jit_ctx *ctx, const struct bpf_insn *insn,
+		     enum which_ebpf_reg w)
+{
+	int ebpf_reg = (w == src_reg || w == src_reg_no_fp) ?
+		insn->src_reg : insn->dst_reg;
+
+	switch (ebpf_reg) {
+	case BPF_REG_0:
+		return MIPS_R_V0;
+	case BPF_REG_1:
+		return MIPS_R_A0;
+	case BPF_REG_2:
+		return MIPS_R_A1;
+	case BPF_REG_3:
+		return MIPS_R_A2;
+	case BPF_REG_4:
+		return MIPS_R_A3;
+	case BPF_REG_5:
+		return MIPS_R_A4;
+	case BPF_REG_6:
+		ctx->flags |= EBPF_SAVE_S0;
+		return MIPS_R_S0;
+	case BPF_REG_7:
+		ctx->flags |= EBPF_SAVE_S1;
+		return MIPS_R_S1;
+	case BPF_REG_8:
+		ctx->flags |= EBPF_SAVE_S2;
+		return MIPS_R_S2;
+	case BPF_REG_9:
+		ctx->flags |= EBPF_SAVE_S3;
+		return MIPS_R_S3;
+	case BPF_REG_10:
+		if (w == dst_reg || w == src_reg_no_fp)
+			goto bad_reg;
+		ctx->flags |= EBPF_SEEN_FP;
+		/*
+		 * Needs special handling, return something that
+		 * cannot be clobbered just in case.
+		 */
+		return MIPS_R_ZERO;
+	case BPF_REG_AX:
+		return MIPS_R_T4;
+	default:
+bad_reg:
+		WARN(1, "Illegal bpf reg: %d\n", ebpf_reg);
+		return -EINVAL;
+	}
+}
+/*
+ * eBPF stack frame will be something like:
+ *
+ *  Entry $sp ------>   +--------------------------------+
+ *                      |   $ra  (optional)              |
+ *                      +--------------------------------+
+ *                      |   $s0  (optional)              |
+ *                      +--------------------------------+
+ *                      |   $s1  (optional)              |
+ *                      +--------------------------------+
+ *                      |   $s2  (optional)              |
+ *                      +--------------------------------+
+ *                      |   $s3  (optional)              |
+ *                      +--------------------------------+
+ *                      |   $s4  (optional)              |
+ *                      +--------------------------------+
+ *                      |   tmp-storage  (if $ra saved)  |
+ * $sp + tmp_offset --> +--------------------------------+ <--BPF_REG_10
+ *                      |   BPF_REG_10 relative storage  |
+ *                      |    MAX_BPF_STACK (optional)    |
+ *                      |      .                         |
+ *                      |      .                         |
+ *                      |      .                         |
+ *     $sp -------->    +--------------------------------+
+ *
+ * If BPF_REG_10 is never referenced, then the MAX_BPF_STACK sized
+ * area is not allocated.
+ */
+static int gen_int_prologue(struct jit_ctx *ctx)
+{
+	int stack_adjust = 0;
+	int store_offset;
+	int locals_size;
+
+	if (ctx->flags & EBPF_SAVE_RA)
+		/*
+		 * If RA we are doing a function call and may need
+		 * extra 8-byte tmp area.
+		 */
+		stack_adjust += 16;
+	if (ctx->flags & EBPF_SAVE_S0)
+		stack_adjust += 8;
+	if (ctx->flags & EBPF_SAVE_S1)
+		stack_adjust += 8;
+	if (ctx->flags & EBPF_SAVE_S2)
+		stack_adjust += 8;
+	if (ctx->flags & EBPF_SAVE_S3)
+		stack_adjust += 8;
+	if (ctx->flags & EBPF_SAVE_S4)
+		stack_adjust += 8;
+
+	BUILD_BUG_ON(MAX_BPF_STACK & 7);
+	locals_size = (ctx->flags & EBPF_SEEN_FP) ? MAX_BPF_STACK : 0;
+
+	stack_adjust += locals_size;
+	ctx->tmp_offset = locals_size;
+
+	ctx->stack_size = stack_adjust;
+
+	/*
+	 * First instruction initializes the tail call count (TCC).
+	 * On tail call we skip this instruction, and the TCC is
+	 * passed in $v1 from the caller.
+	 */
+	emit_instr(ctx, daddiu, MIPS_R_V1, MIPS_R_ZERO, MAX_TAIL_CALL_CNT);
+	if (stack_adjust)
+		emit_instr(ctx, daddiu, MIPS_R_SP, MIPS_R_SP, -stack_adjust);
+	else
+		return 0;
+
+	store_offset = stack_adjust - 8;
+
+	if (ctx->flags & EBPF_SAVE_RA) {
+		emit_instr(ctx, sd, MIPS_R_RA, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+	if (ctx->flags & EBPF_SAVE_S0) {
+		emit_instr(ctx, sd, MIPS_R_S0, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+	if (ctx->flags & EBPF_SAVE_S1) {
+		emit_instr(ctx, sd, MIPS_R_S1, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+	if (ctx->flags & EBPF_SAVE_S2) {
+		emit_instr(ctx, sd, MIPS_R_S2, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+	if (ctx->flags & EBPF_SAVE_S3) {
+		emit_instr(ctx, sd, MIPS_R_S3, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+	if (ctx->flags & EBPF_SAVE_S4) {
+		emit_instr(ctx, sd, MIPS_R_S4, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+
+	if ((ctx->flags & EBPF_SEEN_TC) && !(ctx->flags & EBPF_TCC_IN_V1))
+		emit_instr(ctx, daddu, MIPS_R_S4, MIPS_R_V1, MIPS_R_ZERO);
+
+	return 0;
+}
+
+static int build_int_epilogue(struct jit_ctx *ctx, int dest_reg)
+{
+	const struct bpf_prog *prog = ctx->skf;
+	int stack_adjust = ctx->stack_size;
+	int store_offset = stack_adjust - 8;
+	int r0 = MIPS_R_V0;
+
+	if (dest_reg == MIPS_R_RA &&
+	    get_reg_val_type(ctx, prog->len, BPF_REG_0) == REG_32BIT_ZERO_EX)
+		/* Don't let zero extended value escape. */
+		emit_instr(ctx, sll, r0, r0, 0);
+
+	if (ctx->flags & EBPF_SAVE_RA) {
+		emit_instr(ctx, ld, MIPS_R_RA, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+	if (ctx->flags & EBPF_SAVE_S0) {
+		emit_instr(ctx, ld, MIPS_R_S0, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+	if (ctx->flags & EBPF_SAVE_S1) {
+		emit_instr(ctx, ld, MIPS_R_S1, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+	if (ctx->flags & EBPF_SAVE_S2) {
+		emit_instr(ctx, ld, MIPS_R_S2, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+	if (ctx->flags & EBPF_SAVE_S3) {
+		emit_instr(ctx, ld, MIPS_R_S3, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+	if (ctx->flags & EBPF_SAVE_S4) {
+		emit_instr(ctx, ld, MIPS_R_S4, store_offset, MIPS_R_SP);
+		store_offset -= 8;
+	}
+	emit_instr(ctx, jr, dest_reg);
+
+	if (stack_adjust)
+		emit_instr(ctx, daddiu, MIPS_R_SP, MIPS_R_SP, stack_adjust);
+	else
+		emit_instr(ctx, nop);
+
+	return 0;
+}
+
+static void gen_imm_to_reg(const struct bpf_insn *insn, int reg,
+			   struct jit_ctx *ctx)
+{
+	if (insn->imm >= S16_MIN && insn->imm <= S16_MAX) {
+		emit_instr(ctx, addiu, reg, MIPS_R_ZERO, insn->imm);
+	} else {
+		int lower = (s16)(insn->imm & 0xffff);
+		int upper = insn->imm - lower;
+
+		emit_instr(ctx, lui, reg, upper >> 16);
+		emit_instr(ctx, addiu, reg, reg, lower);
+	}
+
+}
+
+static int gen_imm_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
+			int idx)
+{
+	int upper_bound, lower_bound;
+	int dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+
+	if (dst < 0)
+		return dst;
+
+	switch (BPF_OP(insn->code)) {
+	case BPF_MOV:
+	case BPF_ADD:
+		upper_bound = S16_MAX;
+		lower_bound = S16_MIN;
+		break;
+	case BPF_SUB:
+		upper_bound = -(int)S16_MIN;
+		lower_bound = -(int)S16_MAX;
+		break;
+	case BPF_AND:
+	case BPF_OR:
+	case BPF_XOR:
+		upper_bound = 0xffff;
+		lower_bound = 0;
+		break;
+	case BPF_RSH:
+	case BPF_LSH:
+	case BPF_ARSH:
+		/* Shift amounts are truncated, no need for bounds */
+		upper_bound = S32_MAX;
+		lower_bound = S32_MIN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Immediate move clobbers the register, so no sign/zero
+	 * extension needed.
+	 */
+	if (BPF_CLASS(insn->code) == BPF_ALU64 &&
+	    BPF_OP(insn->code) != BPF_MOV &&
+	    get_reg_val_type(ctx, idx, insn->dst_reg) == REG_32BIT)
+		emit_instr(ctx, dinsu, dst, MIPS_R_ZERO, 32, 32);
+	/* BPF_ALU | BPF_LSH doesn't need separate sign extension */
+	if (BPF_CLASS(insn->code) == BPF_ALU &&
+	    BPF_OP(insn->code) != BPF_LSH &&
+	    BPF_OP(insn->code) != BPF_MOV &&
+	    get_reg_val_type(ctx, idx, insn->dst_reg) != REG_32BIT)
+		emit_instr(ctx, sll, dst, dst, 0);
+
+	if (insn->imm >= lower_bound && insn->imm <= upper_bound) {
+		/* single insn immediate case */
+		switch (BPF_OP(insn->code) | BPF_CLASS(insn->code)) {
+		case BPF_ALU64 | BPF_MOV:
+			emit_instr(ctx, daddiu, dst, MIPS_R_ZERO, insn->imm);
+			break;
+		case BPF_ALU64 | BPF_AND:
+		case BPF_ALU | BPF_AND:
+			emit_instr(ctx, andi, dst, dst, insn->imm);
+			break;
+		case BPF_ALU64 | BPF_OR:
+		case BPF_ALU | BPF_OR:
+			emit_instr(ctx, ori, dst, dst, insn->imm);
+			break;
+		case BPF_ALU64 | BPF_XOR:
+		case BPF_ALU | BPF_XOR:
+			emit_instr(ctx, xori, dst, dst, insn->imm);
+			break;
+		case BPF_ALU64 | BPF_ADD:
+			emit_instr(ctx, daddiu, dst, dst, insn->imm);
+			break;
+		case BPF_ALU64 | BPF_SUB:
+			emit_instr(ctx, daddiu, dst, dst, -insn->imm);
+			break;
+		case BPF_ALU64 | BPF_RSH:
+			emit_instr(ctx, dsrl_safe, dst, dst, insn->imm & 0x3f);
+			break;
+		case BPF_ALU | BPF_RSH:
+			emit_instr(ctx, srl, dst, dst, insn->imm & 0x1f);
+			break;
+		case BPF_ALU64 | BPF_LSH:
+			emit_instr(ctx, dsll_safe, dst, dst, insn->imm & 0x3f);
+			break;
+		case BPF_ALU | BPF_LSH:
+			emit_instr(ctx, sll, dst, dst, insn->imm & 0x1f);
+			break;
+		case BPF_ALU64 | BPF_ARSH:
+			emit_instr(ctx, dsra_safe, dst, dst, insn->imm & 0x3f);
+			break;
+		case BPF_ALU | BPF_ARSH:
+			emit_instr(ctx, sra, dst, dst, insn->imm & 0x1f);
+			break;
+		case BPF_ALU | BPF_MOV:
+			emit_instr(ctx, addiu, dst, MIPS_R_ZERO, insn->imm);
+			break;
+		case BPF_ALU | BPF_ADD:
+			emit_instr(ctx, addiu, dst, dst, insn->imm);
+			break;
+		case BPF_ALU | BPF_SUB:
+			emit_instr(ctx, addiu, dst, dst, -insn->imm);
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		/* multi insn immediate case */
+		if (BPF_OP(insn->code) == BPF_MOV) {
+			gen_imm_to_reg(insn, dst, ctx);
+		} else {
+			gen_imm_to_reg(insn, MIPS_R_AT, ctx);
+			switch (BPF_OP(insn->code) | BPF_CLASS(insn->code)) {
+			case BPF_ALU64 | BPF_AND:
+			case BPF_ALU | BPF_AND:
+				emit_instr(ctx, and, dst, dst, MIPS_R_AT);
+				break;
+			case BPF_ALU64 | BPF_OR:
+			case BPF_ALU | BPF_OR:
+				emit_instr(ctx, or, dst, dst, MIPS_R_AT);
+				break;
+			case BPF_ALU64 | BPF_XOR:
+			case BPF_ALU | BPF_XOR:
+				emit_instr(ctx, xor, dst, dst, MIPS_R_AT);
+				break;
+			case BPF_ALU64 | BPF_ADD:
+				emit_instr(ctx, daddu, dst, dst, MIPS_R_AT);
+				break;
+			case BPF_ALU64 | BPF_SUB:
+				emit_instr(ctx, dsubu, dst, dst, MIPS_R_AT);
+				break;
+			case BPF_ALU | BPF_ADD:
+				emit_instr(ctx, addu, dst, dst, MIPS_R_AT);
+				break;
+			case BPF_ALU | BPF_SUB:
+				emit_instr(ctx, subu, dst, dst, MIPS_R_AT);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void * __must_check
+ool_skb_header_pointer(const struct sk_buff *skb, int offset,
+		       int len, void *buffer)
+{
+	return skb_header_pointer(skb, offset, len, buffer);
+}
+
+static int size_to_len(const struct bpf_insn *insn)
+{
+	switch (BPF_SIZE(insn->code)) {
+	case BPF_B:
+		return 1;
+	case BPF_H:
+		return 2;
+	case BPF_W:
+		return 4;
+	case BPF_DW:
+		return 8;
+	}
+	return 0;
+}
+
+static void emit_const_to_reg(struct jit_ctx *ctx, int dst, u64 value)
+{
+	if (value >= 0xffffffffffff8000ull || value < 0x8000ull) {
+		emit_instr(ctx, daddiu, dst, MIPS_R_ZERO, (int)value);
+	} else if (value >= 0xffffffff80000000ull ||
+		   (value < 0x80000000 && value > 0xffff)) {
+		emit_instr(ctx, lui, dst, (s32)(s16)(value >> 16));
+		emit_instr(ctx, ori, dst, dst, (unsigned int)(value & 0xffff));
+	} else {
+		int i;
+		bool seen_part = false;
+		int needed_shift = 0;
+
+		for (i = 0; i < 4; i++) {
+			u64 part = (value >> (16 * (3 - i))) & 0xffff;
+
+			if (seen_part && needed_shift > 0 && (part || i == 3)) {
+				emit_instr(ctx, dsll_safe, dst, dst, needed_shift);
+				needed_shift = 0;
+			}
+			if (part) {
+				if (i == 0 || (!seen_part && i < 3 && part < 0x8000)) {
+					emit_instr(ctx, lui, dst, (s32)(s16)part);
+					needed_shift = -16;
+				} else {
+					emit_instr(ctx, ori, dst,
+						   seen_part ? dst : MIPS_R_ZERO,
+						   (unsigned int)part);
+				}
+				seen_part = true;
+			}
+			if (seen_part)
+				needed_shift += 16;
+		}
+	}
+}
+
+static int emit_bpf_tail_call(struct jit_ctx *ctx, int this_idx)
+{
+	int off, b_off;
+
+	ctx->flags |= EBPF_SEEN_TC;
+	/*
+	 * if (index >= array->map.max_entries)
+	 *     goto out;
+	 */
+	off = offsetof(struct bpf_array, map.max_entries);
+	emit_instr(ctx, lwu, MIPS_R_T5, off, MIPS_R_A1);
+	emit_instr(ctx, sltu, MIPS_R_AT, MIPS_R_T5, MIPS_R_A2);
+	b_off = b_imm(this_idx + 1, ctx);
+	emit_instr(ctx, bne, MIPS_R_AT, MIPS_R_ZERO, b_off);
+	/*
+	 * if (--TCC < 0)
+	 *     goto out;
+	 */
+	/* Delay slot */
+	emit_instr(ctx, daddiu, MIPS_R_T5,
+		   (ctx->flags & EBPF_TCC_IN_V1) ? MIPS_R_V1 : MIPS_R_S4, -1);
+	b_off = b_imm(this_idx + 1, ctx);
+	emit_instr(ctx, bltz, MIPS_R_T5, b_off);
+	/*
+	 * prog = array->ptrs[index];
+	 * if (prog == NULL)
+	 *     goto out;
+	 */
+	/* Delay slot */
+	emit_instr(ctx, dsll, MIPS_R_T8, MIPS_R_A2, 3);
+	emit_instr(ctx, daddu, MIPS_R_T8, MIPS_R_T8, MIPS_R_A1);
+	off = offsetof(struct bpf_array, ptrs);
+	emit_instr(ctx, ld, MIPS_R_AT, off, MIPS_R_T8);
+	b_off = b_imm(this_idx + 1, ctx);
+	emit_instr(ctx, beq, MIPS_R_AT, MIPS_R_ZERO, b_off);
+	/* Delay slot */
+	emit_instr(ctx, nop);
+
+	/* goto *(prog->bpf_func + 4); */
+	off = offsetof(struct bpf_prog, bpf_func);
+	emit_instr(ctx, ld, MIPS_R_T9, off, MIPS_R_AT);
+	/* All systems are go... propagate TCC */
+	emit_instr(ctx, daddu, MIPS_R_V1, MIPS_R_T5, MIPS_R_ZERO);
+	/* Skip first instruction (TCC initialization) */
+	emit_instr(ctx, daddiu, MIPS_R_T9, MIPS_R_T9, 4);
+	return build_int_epilogue(ctx, MIPS_R_T9);
+}
+
+static bool use_bbit_insns(void)
+{
+	switch (current_cpu_type()) {
+	case CPU_CAVIUM_OCTEON:
+	case CPU_CAVIUM_OCTEON_PLUS:
+	case CPU_CAVIUM_OCTEON2:
+	case CPU_CAVIUM_OCTEON3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool is_bad_offset(int b_off)
+{
+	return b_off > 0x1ffff || b_off < -0x20000;
+}
+
+/* Returns the number of insn slots consumed. */
+static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
+			  int this_idx, int exit_idx)
+{
+	int src, dst, r, td, ts, mem_off, b_off;
+	bool need_swap, did_move, cmp_eq;
+	unsigned int target;
+	u64 t64;
+	s64 t64s;
+
+	switch (insn->code) {
+	case BPF_ALU64 | BPF_ADD | BPF_K: /* ALU64_IMM */
+	case BPF_ALU64 | BPF_SUB | BPF_K: /* ALU64_IMM */
+	case BPF_ALU64 | BPF_OR | BPF_K: /* ALU64_IMM */
+	case BPF_ALU64 | BPF_AND | BPF_K: /* ALU64_IMM */
+	case BPF_ALU64 | BPF_LSH | BPF_K: /* ALU64_IMM */
+	case BPF_ALU64 | BPF_RSH | BPF_K: /* ALU64_IMM */
+	case BPF_ALU64 | BPF_XOR | BPF_K: /* ALU64_IMM */
+	case BPF_ALU64 | BPF_ARSH | BPF_K: /* ALU64_IMM */
+	case BPF_ALU64 | BPF_MOV | BPF_K: /* ALU64_IMM */
+	case BPF_ALU | BPF_MOV | BPF_K: /* ALU32_IMM */
+	case BPF_ALU | BPF_ADD | BPF_K: /* ALU32_IMM */
+	case BPF_ALU | BPF_SUB | BPF_K: /* ALU32_IMM */
+	case BPF_ALU | BPF_OR | BPF_K: /* ALU64_IMM */
+	case BPF_ALU | BPF_AND | BPF_K: /* ALU64_IMM */
+	case BPF_ALU | BPF_LSH | BPF_K: /* ALU64_IMM */
+	case BPF_ALU | BPF_RSH | BPF_K: /* ALU64_IMM */
+	case BPF_ALU | BPF_XOR | BPF_K: /* ALU64_IMM */
+	case BPF_ALU | BPF_ARSH | BPF_K: /* ALU64_IMM */
+		r = gen_imm_insn(insn, ctx, this_idx);
+		if (r < 0)
+			return r;
+		break;
+	case BPF_ALU64 | BPF_MUL | BPF_K: /* ALU64_IMM */
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (dst < 0)
+			return dst;
+		if (get_reg_val_type(ctx, this_idx, insn->dst_reg) == REG_32BIT)
+			emit_instr(ctx, dinsu, dst, MIPS_R_ZERO, 32, 32);
+		if (insn->imm == 1) /* Mult by 1 is a nop */
+			break;
+		gen_imm_to_reg(insn, MIPS_R_AT, ctx);
+		emit_instr(ctx, dmultu, MIPS_R_AT, dst);
+		emit_instr(ctx, mflo, dst);
+		break;
+	case BPF_ALU64 | BPF_NEG | BPF_K: /* ALU64_IMM */
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (dst < 0)
+			return dst;
+		if (get_reg_val_type(ctx, this_idx, insn->dst_reg) == REG_32BIT)
+			emit_instr(ctx, dinsu, dst, MIPS_R_ZERO, 32, 32);
+		emit_instr(ctx, dsubu, dst, MIPS_R_ZERO, dst);
+		break;
+	case BPF_ALU | BPF_MUL | BPF_K: /* ALU_IMM */
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (dst < 0)
+			return dst;
+		td = get_reg_val_type(ctx, this_idx, insn->dst_reg);
+		if (td == REG_64BIT || td == REG_32BIT_ZERO_EX) {
+			/* sign extend */
+			emit_instr(ctx, sll, dst, dst, 0);
+		}
+		if (insn->imm == 1) /* Mult by 1 is a nop */
+			break;
+		gen_imm_to_reg(insn, MIPS_R_AT, ctx);
+		emit_instr(ctx, multu, dst, MIPS_R_AT);
+		emit_instr(ctx, mflo, dst);
+		break;
+	case BPF_ALU | BPF_NEG | BPF_K: /* ALU_IMM */
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (dst < 0)
+			return dst;
+		td = get_reg_val_type(ctx, this_idx, insn->dst_reg);
+		if (td == REG_64BIT || td == REG_32BIT_ZERO_EX) {
+			/* sign extend */
+			emit_instr(ctx, sll, dst, dst, 0);
+		}
+		emit_instr(ctx, subu, dst, MIPS_R_ZERO, dst);
+		break;
+	case BPF_ALU | BPF_DIV | BPF_K: /* ALU_IMM */
+	case BPF_ALU | BPF_MOD | BPF_K: /* ALU_IMM */
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (dst < 0)
+			return dst;
+		if (insn->imm == 0) { /* Div by zero */
+			b_off = b_imm(exit_idx, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_instr(ctx, beq, MIPS_R_ZERO, MIPS_R_ZERO, b_off);
+			emit_instr(ctx, addu, MIPS_R_V0, MIPS_R_ZERO, MIPS_R_ZERO);
+		}
+		td = get_reg_val_type(ctx, this_idx, insn->dst_reg);
+		if (td == REG_64BIT || td == REG_32BIT_ZERO_EX)
+			/* sign extend */
+			emit_instr(ctx, sll, dst, dst, 0);
+		if (insn->imm == 1) {
+			/* div by 1 is a nop, mod by 1 is zero */
+			if (BPF_OP(insn->code) == BPF_MOD)
+				emit_instr(ctx, addu, dst, MIPS_R_ZERO, MIPS_R_ZERO);
+			break;
+		}
+		gen_imm_to_reg(insn, MIPS_R_AT, ctx);
+		emit_instr(ctx, divu, dst, MIPS_R_AT);
+		if (BPF_OP(insn->code) == BPF_DIV)
+			emit_instr(ctx, mflo, dst);
+		else
+			emit_instr(ctx, mfhi, dst);
+		break;
+	case BPF_ALU64 | BPF_DIV | BPF_K: /* ALU_IMM */
+	case BPF_ALU64 | BPF_MOD | BPF_K: /* ALU_IMM */
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (dst < 0)
+			return dst;
+		if (insn->imm == 0) { /* Div by zero */
+			b_off = b_imm(exit_idx, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_instr(ctx, beq, MIPS_R_ZERO, MIPS_R_ZERO, b_off);
+			emit_instr(ctx, addu, MIPS_R_V0, MIPS_R_ZERO, MIPS_R_ZERO);
+		}
+		if (get_reg_val_type(ctx, this_idx, insn->dst_reg) == REG_32BIT)
+			emit_instr(ctx, dinsu, dst, MIPS_R_ZERO, 32, 32);
+
+		if (insn->imm == 1) {
+			/* div by 1 is a nop, mod by 1 is zero */
+			if (BPF_OP(insn->code) == BPF_MOD)
+				emit_instr(ctx, addu, dst, MIPS_R_ZERO, MIPS_R_ZERO);
+			break;
+		}
+		gen_imm_to_reg(insn, MIPS_R_AT, ctx);
+		emit_instr(ctx, ddivu, dst, MIPS_R_AT);
+		if (BPF_OP(insn->code) == BPF_DIV)
+			emit_instr(ctx, mflo, dst);
+		else
+			emit_instr(ctx, mfhi, dst);
+		break;
+	case BPF_ALU64 | BPF_MOV | BPF_X: /* ALU64_REG */
+	case BPF_ALU64 | BPF_ADD | BPF_X: /* ALU64_REG */
+	case BPF_ALU64 | BPF_SUB | BPF_X: /* ALU64_REG */
+	case BPF_ALU64 | BPF_XOR | BPF_X: /* ALU64_REG */
+	case BPF_ALU64 | BPF_OR | BPF_X: /* ALU64_REG */
+	case BPF_ALU64 | BPF_AND | BPF_X: /* ALU64_REG */
+	case BPF_ALU64 | BPF_MUL | BPF_X: /* ALU64_REG */
+	case BPF_ALU64 | BPF_DIV | BPF_X: /* ALU64_REG */
+	case BPF_ALU64 | BPF_MOD | BPF_X: /* ALU64_REG */
+	case BPF_ALU64 | BPF_LSH | BPF_X: /* ALU64_REG */
+	case BPF_ALU64 | BPF_RSH | BPF_X: /* ALU64_REG */
+	case BPF_ALU64 | BPF_ARSH | BPF_X: /* ALU64_REG */
+		src = ebpf_to_mips_reg(ctx, insn, src_reg);
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (src < 0 || dst < 0)
+			return -EINVAL;
+		if (get_reg_val_type(ctx, this_idx, insn->dst_reg) == REG_32BIT)
+			emit_instr(ctx, dinsu, dst, MIPS_R_ZERO, 32, 32);
+		did_move = false;
+		if (insn->src_reg == BPF_REG_10) {
+			if (BPF_OP(insn->code) == BPF_MOV) {
+				emit_instr(ctx, daddiu, dst, MIPS_R_SP, MAX_BPF_STACK);
+				did_move = true;
+			} else {
+				emit_instr(ctx, daddiu, MIPS_R_AT, MIPS_R_SP, MAX_BPF_STACK);
+				src = MIPS_R_AT;
+			}
+		} else if (get_reg_val_type(ctx, this_idx, insn->src_reg) == REG_32BIT) {
+			int tmp_reg = MIPS_R_AT;
+
+			if (BPF_OP(insn->code) == BPF_MOV) {
+				tmp_reg = dst;
+				did_move = true;
+			}
+			emit_instr(ctx, daddu, tmp_reg, src, MIPS_R_ZERO);
+			emit_instr(ctx, dinsu, tmp_reg, MIPS_R_ZERO, 32, 32);
+			src = MIPS_R_AT;
+		}
+		switch (BPF_OP(insn->code)) {
+		case BPF_MOV:
+			if (!did_move)
+				emit_instr(ctx, daddu, dst, src, MIPS_R_ZERO);
+			break;
+		case BPF_ADD:
+			emit_instr(ctx, daddu, dst, dst, src);
+			break;
+		case BPF_SUB:
+			emit_instr(ctx, dsubu, dst, dst, src);
+			break;
+		case BPF_XOR:
+			emit_instr(ctx, xor, dst, dst, src);
+			break;
+		case BPF_OR:
+			emit_instr(ctx, or, dst, dst, src);
+			break;
+		case BPF_AND:
+			emit_instr(ctx, and, dst, dst, src);
+			break;
+		case BPF_MUL:
+			emit_instr(ctx, dmultu, dst, src);
+			emit_instr(ctx, mflo, dst);
+			break;
+		case BPF_DIV:
+		case BPF_MOD:
+			b_off = b_imm(exit_idx, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_instr(ctx, beq, src, MIPS_R_ZERO, b_off);
+			emit_instr(ctx, movz, MIPS_R_V0, MIPS_R_ZERO, src);
+			emit_instr(ctx, ddivu, dst, src);
+			if (BPF_OP(insn->code) == BPF_DIV)
+				emit_instr(ctx, mflo, dst);
+			else
+				emit_instr(ctx, mfhi, dst);
+			break;
+		case BPF_LSH:
+			emit_instr(ctx, dsllv, dst, dst, src);
+			break;
+		case BPF_RSH:
+			emit_instr(ctx, dsrlv, dst, dst, src);
+			break;
+		case BPF_ARSH:
+			emit_instr(ctx, dsrav, dst, dst, src);
+			break;
+		default:
+			pr_err("ALU64_REG NOT HANDLED\n");
+			return -EINVAL;
+		}
+		break;
+	case BPF_ALU | BPF_MOV | BPF_X: /* ALU_REG */
+	case BPF_ALU | BPF_ADD | BPF_X: /* ALU_REG */
+	case BPF_ALU | BPF_SUB | BPF_X: /* ALU_REG */
+	case BPF_ALU | BPF_XOR | BPF_X: /* ALU_REG */
+	case BPF_ALU | BPF_OR | BPF_X: /* ALU_REG */
+	case BPF_ALU | BPF_AND | BPF_X: /* ALU_REG */
+	case BPF_ALU | BPF_MUL | BPF_X: /* ALU_REG */
+	case BPF_ALU | BPF_DIV | BPF_X: /* ALU_REG */
+	case BPF_ALU | BPF_MOD | BPF_X: /* ALU_REG */
+	case BPF_ALU | BPF_LSH | BPF_X: /* ALU_REG */
+	case BPF_ALU | BPF_RSH | BPF_X: /* ALU_REG */
+		src = ebpf_to_mips_reg(ctx, insn, src_reg_no_fp);
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (src < 0 || dst < 0)
+			return -EINVAL;
+		td = get_reg_val_type(ctx, this_idx, insn->dst_reg);
+		if (td == REG_64BIT || td == REG_32BIT_ZERO_EX) {
+			/* sign extend */
+			emit_instr(ctx, sll, dst, dst, 0);
+		}
+		did_move = false;
+		ts = get_reg_val_type(ctx, this_idx, insn->src_reg);
+		if (ts == REG_64BIT || ts == REG_32BIT_ZERO_EX) {
+			int tmp_reg = MIPS_R_AT;
+
+			if (BPF_OP(insn->code) == BPF_MOV) {
+				tmp_reg = dst;
+				did_move = true;
+			}
+			/* sign extend */
+			emit_instr(ctx, sll, tmp_reg, src, 0);
+			src = MIPS_R_AT;
+		}
+		switch (BPF_OP(insn->code)) {
+		case BPF_MOV:
+			if (!did_move)
+				emit_instr(ctx, addu, dst, src, MIPS_R_ZERO);
+			break;
+		case BPF_ADD:
+			emit_instr(ctx, addu, dst, dst, src);
+			break;
+		case BPF_SUB:
+			emit_instr(ctx, subu, dst, dst, src);
+			break;
+		case BPF_XOR:
+			emit_instr(ctx, xor, dst, dst, src);
+			break;
+		case BPF_OR:
+			emit_instr(ctx, or, dst, dst, src);
+			break;
+		case BPF_AND:
+			emit_instr(ctx, and, dst, dst, src);
+			break;
+		case BPF_MUL:
+			emit_instr(ctx, mul, dst, dst, src);
+			break;
+		case BPF_DIV:
+		case BPF_MOD:
+			b_off = b_imm(exit_idx, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_instr(ctx, beq, src, MIPS_R_ZERO, b_off);
+			emit_instr(ctx, movz, MIPS_R_V0, MIPS_R_ZERO, src);
+			emit_instr(ctx, divu, dst, src);
+			if (BPF_OP(insn->code) == BPF_DIV)
+				emit_instr(ctx, mflo, dst);
+			else
+				emit_instr(ctx, mfhi, dst);
+			break;
+		case BPF_LSH:
+			emit_instr(ctx, sllv, dst, dst, src);
+			break;
+		case BPF_RSH:
+			emit_instr(ctx, srlv, dst, dst, src);
+			break;
+		default:
+			pr_err("ALU_REG NOT HANDLED\n");
+			return -EINVAL;
+		}
+		break;
+	case BPF_JMP | BPF_EXIT:
+		if (this_idx + 1 < exit_idx) {
+			b_off = b_imm(exit_idx, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_instr(ctx, beq, MIPS_R_ZERO, MIPS_R_ZERO, b_off);
+			emit_instr(ctx, nop);
+		}
+		break;
+	case BPF_JMP | BPF_JEQ | BPF_K: /* JMP_IMM */
+	case BPF_JMP | BPF_JNE | BPF_K: /* JMP_IMM */
+		cmp_eq = (BPF_OP(insn->code) == BPF_JEQ);
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg_fp_ok);
+		if (dst < 0)
+			return dst;
+		if (insn->imm == 0) {
+			src = MIPS_R_ZERO;
+		} else {
+			gen_imm_to_reg(insn, MIPS_R_AT, ctx);
+			src = MIPS_R_AT;
+		}
+		goto jeq_common;
+	case BPF_JMP | BPF_JEQ | BPF_X: /* JMP_REG */
+	case BPF_JMP | BPF_JNE | BPF_X:
+	case BPF_JMP | BPF_JSGT | BPF_X:
+	case BPF_JMP | BPF_JSGE | BPF_X:
+	case BPF_JMP | BPF_JGT | BPF_X:
+	case BPF_JMP | BPF_JGE | BPF_X:
+	case BPF_JMP | BPF_JSET | BPF_X:
+		src = ebpf_to_mips_reg(ctx, insn, src_reg_no_fp);
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (src < 0 || dst < 0)
+			return -EINVAL;
+		td = get_reg_val_type(ctx, this_idx, insn->dst_reg);
+		ts = get_reg_val_type(ctx, this_idx, insn->src_reg);
+		if (td == REG_32BIT && ts != REG_32BIT) {
+			emit_instr(ctx, sll, MIPS_R_AT, src, 0);
+			src = MIPS_R_AT;
+		} else if (ts == REG_32BIT && td != REG_32BIT) {
+			emit_instr(ctx, sll, MIPS_R_AT, dst, 0);
+			dst = MIPS_R_AT;
+		}
+		if (BPF_OP(insn->code) == BPF_JSET) {
+			emit_instr(ctx, and, MIPS_R_AT, dst, src);
+			cmp_eq = false;
+			dst = MIPS_R_AT;
+			src = MIPS_R_ZERO;
+		} else if (BPF_OP(insn->code) == BPF_JSGT) {
+			emit_instr(ctx, dsubu, MIPS_R_AT, dst, src);
+			if ((insn + 1)->code == (BPF_JMP | BPF_EXIT) && insn->off == 1) {
+				b_off = b_imm(exit_idx, ctx);
+				if (is_bad_offset(b_off))
+					return -E2BIG;
+				emit_instr(ctx, blez, MIPS_R_AT, b_off);
+				emit_instr(ctx, nop);
+				return 2; /* We consumed the exit. */
+			}
+			b_off = b_imm(this_idx + insn->off + 1, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_instr(ctx, bgtz, MIPS_R_AT, b_off);
+			emit_instr(ctx, nop);
+			break;
+		} else if (BPF_OP(insn->code) == BPF_JSGE) {
+			emit_instr(ctx, slt, MIPS_R_AT, dst, src);
+			cmp_eq = true;
+			dst = MIPS_R_AT;
+			src = MIPS_R_ZERO;
+		} else if (BPF_OP(insn->code) == BPF_JGT) {
+			/* dst or src could be AT */
+			emit_instr(ctx, dsubu, MIPS_R_T8, dst, src);
+			emit_instr(ctx, sltu, MIPS_R_AT, dst, src);
+			/* SP known to be non-zero, movz becomes boolean not */
+			emit_instr(ctx, movz, MIPS_R_T9, MIPS_R_SP, MIPS_R_T8);
+			emit_instr(ctx, movn, MIPS_R_T9, MIPS_R_ZERO, MIPS_R_T8);
+			emit_instr(ctx, or, MIPS_R_AT, MIPS_R_T9, MIPS_R_AT);
+			cmp_eq = true;
+			dst = MIPS_R_AT;
+			src = MIPS_R_ZERO;
+		} else if (BPF_OP(insn->code) == BPF_JGE) {
+			emit_instr(ctx, sltu, MIPS_R_AT, dst, src);
+			cmp_eq = true;
+			dst = MIPS_R_AT;
+			src = MIPS_R_ZERO;
+		} else { /* JNE/JEQ case */
+			cmp_eq = (BPF_OP(insn->code) == BPF_JEQ);
+		}
+jeq_common:
+		/*
+		 * If the next insn is EXIT and we are jumping arround
+		 * only it, invert the sense of the compare and
+		 * conditionally jump to the exit.  Poor man's branch
+		 * chaining.
+		 */
+		if ((insn + 1)->code == (BPF_JMP | BPF_EXIT) && insn->off == 1) {
+			b_off = b_imm(exit_idx, ctx);
+			if (is_bad_offset(b_off)) {
+				target = j_target(ctx, exit_idx);
+				if (target == (unsigned int)-1)
+					return -E2BIG;
+				cmp_eq = !cmp_eq;
+				b_off = 4 * 3;
+				if (!(ctx->offsets[this_idx] & OFFSETS_B_CONV)) {
+					ctx->offsets[this_idx] |= OFFSETS_B_CONV;
+					ctx->long_b_conversion = 1;
+				}
+			}
+
+			if (cmp_eq)
+				emit_instr(ctx, bne, dst, src, b_off);
+			else
+				emit_instr(ctx, beq, dst, src, b_off);
+			emit_instr(ctx, nop);
+			if (ctx->offsets[this_idx] & OFFSETS_B_CONV) {
+				emit_instr(ctx, j, target);
+				emit_instr(ctx, nop);
+			}
+			return 2; /* We consumed the exit. */
+		}
+		b_off = b_imm(this_idx + insn->off + 1, ctx);
+		if (is_bad_offset(b_off)) {
+			target = j_target(ctx, this_idx + insn->off + 1);
+			if (target == (unsigned int)-1)
+				return -E2BIG;
+			cmp_eq = !cmp_eq;
+			b_off = 4 * 3;
+			if (!(ctx->offsets[this_idx] & OFFSETS_B_CONV)) {
+				ctx->offsets[this_idx] |= OFFSETS_B_CONV;
+				ctx->long_b_conversion = 1;
+			}
+		}
+
+		if (cmp_eq)
+			emit_instr(ctx, beq, dst, src, b_off);
+		else
+			emit_instr(ctx, bne, dst, src, b_off);
+		emit_instr(ctx, nop);
+		if (ctx->offsets[this_idx] & OFFSETS_B_CONV) {
+			emit_instr(ctx, j, target);
+			emit_instr(ctx, nop);
+		}
+		break;
+	case BPF_JMP | BPF_JSGT | BPF_K: /* JMP_IMM */
+	case BPF_JMP | BPF_JSGE | BPF_K: /* JMP_IMM */
+		cmp_eq = (BPF_OP(insn->code) == BPF_JSGE);
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg_fp_ok);
+		if (dst < 0)
+			return dst;
+
+		if (insn->imm == 0) {
+			if ((insn + 1)->code == (BPF_JMP | BPF_EXIT) && insn->off == 1) {
+				b_off = b_imm(exit_idx, ctx);
+				if (is_bad_offset(b_off))
+					return -E2BIG;
+				if (cmp_eq)
+					emit_instr(ctx, bltz, dst, b_off);
+				else
+					emit_instr(ctx, blez, dst, b_off);
+				emit_instr(ctx, nop);
+				return 2; /* We consumed the exit. */
+			}
+			b_off = b_imm(this_idx + insn->off + 1, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			if (cmp_eq)
+				emit_instr(ctx, bgez, dst, b_off);
+			else
+				emit_instr(ctx, bgtz, dst, b_off);
+			emit_instr(ctx, nop);
+			break;
+		}
+		/*
+		 * only "LT" compare available, so we must use imm + 1
+		 * to generate "GT"
+		 */
+		t64s = insn->imm + (cmp_eq ? 0 : 1);
+		if (t64s >= S16_MIN && t64s <= S16_MAX) {
+			emit_instr(ctx, slti, MIPS_R_AT, dst, (int)t64s);
+			src = MIPS_R_AT;
+			dst = MIPS_R_ZERO;
+			cmp_eq = true;
+			goto jeq_common;
+		}
+		emit_const_to_reg(ctx, MIPS_R_AT, (u64)t64s);
+		emit_instr(ctx, slt, MIPS_R_AT, dst, MIPS_R_AT);
+		src = MIPS_R_AT;
+		dst = MIPS_R_ZERO;
+		cmp_eq = true;
+		goto jeq_common;
+
+	case BPF_JMP | BPF_JGT | BPF_K:
+	case BPF_JMP | BPF_JGE | BPF_K:
+		cmp_eq = (BPF_OP(insn->code) == BPF_JGE);
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg_fp_ok);
+		if (dst < 0)
+			return dst;
+		/*
+		 * only "LT" compare available, so we must use imm + 1
+		 * to generate "GT"
+		 */
+		t64s = (u64)(u32)(insn->imm) + (cmp_eq ? 0 : 1);
+		if (t64s >= 0 && t64s <= S16_MAX) {
+			emit_instr(ctx, sltiu, MIPS_R_AT, dst, (int)t64s);
+			src = MIPS_R_AT;
+			dst = MIPS_R_ZERO;
+			cmp_eq = true;
+			goto jeq_common;
+		}
+		emit_const_to_reg(ctx, MIPS_R_AT, (u64)t64s);
+		emit_instr(ctx, sltu, MIPS_R_AT, dst, MIPS_R_AT);
+		src = MIPS_R_AT;
+		dst = MIPS_R_ZERO;
+		cmp_eq = true;
+		goto jeq_common;
+
+	case BPF_JMP | BPF_JSET | BPF_K: /* JMP_IMM */
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg_fp_ok);
+		if (dst < 0)
+			return dst;
+
+		if (use_bbit_insns() && hweight32((u32)insn->imm) == 1) {
+			if ((insn + 1)->code == (BPF_JMP | BPF_EXIT) && insn->off == 1) {
+				b_off = b_imm(exit_idx, ctx);
+				if (is_bad_offset(b_off))
+					return -E2BIG;
+				emit_instr(ctx, bbit0, dst, ffs((u32)insn->imm) - 1, b_off);
+				emit_instr(ctx, nop);
+				return 2; /* We consumed the exit. */
+			}
+			b_off = b_imm(this_idx + insn->off + 1, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_instr(ctx, bbit1, dst, ffs((u32)insn->imm) - 1, b_off);
+			emit_instr(ctx, nop);
+			break;
+		}
+		t64 = (u32)insn->imm;
+		emit_const_to_reg(ctx, MIPS_R_AT, t64);
+		emit_instr(ctx, and, MIPS_R_AT, dst, MIPS_R_AT);
+		src = MIPS_R_AT;
+		dst = MIPS_R_ZERO;
+		cmp_eq = false;
+		goto jeq_common;
+
+	case BPF_JMP | BPF_JA:
+		/*
+		 * Prefer relative branch for easier debugging, but
+		 * fall back if needed.
+		 */
+		b_off = b_imm(this_idx + insn->off + 1, ctx);
+		if (is_bad_offset(b_off)) {
+			target = j_target(ctx, this_idx + insn->off + 1);
+			if (target == (unsigned int)-1)
+				return -E2BIG;
+			emit_instr(ctx, j, target);
+		} else {
+			emit_instr(ctx, b, b_off);
+		}
+		emit_instr(ctx, nop);
+		break;
+	case BPF_LD | BPF_DW | BPF_IMM:
+		if (insn->src_reg != 0)
+			return -EINVAL;
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (dst < 0)
+			return dst;
+		t64 = ((u64)(u32)insn->imm) | ((u64)(insn + 1)->imm << 32);
+		emit_const_to_reg(ctx, dst, t64);
+		return 2; /* Double slot insn */
+
+	case BPF_JMP | BPF_CALL:
+		ctx->flags |= EBPF_SAVE_RA;
+		t64s = (s64)insn->imm + (s64)__bpf_call_base;
+		emit_const_to_reg(ctx, MIPS_R_T9, (u64)t64s);
+		emit_instr(ctx, jalr, MIPS_R_RA, MIPS_R_T9);
+		/* delay slot */
+		emit_instr(ctx, nop);
+		break;
+
+	case BPF_JMP | BPF_CALL | BPF_X:
+		if (emit_bpf_tail_call(ctx, this_idx))
+			return -EINVAL;
+		break;
+
+	case BPF_LD | BPF_B | BPF_ABS:
+	case BPF_LD | BPF_H | BPF_ABS:
+	case BPF_LD | BPF_W | BPF_ABS:
+	case BPF_LD | BPF_DW | BPF_ABS:
+		ctx->flags |= EBPF_SAVE_RA;
+
+		gen_imm_to_reg(insn, MIPS_R_A1, ctx);
+		emit_instr(ctx, addiu, MIPS_R_A2, MIPS_R_ZERO, size_to_len(insn));
+
+		if (insn->imm < 0) {
+			emit_const_to_reg(ctx, MIPS_R_T9, (u64)bpf_internal_load_pointer_neg_helper);
+		} else {
+			emit_const_to_reg(ctx, MIPS_R_T9, (u64)ool_skb_header_pointer);
+			emit_instr(ctx, daddiu, MIPS_R_A3, MIPS_R_SP, ctx->tmp_offset);
+		}
+		goto ld_skb_common;
+
+	case BPF_LD | BPF_B | BPF_IND:
+	case BPF_LD | BPF_H | BPF_IND:
+	case BPF_LD | BPF_W | BPF_IND:
+	case BPF_LD | BPF_DW | BPF_IND:
+		ctx->flags |= EBPF_SAVE_RA;
+		src = ebpf_to_mips_reg(ctx, insn, src_reg_no_fp);
+		if (src < 0)
+			return src;
+		ts = get_reg_val_type(ctx, this_idx, insn->src_reg);
+		if (ts == REG_32BIT_ZERO_EX) {
+			/* sign extend */
+			emit_instr(ctx, sll, MIPS_R_A1, src, 0);
+			src = MIPS_R_A1;
+		}
+		if (insn->imm >= S16_MIN && insn->imm <= S16_MAX) {
+			emit_instr(ctx, daddiu, MIPS_R_A1, src, insn->imm);
+		} else {
+			gen_imm_to_reg(insn, MIPS_R_AT, ctx);
+			emit_instr(ctx, daddu, MIPS_R_A1, MIPS_R_AT, src);
+		}
+		/* truncate to 32-bit int */
+		emit_instr(ctx, sll, MIPS_R_A1, MIPS_R_A1, 0);
+		emit_instr(ctx, daddiu, MIPS_R_A3, MIPS_R_SP, ctx->tmp_offset);
+		emit_instr(ctx, slt, MIPS_R_AT, MIPS_R_A1, MIPS_R_ZERO);
+
+		emit_const_to_reg(ctx, MIPS_R_T8, (u64)bpf_internal_load_pointer_neg_helper);
+		emit_const_to_reg(ctx, MIPS_R_T9, (u64)ool_skb_header_pointer);
+		emit_instr(ctx, addiu, MIPS_R_A2, MIPS_R_ZERO, size_to_len(insn));
+		emit_instr(ctx, movn, MIPS_R_T9, MIPS_R_T8, MIPS_R_AT);
+
+ld_skb_common:
+		emit_instr(ctx, jalr, MIPS_R_RA, MIPS_R_T9);
+		/* delay slot move */
+		emit_instr(ctx, daddu, MIPS_R_A0, MIPS_R_S0, MIPS_R_ZERO);
+
+		/* Check the error value */
+		b_off = b_imm(exit_idx, ctx);
+		if (is_bad_offset(b_off)) {
+			target = j_target(ctx, exit_idx);
+			if (target == (unsigned int)-1)
+				return -E2BIG;
+
+			if (!(ctx->offsets[this_idx] & OFFSETS_B_CONV)) {
+				ctx->offsets[this_idx] |= OFFSETS_B_CONV;
+				ctx->long_b_conversion = 1;
+			}
+			emit_instr(ctx, bne, MIPS_R_V0, MIPS_R_ZERO, 4 * 3);
+			emit_instr(ctx, nop);
+			emit_instr(ctx, j, target);
+			emit_instr(ctx, nop);
+		} else {
+			emit_instr(ctx, beq, MIPS_R_V0, MIPS_R_ZERO, b_off);
+			emit_instr(ctx, nop);
+		}
+
+#ifdef __BIG_ENDIAN
+		need_swap = false;
+#else
+		need_swap = true;
+#endif
+		dst = MIPS_R_V0;
+		switch (BPF_SIZE(insn->code)) {
+		case BPF_B:
+			emit_instr(ctx, lbu, dst, 0, MIPS_R_V0);
+			break;
+		case BPF_H:
+			emit_instr(ctx, lhu, dst, 0, MIPS_R_V0);
+			if (need_swap)
+				emit_instr(ctx, wsbh, dst, dst);
+			break;
+		case BPF_W:
+			emit_instr(ctx, lw, dst, 0, MIPS_R_V0);
+			if (need_swap) {
+				emit_instr(ctx, wsbh, dst, dst);
+				emit_instr(ctx, rotr, dst, dst, 16);
+			}
+			break;
+		case BPF_DW:
+			emit_instr(ctx, ld, dst, 0, MIPS_R_V0);
+			if (need_swap) {
+				emit_instr(ctx, dsbh, dst, dst);
+				emit_instr(ctx, dshd, dst, dst);
+			}
+			break;
+		}
+
+		break;
+	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU | BPF_END | BPF_FROM_LE:
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (dst < 0)
+			return dst;
+		td = get_reg_val_type(ctx, this_idx, insn->dst_reg);
+		if (insn->imm == 64 && td == REG_32BIT)
+			emit_instr(ctx, dinsu, dst, MIPS_R_ZERO, 32, 32);
+
+		if (insn->imm != 64 &&
+		    (td == REG_64BIT || td == REG_32BIT_ZERO_EX)) {
+			/* sign extend */
+			emit_instr(ctx, sll, dst, dst, 0);
+		}
+
+#ifdef __BIG_ENDIAN
+		need_swap = (BPF_SRC(insn->code) == BPF_FROM_LE);
+#else
+		need_swap = (BPF_SRC(insn->code) == BPF_FROM_BE);
+#endif
+		if (insn->imm == 16) {
+			if (need_swap)
+				emit_instr(ctx, wsbh, dst, dst);
+			emit_instr(ctx, andi, dst, dst, 0xffff);
+		} else if (insn->imm == 32) {
+			if (need_swap) {
+				emit_instr(ctx, wsbh, dst, dst);
+				emit_instr(ctx, rotr, dst, dst, 16);
+			}
+		} else { /* 64-bit*/
+			if (need_swap) {
+				emit_instr(ctx, dsbh, dst, dst);
+				emit_instr(ctx, dshd, dst, dst);
+			}
+		}
+		break;
+
+	case BPF_ST | BPF_B | BPF_MEM:
+	case BPF_ST | BPF_H | BPF_MEM:
+	case BPF_ST | BPF_W | BPF_MEM:
+	case BPF_ST | BPF_DW | BPF_MEM:
+		if (insn->dst_reg == BPF_REG_10) {
+			ctx->flags |= EBPF_SEEN_FP;
+			dst = MIPS_R_SP;
+			mem_off = insn->off + MAX_BPF_STACK;
+		} else {
+			dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+			if (dst < 0)
+				return dst;
+			mem_off = insn->off;
+		}
+		gen_imm_to_reg(insn, MIPS_R_AT, ctx);
+		switch (BPF_SIZE(insn->code)) {
+		case BPF_B:
+			emit_instr(ctx, sb, MIPS_R_AT, mem_off, dst);
+			break;
+		case BPF_H:
+			emit_instr(ctx, sh, MIPS_R_AT, mem_off, dst);
+			break;
+		case BPF_W:
+			emit_instr(ctx, sw, MIPS_R_AT, mem_off, dst);
+			break;
+		case BPF_DW:
+			emit_instr(ctx, sd, MIPS_R_AT, mem_off, dst);
+			break;
+		}
+		break;
+
+	case BPF_LDX | BPF_B | BPF_MEM:
+	case BPF_LDX | BPF_H | BPF_MEM:
+	case BPF_LDX | BPF_W | BPF_MEM:
+	case BPF_LDX | BPF_DW | BPF_MEM:
+		if (insn->src_reg == BPF_REG_10) {
+			ctx->flags |= EBPF_SEEN_FP;
+			src = MIPS_R_SP;
+			mem_off = insn->off + MAX_BPF_STACK;
+		} else {
+			src = ebpf_to_mips_reg(ctx, insn, src_reg_no_fp);
+			if (src < 0)
+				return src;
+			mem_off = insn->off;
+		}
+		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+		if (dst < 0)
+			return dst;
+		switch (BPF_SIZE(insn->code)) {
+		case BPF_B:
+			emit_instr(ctx, lbu, dst, mem_off, src);
+			break;
+		case BPF_H:
+			emit_instr(ctx, lhu, dst, mem_off, src);
+			break;
+		case BPF_W:
+			emit_instr(ctx, lw, dst, mem_off, src);
+			break;
+		case BPF_DW:
+			emit_instr(ctx, ld, dst, mem_off, src);
+			break;
+		}
+		break;
+
+	case BPF_STX | BPF_B | BPF_MEM:
+	case BPF_STX | BPF_H | BPF_MEM:
+	case BPF_STX | BPF_W | BPF_MEM:
+	case BPF_STX | BPF_DW | BPF_MEM:
+	case BPF_STX | BPF_W | BPF_XADD:
+	case BPF_STX | BPF_DW | BPF_XADD:
+		if (insn->dst_reg == BPF_REG_10) {
+			ctx->flags |= EBPF_SEEN_FP;
+			dst = MIPS_R_SP;
+			mem_off = insn->off + MAX_BPF_STACK;
+		} else {
+			dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
+			if (dst < 0)
+				return dst;
+			mem_off = insn->off;
+		}
+		src = ebpf_to_mips_reg(ctx, insn, src_reg_no_fp);
+		if (src < 0)
+			return dst;
+		if (BPF_MODE(insn->code) == BPF_XADD) {
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_W:
+				if (get_reg_val_type(ctx, this_idx, insn->src_reg) == REG_32BIT) {
+					emit_instr(ctx, sll, MIPS_R_AT, src, 0);
+					src = MIPS_R_AT;
+				}
+				emit_instr(ctx, ll, MIPS_R_T8, mem_off, dst);
+				emit_instr(ctx, addu, MIPS_R_T8, MIPS_R_T8, src);
+				emit_instr(ctx, sc, MIPS_R_T8, mem_off, dst);
+				/*
+				 * On failure back up to LL (-4
+				 * instructions of 4 bytes each
+				 */
+				emit_instr(ctx, beq, MIPS_R_T8, MIPS_R_ZERO, -4 * 4);
+				emit_instr(ctx, nop);
+				break;
+			case BPF_DW:
+				if (get_reg_val_type(ctx, this_idx, insn->src_reg) == REG_32BIT) {
+					emit_instr(ctx, daddu, MIPS_R_AT, src, MIPS_R_ZERO);
+					emit_instr(ctx, dinsu, MIPS_R_AT, MIPS_R_ZERO, 32, 32);
+					src = MIPS_R_AT;
+				}
+				emit_instr(ctx, lld, MIPS_R_T8, mem_off, dst);
+				emit_instr(ctx, daddu, MIPS_R_T8, MIPS_R_T8, src);
+				emit_instr(ctx, scd, MIPS_R_T8, mem_off, dst);
+				emit_instr(ctx, beq, MIPS_R_T8, MIPS_R_ZERO, -4 * 4);
+				emit_instr(ctx, nop);
+				break;
+			}
+		} else { /* BPF_MEM */
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_B:
+				emit_instr(ctx, sb, src, mem_off, dst);
+				break;
+			case BPF_H:
+				emit_instr(ctx, sh, src, mem_off, dst);
+				break;
+			case BPF_W:
+				emit_instr(ctx, sw, src, mem_off, dst);
+				break;
+			case BPF_DW:
+				if (get_reg_val_type(ctx, this_idx, insn->src_reg) == REG_32BIT) {
+					emit_instr(ctx, daddu, MIPS_R_AT, src, MIPS_R_ZERO);
+					emit_instr(ctx, dinsu, MIPS_R_AT, MIPS_R_ZERO, 32, 32);
+					src = MIPS_R_AT;
+				}
+				emit_instr(ctx, sd, src, mem_off, dst);
+				break;
+			}
+		}
+		break;
+
+	default:
+		pr_err("NOT HANDLED %d - (%02x)\n",
+		       this_idx, (unsigned int)insn->code);
+		return -EINVAL;
+	}
+	return 1;
+}
+
+#define RVT_VISITED_MASK 0xc000000000000000ull
+#define RVT_FALL_THROUGH 0x4000000000000000ull
+#define RVT_BRANCH_TAKEN 0x8000000000000000ull
+#define RVT_DONE (RVT_FALL_THROUGH | RVT_BRANCH_TAKEN)
+
+static int build_int_body(struct jit_ctx *ctx)
+{
+	const struct bpf_prog *prog = ctx->skf;
+	const struct bpf_insn *insn;
+	int i, r;
+
+	for (i = 0; i < prog->len; ) {
+		insn = prog->insnsi + i;
+		if ((ctx->reg_val_types[i] & RVT_VISITED_MASK) == 0) {
+			/* dead instruction, don't emit it. */
+			i++;
+			continue;
+		}
+
+		if (ctx->target == NULL)
+			ctx->offsets[i] = (ctx->offsets[i] & OFFSETS_B_CONV) | (ctx->idx * 4);
+
+		r = build_one_insn(insn, ctx, i, prog->len);
+		if (r < 0)
+			return r;
+		i += r;
+	}
+	/* epilogue offset */
+	if (ctx->target == NULL)
+		ctx->offsets[i] = ctx->idx * 4;
+
+	/*
+	 * All exits have an offset of the epilogue, some offsets may
+	 * not have been set due to banch-around threading, so set
+	 * them now.
+	 */
+	if (ctx->target == NULL)
+		for (i = 0; i < prog->len; i++) {
+			insn = prog->insnsi + i;
+			if (insn->code == (BPF_JMP | BPF_EXIT))
+				ctx->offsets[i] = ctx->idx * 4;
+		}
+	return 0;
+}
+
+/* return the last idx processed, or negative for error */
+static int reg_val_propagate_range(struct jit_ctx *ctx, u64 initial_rvt,
+				   int start_idx, bool follow_taken)
+{
+	const struct bpf_prog *prog = ctx->skf;
+	const struct bpf_insn *insn;
+	u64 exit_rvt = initial_rvt;
+	u64 *rvt = ctx->reg_val_types;
+	int idx;
+	int reg;
+
+	for (idx = start_idx; idx < prog->len; idx++) {
+		rvt[idx] = (rvt[idx] & RVT_VISITED_MASK) | exit_rvt;
+		insn = prog->insnsi + idx;
+		switch (BPF_CLASS(insn->code)) {
+		case BPF_ALU:
+			switch (BPF_OP(insn->code)) {
+			case BPF_ADD:
+			case BPF_SUB:
+			case BPF_MUL:
+			case BPF_DIV:
+			case BPF_OR:
+			case BPF_AND:
+			case BPF_LSH:
+			case BPF_RSH:
+			case BPF_NEG:
+			case BPF_MOD:
+			case BPF_XOR:
+				set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT);
+				break;
+			case BPF_MOV:
+				if (BPF_SRC(insn->code)) {
+					set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT);
+				} else {
+					/* IMM to REG move*/
+					if (insn->imm >= 0)
+						set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT_POS);
+					else
+						set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT);
+				}
+				break;
+			case BPF_END:
+				if (insn->imm == 64)
+					set_reg_val_type(&exit_rvt, insn->dst_reg, REG_64BIT);
+				else if (insn->imm == 32)
+					set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT);
+				else /* insn->imm == 16 */
+					set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT_POS);
+				break;
+			}
+			rvt[idx] |= RVT_DONE;
+			break;
+		case BPF_ALU64:
+			switch (BPF_OP(insn->code)) {
+			case BPF_MOV:
+				if (BPF_SRC(insn->code)) {
+					/* REG to REG move*/
+					set_reg_val_type(&exit_rvt, insn->dst_reg, REG_64BIT);
+				} else {
+					/* IMM to REG move*/
+					if (insn->imm >= 0)
+						set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT_POS);
+					else
+						set_reg_val_type(&exit_rvt, insn->dst_reg, REG_64BIT_32BIT);
+				}
+				break;
+			default:
+				set_reg_val_type(&exit_rvt, insn->dst_reg, REG_64BIT);
+			}
+			rvt[idx] |= RVT_DONE;
+			break;
+		case BPF_LD:
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_DW:
+				if (BPF_MODE(insn->code) == BPF_IMM) {
+					s64 val;
+
+					val = (s64)((u32)insn->imm | ((u64)(insn + 1)->imm << 32));
+					if (val > 0 && val <= S32_MAX)
+						set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT_POS);
+					else if (val >= S32_MIN && val <= S32_MAX)
+						set_reg_val_type(&exit_rvt, insn->dst_reg, REG_64BIT_32BIT);
+					else
+						set_reg_val_type(&exit_rvt, insn->dst_reg, REG_64BIT);
+					rvt[idx] |= RVT_DONE;
+					idx++;
+				} else {
+					set_reg_val_type(&exit_rvt, insn->dst_reg, REG_64BIT);
+				}
+				break;
+			case BPF_B:
+			case BPF_H:
+				set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT_POS);
+				break;
+			case BPF_W:
+				if (BPF_MODE(insn->code) == BPF_IMM)
+					set_reg_val_type(&exit_rvt, insn->dst_reg,
+							 insn->imm >= 0 ? REG_32BIT_POS : REG_32BIT);
+				else
+					set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT);
+				break;
+			}
+			rvt[idx] |= RVT_DONE;
+			break;
+		case BPF_LDX:
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_DW:
+				set_reg_val_type(&exit_rvt, insn->dst_reg, REG_64BIT);
+				break;
+			case BPF_B:
+			case BPF_H:
+				set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT_POS);
+				break;
+			case BPF_W:
+				set_reg_val_type(&exit_rvt, insn->dst_reg, REG_32BIT);
+				break;
+			}
+			rvt[idx] |= RVT_DONE;
+			break;
+		case BPF_JMP:
+			switch (BPF_OP(insn->code)) {
+			case BPF_EXIT:
+				rvt[idx] = RVT_DONE | exit_rvt;
+				rvt[prog->len] = exit_rvt;
+				return idx;
+			case BPF_JA:
+				rvt[idx] |= RVT_DONE;
+				idx += insn->off;
+				break;
+			case BPF_JEQ:
+			case BPF_JGT:
+			case BPF_JGE:
+			case BPF_JSET:
+			case BPF_JNE:
+			case BPF_JSGT:
+			case BPF_JSGE:
+				if (follow_taken) {
+					rvt[idx] |= RVT_BRANCH_TAKEN;
+					idx += insn->off;
+					follow_taken = false;
+				} else {
+					rvt[idx] |= RVT_FALL_THROUGH;
+				}
+				break;
+			case BPF_CALL:
+				set_reg_val_type(&exit_rvt, BPF_REG_0, REG_64BIT);
+				/* Upon call return, argument registers are clobbered. */
+				for (reg = BPF_REG_0; reg <= BPF_REG_5; reg++)
+					set_reg_val_type(&exit_rvt, reg, REG_64BIT);
+
+				rvt[idx] |= RVT_DONE;
+				break;
+			default:
+				WARN(1, "Unhandled BPF_JMP case.\n");
+				rvt[idx] |= RVT_DONE;
+				break;
+			}
+			break;
+		default:
+			rvt[idx] |= RVT_DONE;
+			break;
+		}
+	}
+	return idx;
+}
+
+/*
+ * Track the value range (i.e. 32-bit vs. 64-bit) of each register at
+ * each eBPF insn.  This allows unneeded sign and zero extension
+ * operations to be omitted.
+ *
+ * Doesn't handle yet confluence of control paths with conflicting
+ * ranges, but it is good enough for most sane code.
+ */
+static int reg_val_propagate(struct jit_ctx *ctx)
+{
+	const struct bpf_prog *prog = ctx->skf;
+	u64 exit_rvt;
+	int reg;
+	int i;
+
+	/*
+	 * 11 registers * 3 bits/reg leaves top bits free for other
+	 * uses.  Bit-62..63 used to see if we have visited an insn.
+	 */
+	exit_rvt = 0;
+
+	/* Upon entry, argument registers are 64-bit. */
+	for (reg = BPF_REG_1; reg <= BPF_REG_5; reg++)
+		set_reg_val_type(&exit_rvt, reg, REG_64BIT);
+
+	/*
+	 * First follow all conditional branches on the fall-through
+	 * edge of control flow..
+	 */
+	reg_val_propagate_range(ctx, exit_rvt, 0, false);
+restart_search:
+	/*
+	 * Then repeatedly find the first conditional branch where
+	 * both edges of control flow have not been taken, and follow
+	 * the branch taken edge.  We will end up restarting the
+	 * search once per conditional branch insn.
+	 */
+	for (i = 0; i < prog->len; i++) {
+		u64 rvt = ctx->reg_val_types[i];
+
+		if ((rvt & RVT_VISITED_MASK) == RVT_DONE ||
+		    (rvt & RVT_VISITED_MASK) == 0)
+			continue;
+		if ((rvt & RVT_VISITED_MASK) == RVT_FALL_THROUGH) {
+			reg_val_propagate_range(ctx, rvt & ~RVT_VISITED_MASK, i, true);
+		} else { /* RVT_BRANCH_TAKEN */
+			WARN(1, "Unexpected RVT_BRANCH_TAKEN case.\n");
+			reg_val_propagate_range(ctx, rvt & ~RVT_VISITED_MASK, i, false);
+		}
+		goto restart_search;
+	}
+	/*
+	 * Eventually all conditional branches have been followed on
+	 * both branches and we are done.  Any insn that has not been
+	 * visited at this point is dead.
+	 */
+
+	return 0;
+}
+
+static void jit_fill_hole(void *area, unsigned int size)
+{
+	u32 *p;
+
+	/* We are guaranteed to have aligned memory. */
+	for (p = area; size >= sizeof(u32); size -= sizeof(u32))
+		uasm_i_break(&p, BRK_BUG); /* Increments p */
+}
+
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+{
+	struct bpf_prog *orig_prog = prog;
+	bool tmp_blinded = false;
+	struct bpf_prog *tmp;
+	struct bpf_binary_header *header = NULL;
+	struct jit_ctx ctx;
+	unsigned int image_size;
+	u8 *image_ptr;
+
+	if (!bpf_jit_enable || !cpu_has_mips64r2)
+		return prog;
+
+	tmp = bpf_jit_blind_constants(prog);
+	/* If blinding was requested and we failed during blinding,
+	 * we must fall back to the interpreter.
+	 */
+	if (IS_ERR(tmp))
+		return orig_prog;
+	if (tmp != prog) {
+		tmp_blinded = true;
+		prog = tmp;
+	}
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	ctx.offsets = kcalloc(prog->len + 1, sizeof(*ctx.offsets), GFP_KERNEL);
+	if (ctx.offsets == NULL)
+		goto out_err;
+
+	ctx.reg_val_types = kcalloc(prog->len + 1, sizeof(*ctx.reg_val_types), GFP_KERNEL);
+	if (ctx.reg_val_types == NULL)
+		goto out_err;
+
+	ctx.skf = prog;
+
+	if (reg_val_propagate(&ctx))
+		goto out_err;
+
+	/*
+	 * First pass discovers used resources and instruction offsets
+	 * assuming short branches are used.
+	 */
+	if (build_int_body(&ctx))
+		goto out_err;
+
+	/*
+	 * If no calls are made (EBPF_SAVE_RA), then tail call count
+	 * in $v1, else we must save in n$s4.
+	 */
+	if (ctx.flags & EBPF_SEEN_TC) {
+		if (ctx.flags & EBPF_SAVE_RA)
+			ctx.flags |= EBPF_SAVE_S4;
+		else
+			ctx.flags |= EBPF_TCC_IN_V1;
+	}
+
+	/*
+	 * Second pass generates offsets, if any branches are out of
+	 * range a jump-around long sequence is generated, and we have
+	 * to try again from the beginning to generate the new
+	 * offsets.  This is done until no additional conversions are
+	 * necessary.
+	 */
+	do {
+		ctx.idx = 0;
+		ctx.gen_b_offsets = 1;
+		ctx.long_b_conversion = 0;
+		if (gen_int_prologue(&ctx))
+			goto out_err;
+		if (build_int_body(&ctx))
+			goto out_err;
+		if (build_int_epilogue(&ctx, MIPS_R_RA))
+			goto out_err;
+	} while (ctx.long_b_conversion);
+
+	image_size = 4 * ctx.idx;
+
+	header = bpf_jit_binary_alloc(image_size, &image_ptr,
+				      sizeof(u32), jit_fill_hole);
+	if (header == NULL)
+		goto out_err;
+
+	ctx.target = (u32 *)image_ptr;
+
+	/* Third pass generates the code */
+	ctx.idx = 0;
+	if (gen_int_prologue(&ctx))
+		goto out_err;
+	if (build_int_body(&ctx))
+		goto out_err;
+	if (build_int_epilogue(&ctx, MIPS_R_RA))
+		goto out_err;
+
+	/* Update the icache */
+	flush_icache_range((unsigned long)ctx.target,
+			   (unsigned long)(ctx.target + ctx.idx * sizeof(u32)));
+
+	if (bpf_jit_enable > 1)
+		/* Dump JIT code */
+		bpf_jit_dump(prog->len, image_size, 2, ctx.target);
+
+	bpf_jit_binary_lock_ro(header);
+	prog->bpf_func = (void *)ctx.target;
+	prog->jited = 1;
+out_normal:
+	if (tmp_blinded)
+		bpf_jit_prog_release_other(prog, prog == orig_prog ?
+					   tmp : orig_prog);
+	kfree(ctx.offsets);
+	kfree(ctx.reg_val_types);
+
+	return prog;
+
+out_err:
+	prog = orig_prog;
+	if (header)
+		bpf_jit_binary_free(header);
+	goto out_normal;
+}
-- 
2.9.4
