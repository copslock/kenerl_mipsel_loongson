Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 21:58:02 +0200 (CEST)
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:23424
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993852AbeF1T5zkmJIm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jun 2018 21:57:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsKfoQw0z043o5JuBDxuVg35NNrQHkp1JO0zVBYTmd4=;
 b=BabSAf0fIWO0BUerIoMgNdA2FQA1qHCdUbksVJ9MLnzbjkml7fZ4Kl9rutdos1GBblNUQFT9yPCnArMihcRCB2X6XnxaFx6yElEOowFM2JAfUHip37/SNkIE9QvvN6gjxwBQd0zra2TQ4QZR/oeaZ2JpiWmBcNRGJ3xiLFDxhbU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.82.185.132) by
 SN1PR07MB3968.namprd07.prod.outlook.com (2603:10b6:802:26::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Thu, 28 Jun 2018 19:57:42 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: [PATCH] MIPS: Fix restartable sequences.
Date:   Thu, 28 Jun 2018 14:57:36 -0500
Message-Id: <1530215856-8795-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: BYAPR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::18) To SN1PR07MB3968.namprd07.prod.outlook.com
 (2603:10b6:802:26::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b80cace-d112-459f-d386-08d5dd31698a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR07MB3968;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3968;3:e3//tEeoOdVE1jpUY8v9C4nqr6X7ZRzA0LRPGNZGXngkfnMcPkgnmj8Cd/m+IM6p+w/uz566ND+vhzuiPG3bKHC3LMm7hBMphgggkngi8L2bPugIcz9CDgRHbczmVl6zdRWq8YzhGv/qFahOVlf/z5z7ELmIkNIK+8kBPe9/5q2AgEc5CJaQPov4e02lULXCJkhc/2a8TBRbxnTMxEABKiAjFR2IifM2SnoY7BUJ5JAxIKSkRv5Uw/0kZ5n152aY;25:bPemtEWduhg2NjaBz3kIZKz3jE0Te3cLkVgPiu9N9T2OP5skEZoUfMwvJ3oqhSIpFU6e/DGqpJOlpV/w/6B/neY2RouiDXPCi4OGjxt6qBOj756mXvEq81Mkya8vo9PGGqeP0xw3DgpH/QstzWbwdNG8KqZLp8/g4zOCPUFDWm90jbYkjry/OX62oSPY/oJ2G20rQqRfHTShhewzSNDBKT6xDti653sfIIvr76++KbQNhuxTY1yotM7dECoyXTxp5vrOpy5Vv2fPdqyEiQMqUD0J72QfK8k4KXSqgYH4ONm6jOcOMRiAZY5cgEiDyJeqID8OsjesDYPoHmxv2IyFog==;31:JnXSzBO15Igf7W/2Rr7CIuhWUssI6yHZ/uvUonF4CSudMKe3AKKpVJVE2uiFmqfA6GpgWb6Vos2MPSBdYWbkyJkhV2itoGv3qorTIUgEtqchz1a6TMRBFXTdr9l4Dy1OF0V9zO5IF7waTYGuBZLH30UUR72a3MEOpK4NQnGfK0nVdILHDEGks+oNJ0UBV+Iis/gF08cmAY8EYLLdAGmMYwyh1ucG+F830s5fnk6ZYA4=
X-MS-TrafficTypeDiagnostic: SN1PR07MB3968:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3968;20:cBJWwUqutlvu3c/IY66uvl9yfvxZ0oHVs1DHh3DdWbJ5PPZjIFK5aXZAdukMiPFxC1jqMlclKsRo50fZf7NDgltz2JNs0LNrhoyGRgURzKsq3objmb2jIPVz68OGWAbHDqFYKSsdsjPPB1eZmsusJKo3jAhRlN2NE9Ap0KuEaecB3C/OuPl+TMVa0fMFJPmkSxUHe7uwJZv/X9k3j0w0hXTPzCCGx1gmxcJiAJVw5DqIUdF5TRhpdrnjORnmlpruf69xelfMnPuG2CGcrzdR9grwRWhgGWRFI5nHOTfB4uzJ+QfBbgX9Lftctq3nZGN/zci2MpKnalOeqs0hDRpDfkVw8OsgmhOyQ4LcA1BFLwGerb74Im8wEgouDr/eHc60Wzquzn3giazcxCkjt27yv9uVQM6lUVUPmcPd0d/1Ql8R0RD7eGG4UHcYMWlFzNzzsbnPOOGIDg9GBlB8p5Gl07bCgMAART8POyxPNDrV9TGcCkE1ZAko9btR4c9evps8;4:mW2s+nE2u6BLesVOWBKTIqw1X7CDzUQhGyYHWw1N8WBSea9NABSf6iNElQofM9IgPoY5Bpo3E7gqw9rHxjMUxgg1qTsYcjg1DOUJ0PfGusk9PEk7K7eKqaH/9rgqa0DC1c4+cO29ayd2DilzxTZNdwkfPX8lO+VsR84IPnGSzJfnh1RnjeU/CE1cNt4ZiVTTlPJtRQfS4gUBDVLTyufhizYOiyfP/kKx3UuyOvwvRWLapAm8ipuLaC2UJRM3TOV8MB1ZJxY+OnO7R8tOHLpRSA==
X-Microsoft-Antispam-PRVS: <SN1PR07MB39688F8691717B820B7E3783804F0@SN1PR07MB3968.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB3968;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB3968;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(6506007)(47776003)(6486002)(316002)(36756003)(386003)(305945005)(81166006)(72206003)(50466002)(106356001)(8676002)(66066001)(81156014)(48376002)(107886003)(3846002)(16526019)(6116002)(2351001)(186003)(4326008)(105586002)(68736007)(6512007)(69596002)(1857600001)(53936002)(50226002)(26005)(476003)(6916009)(86362001)(6666003)(2361001)(25786009)(478600001)(53416004)(5660300001)(2616005)(8936002)(52116002)(486006)(7736002)(97736004)(51416003)(956004)(16586007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB3968;H:black.inter.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB3968;23:gYIkPtAMCDW6aGFtizuqnFTzAyufsFJYOu9ZPqC88?=
 =?us-ascii?Q?aJpJOQjHxXtLsfmF85p9qmzBUqab3LDi9FaDz1GuGm6FiTj0izDcGFfsY1gh?=
 =?us-ascii?Q?vBtuvkeuVUt+70PEuk3+LGE/DxcuKM6I5O6YE3EvvyVgZDWci/jYQ7wbMcp5?=
 =?us-ascii?Q?dVPNPiwjj4eCS2QCsTe5TY8yR02MFqxlXDu3EV1MsfI27VsSq5K8Buw7s4WK?=
 =?us-ascii?Q?FXT8ACH0H35ZCwrgxzVA7KMyiZZMPed/s8JPI+a9MVuXXSETgfQtsmV77OrD?=
 =?us-ascii?Q?PAPiDR8BLXvEvLgvCdiyh7GgZ+rNihGmg7RyRPOZrmk6zA01XqtiKNU/fO9u?=
 =?us-ascii?Q?Tk043ay6JHV5dIGcAXEqHzDmd16uJ8R1rHXcVX6c4oKyapCzKsq1Ym+1/xKN?=
 =?us-ascii?Q?V6AfaZh0Jb/6zehs86fowqLh9GH554g+wNx+7EwADUhSi9msYjREPq+QslnA?=
 =?us-ascii?Q?HLpiqpgk83nWmAj9feqlme/VM0tNvSWxszsA30PLHEEctbNrED1XfBNob+nr?=
 =?us-ascii?Q?JNTxvpocBfyuqUwir/t6PL1REdlkK6+RzgK4i0J45BS1EmYA+19fcgU2dkb3?=
 =?us-ascii?Q?7OJvsPv3t17Ulkc/JOSlnhi1YwWJRpQmGqNb4UTFOuFQHpBQPhTLRvqAdpyZ?=
 =?us-ascii?Q?FeROMohgl2tA+n0r94Fd2NxbyMsaIWkNZYCnk1/MYRZEzfK+aOdbfWwDlgce?=
 =?us-ascii?Q?KuTHNZuh8IixOSk/jeK4EkjbSHRnHkNTdpKZ8FF6otAMlGAjSa2mpTq2+5A1?=
 =?us-ascii?Q?tmsPYT0dawJMZU5MIuMcb7Li1KmgtHpA6lVl3u4keTqcarD80ZBmE1zeBPQ6?=
 =?us-ascii?Q?47ndTdhm2+cgURXwAotqC2USwADGaHrboXt5WYlt++BbkgMQSOPiL4RLcEF/?=
 =?us-ascii?Q?21XEtHyAyB8iPlVlj0StYqd7SgeDxbVH+sTwaPT8oe1n08h8QNGmhw/4XKCt?=
 =?us-ascii?Q?S4Ky29mTPe/T6hhT1hOIwV9HcipRn9dITExasxfUXzq2s03AF7wA95bMQhJL?=
 =?us-ascii?Q?NYoKKUM0qhaAZBxdwvG1H/fix7oQzsaH5O0ULITpFUUbjhPX6IyfYcuATqpH?=
 =?us-ascii?Q?2BHM8n25yzwsZiKXa1XqytJ6ZhrJtcgmkbbCmOZoqYcsB+n5g0fhRMrWgK7y?=
 =?us-ascii?Q?gyqiwuxQQlweY+KDDmaT/sWKmzh3Pp2gvvjTdIGYa8uxp9sIVXgbBSeMPcfU?=
 =?us-ascii?Q?O/fc/g6SOAvVvpVZlCGtxCjkAi9D78ePvXhBxpcCUACj3BgwYaz2TCWlva1l?=
 =?us-ascii?Q?5qBbJD8zwRQPIFAerc=3D?=
X-Microsoft-Antispam-Message-Info: vEa+TmlkZYkwNImsgjvREMHy+lhsGaaWpe9bWOBjrPddebg2q671aPlbxmU3L3psdh0lNgo3y1ojyoIJHQWNOOaRdCnixyCyKKFkzjAqnS48VAhmv9gXxrL2ZyGPe9ObxJySVxjrJyzdkojL0woUMt9SoXsu2t3VYiDyhnX6tpar1RTz+D0UOiLq7gNr5szab8LH22YLrbOHwhoal/2DksrcN9fNCS5KJq3cQbSIPLKCz+fzAdbJSZmnTGDr+6G1HxU7bs9RmC3pRSgrM5Ymwuw9Gi3MxteuiuQnJhcUlOiVaMdzT+25YJBhNv6vaOT3dWZ9B6vFqkmtW4HK2rrqng1cN+rqSeRUMHo1wq4aGto=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3968;6:xkV9JI3+TCPAAAqz/+URbjJ/qC7kqUqGXxe0Y4XSfAHKOrIj9oYE4C6pow2frBkgzWgwNbCiBAFNLM1xieD+UgtJd6dxwYbBRVUIdRC5C+cEApu6Q0gAMRNdk0Nvm4eTU8rK4xi1qdBwsLYQXWIejVNnRL+6jYrtm+9qZhqHAIgN480eTidFCQd0JywIi6nEME/d/rtx2FYP0BBktaa8/7W43l0XaBnU3ebXhO9oWskOoRI6ZwiqyTHNIXLdHnuzIZ81Nm+a2dy/N/fzoy3Qxnm9lSlYUbstoiI2YxrAria4NmIrbrPGnxhm11EKUqMgBs5HJM3uuyZN7HwnQSPLdBUGsXKznhTTpPAvkvGDMi0i0U6qu0+qR4YoDifLoR3ki6d2oGgyeLVpGsJrBjIqlrhqrwtfpUrqs1GQeei1yGqitgDbwtdA4dEOoqrL4MulGCtZs3xZNlDrZI/SFCQ7KQ==;5:VMk59aqEX2/i4iQ5li5aOM8h6CwrJrulWTpxgQWdaE4XYB9ybUtuCh8bU+qVQ1ncyUxR4c8e5Yrb9/EPq69F9k+l3gIl+GFycusJpdz/QNIrKxvjbLYXsUunUDEAmD+QSW0uRAS7p9GeBN1y/3tzmlpGy4qSXY9VgWpy96DxuEc=;24:uxXj9dBGRaKUuzpcQECq1aai6Mugv68z19r7RImoiwmB7n0A7WLUyTO2/Ch5yT2d2nL02eCLO7XU4CXcZwUz7zVnbXtxns3dSW3M4+UALg0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3968;7:Qq/ey0QXGpqzr0D7VQ5pEGAolNwC5xKHg57S9m3MQ7rS4ujJX44JYz2C3MpX12D2/D2sa7XHoymKHzOfSZ2H7as2jUCswQoCrX+g2twfK0dKeDMPA+aAxyQ5xkI41Us3DS4WFWWBVAY0jkt3E83y5aHSv1TwI/Dz/J0CcNIJNoSG8yiNDN3ft9whXjDCnNjXcgyKtHkoqn51KtB06Dcn4mTG7ciMh9bMXou3Dm14uc4hHflZtR6eevC20BiCqTRd
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 19:57:42.8509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b80cace-d112-459f-d386-08d5dd31698a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3968
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64492
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

The API changed in commit 784e0300fe9fe4aa81bd7df9d59e138f56bb605b,
"rseq: Avoid infinite recursion when delivering SIGSEGV" which broke
building the MIPS kernel. Tested boot on cn78xx platform.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 00f2535..0a9cfe7 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -801,7 +801,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		regs->regs[0] = 0;		/* Don't deal with this again.	*/
 	}
 
-	rseq_signal_deliver(regs);
+	rseq_signal_deliver(ksig, regs);
 
 	if (sig_uses_siginfo(&ksig->ka, abi))
 		ret = abi->setup_rt_frame(vdso + abi->vdso->off_rt_sigreturn,
@@ -870,7 +870,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
-		rseq_handle_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
 	}
 
 	user_enter();
-- 
2.1.4
