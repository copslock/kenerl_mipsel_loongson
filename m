Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2014 00:45:41 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819313AbaFIWph6wHGC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jun 2014 00:45:37 +0200
Received: from localhost (c-76-28-255-20.hsd1.wa.comcast.net [76.28.255.20])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8FF24AFB;
        Mon,  9 Jun 2014 22:45:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        Matheus Almeida <Matheus.Almeida@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.14 27/78] MIPS: Fix typo when reporting cache and ftlb errors for ImgTec cores
Date:   Mon,  9 Jun 2014 15:48:07 -0700
Message-Id: <20140609224814.224357274@linuxfoundation.org>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <20140609224813.282275135@linuxfoundation.org>
References: <20140609224813.282275135@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 721a9205396c4ef2a811dd665ec2a232163b583d upstream.

Introduced by the following two commits:
75b5b5e0a262790fa11043fe45700499c7e3d818
"MIPS: Add support for FTLBs"
6de20451857ed14a4eecc28d08f6de5925d1cf96
"MIPS: Add printing of ES bit for Imgtec cores when cache error occurs"

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Reported-by: Matheus Almeida <Matheus.Almeida@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Markos Chandras <markos.chandras@imgtec.com>
Patchwork: https://patchwork.linux-mips.org/patch/6980/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/traps.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1429,7 +1429,7 @@ asmlinkage void cache_parity_error(void)
 	       reg_val & (1<<30) ? "secondary" : "primary",
 	       reg_val & (1<<31) ? "data" : "insn");
 	if (cpu_has_mips_r2 &&
-	    ((current_cpu_data.processor_id && 0xff0000) == PRID_COMP_MIPS)) {
+	    ((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_MIPS)) {
 		pr_err("Error bits: %s%s%s%s%s%s%s%s\n",
 			reg_val & (1<<29) ? "ED " : "",
 			reg_val & (1<<28) ? "ET " : "",
@@ -1469,7 +1469,7 @@ asmlinkage void do_ftlb(void)
 
 	/* For the moment, report the problem and hang. */
 	if (cpu_has_mips_r2 &&
-	    ((current_cpu_data.processor_id && 0xff0000) == PRID_COMP_MIPS)) {
+	    ((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_MIPS)) {
 		pr_err("FTLB error exception, cp0_ecc=0x%08x:\n",
 		       read_c0_ecc());
 		pr_err("cp0_errorepc == %0*lx\n", field, read_c0_errorepc());
