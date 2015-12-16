Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:50:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24993 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014062AbbLPXuKIXYz0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 5CFADD49FAC0D;
        Wed, 16 Dec 2015 23:50:00 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:04 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:03 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 02/16] MIPS: KVM: Drop some unused definitions from kvm_host.h
Date:   Wed, 16 Dec 2015 23:49:27 +0000
Message-ID: <1450309781-28030-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50650
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

Some definitions in the MIPS asm/kvm_host.h are completely unused, so
lets drop them.

MS_TO_NS is no longer used since commit e30492bbe95a ("MIPS: KVM:
Rewrite count/compare timer emulation"). The others don't appear ever to
have been used.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/kvm_host.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 6a313157db83..17782205c5db 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -92,11 +92,6 @@
 #define KVM_INVALID_INST		0xdeadbeef
 #define KVM_INVALID_ADDR		0xdeadbeef
 
-#define KVM_MALTA_GUEST_RTC_ADDR	0xb8000070UL
-
-#define GUEST_TICKS_PER_JIFFY		(40000000/HZ)
-#define MS_TO_NS(x)			(x * 1E6L)
-
 #define CAUSEB_DC			27
 #define CAUSEF_DC			(_ULCAST_(1) << 27)
 
-- 
2.4.10
