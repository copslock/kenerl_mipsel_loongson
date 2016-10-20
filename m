Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 15:53:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52754 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993016AbcJTNwzjkLUR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Oct 2016 15:52:55 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 371E7D196337F;
        Thu, 20 Oct 2016 14:52:46 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 20 Oct 2016 14:52:49 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [GIT PULL] KVM: MIPS: Add missing uaccess.h include
Date:   Thu, 20 Oct 2016 14:52:34 +0100
Message-ID: <1476971554-1215-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1476971554-1215-1-git-send-email-james.hogan@imgtec.com>
References: <1476971554-1215-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

MIPS KVM uses user memory accessors but mips.c doesn't directly include
uaccess.h, so include it now.

This wasn't too much of a problem before v4.9-rc1 as asm/module.h
included asm/uaccess.h, however since commit 29abfbd9cbba ("mips:
separate extable.h, switch module.h to it") this is no longer the case.

This resulted in build failures when trace points were disabled, as
trace/define_trace.h includes trace/trace_events.h only ifdef
TRACEPOINTS_ENABLED, which goes on to include asm/uaccess.h via a couple
of other headers.

Fixes: 29abfbd9cbba ("mips: separate extable.h, switch module.h to it")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index ce961495b5e1..622037d851a3 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/kdebug.h>
 #include <linux/module.h>
+#include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/bootmem.h>
-- 
2.7.3
