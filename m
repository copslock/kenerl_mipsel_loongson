Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 18:02:05 +0200 (CEST)
Received: from mail-eopbgr680090.outbound.protection.outlook.com ([40.107.68.90]:45312
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994648AbeIEQAVoozTO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Sep 2018 18:00:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fARMWj20W2CxyYcHxV/IKLdAzhGC5OZQirALlghF3Ek=;
 b=lkDmycK9XERb6nY9oqABvp8r4Y5R64NAWMkNkFE9XFQbTZDId1+jN9OtrvGsJPiKsh7shfC8TVsOwnvnaBvXEtIEB2eJd6jMPqlI3cS3W4ooRY+olZtLuVVdjtOgTU+tzpAzDmjvXzHw9sPRy1YWDRMckj5NaQQgQi9URDF21dI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 16:00:02 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v4 4/6] MIPS: kexec: Do not flush system wide caches in machine_kexec()
Date:   Wed,  5 Sep 2018 08:59:07 -0700
Message-Id: <20180905155909.30454-5-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905155909.30454-1-dzhu@wavecomp.com>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:4:16::13) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e254dacb-44c8-4828-c4bd-08d61348a402
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:JiwusGb8AZrWdzbPNA6ij7ibSAmuXEWFaz83SZDOa8jCcnZjRKj1yA6qICFghMq54NSzOO0C7CnjGx8tU+TaUpQt+NOD4psAzBTH/iPlC6PJkCTACm4NzDWV/7LbATZCN+WeHDZCDjdL3dJFOXasPVkvIGEWxB44yPFoeXQjhSz9+gRjI1YZyv4UjRY9QCNRsjuBbBTgXxQpSaAUB+3j1QpQ6Y97guIG9IezPwj1rTnG3RbvC1HJZFEbjfXYztpH;25:7mL++CXXZAW8vhWKar/Mtu6oOhVNXKK6zIXtDgxSe4w4fXFCzBJs731xjl7il0Tmf35tQFNOblR0hhYjc3F1DzdGXozwhRzPxXsvkx3tG64JTHq9wPFacE25Lg7BKqdJtXh7hErUmH05tMkxYOpHbKrkyXN2YKyqmiGUQvEyByNr/vMwZiwNRuoln7wtRxWHuW3xCJVSIEV53wscnG2iuSOC/hj2OmKc7IdKRzH4q83aXkDX2rKkJL25ubuzXuIewQCSBr43xwtWSudpqmuaVdhITtSs7mlq6XFEXyeHKOH/HuSk/2ZXk/JlaGm/+UIoVpw7mrPRcywmUhiGWtOsjA==;31:ui9bGtsG09gpEfa2m2K24ui3H6ddftCKWkydT+T0gIPVRM4AdocH49XnaxOh/E0CxGIwEcIvvieNvnsz1ZDSa/LLlj7dCn4QaPZi98H6nAbWXXtIXcWC6duVMVX+9372dLcOPhK01P080cJtzC7t7tLxpEEWDLgo5zpChxxF2JGel+3Deia5A7nrfmYfYYxewptMTEv1zICUluls4wTd1RMBtemJ7+uT8kgEU5+wS/I=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:2n4gj1FyGXRNDSIQdExo4SxAZVm1bg5iF+6LRW2zoTx51rx2b3tlO+jhZLh/BJac816aWeYCdVwnVW5dFU7UmPCqS7xuWA8PLJl+71fUffOjQ2PbEGQ77AjKLr8EoRxDLdppuqrzcGBfp9YcDzhbChduT92Fdb4+0CEjX6MODFRhxmqN1wphUD869Ifhqzad+Q/fIVdCx3nnSOumPYaFijLr04RuUxWHPvJk/C4xO/T157XBoEkZIxdHkMrVuw6U;4:/c8Jpt/4rMbRTUTh6FniUzeo1SMaGvC7uCNmsw+gsQ8CVPVUw9MIMYP7uwZDz/MCY677fdZ23BQgD0XGPS0phSqLp3yoPd+M161SUhT4G99I+fFY08aVmE/kAjtPIAM3skpcPSbDzgSKfR7H5ODrALhGqVvztQdSW2G3yPxYjgTioN2v+pk/67Jo6OldH4fbbOIDponpu5WbXtL1QC4kTQzX0VCLjlYfbsWdiAxALe7Vp5G2+96vHKKcNtGTg0jh8NZ+wfAHlnP4OMQG20pqrX64G4KvjOaOjo3Mn66hC2bpzhVZoeHZ3EqbwlT2t+CD
X-Microsoft-Antispam-PRVS: <BN3PR0801MB21458C24B7353B8DF59DD472A2020@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39840400004)(376002)(199004)(189003)(11346002)(956004)(476003)(446003)(486006)(16526019)(26005)(53936002)(6506007)(386003)(81156014)(81166006)(5660300001)(53416004)(14444005)(8676002)(2906002)(8936002)(25786009)(48376002)(106356001)(4326008)(51416003)(105586002)(50226002)(66066001)(47776003)(68736007)(107886003)(76176011)(50466002)(305945005)(2616005)(52116002)(7736002)(316002)(37156001)(86362001)(97736004)(69596002)(16586007)(1076002)(6512007)(6486002)(6116002)(36756003)(478600001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:Lyh6Ge9+UL4yrxReBE9PGTNw0MdRu7/mix0w/4B?=
 =?us-ascii?Q?PbI/JYRLXQoi45ILAbfCA6sB26URH9IcOluPCLOLt9cruVm78irFZnGAlHmb?=
 =?us-ascii?Q?2e8oWdhuWZwJmXAp258LyzpHQ8y1CSQUuuAWnimp3q8w2L8RIcBtParhyI8n?=
 =?us-ascii?Q?XD7yo4ZDB4X6RA83uFRmsiSHirbgznaOHYdIWtO9BqjBPf/eYVNusdFbK11E?=
 =?us-ascii?Q?acjnm43+LOxmV4s0C3/1aLydPrieRfGMlPAWT1ikxKsAzSpqYsQY2RAPzrMn?=
 =?us-ascii?Q?BIl7pgh8aPaBcVPn2XsD9Te9ORTUMPH9ISXe5Cqg9xerhjoqMstKAEruoBwQ?=
 =?us-ascii?Q?JB1PIhhy+mBw/bOGkr4Hmabk10biyK0w9NrWwPY8iuFC2QFPn06gM39Itubh?=
 =?us-ascii?Q?f9lrWmEQtNKWOjHg8Ed33992vHp5HW++KqfvdrWxp8o/gZDvvwIyNugYZxLG?=
 =?us-ascii?Q?jK9wpYs4jNCnHY9xq1TZqzc15XYZhnY6PksjICmPntJkcABRJwZhXHm5ffAQ?=
 =?us-ascii?Q?b5Ysl2CAWxL1Ewc0Xn2PAoTWcpjfZXZd0X/RsWrpOtVYU8wqZV7L7jY+Vs0Z?=
 =?us-ascii?Q?SjfzgbB/PWZ69EGYFpVSo1LWSChmRe3dnz2v5lO8XAYglk03cS/ebvaKGrvY?=
 =?us-ascii?Q?qQMnAX6gRZ2OprVg3apvVRnyvv6831qqLPDsfZtivCOSDBmR78uWHzCPtdl3?=
 =?us-ascii?Q?zt/JBlqZgrERETzk1ka2+O6/+P4aAX6jqprv0B1JF/L11wk3egK+roxrwjqo?=
 =?us-ascii?Q?qD2XAzHTrVjS5JZ52vXRbx3IgAbnj+EMhhOykiwRndCDgsv00vdcPJ8N6KZS?=
 =?us-ascii?Q?trVEwdAVRWu2VK+JzfbWgVInyM4/HEFJOjudQFxzPrxg3x2NvVN0qLhMd+bP?=
 =?us-ascii?Q?7M/7SYpJaJlkHr7dclFatbzU0QlQEudfxsqZeuq1uG8NWeZPX73T/wZP8bjF?=
 =?us-ascii?Q?2dpRqaqeGbHAXBF1L29HPPRw/D6IK6pBlMeYaVIBTlzGbwm62hqlFRt4z49f?=
 =?us-ascii?Q?f3UtL808jW8MggQJ0fydr7N1xmC1O6lUJZ93chYbj2z17V2YBRQEUO6y07vt?=
 =?us-ascii?Q?U2KD1XlqXY5q8RggjrcIOULHXuSDR2yI6s8XjZpt6fti1pdXASoZEE4Vw+fF?=
 =?us-ascii?Q?Fmg7o877xXWmcHad2zZ50dlStv9epbInbSapYQx5srtuGnY7cLQhOqnyfT/V?=
 =?us-ascii?Q?/SL/vRDh4Od0cvpJXzxvK9kqybAM8xxp/HmpLyw/LBuZB277gcgOP/PiWng?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: NrGkHlWINfClpFsDNHMlgmvKumEZw68fX8lY6uVYu7YKGtOQeqQy2JD5VtT2FqqKqd2e6oJuNlhdI5SbY4QxBMVQblWOSkkRT9BhQSgIPl7jI5SFUYtq74a9DBJLCVKX6dXDKTA3C0TsFvCc4T4O/SeCv58VVZ53HtrapUM+Ai3tSbaxaDO/hJOQJBjco08jpBIm9szASanQI27bP9WaGcccJn1L7zM53RwfmiLFOlg8SZ52osFrDsOQxOZGGy+syO0vIHD1RksiMFFWW0jaJA5qmseRI+h9jnyTVMEeXyWosJfwpo+lbE6cDgRf3SrXzZ0raFur/i6WnxgGzQ9LPQ8SQ7qBtplktLL9rNYhbSo=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:U4yN+Bx/kAP4IldVgn70mdbNUVzW8NaXLP4nCABcDQ3jkEYlu4BGN+dRZyik4UiBg9spU9Ijl6Ee8SBUGd/KRTkAWbQQgNN4uSvYnWCr8Q0c6xfqcK0JL2MAUXRMU+B4xLHhEWqKY0DazwfUPPqifs4pNYWU5N5R1TL+tQTptqXmLMPoiKeAQSv/466almexXgJTRqpwFtXhrqxWJZ2HF6jPhKmMCCxRRSnmhC+UM8l9lqg3p7A1Phi4tvNYhpvL/MFvuLTKHRBCFhGamBUEV1RDG6UyEQK43o2Rm1TrHZw5sp6iTNIgqdE7pptn2aaw17N9a5Y+iPOOHlw/PgXPjvvyGEMFJP8bn9dQYhtLrkX4El86rOC9L3XF/qqoy4zWWEbo0spmu4XRVjyqdUOcbCjVIMf09zLiO9HX+1NIMMiTuXsd+9BmO37Zd/S13ncMZ3XLw3IsgYo5ZxM0kbGRYA==;5:0NdkvwlxkjmWWoKMMTe5nT0UFjyzTlS8Fil07oIl0aO4e5V3QH9xOqXFv18C+OL/ts5d8j9K1GwlEecXu5i3bgKy4rM21R/Mpocdv2zowUZCz2RqC9kNuhmQsMmvyzHnBFng03jlDN2msGL76f9cef0HHBzkpTi0vrg4otEDALA=;7:33aVdxtiKAOIPpzRvzVLI+FL/y/zTcmYT892AytUyxsRpUrpSrA0357kvXdfc9WeahH8ogQp+yd8ipjPZLsGEkIUaGNVhhy6j31PpksADx7fF7tFXLUBGIKDA/HzdJVHX8TOUpwa8E6MOTRGPSIW1iqIA9CsPEqItGu4uyVj3UVHKruLJDIpUMTSsH+VDh/RmOuf154WIkc8xzs50IXheqaNrwmpooKPFSIINgTcT3kZaysI8DyapAJdTFxNW2/u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 16:00:02.3940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e254dacb-44c8-4828-c4bd-08d61348a402
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

Instead of __flush_cache_all(), simply flush local icache range. In systems
without IOCU, flushing system wide caches require sending IPIs. But other
CPUs have disabled local IRQs waiting for the reboot signal. It will then
cause system hang.

This patch fixes this problem.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/kernel/machine_kexec.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index baffc7113204..c2119e448490 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -139,7 +139,16 @@ machine_kexec(struct kimage *image)
 
 	printk("Will call new kernel at %08lx\n", image->start);
 	printk("Bye ...\n");
-	__flush_cache_all();
+	/*
+	 * __flush_cache_all() is expensive but unnecessary. More
+	 * importantly, it could freeze the system as it may need to send
+	 * IPIs, whereas other CPUs have been waiting for the reboot signal
+	 * (kexec_ready_to_reboot) with local irqs disabled, because
+	 * machine_crash_shutdown() has been called prior to entering
+	 * this function - machine_kexec().
+	 */
+	local_flush_icache_range(reboot_code_buffer,
+				 reboot_code_buffer + relocate_new_kernel_size);
 #ifdef CONFIG_SMP
 	atomic_set(&kexec_ready_to_reboot, 1);
 
-- 
2.17.1
