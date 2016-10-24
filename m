Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 14:28:27 +0200 (CEST)
Received: from mout.web.de ([212.227.15.4]:55286 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992028AbcJXM2S1kr5Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2016 14:28:18 +0200
Received: from [192.168.1.2] ([77.182.95.108]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lpeys-1cbXLf3lCA-00fOzv; Mon, 24 Oct 2016 14:27:58
 +0200
Subject: [PATCH 1/4] MIPS/kernel/r2-to-r6-emul: Use seq_puts() in
 mipsr2_stats_show()
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
Message-ID: <4126c272-cdf6-677a-fe98-74e8034078d8@users.sourceforge.net>
Date:   Mon, 24 Oct 2016 14:27:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zQIcyYs8lW6Xxih8CksDDIOHLkB2+Xyi/ciaCc8OV50MEjt8y4K
 vYaH3rrtfUvi/QtU+Q8ZYkkO4icEtEwGfUKP9r9pyX9DkXMremM3+ZtPglBfqdsZLK14LyX
 RKH+UiUSVUEtNYrYrlVTu9WeRBAz/Osdh3RRBZaP+x5G+ak3GXqYQ5d2vWjWakwJULuUEo4
 eVmdHtwDeOC3Jg5fC81cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oxdS3FR8XWY=:wowUJKPTDmhXwAY8pQJrBT
 D2Hbvifig5C6jOcvjA+cLoMRePHhEwkfD0mpWw1IQOzrsycZZVgqmz8JvHfVr4Nv7+8iLYCBP
 ROCkCN5TZvFlNC/aQmTLBOHInzAMdSabXmP+I3YJKUWApW7gG1xAOz51jzuZ3lCY46V+0Z/ZB
 xMvw7Pu9afFPOiSzBNLK5BzAPdeHHG6pID9Af8xM96RwW30GtyewWpQcIdlYU1mbJRXw15dSd
 yfk7+/esvj0SIAVgMa0uW98MJH5GNuXrWIZGvwLnsTyk5NRf0P+T/oDjwErUkAdse2M/rCWID
 EnQ/2wFxdNyEKqra2jkGxYH8et7U2eq9MtSZt/gGpG88YSBr5pWfF+4MYuLa3uy9ZzEUbwOXw
 AHWJhrSEfqtOhKCBbUM04ILN2gNlWsRkpu9PhzoMy+9lLWgyvnMJO19iqk4xUBMiwHzlvTf8m
 XVkW7X24W56hT5HHGPN2gj1szlZxpTsUCtvc/E2vm5wyTKHfKwTR3OOzQdw8ZT/oKuhEZZU8+
 4go4Qz56vhpCLcSxFhbxqW4wra9DUB/cduLVor6jIOvK0fbpNwUxT7uVYEkTpqQRBc/r/qPBK
 zeA/2DWp4dA7kQu/W1FzB5Hn+dUsAYaL5zL4bLAUaZL5V67bjTs0NiNleiCFkxBT7H7l1SUGa
 UVjVzmjbJcDjUpDC3GaWgHVM3MORMiaNXSNS+Q+TgRHnX/iqGShZZ97kg9CKZEqCuWtVg+LBo
 4lBcCGAFvVqAeL3Y2G5zOTQ/34FgZo2jBJxLp5N+BUg+uz90MBjUX2AmzilCM39DspP6Lo+4i
 mrhojFS
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55550
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
Date: Mon, 24 Oct 2016 09:34:51 +0200

A string which did not contain a data format specification should be put
into a sequence. Thus use the corresponding function "seq_puts"
so that the data output will be a bit more efficient for the headline.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index 22dedd6..1bdcb65 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -2232,9 +2232,10 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
 
 static int mipsr2_stats_show(struct seq_file *s, void *unused)
 {
-
-	seq_printf(s, "Instruction\tTotal\tBDslot\n------------------------------\n");
-	seq_printf(s, "movs\t\t%ld\t%ld\n",
+	seq_puts(s,
+		 "Instruction\tTotal\tBDslot\n------------------------------\n"
+		 "movs\t\t");
+	seq_printf(s, "%ld\t%ld\n",
 		   (unsigned long)__this_cpu_read(mipsr2emustats.movs),
 		   (unsigned long)__this_cpu_read(mipsr2bdemustats.movs));
 	seq_printf(s, "hilo\t\t%ld\t%ld\n",
-- 
2.10.1
