Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 01:50:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60399 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012601AbbHEXtprAcn1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 01:49:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C82289D25E9EC;
        Thu,  6 Aug 2015 00:49:35 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 6 Aug
 2015 00:49:40 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 6 Aug
 2015 00:49:39 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 5 Aug 2015
 16:49:36 -0700
Subject: [PATCH v4 3/3] MIPS: set stack/data protection as non-executable
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <daniel.sanders@imgtec.com>, <linux-mips@linux-mips.org>,
        <cernekee@gmail.com>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <heiko.carstens@de.ibm.com>,
        <paul.gortmaker@windriver.com>, <behanw@converseincode.com>,
        <macro@linux-mips.org>, <cl@linux.com>, <pkarat@mvista.com>,
        <linux@roeck-us.net>, <tkhai@yandex.ru>, <james.hogan@imgtec.com>,
        <alexinbeijing@gmail.com>, <rusty@rustcorp.com.au>,
        <Steven.Hill@imgtec.com>, <lars.persson@axis.com>,
        <aleksey.makarov@auriga.com>, <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <luto@amacapital.net>, <dahi@linux.vnet.ibm.com>,
        <markos.chandras@imgtec.com>, <eunb.song@samsung.com>,
        <kumba@gentoo.org>
Date:   Wed, 5 Aug 2015 16:49:36 -0700
Message-ID: <20150805234936.20722.60927.stgit@ubuntu-yegoshin>
In-Reply-To: <20150805234348.20722.71740.stgit@ubuntu-yegoshin>
References: <20150805234348.20722.71740.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

This is a last step of 3 patches which shift FPU emulation out of
stack into protected area. So, it disables a default executable stack.

Additionally, it sets a default data area non-executable protection.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/include/asm/page.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 89dd7fed1a57..0b6cec4a1b80 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -228,7 +228,7 @@ extern int __virt_addr_valid(const volatile void *kaddr);
 #define virt_addr_valid(kaddr)						\
 	__virt_addr_valid((const volatile void *) (kaddr))
 
-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
+#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
 #define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
