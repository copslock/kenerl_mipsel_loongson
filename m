Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 20:54:05 +0100 (CET)
Received: from mail-sn1nam01on0049.outbound.protection.outlook.com ([104.47.32.49]:40723
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993043AbcKNTx6gXaLE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Nov 2016 20:53:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=07KPdroEzSLKPVdnlG/UdjvkcCJbyzXG0a6Pt3tgs6Q=;
 b=dt5QmrIba8Jjp1zvdGmTv0D/SMgoL5fBrk1WI9VEF4ELWXbs/9eMBNTq+jd76HTKMKZtr9rpHWTkeWRTTywN4bmOayJm74ZIxk7Ft/VNhiTgnD/HNupCZUx1r+CFGcgVwwXValpPnxnlbhkT7W/eeNd5guF1zxBEC679ysQl6as=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3205.namprd07.prod.outlook.com (10.172.115.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.707.6; Mon, 14 Nov 2016 19:53:48 +0000
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
To:     Jan Glauber <jglauber@cavium.com>, Wolfram Sang <wsa@the-dreams.de>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
Date:   Mon, 14 Nov 2016 13:53:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: CY1PR12CA0039.namprd12.prod.outlook.com (10.160.137.49) To
 CY4PR07MB3205.namprd07.prod.outlook.com (10.172.115.147)
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;2:My71502gJe2ndapPuDwPp5NoZqdAR7gySqalWCP67CqqXwE2xkebINq5MfIq3riOVG7WyKq4sX3PYL/4GdCe0cC32dXulc1HW112lFnRl1tYwL9x3Z/H+EM2cAt49jUeXZE37Yr9JSNyvJbZJt5rzkiOSZgyOAo+DG4za4KnzcU=;3:ir7xZe9eAATlTAYnvpVIMdmySVy7BX2kMqSlNE84BPDcEOg7MLaOp2XEjVSGPZo0Z5fLnsZLlkGRCK0HYGJw/n5vs3h3SWTiXV62aP2WoENG/P5RVl2k2zsDVgVBYz04yyGzRrcR07/uFfE91B+CjF1KavjxEGGj8UqLi0zMrrM=
X-MS-Office365-Filtering-Correlation-Id: 2b29c15d-c1c3-4e59-846a-08d40cc7f3a9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3205;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;25:79YF0PYMvz8ILN4W0MlofHPQaW0+pCp5ILo/zXaaiFvfWEAPBoiAJuupOqa6LB7Mv9wTvqFpK9vIxdViP/ABddQJVDgF0t2RDsxP1uArxS5S2nVs1b/wIfiIdb/2fhXVK+2akqTyMZINa22ztyhcM0q3oca/URLr08XsDSi/WKbiFWcCEXILU5DtY7YahM2MIOQPiGqVsqRvZGmvmN5s3QLH2pOmpUibX7KKmufB0+CRzas6R98D5/BlltexdzzNie3k5/ZocbPKhLecTq5dEl2vYrc2YyxaWgcPHfUyYf3T9NP72N90UDskiE2G3He7pv5tsTW9RZujDYCcwKVGymjl6OpoL19hxTJMwYs0KN7JS31eX+RG1w4uwYOACjiR27k+TsM3PHqaWEGHuNLO9qGEx7AM+QaZDK/Mbv5DwY+FJw5d0r59Vo1hbv4/Xi7F4PLERRnX32DzCW1PfO16qTwFfbQcdaiTZAaLe7w0dDtc08vSrID0OgfQZkJnLz15thZRD9RZCAtSNxjHuxQVuvJ87VV+wYADj7l7ip5wzNIasJ9BDFoI1dOlLy9wbvxmotw6qiJDP0ha/Zyo8qXsfRZ8/5dnaWU4YLAYjHdKkBcTs6Z4Kw6JmjV1UQQpMIvBXm775CuGjp8GyAMHExKSP1O8DRioTmRSTQNFXa1/ZXITqnLUdUAIpLs5fyAb+AYkmb17E7IgqqN4dqBnwYAly35p1DPY9Bzgquyl/+w2MDI=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;31:PlX6Oos7SYm3ciCo9nXWBuJgQXu4vNELW9ytjXFO2H3nq1oVU0K9Z8b4Tj392+ULMTz/RvqQevUptKD++fpOXM/o5VEIc+LUYCIc3icWmdXcICfdZLUnGdu16uxPWx2RDHaCqurKrEefBZad+r7HHx2BNDQdZ3BqPwsy53wI1wYOVd2xEOBE+U+12cRpIBFYgq3Hwa/QlyYjr4cSFqoNh3PEyd9esTZIog/oZ9wTpIfhAbQpCdqspsXylsTRG+jz;20:kTVdPr7O2pY/W4G2LsYB2SGFaK5vcBXXJiptDJixscLZYVH45Fqgtdt6GanZmoxxpFPS+I1sYjFBVAKmLyPzaMfear+OdN3lg4yR1azsPnhFJRwajCiUaTmB2qeorVXujdItn6mOjrFRGC4Bxfr6OopaJ3Ay/GqyERGGvt8wgriiMKvQvMe1oZYYdRgeRbPGpJjw6w6sQ9kNJvl1ZrZci6hDm+/Hx9XBU2oAmstqtw8VFE3XoMNx0mbLUBTy4E9/dPXhr4hsALscHtU5p8wmkLaQYcAp0HqDurh7JTszb4mGUoCJSP4SaCL0547VS65IaURQddSzOT7kuw1sxHPq7isrqZGeLJDCAoU5uO/XoCwFQt7YxI0AOG2wzzMXOp7TQz22rOdHZdZGCHuhR4zEfzAuwPzSNWfsQcTZIw6b/ZsFfSOKymaAGNq7guMWM3+Jgquw4KzjVSKNZh6QnSgpSx3OXgroLR+WAI3XWytEPUWPgRw9iMoo3rnzap4XHBGM
X-Microsoft-Antispam-PRVS: <CY4PR07MB32054C0B374D9D7D35AD909B80BC0@CY4PR07MB3205.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6060326)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6061324);SRVR:CY4PR07MB3205;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3205;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;4:1lKhbUccIuaYcT9RplN+cI2HEuTq/qVB8ht0oSseFnOo84ZHpLpIZCeFpEUJJ6E7WBs1m+i5rP/zyUCU10Y7S/TlFI2ak5oWgHgFIrIEtyNrD//386n5Ttfd/HtKU1R5sfFALNTYn0oJBL4m41ExAd0Kovy9oIQC+FxI/o8tZGh3Lq8FYIunOU4lRxsESwCg0p7jBPD/3afb3sfazGM3heip8ZntPrqZxRknFxO4FGIQZAxelf8fnbeNh6qzm6RRx5mjyYVmTwTQVjodTUx+FBBqcqNpP7P8TxyvvfdOTguhmgljBbYB5wreyQ/73FQWgez1Dov8nQorbjtI2g1bzCM1l6j5Ot5HV1KIA0FvPlpvuuPvmyMszgEK5LJbJJ49Du9rPt+NzSW8C1IZT1nrG45JqqY3LiC2Yzbp9G0D8/c=
X-Forefront-PRVS: 0126A32F74
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(199003)(377454003)(189002)(24454002)(106356001)(105586002)(65826007)(6666003)(65956001)(54356999)(97736004)(66066001)(64126003)(50986999)(68736007)(65806001)(42186005)(8676002)(50466002)(4326007)(83506001)(31686004)(5001770100001)(81166006)(81156014)(4001430100002)(2950100002)(107886002)(2906002)(230700001)(7736002)(7846002)(36756003)(5660300001)(3846002)(47776003)(92566002)(305945005)(189998001)(31696002)(6116002)(86362001)(33646002)(77096005)(76176999)(4001350100001)(101416001)(23746002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3205;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY4PR07MB3205;23:EteH60A3c4sOWUTiJBdSpc/cRSriMtCL83rFN?=
 =?Windows-1252?Q?QgAgvV6/s7XU6OQ4wFdWyVwrwb3cR85k9hHdH+WyTQW6hcylytyaKluk?=
 =?Windows-1252?Q?235elWgAcASZZNL9Vz0HKRGowubmpU4qVaJa/rc+kFrl0co7L4CUKq+h?=
 =?Windows-1252?Q?BpHcYqhwui1+bwcBdS1+3eesv0d+3j/u1C4vjTSySC+vFXzh/vTi4OZb?=
 =?Windows-1252?Q?tw6pfCDHXBqtCDJWOxzRStMKoGVucX0WzwH9C50vSHNvTq6ifT8gih0l?=
 =?Windows-1252?Q?SWN+vemRxcWo+rGTioES872th5b35IBUP4ddrC6k/GrigZlYrBS/WzhI?=
 =?Windows-1252?Q?q+cSHL5pF9CQ4OSG1XbGjnA0mcWeqIt3yErnJmz08ebyXawZY2JP5iQ9?=
 =?Windows-1252?Q?M227lxn+gHhnWcaSnynoYeusV5KtI3N1/Fkf+DCPLf9qlVvCOcIrc+mc?=
 =?Windows-1252?Q?WUpFf4NE2eN8DAnm+4tlECsSMC8kaIyyCX4Qw7aoBKgHNLcvikya7mi/?=
 =?Windows-1252?Q?rUT2SFubKsVekzvML1fLkt13sri5GV+SHCP0gPTKBl4ptg8oyM0/0Cta?=
 =?Windows-1252?Q?JspGruKbdJOOBmPHj0pewoyFDbs3rXbogzV+IOQ3NIV29Nn+FcAoQQpm?=
 =?Windows-1252?Q?WQzFq37d+QMB8hHomLCEeeZ4JuxSqEFLSenS90T+bYlMSejaQMkGMJ2O?=
 =?Windows-1252?Q?LltSMw6nJ6a7+9DEzJRpUTFFPjz4LTJGxHN64K3vtCbS4mxGMoOtaX3v?=
 =?Windows-1252?Q?1w8pdRaJt5gigGBMfSpokVJR3D5Tzabavelw1TRX3oW7X+7GDNwHXcUq?=
 =?Windows-1252?Q?GV3WELTFGz+JSb0JPuppXNzlBrxucjF0Hsj+xCQosTWl+5eX+IXw7zAU?=
 =?Windows-1252?Q?+d3D9X2bbK8lNGXOR6SXd5DFSXErvuqSoxFlt5h2f5Z67IzOBTAcn36E?=
 =?Windows-1252?Q?TS7eRi4skw+UtFyRwaWWL2llgUKYfmjS1SeD9Cb0MZBvd+eyJ2baublm?=
 =?Windows-1252?Q?7/+z3L8b1/taT68hrdBijFCEHR6yvxq3SbUTTA5tfXP3He0+dJyZHkIV?=
 =?Windows-1252?Q?jezRdCEWQaMD2zMr3hZmgw7gMcJnr4SPRujAsjhMWkkWREvIbQbDv4v8?=
 =?Windows-1252?Q?5tpK44t1yXvnOP2g5y3AjESeAah5Stzd1qen2OoXmTY3zCDzfkrgcLHR?=
 =?Windows-1252?Q?YY42hrzpH1ZmFtgasZxVUe3p/l6F6mxkf2N2N3HG1vYH8CMCPo2AhqSa?=
 =?Windows-1252?Q?3RPDGKkiawEdnXDVJLnfk8qLV3QI45unmaWydmBAuhEdAvAN/kjVmOWR?=
 =?Windows-1252?Q?KEcGcVqv4CJrfkiqyog4DlJTve0lbFDXju7iHlA48TyRupOU4uPtLRGa?=
 =?Windows-1252?Q?E6ZE6iqnQ4IZ+mEFuiRUlpY2Ja8MEUzCXzxtEiHTkg5vUY7sk/UyGoPb?=
 =?Windows-1252?Q?9MPBCPprU573O2c0/zN?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;6:NltF1lsqE74msjxyIeguvKW8GLz+SDn7Clajhj8W1VQGKfExKwrfmhr1F7i7v9zZU3bU6u4/yTAxLzgFaUbGTnSXxIBizOJFjJ4lwt8Ehbs36HkDC3MxZha+r/ASXFtPhHsyxnvg4LzPYldD/VVYixHXSt8+ei30gQbWOHfqHnToiQCnPdt3OO+aVKghHpVFZxukiGcbmOiPLIiy+yN0Ctn8ndPqtyJ6pnPvxmCsphAFalwCypLapAsY/syw4WjdidGr+qG+nugomzXbYgItsn3s5wLlUu3pu/DSbEQWdAyWarSXGzIUX3Vg5yvCWLi+5iq8sce7WX6c/Tf+dTafUPSVk+Z5bAK1CnrcNJYTSlA=;5:jhza33FwjXYVjYa1JQ2FVI/J6PViOZKGE1LlFcPgqpArZ9G2TQfiSYiTmT7E/DowYO5OP1VMLNdGVGFYRgQF0HjZYKLgTS7dAduTzSSZlE41UqOUuhHIlG9tcbn2AAF1fXdA4CfzMMTkZYnQGOh5ug==;24:HdHxs+3EdB7IL0LfgmADIkZkc8OvH6e7zs6T8dsPzUJdic/3rnX/pzGgIodxqWBeIQroHESu5Yo/tjt2WArguh+8302hkfUUUfLjKnm6Kxw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;7:NiXyAqoqbI0TjcJjOlcZMZHcNT+zyGJXfdt8bTG/K635JS50P66+CTFBygVvzPXKDjy/qVRC2syIfxihGnD+LA7/sKXJgvcJk8BigeUUr8SbrbSF/IPvgxzH/8UrXxEZd0p+P7ufBUSe08Mluevd8rlAS42l3q259FGgsjA7M4PngTfpF2hKqEEwlf8VNem7yRmxvaq5kePGelcv45AiNlPr7SFx4gIkFO8Cr5ZddNTMUIKjLwgf+mjgExEvPaF/a+WesbXMHhEdpJdYnMTPUvWlWKa7MjOwrdEvEB8H90sEpb8fZalf52UR9ew8kEhwncT1f6r7vdDrXJM+rRYkT2UTgp9Kyk24rpYBrJednzk=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2016 19:53:48.5825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3205
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

On 11/14/2016 12:50 PM, Jan Glauber wrote:
> 
> Since time is running out for 4.9 (or might have already if you're not
> going to send another pull request) I'm going for the safe option
> to fix the Octeon i2c problems, which is:
> 
> 1. Reverting the readq_poll_timeout patch since it is broken
> 2. Apply Patch #2 from Paul
> 3. Add a small fix for the recovery that makes Paul's patch
>    work on ThunderX
> 
> I'll try to come up with a better solution for 4.10. My plan is to get rid
> of the polling-around-interrupt thing completely, but for that we need more
> time to make it work on Octeon.
> 
> Please consider for 4.9.
> 
Hey Jan.

This does not work on Octeon 71xx platforms. I will look at it more
closely tomorrow.

Steve
