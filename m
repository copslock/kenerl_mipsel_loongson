Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2018 09:54:04 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48854 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992973AbeAVIxuBtBN4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jan 2018 09:53:50 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB2EFF00;
        Mon, 22 Jan 2018 08:53:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.14 78/89] MIPS: CM: Drop WARN_ON(vp != 0)
Date:   Mon, 22 Jan 2018 09:45:58 +0100
Message-Id: <20180122084002.242771771@linuxfoundation.org>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180122083954.683903493@linuxfoundation.org>
References: <20180122083954.683903493@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62265
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit c04de7b1ad645b61c141df8ca903ba0cc03a57f7 upstream.

Since commit 68923cdc2eb3 ("MIPS: CM: Add cluster & block args to
mips_cm_lock_other()"), mips_smp_send_ipi_mask() has used
mips_cm_lock_other_cpu() with each CPU number, rather than
mips_cm_lock_other() with the first VPE in each core. Prior to r6,
multicore multithreaded systems such as dual-core dual-thread
interAptivs with CPU Idle enabled (e.g. MIPS Creator Ci40) results in
mips_cm_lock_other() repeatedly hitting WARN_ON(vp != 0).

There doesn't appear to be anything fundamentally wrong about passing a
non-zero VP/VPE number, even if it is a core's region that is locked
into the other region before r6, so remove that particular WARN_ON().

Fixes: 68923cdc2eb3 ("MIPS: CM: Add cluster & block args to mips_cm_lock_other()")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17883/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/mips-cm.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -292,7 +292,6 @@ void mips_cm_lock_other(unsigned int clu
 				  *this_cpu_ptr(&cm_core_lock_flags));
 	} else {
 		WARN_ON(cluster != 0);
-		WARN_ON(vp != 0);
 		WARN_ON(block != CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 
 		/*
