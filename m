Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2018 23:27:04 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:46856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992066AbeKKW1A1qhLL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Nov 2018 23:27:00 +0100
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE9C2175B;
        Sun, 11 Nov 2018 22:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975218;
        bh=Rx3BK9wNQ7WRAINZj8JQsEa0Nf7iAX5LUk5+nLvsV2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4E8kkqxzMhiyVwSU4uXp/4Ifen24sbTPQ1ZhP3eXuUm99c0ADcSP9ih+YD8N2w47
         fx3bz3kPWnPHRRug3FMGOtZUEd+1tIgqsyKweaG6Q+4Z3elHVnfaaKcwu/nDK9c83G
         8qRoheWiB6IsqcIxB4xoVApxqMy3XXYmmT/PpZFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 002/361] MIPS: VDSO: Reduce VDSO_RANDOMIZE_SIZE to 64MB for 64bit
Date:   Sun, 11 Nov 2018 14:15:49 -0800
Message-Id: <20181111221620.507857847@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <SRS0=XqPF=NW=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67239
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c61c7def1fa0a722610d89790e0255b74f3c07dd ]

Commit ea7e0480a4b6 ("MIPS: VDSO: Always map near top of user memory")
set VDSO_RANDOMIZE_SIZE to 256MB for 64bit kernel. But take a look at
arch/mips/mm/mmap.c we can see that MIN_GAP is 128MB, which means the
mmap_base may be at (user_address_top - 128MB). This make the stack be
surrounded by mmaped areas, then stack expanding fails and causes a
segmentation fault. Therefore, VDSO_RANDOMIZE_SIZE should be less than
MIN_GAP and this patch reduce it to 64MB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: ea7e0480a4b6 ("MIPS: VDSO: Always map near top of user memory")
Patchwork: https://patchwork.linux-mips.org/patch/20910/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
Cc: stable@vger.kernel.org # 4.19
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 49d6046ca1d0..c373eb605040 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -81,7 +81,7 @@ extern unsigned int vced_count, vcei_count;
 
 #endif
 
-#define VDSO_RANDOMIZE_SIZE	(TASK_IS_32BIT_ADDR ? SZ_1M : SZ_256M)
+#define VDSO_RANDOMIZE_SIZE	(TASK_IS_32BIT_ADDR ? SZ_1M : SZ_64M)
 
 extern unsigned long mips_stack_top(void);
 #define STACK_TOP		mips_stack_top()
-- 
2.17.1
