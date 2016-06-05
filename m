Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2016 00:30:36 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:32957 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042520AbcFEWY6kpjTK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2016 00:24:58 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 37F6D94F;
        Sun,  5 Jun 2016 22:24:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.5 022/128] MIPS: Build microMIPS VDSO for microMIPS kernels
Date:   Sun,  5 Jun 2016 15:22:57 -0700
Message-Id: <20160605222321.916773893@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605222321.183131188@linuxfoundation.org>
References: <20160605222321.183131188@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53878
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

4.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit bb93078e655be1e24d68f28f2756676e62c037ce upstream.

MicroMIPS kernels may be expected to run on microMIPS only cores which
don't support the normal MIPS instruction set, so be sure to pass the
-mmicromips flag through to the VDSO cflags.

Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13349/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/vdso/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -5,6 +5,7 @@ obj-vdso-y := elf.o gettimeofday.o sigre
 ccflags-vdso := \
 	$(filter -I%,$(KBUILD_CFLAGS)) \
 	$(filter -E%,$(KBUILD_CFLAGS)) \
+	$(filter -mmicromips,$(KBUILD_CFLAGS)) \
 	$(filter -march=%,$(KBUILD_CFLAGS))
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
