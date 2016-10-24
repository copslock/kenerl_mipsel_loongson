Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 14:31:17 +0200 (CEST)
Received: from mout.web.de ([212.227.15.3]:61462 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992028AbcJXMbKg7xxY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2016 14:31:10 +0200
Received: from [192.168.1.2] ([77.182.95.108]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M95ET-1c3pSN1rMD-00CTLu; Mon, 24 Oct 2016 14:30:54
 +0200
Subject: [PATCH 4/4] MIPS/kernel/proc: Combine four seq_printf() calls into
 one call in show_cpuinfo()
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
Message-ID: <61796ee0-b3b8-53a6-d29d-487c89145fc1@users.sourceforge.net>
Date:   Mon, 24 Oct 2016 14:30:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:43R64I2orqHSd8Z57d0u7DJ3OnxdANPRtFnlDT0puBAIs49J8g1
 Ian2ggEye6+sNbj1J+A4GxGP2frN2b1Taj1BUe/E1AEjL2EfRd2rritkbRJXJSdGLqgXeY9
 gwRkBRlKWE0rUkSG9oxifCApzDAx758RALq4oZXGPu5wBnj3GjI1FHVIRF8+824zJ+prtrZ
 +D8NslH/b8T2b5JMuds8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:78UIlUGrmk8=:54ViW/ApG04RUf9XU9Eqzr
 iT/Meu3TxU3GnV5SeZcPoGtDaH/IS5Oal4V1WrZntdK08sJgwmlkBJMjx6C9rPT0rtHJsNGZm
 pT0y3qvobvYArAwe/y3hZ+u8v9QrXZTcyyefV9K3X2ziNs3wWaJxX349uGt+f+WW+r/edB0vt
 UoGEJ3aLI/N1d80Q1bZdrh1M98Xo7cEoWAWKNlFX6mwfqIYe8pKgJ1S1Z17833i+jSZUyf8DA
 eut5gz4KaOSbfv8J95JTFpnSIyYMrd0sGUOXlzRUpq552gk6hMYkWiDUwDrJ1DEuq8vRryuG+
 ZTquTmQW2gV/1Uh7t455GNsgJScFRiIiwnogjoPtZM5dC7MbvmXx+APKkfz/DUyZ+F0N+iF+N
 QnbsYVyaMI7oFLweX168Zkf4XaFKu8/kSA3qnA1sYzUbjbwtBILICgEV0+/uhxkLOCAGHicDP
 p/b68i5HpjFcI7jUIFpYYVd3xZCSvYYcTzrrngSYzTkVWEGK9vY/FsYersVIL14Mg1mjG1oI+
 iBx/MJTFZS6nKnOqkirc1xNXCiPXxZxLOQoshj1bWmwv35xMONuPGbF1uH/ZJ2dYtvGh6/+R9
 lLLJHF8JiZXoVmFiEEiyaVgVlMIZ4twZP0Hx8UxsFLaJcvfWLmVc5NW8OoseR2peS71p7w75d
 kHIYcjEeRdHWyE/WimW1CsKKl19eruKP++NZajXNKiFMM1rhXMjberPJe821l9kfpwhnknOdG
 +dA+k+iduh/zoaudQ5ZLzZtne3CzmztYjgsdxTgw1ov6P+50cH1z+/maFIjh//lWyfc8ZDWIP
 sbUzJnB
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55553
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
Date: Mon, 24 Oct 2016 13:54:58 +0200

Some data were printed into a sequence by four separate function calls.
Print the same data by one function call instead.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/proc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 07480a9..1047a03 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -142,12 +142,15 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "micromips kernel\t: %s\n",
 		      (read_c0_config3() & MIPS_CONF3_ISA_OE) ?  "yes" : "no");
 	}
-	seq_printf(m, "shadow register sets\t: %d\n",
-		      cpu_data[n].srsets);
-	seq_printf(m, "kscratch registers\t: %d\n",
-		      hweight8(cpu_data[n].kscratch_mask));
-	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
-	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
+	seq_printf(m,
+		   "shadow register sets\t: %d\n"
+		   "kscratch registers\t: %d\n"
+		   "package\t\t\t: %d\n"
+		   "core\t\t\t: %d\n",
+		   cpu_data[n].srsets,
+		   hweight8(cpu_data[n].kscratch_mask),
+		   cpu_data[n].package,
+		   cpu_data[n].core);
 
 #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
 	if (cpu_has_mipsmt)
-- 
2.10.1
