Return-Path: <SRS0=ULQD=RZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD172C43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 04:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A27218FE
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 04:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfCVEPx (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Mar 2019 00:15:53 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:55050 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCVEPx (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 22 Mar 2019 00:15:53 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C329272CC53;
        Fri, 22 Mar 2019 07:15:50 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 99C077CC74C; Fri, 22 Mar 2019 07:15:50 +0300 (MSK)
Date:   Fri, 22 Mar 2019 07:15:50 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     linux-kernel@vger.kernel.org
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH linux-next v8 3/7] mips: define syscall_get_error()
Message-ID: <20190322041550.GD27266@altlinux.org>
References: <20190322041409.GA27266@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322041409.GA27266@altlinux.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

syscall_get_error() is required to be implemented on all
architectures in addition to already implemented syscall_get_nr(),
syscall_get_arguments(), syscall_get_return_value(), and
syscall_get_arch() functions in order to extend the generic
ptrace API with PTRACE_GET_SYSCALL_INFO request.

Acked-by: Paul Burton <paul.burton@mips.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v8: unchanged
    v7: added Acked-by
    v6: unchanged
    v5: initial revision

 arch/mips/include/asm/syscall.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 6a22c9352ef6..466957d0474b 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -89,6 +89,12 @@ static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
 	unreachable();
 }
 
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	return regs->regs[7] ? -regs->regs[2] : 0;
+}
+
 static inline long syscall_get_return_value(struct task_struct *task,
 					    struct pt_regs *regs)
 {
-- 
ldv
