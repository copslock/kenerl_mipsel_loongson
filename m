Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 17:01:50 +0200 (CEST)
Received: from mail-eopbgr30116.outbound.protection.outlook.com ([40.107.3.116]:44544
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992717AbcHPPBnihUbb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Aug 2016 17:01:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GhOIzEIhC17h3Oapz34sDVgs7Zf24zBeTB9hNoNpJR4=;
 b=gPckZUCMhlZnQUdgDkS5G0zLfHgXp/AAcSiXCsdhbHKU/2Nt2+9nyAQ/le5rhuXEs5/WdZaMWynRQiP8c2ZGMJnv8Y/XFzJaNMwHvh1QANa1qtxx98zZEMGCate0lNeoGdCGK0da4336xdtc2M6PQGCFGVqpmm8RV11okjbtRw8=
Received: from DB6PR0701CA0029.eurprd07.prod.outlook.com (10.168.7.167) by
 DB6PR0701MB2952.eurprd07.prod.outlook.com (10.168.84.14) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.549.15; Tue, 16 Aug 2016 15:01:36 +0000
Received: from DB3FFO11FD049.protection.gbl (2a01:111:f400:7e04::164) by
 DB6PR0701CA0029.outlook.office365.com (2603:10a6:4:3::39) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.557.21 via Frontend Transport; Tue, 16 Aug 2016 15:01:35 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.241) by
 DB3FFO11FD049.mail.protection.outlook.com (10.47.217.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.567.7 via Frontend Transport; Tue, 16 Aug 2016 15:01:36 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id u7GF0hbw012637
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2016 18:00:43 +0300
Received: from ak-desktop.emea.nsn-net.net (eskara3c-dhcp036118.emea.nsn-net.net [10.144.36.118])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with SMTP id u7GF0gb5012574;
        Tue, 16 Aug 2016 18:00:42 +0300
X-HPESVCS-Source-Ip: 10.144.36.118
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 18:00:57 +0300
Date:   Tue, 16 Aug 2016 18:00:57 +0300
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [BISECTED REGRESSION] v4.8-rc: DT/OCTEON driver probing broken
Message-ID: <20160816150056.GD18731@ak-desktop.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:NLI;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(7916002)(2980300002)(438002)(199003)(189002)(8676002)(23726003)(626004)(305945005)(7846002)(97756001)(92566002)(1076002)(50466002)(50986999)(83506001)(2906002)(586003)(4326007)(54356999)(356003)(9686002)(8936002)(81156014)(33656002)(81166006)(47776003)(42186005)(229853001)(97736004)(46406003)(2201001)(106466001)(86362001)(189998001)(68736007)(19580405001)(4001350100001)(87936001)(5001770100001)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0701MB2952;H:fihe3nok0735.emea.nsn-net.net;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DB3FFO11FD049;1:eh6ofQC6BevFAN8DCt4cXFtCSGHCe5H7IN7aPU6evnMVov4AngzWkmrozpKAJa/XRuf4l504M17fxx9QD0AlBHUPAVLpiI3pTQ8w+n80mHGhZ4eRE+eZ4Q6oNBVK+PBZv672V3V4ZCc1V9Bxhx3uFdKJheux1psPcnib2Gco0NnSDiMp2Av4zNDJMGfkkXbU45iACadf7ROEYqDlm06c6Br7VyJi0yAb/DnEjURnN6Qnz6/XWW+RNQkSSC2JsSsETVmAWpI5XGLJhBCHgYt9WUMkpU3KtRDyvXEZiXqYVMNYRmzf0jQfYGBY+AR2muZ576rUHjjRPRgoQbTpSXopr0uSV3Xd6KyOrKK3Zp7fay+zkcqk4w2Xt4o+6fPd9RpdtkPc1vIj2VbbLW1sezqOvxWmll5RMNjKnoCAWsVQTVDJwupo9N0UNVuGLYNMes3GyLvJsmR5e/xycryvXZVq6dk08YKRSFqBIljS67+TaayzVuNEIjp/LhbD3pLWImJg
X-MS-Office365-Filtering-Correlation-Id: d00c3318-ad4c-463c-6f47-08d3c5e63898
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB2952;2:BQ8+fYgCPw7gg6kp8zczdY3R5tvE3BLnSra/Jg0GtkhwUdBgJVldtyu2/u5WvPjDW8xitPJa9fnxhMNfJZaim6rUOF3LYvbki0p/b3Rd8HDxwI176/CQM0RO5Tp+lJMH/yEdbY7rcIE0zwUk33PjLtyNl1hdL5B59I8wW1hRIS1rI88Qk/tMdlBAyZ8Ps+4t;3:NeZnW3fAHiHC6Yzm/cCM8fc8WKMSRmHNxMRQEzxrx2ZiYOeLCBtHe4eXhm/nKqS2Cfuin0F0t2O0g5hSX9vXA/hyt7mpHHjzufvM8cE52NHrbLaWNFWC/jrYmvOC1PzdgSGjx6ZkSVcTAjo2AVuF+J23UCzWTSdugFw7jF0/oQyNJrHJaT1JoAd+cOsxk5aZ7eQI3zQixdzpCj/yTIFwdLcL7C+nB3T0DdyzHseN7Qj8YLP9HG0Q1Rlu+H1dGIRmPyB+JMA5t1KV6u8h+Z6FiA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:DB6PR0701MB2952;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB2952;25:slUI4R7B2ZQO+ItQiYOx6p2JCMzTsqNwMKjBp89KQL22wgXi58lLOWR7MG4KGty7s1ijSxmclO6ofg0OW1AxhS16yPQLFbPNREIr0YwQ/oVrOeyNLcHaVkwl9hHSn42G1wSL+wBx2cXhyGIaAlsetP2ln5XG8aWF/FIL7uVFfrmXHLexFYpQhq3Z/fvCJti35wgUp1iNf1E+rw2SO1qo8gkBDEp0CDTBlVHMBI7CFym5vUl7OJbfDLSZ0vK2t8Da/X3SuxDv+4SLIzUOL8/bhhYrvoOjeE29kkIut/czdJQQjSSBRYppaP6m/5n1Adp80rMpWtME8usmMe0MxIMbiELtebeGbExqHyhwCdSKrlCdL/G40KzCgiJUYDyp7HucMCIkD49iJUohplFw1+LbJVa4Fl+S3LRfWrl5M7HolOcy++C32pd6tprfnubXNYqHS/P7mLso/t9c9LA+f+5pKnjL9k2ETtk6PtVoEu9BBZJ81zY60XMzu0NH6zWfIcFvgkr0PrYRabuozAy9WQ8eimN5Er3FSjpWc4zMTXeW+YWFKs6tWzt2ZHisHdSyF0SqKVBJNARQh4IMQUJ2quzFI3mRXB1Ep8yLK+pLdQY9FrxsUjfP6PZcEsc2ciSOZ60YwVzcdx56JmMNJRxxIuy+nam7pKuVlYiV21A2uYemjL50Q5MeqDZG/9nuTkLsXpKP+nEkORd1ecVhMNTaIwLsIpwU/yNVHZG7YAHMMjT+BELnIBWLgFWmd7D8IYhXnvwB
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB2952;31:CUeY3dqDUw72zZ/LeHJytqCQzZ4X7rrEgQBnXMrWoKBK/Sm2MJFHk55fLBgVEOYwfyCRXqiLhDOIcu10ESH+zgPJd3ZAArJAalRsv0RQPByz4msTq8nab2iw1sN4XzJ3twif2Kg7JJslKw8oXD4OFgQ3q99pfs2VG9+DAbqs8wKLMKMO/dN+GxhzNX/S33OCerw+SpmoEAPJgg4M9nHKQiLdyIj0ZZkGzgja0xQdPXg=;20:LLg4UBg6M0DFHcRo/PK17GNpCIpFjd4nUk52OyZFEd6SQlpIFr4YKYCwLXBM2Cek+7bYMbNcRgpEJ9Dtw17V+NiLr+DVbfxazhYKKYZCv899r3zJKYmavWD0QAyCDI3e4VYObnZJOTl/0ps/8ua3CvGDGYth3R5fxUh5T4+ev2IRYd8Vk0ARYnX8QWLdnSjkyuCO4kgB+8s54Rln37ePO1ZDjMi4J6SFy1NMurkve2DdRNk7Sznkz6wXOt2GCF/8lG3gqJopisjpr69u1/qx4DIaRjNpy+5CdsitxmwrF5Y3LURRIcdFc+TW2rCgn/ud1lJ9iIkhnpldQat0TvyutojB8k41VvXBcTIJ+rn07V+y6S9Z5JJiN4cwbY+Eiz1Aedir2ADvp5aMM85W1nEGX8Y529x48nIJT2ee+Jv0hs4RPVj+siuK4eMPXRbbb3D8aLIdSJyHiUfO7UF5PSX0ZDd0jxpSf+KRFMP0tkk3RyWu2j8BgG/hG0J/+XWScB+nygYPzvNXtrngwoixrZiDgzt5AUnIuZKv3kwsd/3jooEgkevr2jNpFjVkkB+DoZOwckEYRTtTpexpu58U2H3zX4ei2EH5RcMX42yedH4KLrU=
X-Microsoft-Antispam-PRVS: <DB6PR0701MB2952224784215D15FC7D2C5AF4130@DB6PR0701MB2952.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(13016025)(13018025)(3002001)(10201501046)(6055026);SRVR:DB6PR0701MB2952;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0701MB2952;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB2952;4:ZM1TryOV04uDCfFon4en7MiCqfu+ZegdrUKOjzqH5zGqJtSxHGWoPBJKVfhUEHmHDSFCuukD2HUENWVYeYsl+nEJBygi78U7f+npp2ofdaGkQVBLJbYV1ttdDb6CXrJOR/EFBFya8/ku4ydg973MatPOLj9N68xGsLzTm9nhH0cPl1bM2t4L+GiSTxAi7H4g8SYdSiHlkFmyx1oD2Zi5px6BGGX/9TT0vyyOPrBfqxWu7Gxm2ssBZIExUh+KjGWFpBzE20k9MwSsVinMwEh4LszZdlRWZR7IOi457ncJq37VprQH2AGNn6Fz6NIwHr0QKAWS2yyiNukMi0YtbwD2pJ2SqeKR63OE6W39+i8+OGsrZh046xH3ibUPlOzy7MUOO4S+F7P6wdssU1NiqTP71xV2sQlcbUVYoBtt1ObrkVAcQ+JcsRaxyVzgdmhSyB/n
X-Forefront-PRVS: 0036736630
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0701MB2952;23:FV2gHTVvH5E0nHAx9d2TiE7MdwnwtDbutFDwRjd?=
 =?us-ascii?Q?SDjo/EVc9GgHSd08RBdxXxUIOxl/MPPyO8YY1jNqiJjiaaCL411Ximoau5qU?=
 =?us-ascii?Q?lR3FkvGuLJnfOwL8YX4aJQsFEUMMRPTAo3YAkwb+yvuIm9YP1u+mBIsNpB8G?=
 =?us-ascii?Q?A1hHsEuPqZCgvqtqUOD3IQnjqPL9Qh/P32wIR5AQby+klGeqeNWn5cKmzjSf?=
 =?us-ascii?Q?fVQ0V1OwGNXPBzfGsgEYMyQegWoqf2Cosjp9tuf5kCOQj270Hd7deLb7SjsD?=
 =?us-ascii?Q?reeSVzBkn6b/VlOdRmq9FH7B48RD6Oubm53BU+j5x7ZIMufoRrE44lD1ADzv?=
 =?us-ascii?Q?GIu8zTyPZO+fRosX3keA8bPI0uIoV4M+7oWgk0LLzUk9w5z3MkzVWo3RQ0It?=
 =?us-ascii?Q?7nSgzo1wOFJ82bA1egSOHApMuL6SF+TOX+Vt5g/hQAP5wE21A3Lk21h61k5H?=
 =?us-ascii?Q?VxNhJn2tzIUiXJ1iEFEjaSJ0e41t3KseiomIYp+nFm4FBsS4XB3th5r9Ghcv?=
 =?us-ascii?Q?Yp0Cz8YCv3ZQv4LfWS0as9qJDQxSyfT0vJjgNV4Hnc0zLSkVGW9+cKCge8o0?=
 =?us-ascii?Q?jjGss+dT3ybAVIPOP2u1h2/Imn6NsvrbLOyR7SSs+5GLDOI6Xs4YNzgl1XfC?=
 =?us-ascii?Q?GtK8AoH19Wzzf17EsNsLFRI8UnKZQ5mn/GVEE/BTAe8thSL7EvAuxc4JvzSE?=
 =?us-ascii?Q?YFWl7kzAjTMJ1QEJQ68M+FwVIK+qzTdXNPkc5SaDpOBeAXCLJuiR60FEKftl?=
 =?us-ascii?Q?Rdw3/08DhA14THKvZK+N80XgDbepJogg5wEJH7ms1+w5ThuIEa/t5PpMOU6M?=
 =?us-ascii?Q?pTJ6yECstPzHVtont8QRbYxRHdk4HJZm6LcGbKC+D6IAqcuaPLCCdLWuyg1V?=
 =?us-ascii?Q?3PyromCglIIgr5Uz84SrmuPdQBKSoskGoFJC/sQsnZ63vUPtfnMEjUHpGaVg?=
 =?us-ascii?Q?jnw8wNP/s6f5r4ChPUNzDg/DaF1QFy5cRRT82v+IodJW+7MI61uD+9t6fjq/?=
 =?us-ascii?Q?f/asPaBNMlZK783Et+qQ6hK44nACR9+K1fvlVlFKfyh6z85H5e4KT3O3yLoN?=
 =?us-ascii?Q?gzuUsuvU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB2952;6:m0+AGpxuYpRN049akRCfWEnrvLUjoJMDpUGrNQjpsVoD4msD1/efjdVQWkTbZNXisPKkuUQgmOkZSkbSoGzILstQ84Fd9TZ1PgN+fjf3jQBw+SnQ6ODbpp8Djg7+qBi3WT6CevWlZhR3y+dXiYXu/7cXWnqif8A5kQ4ETyyfcxXj0uNeRwN1H4mteWxll5wltw2Ig9m1ZSx7i7kuV+KSVHND9zXrbPMh2nVWZIoykduP+OyWXTZ2X9oID5PyiwOS/DQbCIsbgCsIkTnAnd2EImAGGTHmFIzfnylEi9yfX30FGCZQ23jufCyQVDXrlm6uOvpJqGIdPptmcA4WXwLXSw==;5:lzXMwT/TXz9GEP2taxdzx4gFxSgsPHliU5jttlJVytudzcC7juUUVCh2+FqwsCtuNXX1J86BeCCFLdeONkWtS+QA/LLMYbkULUkzoiD2PFdzgtnoQktITdiZ75rOmV2qtvUbiFu327tfJ6pKY0TZ9A==;24:h1hDHdbUszQZZCnwfWujEz1gzLY/uZ3/pCfmYCOOT3qj/x4PiBcufqeXUsX2egeGF3ud1nmCaGzgfO66xOUXc/TsrjirNiMnkU62LnVcf/E=;7:XXZ2ZvTJCaZnbKC8AyPyUGKP2cK6NKDxJInaP4hlVPBl6E0sRNFw1eZh6iG8jF1iGmvo54Dm4rtNy3mDFp4gRkRNLFc3Xo2C4YGedTnuwihX2VAjW7uaDXDgRzcNpy63GIgdiWvXPPe1cgTo3WTdOJLDIZ1sBKuDU9eXlO/lN1LWOZSyG0XnvbFBEe18wpd+4tDNaaxalx5SBin2YYs3kfG2adRh5U8mdwi6TMPcd+txRio0ignFZo/Se88Z+oOj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2016 15:01:36.9851
 (UTC)
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB2952
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

Hi,

Commit 44a7185c2ae6 ("of/platform: Add common method to populate default
bus") added new arch_initcall of_platform_default_populate_init() that
will be called before device_initcall octeon_publish_devices(). Now the
of_platform_bus_probe() called in octeon_publish_devices() is apparently
doing nothing:

[   52.331353] calling  octeon_publish_devices+0x0/0x14 @ 1
[   52.331358] OF: of_platform_bus_probe()
[   52.331362] OF:  starting at: /
[   52.331378] OF: of_platform_bus_create() - skipping /soc@0, already populated
[   52.331394] initcall octeon_publish_devices+0x0/0x14 returned 0 after 29 usecs

This also means that USB etc. won't get probed.

Any ideas what would be the proper fix for this? Changing
octeon_publish_devices() to arch_initcall seems to work but that may be
a bit hackish... Also, there might be also other MIPS boards affected
(arch/mips/netlogic/xlp/dt.c, arch/mips/mti-malta/malta-dt.c).

A.
