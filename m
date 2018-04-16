Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 16:49:47 +0200 (CEST)
Received: from conuserg-10.nifty.com ([210.131.2.77]:30883 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994584AbeDPOszSn-VU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 16:48:55 +0200
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w3GElqto017749;
        Mon, 16 Apr 2018 23:47:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqto017749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1523890073;
        bh=u/JyZf4rXJKqtAzOJ/xV5DQ4UOoLf7ue1MAcnhso4LY=;
        h=From:To:Cc:Subject:Date:From;
        b=qWxZ1sf0UlFUtg6WNwxIDu40vbybWv2GSPifESuC8XgrhZQZXWZobKFpeY9IizFlh
         vWOPUE02Or/QHapIJkfp2vmI8hT/+cpv4VsVdmDlYPbJiNXtifOL8tJcUBnMiemMWR
         worrf8FzrCgG5sMq9XR2cXdPX1NDIzoHoJ6lxuLkhWtq40Ug2ohl9rAu1k2QTFTSej
         ziggZdIJNPO7sKViSkPo4scNG5xroUfXaJ6/ebVmTutcd/fVe7OR+SNPz+mROMGtGi
         yIa/8x7lzbINB8StN2iaZc/7p58ByCaB6eYnZrWuPxJ4CgieQhquFwiLpssaYdoOo1
         /OuFLqa4ZT82g==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] MIPS: boot: fix various problems in arch/mips/boot/Makefile
Date:   Mon, 16 Apr 2018 23:47:40 +0900
Message-Id: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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


When I was trying to fix commit 0f9da844d877 in a more correct way,
I found various problems in arch/mips/boot/Makefile.

ITS is always rebuilt when you rebuild the kernel without touching
anything.  Many build rules are wrong.

If you look at the last patch in this series, you may realize
supporting ITB building in the kernel can cause nasty problems.
Personally, I do not like it, but I tried my best to fix the problems.

With this series, ITB is rebuilt only when necessary.



Masahiro Yamada (7):
  Revert "MIPS: boot: Define __ASSEMBLY__ for its.S build"
  MIPS: boot: do not include $(cpp_flags) for preprocessing ITS
  MIPS: boot: fix build rule of vmlinux.its.S
  MIPS: boot: correct prerequisite image of vmlinux.*.its
  MIPS: boot: add missing targets for vmlinux.*.its
  MIPS: boot: merge build rules of vmlinux.*.itb by using pattern rule
  MIPS: boot: rebuild ITB when contained DTB is updated

 arch/mips/boot/Makefile | 69 ++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

-- 
2.7.4
