Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Oct 2015 04:52:17 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39163 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006994AbbJRCvQHTdId (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Oct 2015 04:51:16 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2170D26C;
        Sun, 18 Oct 2015 02:51:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.2 210/258] MIPS: CPS: #ifdef on CONFIG_MIPS_MT_SMP rather than CONFIG_MIPS_MT
Date:   Sat, 17 Oct 2015 18:58:43 -0700
Message-Id: <20151018014739.942301287@linuxfoundation.org>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <20151018014729.976101177@linuxfoundation.org>
References: <20151018014729.976101177@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49581
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

4.2-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 7a63076d9a31a6c2073da45021eeb4f89d2a8b56 upstream.

The CONFIG_MIPS_MT symbol can be selected by CONFIG_MIPS_VPE_LOADER in
addition to CONFIG_MIPS_MT_SMP. We only want MT code in the CPS SMP boot
vector if we're using MT for SMP. Thus switch the config symbol we ifdef
against to CONFIG_MIPS_MT_SMP.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/10867/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/cps-vec.S |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -224,7 +224,7 @@ LEAF(excep_ejtag)
 	END(excep_ejtag)
 
 LEAF(mips_cps_core_init)
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP
 	/* Check that the core implements the MT ASE */
 	has_mt	t0, 3f
 
@@ -311,7 +311,7 @@ LEAF(mips_cps_boot_vpes)
 
 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	li	t9, 0
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP
 	has_mt	ta2, 1f
 
 	/* Find the number of VPEs present in the core */
@@ -339,7 +339,7 @@ LEAF(mips_cps_boot_vpes)
 	PTR_L	ta3, COREBOOTCFG_VPECONFIG(t0)
 	PTR_ADDU v0, v0, ta3
 
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP
 
 	/* If the core doesn't support MT then return */
 	bnez	ta2, 1f
@@ -453,7 +453,7 @@ LEAF(mips_cps_boot_vpes)
 
 2:	.set	pop
 
-#endif /* CONFIG_MIPS_MT */
+#endif /* CONFIG_MIPS_MT_SMP */
 
 	/* Return */
 	jr	ra
