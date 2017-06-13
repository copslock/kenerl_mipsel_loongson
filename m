Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 01:51:09 +0200 (CEST)
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:38921
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993865AbdFMXtxRvvZW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 01:49:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cmwKijxoSdvx8QKDWX4lyYlTPLcQuQ0/jCVxlela4Sw=;
 b=T50BrdZyZYhfBDBWyDqlI70uXEMnAO9Jitmook95UQQQ6w4Lz9qzzQMblmkcG6Amjwz3jWuXyNlIrLDXZWCHYHzv9/B5SM3yY9hcKvhq7piJC+iNRgxyMxl4BH26ZHmock/MOIMvApmzp5xkBODXTVpEcKhs4lVJFOtI3RNPGvs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Tue, 13 Jun 2017 23:49:45 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 3/4] bpf: Add MIPS support to samples/bpf.
Date:   Tue, 13 Jun 2017 16:49:37 -0700
Message-Id: <20170613234938.4823-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170613234938.4823-1-david.daney@cavium.com>
References: <20170613234938.4823-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0024.namprd07.prod.outlook.com (10.166.107.19) To
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR07MB3501:
X-MS-Office365-Filtering-Correlation-Id: 923294e7-a36a-4717-ab76-08d4b2b6ded2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;3:e9AZ7KWJfhB1FcJ530Hi48l1eO0x0WRfpZ5RrHwxcRpzdhR3HtM2brxaifWSt23JdMFRjkAUzQpCEFzBCJby+esoVSdIGL8M202ZDgA1BplXhKxMPE6tWwM/sdjzyS/ojjcBnGf/uedgRlIs2qNiMkuIe/aTyD1Q0FP6/vqB/wmEtVure9TSJpEneWB0jKo3NsoMl1Dg/PeHG1syzvcRBbsAahNGSBZI+LGZcxC6y5hTX7Zzc7ZhFTGC5w+6U7CCtBnrnu3o3b0YZ7LjW9Htn0lRXr23JWSM9dBdaEhzQNYP0azb0vY/NSgN4rX+X/Rkz5cW2J99sTFdaKBihn+0BA==;25:ImOA9Md8jYSjewTn7iLymf05khs1C67XG8VmhKTH+eUNbDGDN8MhDn7XHg/ID8wm/itIKuTE1OWJ1e3C02NVWzxulGoO6DKF2MMEKoqnjZCr5K9C7CO9sgxdmAoP2F7PhKxTk6dxCws/DB1QIXMOSijUn9BbtZTx8v5exbE4RlGJCXnTHvK6ON49BCG4pk4FSOhNn8VHFUAoKqdAlcydAQWPCdkrKCEJFymUbF4mS7F4yKmAq32sV5vdtwI5FEH7AzOkUWF0qC3TPUcuo28vdcRnsrQBnDkC+/8/MIJx43HtLJOQf7I4jaH3BZ5lQbYiLBDph5dL91V5hPwo6f5qwWhieoBieyUXmBNemQc+9L7pqiOdkVXBu6j3iLoPIYbG0md1UKOoVAsbBl4yqJ+r6oCt6x5HsGdGKIna58NCo30xNI2/DJ9lZYUxnGb+rGN0oVqTyAdbihFnghOWI9LvzfUfi9AfPhwzwJJyJsfIB+4=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;31:70Y+tsN74paCQZfri3FoZ/sNQf7wAZWEKRyTSv1lp1qtMxTlDWG1ApD2k3gFqcsIKPJX0Y+60TfWYASIlhPXjjxSl7T7b3Qt52aMnkY1t0/dMwuwUcWuE9sSTS45SQW+a+YqB+j2AkM+nOSk2CJCmWkzMgWo5V2Eh1AffU2XTqc6AGPcS7+/Fpn1K72P0dVqL2feL693JrIstxtEIT0uMitL+hGlfT5HvQufcsQYhZs=;20:sxHfToJCP28uvThoz0V6T3sIr4aLfnWsBzfhhWPqBdtc8CJs7CB6iMlRvjJNrH+l2te/tdyBPN4t/NGiwWpP3v9SYH6m92/oIr1O/hUC+4rEmIQBW07PzK2O9pubSV5yKdGWQQOH7gahl9F56Rm0zu2QLlhABI5uyr+3hmsqHzDnr+Wyz1v1uGfdvYSX3FgqWtbV/W6Jj2JuWWZQzb9QtBfQXxovQyQMjnt2tM/dK4oiL+10m7GWWASXZO95QF80qhrWtfUTi9BoXJwo+Z9u+qllkcaVW6bkvuds8+dRtEPcM3j1uTrxoXtURp5K7sw508fYzB/wnkxA2R+fnAUGl+aED9Y4MBV/0aPwoILG/PruicwejI+ReaoHEaeUr/amC11UD+2fkoc0BtPCPixE1+4BscrXcMdJ1CxuVTBdaf27Sj4Nh9tUl3QOMl5/TuEWrOPb+x9X0TzxFXJi8lkVrrEwmapRpWrzkNnOGVSjdq8I3Qop4mzHRO5oVqi8geO0
X-Microsoft-Antispam-PRVS: <MWHPR07MB3501D82BADF2872CCD70D5E197C20@MWHPR07MB3501.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123558100)(20161123560025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3501;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;4:tjBHWhQxcBxT6fJnGMwNHpaVbGU26+Mvhmr/MXiW/q?=
 =?us-ascii?Q?WqKx68oJKlYUj/6fXz6EGuwxm4tyAL7sxkJh8a3iFaI9OzzAMruWNx6Jzre0?=
 =?us-ascii?Q?DVrkeN6XWkVr67Zz332jBnFrw2CrJ58NIF+SK5ccHnKUUtyy9Fh+AVFWBCpu?=
 =?us-ascii?Q?z/lYJe07LsLqgCDxR1yKtwlhMU0jaeDVAmajXMWs7vgBgX4QM8RQx/xPpiLV?=
 =?us-ascii?Q?mrdSphGxAZUGglU8FwY1+t0J2vCzpxSfpOSeS9AdC/iW8f/qJlAbDZTJ+qJ5?=
 =?us-ascii?Q?3ZyGOUr2RIWnza8Lnzud/8URyCnex674YAH67vc8nVTT4aJlbhmepV2jLkMR?=
 =?us-ascii?Q?hScnnoJ0S3JmQQnZEINGtO1b5T2P97G8jlVVAJ7EKGKesTTLY3AC2keCLj3Z?=
 =?us-ascii?Q?u0EfmwnOBsd12GpHwdkKYqyhYQDrJTYn7o9EwJDHQrcy8/BWP5jHOAlBP/V6?=
 =?us-ascii?Q?GXF7LnxkEKrpjKVJInLjmKaMt9dR8FWuIfIEC6Oa8BQmECEA+QN6vsEa2Ljv?=
 =?us-ascii?Q?YnGh5Vr7zFW0ofzZVNNvo+cW/bNI485tOhXYDesVmZ5vGV4EHVM8Ht5Wovi3?=
 =?us-ascii?Q?t+cgf2x1p1GnYcebG/FhUmdmFZenfROseliSYbFb+l7dwKzNYFoLFyGKaRZz?=
 =?us-ascii?Q?EbHRoYV/i7axRDcmv9JscTTeFrQrGR4RZybw44NDz36PKZrPSZ/ITpa/Ljvb?=
 =?us-ascii?Q?7H04zjJj45+g/FbSqYTofpDubzrsge/oSJcj0iB7Ssub5MNix8reJKHK297n?=
 =?us-ascii?Q?F/xsuoCNsM064jZgjip2LMFwQi7gAU9CUmflLPshi+l0LxBygWdidxxTwQr5?=
 =?us-ascii?Q?hFM8z7IfBYSrELPynfOP0Rfc0gL79qBfvMtinTsdZ6Ff0mKW/guOvwuyWyhX?=
 =?us-ascii?Q?NcCQ6radgFstpPzgZVdM8+VhCOVmSj/VXNaRHJfKXmjoJX1nKtvxlUvghQky?=
 =?us-ascii?Q?1aQEB50t2u/oqwPxi7ovCoz5OKmCw45iKfSIuC30E8jctWGeFBApqzMEq/k/?=
 =?us-ascii?Q?zKN4dzk67gKkh3IcQeNVV83WPWKkJ5A9Fqy9t3zX1GpVPUVEeTi+tBQ+a0UP?=
 =?us-ascii?Q?9FSPCPLxfjCGKrTVqxP2akov0x9aQ/r2EZ0Pbu+6F1TL8I+HGJ+G6MVGNhCQ?=
 =?us-ascii?Q?p8pG7S8LChjgiSOIG2BBD66/TazqAp?=
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39840400002)(39450400003)(39410400002)(39400400002)(39850400002)(189002)(199003)(6512007)(105586002)(53936002)(50226002)(53416004)(2950100002)(106356001)(4326008)(189998001)(6506006)(25786009)(42186005)(6666003)(33646002)(50466002)(69596002)(5003940100001)(6486002)(48376002)(76176999)(47776003)(7736002)(305945005)(1076002)(478600001)(101416001)(2906002)(81156014)(8676002)(81166006)(72206003)(107886003)(36756003)(5660300001)(66066001)(38730400002)(3846002)(68736007)(97736004)(6116002)(86362001)(50986999);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3501;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;23:TkTj194itqK6rH39WK3MYyz2YgRShzeolknxm3NUk?=
 =?us-ascii?Q?EbiueNgjBFyWX3pjfTdtpwIkWja/R6yXgk/+z1Vr0OwvNU8ig6dgzUF6QEZQ?=
 =?us-ascii?Q?6H6cnDWWFevlK9z+mP+5PBjNrbkVwspEUTMGiGAPk8fwPvh5fl57ZGiNyqmH?=
 =?us-ascii?Q?MXMb7xbdxbb6oyNHEgsGcywIHmDvgWdcLdKqbKOL34jMGgqIwLoHVYqtQ+pg?=
 =?us-ascii?Q?EiqcFMBiJhvLCKJSs/nQcjMQZgWF3doSns6g/YWdriXMsXxq/KMt67s/16Ka?=
 =?us-ascii?Q?yBXfq67O72EIgXiqwgkK7c+lPRYMIvq1aeX14tyaXfEYg1PVegP1rlIuLFuv?=
 =?us-ascii?Q?j7yPe0x8Fe6THQk0YbpQEPSt3Ic7+qSwG3QHA5/9Sdn2LGo1Vbu209RLR3OY?=
 =?us-ascii?Q?Gm/fgcSgvnyXuiQyQoPcFDSfrXLFd1srE0EDoSYIUFkCTgXZMqgiJ6mIv3Wt?=
 =?us-ascii?Q?APPCdTC/X4kdm0hwXmDUC3uiwGGP8BTzk6pF8uMDkawFk4Mwke5UYXql3cKF?=
 =?us-ascii?Q?iOARt9+p1Jx7Cr5DRtihwsSbu9RQf3TE1ykF9iko+puDvWSN8RlA86bGzs67?=
 =?us-ascii?Q?LALpJKuOOLi3LgDIZu4TRDNA5/z0XEV2NfAvekK2p5azj6mCw35rkKd2bNIW?=
 =?us-ascii?Q?lqgHzxEp3FvWECwBSMCDGRqeYm8OeixbGEEHUjgKRU8STroMte+YZFlFl3Z+?=
 =?us-ascii?Q?/SGKe857pPf30gBfyVHb2H8xnQCH2njZkSuCiS39xdPLzJEqpb1MpWbLxMSd?=
 =?us-ascii?Q?0236sbAX2Yni4Y7i8uNs++v1szFkb0tdhEO0rjbSGnOZvuGfG8aEM6ge2rFv?=
 =?us-ascii?Q?oE9yDb20mO6jgMT376VeZrKT137Ev8U9u6K96FVSIIsiSMZrWOkGO4TnQ6HG?=
 =?us-ascii?Q?G3ZKDXLWlZN1REbdXlYvxZh/fvV2zrmAJ0H6g1vXav9HA8sUC8IqJiu8MKz8?=
 =?us-ascii?Q?BXYNvz0biN4CdbmjhOCEDkNqptAX6RAvuyKlBktDUs9yG098lnC0iM6Lm1mU?=
 =?us-ascii?Q?06u2NAn+B95e6M/JcLIo+A/DFW7r10e74bq1Vhygn34LSMhSH6rCEI8ttIsA?=
 =?us-ascii?Q?U+8++ygRz5xwgO4UApr0rWK+79SJR9G8vYQBiXdBYkoF2+6E/6ighRDkLtqa?=
 =?us-ascii?Q?OXkfV0DbeeINIwR9Y1OxpYJepQkatsajR6455NKK/OW02T8wBBjtPgEG1p0w?=
 =?us-ascii?Q?/swBSGuPPjOD+rebVoUHE/dzQrb1P90WBi6cGX+Y+o22EPfWEf6fo27oPqCb?=
 =?us-ascii?Q?I2fyd0The4dpWoFMOM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;6:HCNZmjmZ+jyy2fx/0kQr1FBhzub9wZ/ZhoaltsR1GQ1JypaDIo70mpPR/QHS809siGzU739sT64siuUG/mQOlhJilg7Sg40F7xJ8iUHzqhiZcpB4YDJXjQWcjbtkcq6JBzbGJOXCyoh0M5Zpu8AgkWmI5KRgxFplAgLByy1O9LmzCMCnB+puMTYWHJaBg/hxuNpAKwKNCt5xPhO3AX+iwmihMWb1dwxJrTGDGRu1FZvWKWUlsieGJZ4cK3n/7vVm5EglqD22kF/bSwHcbqE/K1T8wDbPIQGLywBgYqkOfbEFaVyefMM+RU+Dl0Ze99VDf0L6nWt9tuwnlgcFE9knXdm8Dp4bmp3cqT2kUgC+Vfkqm5BJcgCKuhV8QL03mPcbmWQoQs5YtEFYyaZJTkocySfQu0POuKZOenojqXSGfN59cjOKziM8C7g4r1hoDGxhwOjlyi7x2pLjSFdGaUGMDurpGLQvCttPvtLXBKreajzvShbuVopDb7DpgtD4dJ6Mwlm4SDn9jKLlYoaloJ+bEw==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;5:zdVO05UqZXXuXpWtapkcarzYduAj0k3/fgTJ1NnehZQp7Gu3AJ2ov1zD99a3Rvj03zj+xrG7P4TMM1m0hrgSeIi5kI2PcttYMyYEk8U+Edz0e2lLEB5zpMm9/o/ikPus5uC123idzoLPe4ByVQCJslGGtkpFF6BftNj+43XQEOO5RpHuGAlfrtOxl96Zfyr/GgsCKuYemXbY9+5kaG5dW7TeCVC20VuR1u5aJGv8Vte56j4jUG67sYEGQ8kW6L5wuh/xAZ5ctbXLMQWKx3A66ozexnGjZDL9IkqgAgdnP5EYsuWHG0eE+SXQSUYS+HHnIyqfyK+FLEll+hTHPh3ChhMF89vuv1BaJgIPWHq4RguKNzjYkxEmxLFlnw93TalDTfYtyCIAEyGqBuFpD5dsqCva299ogvpA0kODHHOb5t1Wmw5zDi+oVbMwpN9EqYX0AoMDaTHDQSmGD5+3Jff8BIiTqVgi6AkHcIzALVx3BOkNlnRcrZ/9Cdc1opcelcmb;24:NUNOG1T3u1UJQWwWLYHqUh2xLbJZu5k+DhAmZEpNMb5nzBOS56NMnLNpUOEJ+0wmq9CULtuAEmmyijWQS/WbKQ/FOCuAcFVIzDGeD6Shwig=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;7:NX0FEIcG+x45ukNlOLo8PA59hAgmfoEr33p5CDsKdE9dYqMKCUq1lXDjY3aFY/pW5QZQls0dKipVjcksKov4MLI/C54BJftowe8nJO+WmyI/RM89d10e1aShbk4ibv0mmXlplVnbm/RXTOXDOG9meWTwdAllcxHF0XILEeGMMPPoOap0+IHjbfZlT0ejs1foGVknDHDuraTquxhvoyzkZrAfE5ZgpTWlY1w/BMmKAKgYf8I5ImYX1exiBWvW1SZFTki3YibwtWugbUJaGGbSm8gFkBdugV1Y+4gsNueDXWRNyBeF5nc07Y9CUpc0stqe/ss7exeOPsVf/vkRvEWCkg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2017 23:49:45.5722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3501
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58435
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 samples/bpf/bpf_helpers.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/samples/bpf/bpf_helpers.h b/samples/bpf/bpf_helpers.h
index 9a9c95f..76526da 100644
--- a/samples/bpf/bpf_helpers.h
+++ b/samples/bpf/bpf_helpers.h
@@ -135,6 +135,19 @@ static int (*bpf_skb_change_head)(void *, int len, int flags) =
 #define PT_REGS_SP(x) ((x)->sp)
 #define PT_REGS_IP(x) ((x)->pc)
 
+#elif defined(__mips__)
+
+#define PT_REGS_PARM1(x) ((x)->regs[4])
+#define PT_REGS_PARM2(x) ((x)->regs[5])
+#define PT_REGS_PARM3(x) ((x)->regs[6])
+#define PT_REGS_PARM4(x) ((x)->regs[7])
+#define PT_REGS_PARM5(x) ((x)->regs[8])
+#define PT_REGS_RET(x) ((x)->regs[31])
+#define PT_REGS_FP(x) ((x)->regs[30]) /* Works only with CONFIG_FRAME_POINTER */
+#define PT_REGS_RC(x) ((x)->regs[1])
+#define PT_REGS_SP(x) ((x)->regs[29])
+#define PT_REGS_IP(x) ((x)->cp0_epc)
+
 #elif defined(__powerpc__)
 
 #define PT_REGS_PARM1(x) ((x)->gpr[3])
-- 
2.9.4
