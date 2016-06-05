Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:46:34 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042452AbcFEVmkk8Xkp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:42:40 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2565B94E;
        Sun,  5 Jun 2016 21:42:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Tejun Heo <tj@kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 23/99] MIPS: VDSO: Build with `-fno-strict-aliasing
Date:   Sun,  5 Jun 2016 14:40:56 -0700
Message-Id: <20160605213905.265036668@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605213902.974592018@linuxfoundation.org>
References: <20160605213902.974592018@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53828
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@imgtec.com>

commit 94cc36b84acc29f543b48bc5ed786011b112a666 upstream.

Avoid an aliasing issue causing a build error in VDSO:

In file included from include/linux/srcu.h:34:0,
                 from include/linux/notifier.h:15,
                 from ./arch/mips/include/asm/uprobes.h:9,
                 from include/linux/uprobes.h:61,
                 from include/linux/mm_types.h:13,
                 from ./arch/mips/include/asm/vdso.h:14,
                 from arch/mips/vdso/vdso.h:27,
                 from arch/mips/vdso/gettimeofday.c:11:
include/linux/workqueue.h: In function 'work_static':
include/linux/workqueue.h:186:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
  return *work_data_bits(work) & WORK_STRUCT_STATIC;
  ^
cc1: all warnings being treated as errors
make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1

with a CONFIG_DEBUG_OBJECTS_WORK configuration and GCC 5.2.0.  Include
`-fno-strict-aliasing' along with compiler options used, as required for
kernel code, fixing a problem present since the introduction of VDSO
with commit ebb5e78cc634 ("MIPS: Initial implementation of a VDSO").

Thanks to Tejun for diagnosing this properly!

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13357/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/vdso/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -9,7 +9,8 @@ ccflags-vdso := \
 	$(filter -march=%,$(KBUILD_CFLAGS))
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
-	-O2 -g -fPIC -fno-common -fno-builtin -G 0 -DDISABLE_BRANCH_PROFILING \
+	-O2 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
+	-DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-stack-protector)
 aflags-vdso := $(ccflags-vdso) \
 	$(filter -I%,$(KBUILD_CFLAGS)) \
