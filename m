Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 14:30:22 +0200 (CEST)
Received: from mout.web.de ([212.227.15.3]:51224 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992036AbcJXMaPR0tHY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2016 14:30:15 +0200
Received: from [192.168.1.2] ([77.182.95.108]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MPY5x-1c2l7u14vx-004jOg; Mon, 24 Oct 2016 14:29:59
 +0200
Subject: [PATCH 3/4] MIPS/kernel/proc: Replace 28 seq_printf() calls by
 seq_puts() in show_cpuinfo()
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
Message-ID: <33b51bd8-7225-55a5-4be8-d062390e6f67@users.sourceforge.net>
Date:   Mon, 24 Oct 2016 14:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:KV3SYjN7YcDBuaGK2NjY5rhhZMNJ+fEsfwVswIWS3/ddqWO5lxF
 1C3kqnUpuPuWLKUnAopeIpqN574g4I2fW1ynS7918QJtm3mxb9YujwcEJ0XD1PXwHxdGwry
 r9VMaJ1AXhN2mt7yj5S1CRBxqxJpqiUog5gIn3BIsBhXffZvt9SIQnVojumsqjz2Gc62kBi
 pVlwDnB1befJWNy6sVPEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D4JQNR6FnHs=:y9/jyBjd/UB0q0BCGDH5PK
 JB87HiP8yQPJNJcj25aF8aXSw1TsFSb7Oe3IUFvxNbYvwzzG3jDPwYu0PvUnsIOC83M6FJK/j
 Azz9WA2DdgR/NgcN6/g+6cxxcVuI+Uxc69N9d03kjM9ourSu0gGI/7GbJr9/KA+PTh7DWV237
 UIIo8BNAQM4wsrsAJ2FznZ6YM33LWdp5qlm6z9AswNQHSdb9RiyKQvs//wis7UKJi6NVjV6OL
 67pcaUgOqy1VSYxuVFYmGN6GSBnH8mEJxNraCZmV3o+tbnebxhkpdF5FGlsFG9WcZCOtHcmGk
 xaE8yoP4FobhEFxRlo+AqjPLXDpT4ipkkXKHyFNigFjMFocp1aGq8TQzQirHp+1Vqg4U6o079
 PTtnrZx8EtILrMN6+grCcvtDcLk8377WtpTeqNfZ4YjpPnGCJoItcmlandC/DDgOEKZV8VD+d
 XPwzWNCaXCNictPn78tSy2FqF8sAGJe2frXKfEya/yxdNNqfa/EFFjF0NxTQJail3SxgznqKs
 lB9BoHdU6ahl/z9VfVygOvhlwFmINC2+VUnBq38JUU0J0B+CREP1/SmSUtFLrPbmsIPEAeDwV
 LhSF7QVj1Xm6KhNoq4XfiKZcNp3CiST1+x5cyoroYsZa0GDIiMzAnj/8x/QTCILpgZWN+fz3r
 HkaPOEFtMw//1oqtDs4Bsv04CuaP5BT3FZg+hzoJBqQVb5VPaOzWamiNLIZdD46BzlgpkyBFf
 tQUqSA8X88doZQPHJLWmmwKpreZMUinrX1B4spE3Cqwp1jyzlCGqcGv3i2V6bny29kyVR/imV
 shj2jvz
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55552
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
Date: Mon, 24 Oct 2016 13:45:04 +0200

Strings which did not contain data format specifications should be put
into a sequence.

* Thus use the corresponding function "seq_puts" so that the data output
  will be a bit more efficient.

* Omit the format string "%s" which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/proc.c | 74 +++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 765489b..07480a9 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -79,49 +79,63 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		for (i = 0; i < cpu_data[n].watch_reg_count; i++)
 			seq_printf(m, "%s0x%04x", i ? ", " : "" ,
 				cpu_data[n].watch_reg_masks[i]);
-		seq_printf(m, "]\n");
+		seq_puts(m, "]\n");
 	}
 
-	seq_printf(m, "isa\t\t\t:"); 
+	seq_puts(m, "isa\t\t\t:");
 	if (cpu_has_mips_r1)
-		seq_printf(m, " mips1");
+		seq_puts(m, " mips1");
 	if (cpu_has_mips_2)
-		seq_printf(m, "%s", " mips2");
+		seq_puts(m, " mips2");
 	if (cpu_has_mips_3)
-		seq_printf(m, "%s", " mips3");
+		seq_puts(m, " mips3");
 	if (cpu_has_mips_4)
-		seq_printf(m, "%s", " mips4");
+		seq_puts(m, " mips4");
 	if (cpu_has_mips_5)
-		seq_printf(m, "%s", " mips5");
+		seq_puts(m, " mips5");
 	if (cpu_has_mips32r1)
-		seq_printf(m, "%s", " mips32r1");
+		seq_puts(m, " mips32r1");
 	if (cpu_has_mips32r2)
-		seq_printf(m, "%s", " mips32r2");
+		seq_puts(m, " mips32r2");
 	if (cpu_has_mips32r6)
-		seq_printf(m, "%s", " mips32r6");
+		seq_puts(m, " mips32r6");
 	if (cpu_has_mips64r1)
-		seq_printf(m, "%s", " mips64r1");
+		seq_puts(m, " mips64r1");
 	if (cpu_has_mips64r2)
-		seq_printf(m, "%s", " mips64r2");
+		seq_puts(m, " mips64r2");
 	if (cpu_has_mips64r6)
-		seq_printf(m, "%s", " mips64r6");
-	seq_printf(m, "\n");
-
-	seq_printf(m, "ASEs implemented\t:");
-	if (cpu_has_mips16)	seq_printf(m, "%s", " mips16");
-	if (cpu_has_mdmx)	seq_printf(m, "%s", " mdmx");
-	if (cpu_has_mips3d)	seq_printf(m, "%s", " mips3d");
-	if (cpu_has_smartmips)	seq_printf(m, "%s", " smartmips");
-	if (cpu_has_dsp)	seq_printf(m, "%s", " dsp");
-	if (cpu_has_dsp2)	seq_printf(m, "%s", " dsp2");
-	if (cpu_has_dsp3)	seq_printf(m, "%s", " dsp3");
-	if (cpu_has_mipsmt)	seq_printf(m, "%s", " mt");
-	if (cpu_has_mmips)	seq_printf(m, "%s", " micromips");
-	if (cpu_has_vz)		seq_printf(m, "%s", " vz");
-	if (cpu_has_msa)	seq_printf(m, "%s", " msa");
-	if (cpu_has_eva)	seq_printf(m, "%s", " eva");
-	if (cpu_has_htw)	seq_printf(m, "%s", " htw");
-	if (cpu_has_xpa)	seq_printf(m, "%s", " xpa");
+		seq_puts(m, " mips64r6");
+	seq_puts(m,
+		 "\n"
+		 "ASEs implemented\t:");
+	if (cpu_has_mips16)
+		seq_puts(m, " mips16");
+	if (cpu_has_mdmx)
+		seq_puts(m, " mdmx");
+	if (cpu_has_mips3d)
+		seq_puts(m, " mips3d");
+	if (cpu_has_smartmips)
+		seq_puts(m, " smartmips");
+	if (cpu_has_dsp)
+		seq_puts(m, " dsp");
+	if (cpu_has_dsp2)
+		seq_puts(m, " dsp2");
+	if (cpu_has_dsp3)
+		seq_puts(m, " dsp3");
+	if (cpu_has_mipsmt)
+		seq_puts(m, " mt");
+	if (cpu_has_mmips)
+		seq_puts(m, " micromips");
+	if (cpu_has_vz)
+		seq_puts(m, " vz");
+	if (cpu_has_msa)
+		seq_puts(m, " msa");
+	if (cpu_has_eva)
+		seq_puts(m, " eva");
+	if (cpu_has_htw)
+		seq_puts(m, " htw");
+	if (cpu_has_xpa)
+		seq_puts(m, " xpa");
 	seq_putc(m, '\n');
 
 	if (cpu_has_mmips) {
-- 
2.10.1
