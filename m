Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 00:29:34 +0200 (CEST)
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:23616
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994625AbdFMW27i-M9u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 00:28:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=s3toZFlFCPB1b9t/QJxdNPU4UGVNuRzCwvpFtaHQhlc=;
 b=nj979Z2Y/qDEOIX0wwYScsf7bSE2z8DvgPoIHi0IY2ESdV80/2zU0Yq/QD1V/ObqgC1aP1tPTmaqmnMuI5yBYfM97s4YdS6L7x9OrUwm8BNBRjwDPB2Fzjatl4YxIS9Dy+IGybfAiH4GKwpW7B+Kfar23S7SfyhGGKk37xPgSDU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Tue, 13 Jun 2017 22:28:51 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 1/5] MIPS: Optimize uasm insn lookup.
Date:   Tue, 13 Jun 2017 15:28:43 -0700
Message-Id: <20170613222847.7122-2-david.daney@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3e918165-bb4c-4dbf-8212-08d4b2ab91c4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:KOeq04wdfBiYNz+gwj2m7iBzRloHDq6IgCmHDkglUa1PadBVK75WAuccddFTwaASpoTh9m8y4RvuR6N5RHcVpSnX/gjFvq4IejZfWBF0/JD1R0z/j0xbs/1cv+RiLqrW2V0PUlGVc+Jko/ZKLka2sSc6M3lXV9kMy0lGZ/usw513QxWJDfjEMMnr5kRgQNN63kYKQy3QKC07FVm2koLxJU79T3M+qHiS1WXjiWrqfBYU1q9DHowMZ1BIvMMoIsI9iQr1TtT/1k2quc17OLLG6vLBdbRwNLaGd7Ua0CaDQOmJ3u9oIJZusN4B/qTsGz2VHQZzI61XCWueMnMOI3v38g==;25:fleJbEpeTjQSSdfjn+n7bMAOMp0qeGV4b8EWUrACKjl/XDpDWVse8hHx2TRmuAV55+V8bGByQYgWAsADSE5KN//+TmQBwNmIGt8bJvIhTvtdDKVPzSFgmQnKhqQzWgCOkxgay6eAIoi3j7KsltBLyhVJ7gYW7wxMOKX2EIy42Wfh21haN5p8kkLF9+6khTS8Y1/Bc+2UWhxTHYWBrh7zyE2YVqsXQEMMhttnUK8zP2B0xQ7XMetGIb7kAReVZgfzFVk0a86CnAvZ4lIrxopUkLqiOSjivcDDwN6XFw2an6D1nJPDCL9RoTBlsvYVlbdiT0Nb9h81DkPnzH7iZ82glWJK/k/o6j8FuhUqbe81WACFvKodbtoCmFVT+kDxX0vSB5cBIgzI+FyKBQqG9rx2cCjihQkIw6VZeNwOhQf3lfqfBajsk0IjRdQBGhWyEfRaxOsWo3aRcZnpx/ASiq47w6S1DF1jMZhF4Jf/uaX18oU=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;31:cLk9HSJYk/TszBHzFF3muqzwPr/YY4+1dIoS1fTWbKNDGR6r83hYdwEBgkTOoiY3j2WUi/SmIGmqpQzdWw1UO4reXAmhxFBK2xNRzBErXg7y7JYEYYeUZZshsR2nr6HTOf56CH7iJ8x4BSdFjG76M3cpkkzPh3WYVcxJc2eSz0my9dVN2irLP8dlZYUSBXZuhOWJmQjw54ZY4tPg2jDrzlzlqAFH+xl09PfEhpnrA+Kvckz2ULBYfOcDn/7iQeG5ZN3dJg8ateWPyKRHfieytQ==;20:NIIIzpmKO6Nk3LVfu4BSKmeNJ7NA4F6qqnchXSxLWugfuzuLKN7Z5d7f9oGYTXOX3o0c23M/0EMnYIci5mx9cM03alE8EPQj3FoqoVGqUqpIHb35BG6IQINtj3vFEMbJsOS68t91nNKrcosPjGhDOZNcZdx5an19Q67i2b20dFn0A5PSzoqRFVFmrbFbyz8E08v9Rh6sCApok9jwxxNLBDD3FEl3wHlLIcMZTEuwrtLJf5fnflDfMyLBsmG8ypKMPX3vehiCl0tV6fHK+wCpDRhiW3k5g1GbF2y60YttjEi0ojv/fx7wYesBpwnmWtqfWtXN6fMvJRFQeXGn1YbSltKX+G34ANYKQ1UfeVqhbrLl+uNZTuJ9F5kY7X7up2v/2Oajsx3FNQWbONQWr3+o13P2DeM2/yaMIa9U2pTY7yQ9s6+CDCLmSeYs7xx6ibp+/H4LmdkV5MbPbc+VPSxF99ZX+XDXV2KAXjVC1CdE+i6ufbkY7HMHN7HIg/PnlETR
X-Microsoft-Antispam-PRVS: <CY4PR07MB3496D20794116DD454534A6C97C20@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6041248)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;4:N2mPWUxrv+HCTk5lyAERifexLH5ZQo2peWnvWplmR7?=
 =?us-ascii?Q?ZGMBgwkVkOlWkRaL6k51eF28Hf4RUPeRdHvHvWhIL4aE/LOGcyielfB5LbFL?=
 =?us-ascii?Q?oKFTNSd/SXXNFG4/u9BvtgqCcpm468w4to4qHtnv4ZcrIn4LPXdJjU6mADM9?=
 =?us-ascii?Q?wXODXPLf/DEeDFUA34u/EMJHZwq2Htwzz6YLrCraEnlFyPbQZ8LC1XAycz39?=
 =?us-ascii?Q?Gydg06g3I1Dk4J98g7IWSRDZY6mB6BrQgAWo/wECrxLVWlNcGEJFcA1Yqj9X?=
 =?us-ascii?Q?30nJrlHmfuadBY4msMkMx8cBIDNCwmfrxjCN87VishIqMM+Ascdlj7EOAXge?=
 =?us-ascii?Q?fen68sGFICG475Y2FNjjf9VwI583x8sE7TqtLyLhWMh0QmlF2LZDCVdKsjeP?=
 =?us-ascii?Q?qQkEG/S8I0x5xo0NMxYAmbyqwQlq+HCIIAaRpI0hFdKuDmxZ3mfruL3Z+pe2?=
 =?us-ascii?Q?ArdO6aydrCmQZWnb7XArVKqah38uFqqLe3f1SFEYY9L3JEjouzVmVzk6fn+Q?=
 =?us-ascii?Q?QPBNnserlDcIuYbVZ9g6rirQCEKcst6xIeOsa1YuyA/ptFmOobW6oW5EMzW3?=
 =?us-ascii?Q?tVUfICXeBCXUmdV2FGOxLbzUh7Po/OxC4SbXmnOjPnJrpOEve+C8SG/HQME+?=
 =?us-ascii?Q?i1q+HGdRVUGS7nCW6+ESmMWDeGR1o1sF4fl1JsDAJTjsnJAfpEE0ef1zSE21?=
 =?us-ascii?Q?tUFzFyNB665vvecmrPZQO5AHINzb9WvkTH7mL9C6dBYgYVKdYiJppfXwvkQY?=
 =?us-ascii?Q?xoo+KHqRG8PzwIvgMJgw7SNv1h1S0d5ZZ8JPWW2uQgYDgK1JtyGle4ijO1+d?=
 =?us-ascii?Q?BP0FKDohKPWpJlB8qnnt23NN9vO6pGfSH/52CQlv0RPpCGu/O0mDZvS2etu9?=
 =?us-ascii?Q?XU4zYzR+eZHphsSqFLkUL8++S+4denUwuOlKFZgTAzcRb6tdUUSqZToudd33?=
 =?us-ascii?Q?GmCLwTPvtgZ3QVyuZ5haUYk3aQA8V9Xy6ZvkYLrGcZ6lzCbZ6/moipIay3uV?=
 =?us-ascii?Q?6wAg51t3JyrBKNVGQQoYxWoiB6xY3Gh/Bi0e8kohVq9Jfy2a/SrnlfYW1Vt/?=
 =?us-ascii?Q?acq+yBhiAsKr6ZvGDRIDDPqrDODfFf6mq6ds67eznlRov+Pzp8cZI/297guR?=
 =?us-ascii?Q?It/+Qf6geijx5IDZjm4iMotwwss5oI?=
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39410400002)(39400400002)(39850400002)(39840400002)(39450400003)(199003)(189002)(6486002)(1076002)(6666003)(2950100002)(36756003)(6506006)(105586002)(53416004)(42186005)(33646002)(106356001)(101416001)(50466002)(48376002)(76176999)(50986999)(72206003)(6116002)(5003940100001)(3846002)(50226002)(305945005)(97736004)(7736002)(189998001)(81156014)(8676002)(68736007)(53936002)(86362001)(69596002)(38730400002)(4326008)(54906002)(47776003)(25786009)(6512007)(81166006)(5660300001)(66066001)(107886003)(478600001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:+bcyU/atbhCofZ5LCWS5Yr32PjwgmbKF59OoNxaf+?=
 =?us-ascii?Q?eOJPXAUXBh/TfR2jMzycAjPARQb2wKkMS5xdCmi6Ivgs0xHSlyEiZk/db2Qs?=
 =?us-ascii?Q?M3LkcZapLNQWLrUJSGBGzdVYEMmYf4okoqPzN2DP5vTH+kvW+hbPaSJo7a6g?=
 =?us-ascii?Q?WOyeGaQAibSVmST1eU9To1cFDp+mrNvHIZ6OxL1Ls4mzPrI+00qcPSWjXi5x?=
 =?us-ascii?Q?osJ3l8hVoWC3jyBGSfXKCdyQ00ppIpXCwg43GCGmfp7vhWXh0D0LWWjjRCLd?=
 =?us-ascii?Q?yZ8OwwZErv/kpytZKB13miR2JlQ749tIktIL667SXOVcjK3AQ9I6YcjxidsK?=
 =?us-ascii?Q?uuy2pgQgvkPI7mbQ8jXiKELXrNgbuh6C10DCHrdHFIIYLCymYiRbu25duKaZ?=
 =?us-ascii?Q?0mpu3KHb8BfKLdQYOyybAUdGzqas3jeahwoQcMWS1Ad3LLntVb/wlGHyp3ZV?=
 =?us-ascii?Q?NnalSJZbw9CBI3IMCjz2WhgxOCBVT0ixrJZxUZjownLLnte6CgrO+AF+5EE/?=
 =?us-ascii?Q?M2TeObGz0CPNP7+srdmbmYY+Z4wz8J3IiaFKWnnabL8MqS0AJqkxG5bm63iN?=
 =?us-ascii?Q?UxTVrcPpPNObzMXMuI5uOwMCgjcm22Aq48pgqPftHIcW3nG3/T43mv05hKFq?=
 =?us-ascii?Q?qpBe82ZPLeNSFwqE7fiaoGpQC3RHEEnoGL+jzTlyrn8xePttyKF0WQD29YxV?=
 =?us-ascii?Q?xMwJi8cdflOTm5ykVorFBm6PRe6MynqTe986yvonVjkAfLjE579MEFWsSvZW?=
 =?us-ascii?Q?V1wH8BfzgWvJvKemTVkW//rP8tG4m3yAb4akh/+A0NV+QMgBVZNjeLagbw/c?=
 =?us-ascii?Q?j8XZhWx3DSNhgHs53aVBFJkOoQnsTXO1XZdWMiLnVgBhtkdvc7uThMSd6KlF?=
 =?us-ascii?Q?O1g+WHFyMcHAhs+/aCivWBp9o3UTjhh0w6/SP6UxjIIjXm5zoQJzr3fFwfAt?=
 =?us-ascii?Q?YIkERcC1CWkVDChbRoZ07WfSFBvnP7RUgc6fNfox0kQ+Zgabn8Tz19eaOUKE?=
 =?us-ascii?Q?mLHrITOF1GhYFEtE/XeizxxMOPOvxOCqCxS/3vIKH5xg9s8PvX7Ur73ino4Q?=
 =?us-ascii?Q?UpLlWBml6lFMkqDNhe8avrBYnOKl56hclPIv5oF+36GIhcLYJ+XpsxDzMKAu?=
 =?us-ascii?Q?hXr1GvUFqaNWucckQmOoqflJ8+WnwIhw1wWp3L+VkO6wDNPXufLWWYDG1MBV?=
 =?us-ascii?Q?8Ld+lP4ZpyhESmoP67KpGgvyra7xoKBSgfgEDitLpyIZ+bQkqQ8YEavaVZff?=
 =?us-ascii?Q?0uVD9pchDVRM9vgnFFEo7KLDN1TRPSoCiruMg+F?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:AvkQMCqNNMOBRmo5odQepATHZms8K4iFslskmTVp6ur27eraPtZRB2OU3tn8gYInBLoUHBcJ72QbWhFh778lKCXocZgCvjOvUhBp/k5ye+O5sYvfGn4R0NUFp52Id1bzS7WZY1EGBSZC2AmKqKB3mazhAw+j/EXPEIOJ64y1VKeLvURioHQS380W+pAoGleT5tpM0eFcHQbTf6uqFKY9Lrf9OhCdfLRQOmVZ6dt9Kym4ziO+RB7/ea93qxHgSoj509yz7ZR6zDhp1M1g6q7DpEotCh13S7Pd7HjVcjRCwom7A3EIIfNPcbBNv+suvY9MSB92HNEyeQrH8rQh3wPRjo29TVvwd9CN7ocTodPrsgKawLi9yD3kPYFTWentBi4DQV3DFk2SPHcS07h5i279fUhz5e+iMBqlIfwQlcl9qPt4svfxkbx8zTLNCNOGFwgg63u2S3IqTYcCJZWVpJpuV1x9SNqvylVzpqmLCdzHkIYwtw4lnWcfyfbjbin4i3wlBt4bNt/nb/rvcTpf9Q8gsA==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;5:sA9JLAfUHLeat3dmaa/kV18CsV/YEiU3War3P07FwugeyBceaJzXcNGFia4UNjZyfuthwD5soCmXhd6UcWlmEtga/3LQ5i7ELXyH8FA5uNzgiCHrBcmao2+g8uA+96LveQ0uWtBrfSvOwnnAjO6fbZZGoNU0pNVPD/27BHah6jlI5wdgJe5NgpgglWLaUhJR7oWGE6KZyhTomLUY+/J9LN41IOX8A5ObEG7zqXXl1QLoXlRPtjd4LfDhwiAdR2XBkicnjguuOYm1bMrOqiETzpebD8qUBGE8pZYAremvFUvet3KbPlM0nrwJzbHD8AQR1Lk7ma0a3TR+DO0/0irAjjxtuCZaHbtwQI6T9U/uBmudajf6RtBQfw3QMpy0coea8DsyYX8+F4ieWXztLw/0NlBOctdVGbf0c/jmFxZT/zGLqpVhUvN+PxS+vlUMFtExAG4BD8fghWBxZO7jg0wHWVNpImjyI2BlH68+64M4ca0Hm+8ksRUe17aODUv4MVR/;24:LPSM6xQGKvnQ3Ox6gVp4Afd51cXklGzNaRMpDI8zMQYlo/1jsn+z2b4wLQG9o2GeUbWfb6zkEmQ5M+FWRLZAyLWRpnjlZD4Ex+C4e3jRZDc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;7:0AnLkVo4h+a1J6R1vRtSzJ/S/mW4SR6aeYgS8m22d1MspWucXa4Qpy/6114X4MRWMdZv2WarfKpPHHL5UbI8ifJO/Wb3z1pu3Gz4H/lapCA4xssaJEoyU4pK0uxwNn4PO9F0TMPNUdC4gjz4E0AzrLPK4FX+UNLGTnY/LQMMHixYMWgje3uump3R7zuTtUxj0Ag07CANRHxtNz2SmFhqtHdQAnx8laoy9SBcdWAJQgkCucPPS8fYEyjl3seEEQ4II2s+8F2N7c3+bVTpFp/tYq/CqEr5RizALKhnllNKe/HVhvDa23iiZD07yRTGKXDUkCuluq9qD1tPek9OsgkLGw==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2017 22:28:51.5652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58427
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

Instead of doing a linear search through the insn_table for each
instruction, use the opcode as direct index into the table.  This will
give constant time lookup performance as the number of supported
opcodes increases.  Make the tables const as they are only ever read.
For uasm-mips.c sort the table alphabetically, and remove duplicate
entries, uasm-micromips.c was already sorted and duplicate free.
There is a small savings in object size as struct insn loses a field:

$ size arch/mips/mm/uasm-mips.o arch/mips/mm/uasm-mips.o.save
   text	   data	    bss	    dec	    hex	filename
  10040	      0	      0	  10040	   2738	arch/mips/mm/uasm-mips.o
   9240	   1120	      0	  10360	   2878	arch/mips/mm/uasm-mips.o.save

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/uasm-micromips.c | 188 ++++++++++++++++++------------------
 arch/mips/mm/uasm-mips.c      | 217 +++++++++++++++++++++---------------------
 arch/mips/mm/uasm.c           |   3 +-
 3 files changed, 199 insertions(+), 209 deletions(-)

diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 277cf52..c28ff53 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -40,93 +40,92 @@
 
 #include "uasm.c"
 
-static struct insn insn_table_MM[] = {
-	{ insn_addu, M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD },
-	{ insn_addiu, M(mm_addiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
-	{ insn_and, M(mm_pool32a_op, 0, 0, 0, 0, mm_and_op), RT | RS | RD },
-	{ insn_andi, M(mm_andi32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
-	{ insn_beq, M(mm_beq32_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_beql, 0, 0 },
-	{ insn_bgez, M(mm_pool32i_op, mm_bgez_op, 0, 0, 0, 0), RS | BIMM },
-	{ insn_bgezl, 0, 0 },
-	{ insn_bltz, M(mm_pool32i_op, mm_bltz_op, 0, 0, 0, 0), RS | BIMM },
-	{ insn_bltzl, 0, 0 },
-	{ insn_bne, M(mm_bne32_op, 0, 0, 0, 0, 0), RT | RS | BIMM },
-	{ insn_cache, M(mm_pool32b_op, 0, 0, mm_cache_func, 0, 0), RT | RS | SIMM },
-	{ insn_cfc1, M(mm_pool32f_op, 0, 0, 0, mm_cfc1_op, mm_32f_73_op), RT | RS },
-	{ insn_cfcmsa, M(mm_pool32s_op, 0, msa_cfc_op, 0, 0, mm_32s_elm_op), RD | RE },
-	{ insn_ctc1, M(mm_pool32f_op, 0, 0, 0, mm_ctc1_op, mm_32f_73_op), RT | RS },
-	{ insn_ctcmsa, M(mm_pool32s_op, 0, msa_ctc_op, 0, 0, mm_32s_elm_op), RD | RE },
-	{ insn_daddu, 0, 0 },
-	{ insn_daddiu, 0, 0 },
-	{ insn_di, M(mm_pool32a_op, 0, 0, 0, mm_di_op, mm_pool32axf_op), RS },
-	{ insn_divu, M(mm_pool32a_op, 0, 0, 0, mm_divu_op, mm_pool32axf_op), RT | RS },
-	{ insn_dmfc0, 0, 0 },
-	{ insn_dmtc0, 0, 0 },
-	{ insn_dsll, 0, 0 },
-	{ insn_dsll32, 0, 0 },
-	{ insn_dsra, 0, 0 },
-	{ insn_dsrl, 0, 0 },
-	{ insn_dsrl32, 0, 0 },
-	{ insn_drotr, 0, 0 },
-	{ insn_drotr32, 0, 0 },
-	{ insn_dsubu, 0, 0 },
-	{ insn_eret, M(mm_pool32a_op, 0, 0, 0, mm_eret_op, mm_pool32axf_op), 0 },
-	{ insn_ins, M(mm_pool32a_op, 0, 0, 0, 0, mm_ins_op), RT | RS | RD | RE },
-	{ insn_ext, M(mm_pool32a_op, 0, 0, 0, 0, mm_ext_op), RT | RS | RD | RE },
-	{ insn_j, M(mm_j32_op, 0, 0, 0, 0, 0), JIMM },
-	{ insn_jal, M(mm_jal32_op, 0, 0, 0, 0, 0), JIMM },
-	{ insn_jalr, M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RT | RS },
-	{ insn_jr, M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RS },
-	{ insn_lb, M(mm_lb32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
-	{ insn_ld, 0, 0 },
-	{ insn_lh, M(mm_lh32_op, 0, 0, 0, 0, 0), RS | RS | SIMM },
-	{ insn_ll, M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM },
-	{ insn_lld, 0, 0 },
-	{ insn_lui, M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM },
-	{ insn_lw, M(mm_lw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
-	{ insn_mfc0, M(mm_pool32a_op, 0, 0, 0, mm_mfc0_op, mm_pool32axf_op), RT | RS | RD },
-	{ insn_mfhi, M(mm_pool32a_op, 0, 0, 0, mm_mfhi32_op, mm_pool32axf_op), RS },
-	{ insn_mflo, M(mm_pool32a_op, 0, 0, 0, mm_mflo32_op, mm_pool32axf_op), RS },
-	{ insn_mtc0, M(mm_pool32a_op, 0, 0, 0, mm_mtc0_op, mm_pool32axf_op), RT | RS | RD },
-	{ insn_mthi, M(mm_pool32a_op, 0, 0, 0, mm_mthi32_op, mm_pool32axf_op), RS },
-	{ insn_mtlo, M(mm_pool32a_op, 0, 0, 0, mm_mtlo32_op, mm_pool32axf_op), RS },
-	{ insn_mul, M(mm_pool32a_op, 0, 0, 0, 0, mm_mul_op), RT | RS | RD },
-	{ insn_or, M(mm_pool32a_op, 0, 0, 0, 0, mm_or32_op), RT | RS | RD },
-	{ insn_ori, M(mm_ori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
-	{ insn_pref, M(mm_pool32c_op, 0, 0, (mm_pref_func << 1), 0, 0), RT | RS | SIMM },
-	{ insn_rfe, 0, 0 },
-	{ insn_sc, M(mm_pool32c_op, 0, 0, (mm_sc_func << 1), 0, 0), RT | RS | SIMM },
-	{ insn_scd, 0, 0 },
-	{ insn_sd, 0, 0 },
-	{ insn_sll, M(mm_pool32a_op, 0, 0, 0, 0, mm_sll32_op), RT | RS | RD },
-	{ insn_sllv, M(mm_pool32a_op, 0, 0, 0, 0, mm_sllv32_op), RT | RS | RD },
-	{ insn_slt, M(mm_pool32a_op, 0, 0, 0, 0, mm_slt_op), RT | RS | RD },
-	{ insn_sltiu, M(mm_sltiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
-	{ insn_sltu, M(mm_pool32a_op, 0, 0, 0, 0, mm_sltu_op), RT | RS | RD },
-	{ insn_sra, M(mm_pool32a_op, 0, 0, 0, 0, mm_sra_op), RT | RS | RD },
-	{ insn_srl, M(mm_pool32a_op, 0, 0, 0, 0, mm_srl32_op), RT | RS | RD },
-	{ insn_srlv, M(mm_pool32a_op, 0, 0, 0, 0, mm_srlv32_op), RT | RS | RD },
-	{ insn_rotr, M(mm_pool32a_op, 0, 0, 0, 0, mm_rotr_op), RT | RS | RD },
-	{ insn_subu, M(mm_pool32a_op, 0, 0, 0, 0, mm_subu32_op), RT | RS | RD },
-	{ insn_sw, M(mm_sw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
-	{ insn_sync, M(mm_pool32a_op, 0, 0, 0, mm_sync_op, mm_pool32axf_op), RS },
-	{ insn_tlbp, M(mm_pool32a_op, 0, 0, 0, mm_tlbp_op, mm_pool32axf_op), 0 },
-	{ insn_tlbr, M(mm_pool32a_op, 0, 0, 0, mm_tlbr_op, mm_pool32axf_op), 0 },
-	{ insn_tlbwi, M(mm_pool32a_op, 0, 0, 0, mm_tlbwi_op, mm_pool32axf_op), 0 },
-	{ insn_tlbwr, M(mm_pool32a_op, 0, 0, 0, mm_tlbwr_op, mm_pool32axf_op), 0 },
-	{ insn_wait, M(mm_pool32a_op, 0, 0, 0, mm_wait_op, mm_pool32axf_op), SCIMM },
-	{ insn_wsbh, M(mm_pool32a_op, 0, 0, 0, mm_wsbh_op, mm_pool32axf_op), RT | RS },
-	{ insn_xor, M(mm_pool32a_op, 0, 0, 0, 0, mm_xor32_op), RT | RS | RD },
-	{ insn_xori, M(mm_xori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
-	{ insn_dins, 0, 0 },
-	{ insn_dinsm, 0, 0 },
-	{ insn_syscall, M(mm_pool32a_op, 0, 0, 0, mm_syscall_op, mm_pool32axf_op), SCIMM},
-	{ insn_bbit0, 0, 0 },
-	{ insn_bbit1, 0, 0 },
-	{ insn_lwx, 0, 0 },
-	{ insn_ldx, 0, 0 },
-	{ insn_invalid, 0, 0 }
+static const struct insn const insn_table_MM[insn_invalid] = {
+	[insn_addu]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD},
+	[insn_addiu]	= {M(mm_addiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
+	[insn_and]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_and_op), RT | RS | RD},
+	[insn_andi]	= {M(mm_andi32_op, 0, 0, 0, 0, 0), RT | RS | UIMM},
+	[insn_beq]	= {M(mm_beq32_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
+	[insn_beql]	= {0, 0},
+	[insn_bgez]	= {M(mm_pool32i_op, mm_bgez_op, 0, 0, 0, 0), RS | BIMM},
+	[insn_bgezl]	= {0, 0},
+	[insn_bltz]	= {M(mm_pool32i_op, mm_bltz_op, 0, 0, 0, 0), RS | BIMM},
+	[insn_bltzl]	= {0, 0},
+	[insn_bne]	= {M(mm_bne32_op, 0, 0, 0, 0, 0), RT | RS | BIMM},
+	[insn_cache]	= {M(mm_pool32b_op, 0, 0, mm_cache_func, 0, 0), RT | RS | SIMM},
+	[insn_cfc1]	= {M(mm_pool32f_op, 0, 0, 0, mm_cfc1_op, mm_32f_73_op), RT | RS},
+	[insn_cfcmsa]	= {M(mm_pool32s_op, 0, msa_cfc_op, 0, 0, mm_32s_elm_op), RD | RE},
+	[insn_ctc1]	= {M(mm_pool32f_op, 0, 0, 0, mm_ctc1_op, mm_32f_73_op), RT | RS},
+	[insn_ctcmsa]	= {M(mm_pool32s_op, 0, msa_ctc_op, 0, 0, mm_32s_elm_op), RD | RE},
+	[insn_daddu]	= {0, 0},
+	[insn_daddiu]	= {0, 0},
+	[insn_di]	= {M(mm_pool32a_op, 0, 0, 0, mm_di_op, mm_pool32axf_op), RS},
+	[insn_divu]	= {M(mm_pool32a_op, 0, 0, 0, mm_divu_op, mm_pool32axf_op), RT | RS},
+	[insn_dmfc0]	= {0, 0},
+	[insn_dmtc0]	= {0, 0},
+	[insn_dsll]	= {0, 0},
+	[insn_dsll32]	= {0, 0},
+	[insn_dsra]	= {0, 0},
+	[insn_dsrl]	= {0, 0},
+	[insn_dsrl32]	= {0, 0},
+	[insn_drotr]	= {0, 0},
+	[insn_drotr32]	= {0, 0},
+	[insn_dsubu]	= {0, 0},
+	[insn_eret]	= {M(mm_pool32a_op, 0, 0, 0, mm_eret_op, mm_pool32axf_op), 0},
+	[insn_ins]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_ins_op), RT | RS | RD | RE},
+	[insn_ext]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_ext_op), RT | RS | RD | RE},
+	[insn_j]	= {M(mm_j32_op, 0, 0, 0, 0, 0), JIMM},
+	[insn_jal]	= {M(mm_jal32_op, 0, 0, 0, 0, 0), JIMM},
+	[insn_jalr]	= {M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RT | RS},
+	[insn_jr]	= {M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RS},
+	[insn_lb]	= {M(mm_lb32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
+	[insn_ld]	= {0, 0},
+	[insn_lh]	= {M(mm_lh32_op, 0, 0, 0, 0, 0), RS | RS | SIMM},
+	[insn_ll]	= {M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM},
+	[insn_lld]	= {0, 0},
+	[insn_lui]	= {M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM},
+	[insn_lw]	= {M(mm_lw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
+	[insn_mfc0]	= {M(mm_pool32a_op, 0, 0, 0, mm_mfc0_op, mm_pool32axf_op), RT | RS | RD},
+	[insn_mfhi]	= {M(mm_pool32a_op, 0, 0, 0, mm_mfhi32_op, mm_pool32axf_op), RS},
+	[insn_mflo]	= {M(mm_pool32a_op, 0, 0, 0, mm_mflo32_op, mm_pool32axf_op), RS},
+	[insn_mtc0]	= {M(mm_pool32a_op, 0, 0, 0, mm_mtc0_op, mm_pool32axf_op), RT | RS | RD},
+	[insn_mthi]	= {M(mm_pool32a_op, 0, 0, 0, mm_mthi32_op, mm_pool32axf_op), RS},
+	[insn_mtlo]	= {M(mm_pool32a_op, 0, 0, 0, mm_mtlo32_op, mm_pool32axf_op), RS},
+	[insn_mul]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_mul_op), RT | RS | RD},
+	[insn_or]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_or32_op), RT | RS | RD},
+	[insn_ori]	= {M(mm_ori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM},
+	[insn_pref]	= {M(mm_pool32c_op, 0, 0, (mm_pref_func << 1), 0, 0), RT | RS | SIMM},
+	[insn_rfe]	= {0, 0},
+	[insn_sc]	= {M(mm_pool32c_op, 0, 0, (mm_sc_func << 1), 0, 0), RT | RS | SIMM},
+	[insn_scd]	= {0, 0},
+	[insn_sd]	= {0, 0},
+	[insn_sll]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_sll32_op), RT | RS | RD},
+	[insn_sllv]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_sllv32_op), RT | RS | RD},
+	[insn_slt]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_slt_op), RT | RS | RD},
+	[insn_sltiu]	= {M(mm_sltiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
+	[insn_sltu]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_sltu_op), RT | RS | RD},
+	[insn_sra]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_sra_op), RT | RS | RD},
+	[insn_srl]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_srl32_op), RT | RS | RD},
+	[insn_srlv]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_srlv32_op), RT | RS | RD},
+	[insn_rotr]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_rotr_op), RT | RS | RD},
+	[insn_subu]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_subu32_op), RT | RS | RD},
+	[insn_sw]	= {M(mm_sw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
+	[insn_sync]	= {M(mm_pool32a_op, 0, 0, 0, mm_sync_op, mm_pool32axf_op), RS},
+	[insn_tlbp]	= {M(mm_pool32a_op, 0, 0, 0, mm_tlbp_op, mm_pool32axf_op), 0},
+	[insn_tlbr]	= {M(mm_pool32a_op, 0, 0, 0, mm_tlbr_op, mm_pool32axf_op), 0},
+	[insn_tlbwi]	= {M(mm_pool32a_op, 0, 0, 0, mm_tlbwi_op, mm_pool32axf_op), 0},
+	[insn_tlbwr]	= {M(mm_pool32a_op, 0, 0, 0, mm_tlbwr_op, mm_pool32axf_op), 0},
+	[insn_wait]	= {M(mm_pool32a_op, 0, 0, 0, mm_wait_op, mm_pool32axf_op), SCIMM},
+	[insn_wsbh]	= {M(mm_pool32a_op, 0, 0, 0, mm_wsbh_op, mm_pool32axf_op), RT | RS},
+	[insn_xor]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_xor32_op), RT | RS | RD},
+	[insn_xori]	= {M(mm_xori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM},
+	[insn_dins]	= {0, 0},
+	[insn_dinsm]	= {0, 0},
+	[insn_syscall]	= {M(mm_pool32a_op, 0, 0, 0, mm_syscall_op, mm_pool32axf_op), SCIMM},
+	[insn_bbit0]	= {0, 0},
+	[insn_bbit1]	= {0, 0},
+	[insn_lwx]	= {0, 0},
+	[insn_ldx]	= {0, 0},
 };
 
 #undef M
@@ -156,20 +155,17 @@ static inline u32 build_jimm(u32 arg)
  */
 static void build_insn(u32 **buf, enum opcode opc, ...)
 {
-	struct insn *ip = NULL;
-	unsigned int i;
+	const struct insn *ip;
 	va_list ap;
 	u32 op;
 
-	for (i = 0; insn_table_MM[i].opcode != insn_invalid; i++)
-		if (insn_table_MM[i].opcode == opc) {
-			ip = &insn_table_MM[i];
-			break;
-		}
-
-	if (!ip || (opc == insn_daddiu && r4k_daddiu_bug()))
+	if (opc < 0 || opc >= insn_invalid ||
+	    (opc == insn_daddiu && r4k_daddiu_bug()) ||
+	    (insn_table_MM[opc].match == 0 && insn_table_MM[opc].fields == 0))
 		panic("Unsupported Micro-assembler instruction %d", opc);
 
+	ip = &insn_table_MM[opc];
+
 	op = ip->match;
 	va_start(ap, opc);
 	if (ip->fields & RS) {
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 2277499..f3937e3 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -48,126 +48,124 @@
 
 #include "uasm.c"
 
-static struct insn insn_table[] = {
-	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
-	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
-	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
-	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_beql, M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_beq, M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_bgezl, M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM },
-	{ insn_bgez, M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM },
-	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
-	{ insn_bltz, M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM },
-	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+static const struct insn const insn_table[insn_invalid] = {
+	[insn_addiu]	= {M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
+	[insn_addu]	= {M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD},
+	[insn_and]	= {M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD},
+	[insn_andi]	= {M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM},
+	[insn_bbit0]	= {M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
+	[insn_bbit1]	= {M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
+	[insn_beq]	= {M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
+	[insn_beql]	= {M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
+	[insn_bgez]	= {M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM},
+	[insn_bgezl]	= {M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM},
+	[insn_bltz]	= {M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM},
+	[insn_bltzl]	= {M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM},
+	[insn_bne]	= {M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	[insn_cache]	= {M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 #else
-	{ insn_cache,  M6(spec3_op, 0, 0, 0, cache6_op),  RS | RT | SIMM9 },
+	[insn_cache]	= {M6(spec3_op, 0, 0, 0, cache6_op),  RS | RT | SIMM9},
 #endif
-	{ insn_cfc1, M(cop1_op, cfc_op, 0, 0, 0, 0), RT | RD },
-	{ insn_cfcmsa, M(msa_op, 0, msa_cfc_op, 0, 0, msa_elm_op), RD | RE },
-	{ insn_ctc1, M(cop1_op, ctc_op, 0, 0, 0, 0), RT | RD },
-	{ insn_ctcmsa, M(msa_op, 0, msa_ctc_op, 0, 0, msa_elm_op), RD | RE },
-	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
-	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
-	{ insn_di, M(cop0_op, mfmc0_op, 0, 12, 0, 0), RT },
-	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
-	{ insn_divu, M(spec_op, 0, 0, 0, 0, divu_op), RS | RT },
-	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
-	{ insn_dmtc0, M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
-	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
-	{ insn_drotr, M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE },
-	{ insn_dsll32, M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE },
-	{ insn_dsll, M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE },
-	{ insn_dsra, M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE },
-	{ insn_dsrl32, M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE },
-	{ insn_dsrl, M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE },
-	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
-	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
-	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
-	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
-	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
-	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),	JIMM },
-	{ insn_jalr,  M(spec_op, 0, 0, 0, 0, jalr_op), RS | RD },
-	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
+	[insn_cfc1]	= {M(cop1_op, cfc_op, 0, 0, 0, 0), RT | RD},
+	[insn_cfcmsa]	= {M(msa_op, 0, msa_cfc_op, 0, 0, msa_elm_op), RD | RE},
+	[insn_ctc1]	= {M(cop1_op, ctc_op, 0, 0, 0, 0), RT | RD},
+	[insn_ctcmsa]	= {M(msa_op, 0, msa_ctc_op, 0, 0, msa_elm_op), RD | RE},
+	[insn_daddiu]	= {M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
+	[insn_daddu]	= {M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD},
+	[insn_di]	= {M(cop0_op, mfmc0_op, 0, 12, 0, 0), RT},
+	[insn_dins]	= {M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE},
+	[insn_dinsm]	= {M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE},
+	[insn_divu]	= {M(spec_op, 0, 0, 0, 0, divu_op), RS | RT},
+	[insn_dmfc0]	= {M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
+	[insn_dmtc0]	= {M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
+	[insn_drotr]	= {M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE},
+	[insn_drotr32]	= {M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE},
+	[insn_dsll]	= {M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE},
+	[insn_dsll32]	= {M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE},
+	[insn_dsra]	= {M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE},
+	[insn_dsrl]	= {M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE},
+	[insn_dsrl32]	= {M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE},
+	[insn_dsubu]	= {M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD},
+	[insn_eret]	= {M(cop0_op, cop_op, 0, 0, 0, eret_op),  0},
+	[insn_ext]	= {M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE},
+	[insn_ins]	= {M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE},
+	[insn_j]	= {M(j_op, 0, 0, 0, 0, 0),  JIMM},
+	[insn_jal]	= {M(jal_op, 0, 0, 0, 0, 0),	JIMM},
+	[insn_jalr]	= {M(spec_op, 0, 0, 0, 0, jalr_op), RS | RD},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
+	[insn_jr]	= {M(spec_op, 0, 0, 0, 0, jr_op),  RS},
 #else
-	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jalr_op),  RS },
+	[insn_jr]	= {M(spec_op, 0, 0, 0, 0, jalr_op),  RS},
 #endif
-	{ insn_lb, M(lb_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
-	{ insn_lh,  M(lh_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_lhu,  M(lhu_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	[insn_lb]	= {M(lb_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
+	[insn_ld]	= {M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_lddir]	= {M(lwc2_op, 0, 0, 0, lddir_op, mult_op), RS | RT | RD},
+	[insn_ldpte]	= {M(lwc2_op, 0, 0, 0, ldpte_op, mult_op), RS | RD},
+	[insn_ldx]	= {M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD},
+	[insn_lh]	= {M(lh_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_lhu]	= {M(lhu_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
-	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	[insn_ll]	= {M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_lld]	= {M(lld_op, 0, 0, 0, 0, 0),	RS | RT | SIMM},
 #else
-	{ insn_lld,  M6(spec3_op, 0, 0, 0, lld6_op),  RS | RT | SIMM9 },
-	{ insn_ll,  M6(spec3_op, 0, 0, 0, ll6_op),  RS | RT | SIMM9 },
+	[insn_ll]	= {M6(spec3_op, 0, 0, 0, ll6_op),  RS | RT | SIMM9},
+	[insn_lld]	= {M6(spec3_op, 0, 0, 0, lld6_op),  RS | RT | SIMM9},
 #endif
-	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),	RT | SIMM },
-	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
-	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_mfhc0,  M(cop0_op, mfhc0_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_mfhi,  M(spec_op, 0, 0, 0, 0, mfhi_op), RD },
-	{ insn_mflo,  M(spec_op, 0, 0, 0, 0, mflo_op), RD },
-	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_mthc0,  M(cop0_op, mthc0_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_mthi,  M(spec_op, 0, 0, 0, 0, mthi_op), RS },
-	{ insn_mtlo,  M(spec_op, 0, 0, 0, 0, mtlo_op), RS },
+	[insn_lui]	= {M(lui_op, 0, 0, 0, 0, 0),	RT | SIMM},
+	[insn_lw]	= {M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_lwx]	= {M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD},
+	[insn_mfc0]	= {M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
+	[insn_mfhc0]	= {M(cop0_op, mfhc0_op, 0, 0, 0, 0),  RT | RD | SET},
+	[insn_mfhi]	= {M(spec_op, 0, 0, 0, 0, mfhi_op), RD},
+	[insn_mflo]	= {M(spec_op, 0, 0, 0, 0, mflo_op), RD},
+	[insn_mtc0]	= {M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
+	[insn_mthc0]	= {M(cop0_op, mthc0_op, 0, 0, 0, 0),  RT | RD | SET},
+	[insn_mthi]	= {M(spec_op, 0, 0, 0, 0, mthi_op), RS},
+	[insn_mtlo]	= {M(spec_op, 0, 0, 0, 0, mtlo_op), RS},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_mul, M(spec2_op, 0, 0, 0, 0, mul_op), RS | RT | RD},
+	[insn_mul]	= {M(spec2_op, 0, 0, 0, 0, mul_op), RS | RT | RD},
 #else
-	{ insn_mul, M(spec_op, 0, 0, 0, mult_mul_op, mult_op), RS | RT | RD},
+	[insn_mul]	= {M(spec_op, 0, 0, 0, mult_mul_op, mult_op), RS | RT | RD},
 #endif
-	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM },
-	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
+	[insn_or]	= {M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD},
+	[insn_ori]	= {M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	[insn_pref]	= {M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 #else
-	{ insn_pref,  M6(spec3_op, 0, 0, 0, pref6_op),  RS | RT | SIMM9 },
+	[insn_pref]	= {M6(spec3_op, 0, 0, 0, pref6_op),  RS | RT | SIMM9},
 #endif
-	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
-	{ insn_rotr,  M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE },
+	[insn_rfe]	= {M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0},
+	[insn_rotr]	= {M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE},
 #ifndef CONFIG_CPU_MIPSR6
-	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
-	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	[insn_sc]	= {M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_scd]	= {M(scd_op, 0, 0, 0, 0, 0),	RS | RT | SIMM},
 #else
-	{ insn_scd,  M6(spec3_op, 0, 0, 0, scd6_op),  RS | RT | SIMM9 },
-	{ insn_sc,  M6(spec3_op, 0, 0, 0, sc6_op),  RS | RT | SIMM9 },
+	[insn_sc]	= {M6(spec3_op, 0, 0, 0, sc6_op),  RS | RT | SIMM9},
+	[insn_scd]	= {M6(spec3_op, 0, 0, 0, scd6_op),  RS | RT | SIMM9},
 #endif
-	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
-	{ insn_sllv,  M(spec_op, 0, 0, 0, 0, sllv_op),  RS | RT | RD },
-	{ insn_slt,  M(spec_op, 0, 0, 0, 0, slt_op),  RS | RT | RD },
-	{ insn_sltiu, M(sltiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_sltu, M(spec_op, 0, 0, 0, 0, sltu_op), RS | RT | RD },
-	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
-	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
-	{ insn_srlv,  M(spec_op, 0, 0, 0, 0, srlv_op),  RS | RT | RD },
-	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),	RS | RT | RD },
-	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_sync, M(spec_op, 0, 0, 0, 0, sync_op), RE },
-	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
-	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
-	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
-	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
-	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
-	{ insn_wait, M(cop0_op, cop_op, 0, 0, 0, wait_op), SCIMM },
-	{ insn_wsbh, M(spec3_op, 0, 0, 0, wsbh_op, bshfl_op), RT | RD },
-	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
-	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
-	{ insn_yield, M(spec3_op, 0, 0, 0, 0, yield_op), RS | RD },
-	{ insn_ldpte, M(lwc2_op, 0, 0, 0, ldpte_op, mult_op), RS | RD },
-	{ insn_lddir, M(lwc2_op, 0, 0, 0, lddir_op, mult_op), RS | RT | RD },
-	{ insn_invalid, 0, 0 }
+	[insn_sd]	= {M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_sll]	= {M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE},
+	[insn_sllv]	= {M(spec_op, 0, 0, 0, 0, sllv_op),  RS | RT | RD},
+	[insn_slt]	= {M(spec_op, 0, 0, 0, 0, slt_op),  RS | RT | RD},
+	[insn_sltiu]	= {M(sltiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
+	[insn_sltu]	= {M(spec_op, 0, 0, 0, 0, sltu_op), RS | RT | RD},
+	[insn_sra]	= {M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE},
+	[insn_srl]	= {M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE},
+	[insn_srlv]	= {M(spec_op, 0, 0, 0, 0, srlv_op),  RS | RT | RD},
+	[insn_subu]	= {M(spec_op, 0, 0, 0, 0, subu_op),	RS | RT | RD},
+	[insn_sw]	= {M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_sync]	= {M(spec_op, 0, 0, 0, 0, sync_op), RE},
+	[insn_syscall]	= {M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
+	[insn_tlbp]	= {M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0},
+	[insn_tlbr]	= {M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0},
+	[insn_tlbwi]	= {M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0},
+	[insn_tlbwr]	= {M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0},
+	[insn_wait]	= {M(cop0_op, cop_op, 0, 0, 0, wait_op), SCIMM},
+	[insn_wsbh]	= {M(spec3_op, 0, 0, 0, wsbh_op, bshfl_op), RT | RD},
+	[insn_xor]	= {M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD},
+	[insn_xori]	= {M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM},
+	[insn_yield]	= {M(spec3_op, 0, 0, 0, 0, yield_op), RS | RD},
 };
 
 #undef M
@@ -196,20 +194,17 @@ static inline u32 build_jimm(u32 arg)
  */
 static void build_insn(u32 **buf, enum opcode opc, ...)
 {
-	struct insn *ip = NULL;
-	unsigned int i;
+	const struct insn *ip;
 	va_list ap;
 	u32 op;
 
-	for (i = 0; insn_table[i].opcode != insn_invalid; i++)
-		if (insn_table[i].opcode == opc) {
-			ip = &insn_table[i];
-			break;
-		}
-
-	if (!ip || (opc == insn_daddiu && r4k_daddiu_bug()))
+	if (opc < 0 || opc >= insn_invalid ||
+	    (opc == insn_daddiu && r4k_daddiu_bug()) ||
+	    (insn_table[opc].match == 0 && insn_table[opc].fields == 0))
 		panic("Unsupported Micro-assembler instruction %d", opc);
 
+	ip = &insn_table[opc];
+
 	op = ip->match;
 	va_start(ap, opc);
 	if (ip->fields & RS)
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 730363b..f23ed85 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -46,7 +46,6 @@ enum fields {
 #define SIMM9_MASK	0x1ff
 
 enum opcode {
-	insn_invalid,
 	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
 	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
 	insn_bne, insn_cache, insn_cfc1, insn_cfcmsa, insn_ctc1, insn_ctcmsa,
@@ -62,10 +61,10 @@ enum opcode {
 	insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall, insn_tlbp,
 	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh, insn_xor,
 	insn_xori, insn_yield, insn_lddir, insn_ldpte, insn_lhu,
+	insn_invalid /* insn_invalid must be last */
 };
 
 struct insn {
-	enum opcode opcode;
 	u32 match;
 	enum fields fields;
 };
-- 
2.9.4
