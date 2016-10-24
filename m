Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 14:29:19 +0200 (CEST)
Received: from mout.web.de ([212.227.15.3]:49184 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992036AbcJXM3N1RzDY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2016 14:29:13 +0200
Received: from [192.168.1.2] ([77.182.95.108]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MWS0g-1cRfSU141q-00XgLP; Mon, 24 Oct 2016 14:28:56
 +0200
Subject: [PATCH 2/4] MIPS/kernel/proc: Use seq_putc() in show_cpuinfo()
To:     linux-mips@linux-mips.org,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
References: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <0c465554-d78d-2e2c-ae45-34d6f9f507fc@users.sourceforge.net>
Date:   Mon, 24 Oct 2016 14:28:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:gXqWD3Mx/UUSV9voYDqRrDUbZCPW1y9vfToTK+38tAd99GZEEh/
 +m7C/0AcIpFpmfMf6Bxu5Mtnmm0e93Q3RltDe4tJ9Qxs+GaOUoogkWwpd3OkkIjswBCtYZo
 vMhwqWCXq9fWATXG5x0PB0RlDmKVqJ+4Xha0Trn3xJb9o90xbevphp9Ijf82dpK77aOybPv
 WaKfymxJLH6MFs7N0k46g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KvC4VP2LMhw=:8MTKH+L9cIbw57g8YyNpAG
 waLnwS9ByyHy7XIF/C1wR3NIEzCPV5D1HUyMipLQKqP9nu1KF6RdCeWtIC5WJYRPF7WUe1ohR
 rp128OjSvc1ES2oerCCJmq4qJKBDckXEvx6o0go3S/iBHTKRu+cG1wKmmYh5X2lcPHjdE+x4W
 zYWdkYmCVx/z8Nq1SA6YfX0Cy6dWe3kKlSgYZcwgWl4VfPP16rAHgMDrvfoOCZy00PoBhrnUx
 EnE01F8vj16o0ur0B7M6RuJ/p4wGAZM/fDlzuZ4VgviSXIN9Y8+Aqi33pnC4fIcQfffu7zUSq
 9Evk8DcgUQImsbU5s+MJb0UXUN3Cn1TFDzgX+vWVKmhG/AscEIxKvrOXXN1lsNFnIA1T2TPss
 4JDWgmBe1l9bcjamVC5vhP+z6BjyZKQTP9lPhi/pjcgh2g6Rt0VeLrC0toU4DkexRgUL4btoa
 6nlWUBGiIMNbA8PCTGq8ecuE5FYqyVYzrgRILjW/k531srCIqmU4qC/fvbecmUctDNj7ej7IY
 By5E0+LxBkbaEgKph9tDH+9KznkImaz6xK5HoeP8eFoyW2YzntRq9ZRFs+Xe8BenUxu7Wkl8f
 fAVPKlhItxUKB1FR/PbOV2nGy4UEyOpt71NQNZVY4P8I0Oa/ZNrPN9M6aqRlmSiCZmvFy5EG5
 5+z6JaC1tUqTL8oUpRG07S7WWFZv08r/wY4KejELToM48x8aQrfT4hV7X/eLa+rY5fuaNI5Hw
 ae8hszHWuAuQdx1tTMFvvmOslamYLR3iOVtrbV+OfFc+VBj7HR0zHQCI1ZoP4FWhMGp8zwwnS
 TMfn0dU
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 24 Oct 2016 12:54:15 +0200

A few single characters (line breaks) should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/proc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 4eff2ae..765489b 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -122,7 +122,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (cpu_has_eva)	seq_printf(m, "%s", " eva");
 	if (cpu_has_htw)	seq_printf(m, "%s", " htw");
 	if (cpu_has_xpa)	seq_printf(m, "%s", " xpa");
-	seq_printf(m, "\n");
+	seq_putc(m, '\n');
 
 	if (cpu_has_mmips) {
 		seq_printf(m, "micromips kernel\t: %s\n",
@@ -152,9 +152,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 	raw_notifier_call_chain(&proc_cpuinfo_chain, 0,
 				&proc_cpuinfo_notifier_args);
-
-	seq_printf(m, "\n");
-
+	seq_putc(m, '\n');
 	return 0;
 }
 
-- 
2.10.1
