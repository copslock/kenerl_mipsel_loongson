Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2014 23:47:58 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008237AbaLEWqE7Xfnu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2014 23:46:04 +0100
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 77399A69;
        Fri,  5 Dec 2014 22:45:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.17 004/122] MIPS: tlb-r4k: Add missing HTW stop/start sequences
Date:   Fri,  5 Dec 2014 14:42:58 -0800
Message-Id: <20141205223306.211709248@linuxfoundation.org>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <20141205223305.514276242@linuxfoundation.org>
References: <20141205223305.514276242@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44600
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

3.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 6a8dff6ab16c903b0d8ef5fbf21543f39bf5d675 upstream.

HTW needs to stop and start again whenever the EntryHI register
changes otherwise an inflight HTW operation might use the new
EntryHI register for updating an old entry and that could lead
to crashes or even a machine check exception. We fix this by
ensuring the HTW has stop whenever the EntryHI register is about
to change

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8511/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/tlb-r4k.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -299,6 +299,7 @@ void __update_tlb(struct vm_area_struct
 
 	local_irq_save(flags);
 
+	htw_stop();
 	pid = read_c0_entryhi() & ASID_MASK;
 	address &= (PAGE_MASK << 1);
 	write_c0_entryhi(address | pid);
@@ -346,6 +347,7 @@ void __update_tlb(struct vm_area_struct
 			tlb_write_indexed();
 	}
 	tlbw_use_hazard();
+	htw_start();
 	flush_itlb_vm(vma);
 	local_irq_restore(flags);
 }
@@ -422,6 +424,7 @@ __init int add_temporary_entry(unsigned
 
 	local_irq_save(flags);
 	/* Save old context and create impossible VPN2 value */
+	htw_stop();
 	old_ctx = read_c0_entryhi();
 	old_pagemask = read_c0_pagemask();
 	wired = read_c0_wired();
@@ -443,6 +446,7 @@ __init int add_temporary_entry(unsigned
 
 	write_c0_entryhi(old_ctx);
 	write_c0_pagemask(old_pagemask);
+	htw_start();
 out:
 	local_irq_restore(flags);
 	return ret;
