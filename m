Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 23:13:39 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.175]:13873 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025225AbZETWNd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 23:13:33 +0100
Received: by wf-out-1314.google.com with SMTP id 28so229477wfa.21
        for <multiple recipients>; Wed, 20 May 2009 15:13:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=E2YeYECAGncvIcH7wDZoMlVT850Fxl5InfxSuGOpzaU=;
        b=lEd7T1/PYXvYwbXauRgR/+AXW6gw+9atJ/d4K3IXGRZzMX6DoWuatFT00pjuXWmKd4
         0+Yo6KSN/fFs6eYIEMjWr1eDKADG4on6rMBw7gWzbPHCTyxTqovuG6fYY1kkTd9Wykwq
         eIuRQCysTW1F3iMfpG0Bbhevhp+MWZ+BlhnZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Qp34cdbFcuZLz5CU2RApZwqQT9ux6sA/Y0qyIiopD6OY65t1xmQTn8WC9Rqx5dYwwl
         koR39U5BnnGGGdG4nSIsO7hrVT90RGvK38YgRacEZyXLbtIjv2/hofjEjz3UrXULKYkH
         FT/AeNb7c+nWHYOf5B5Tjyra22gr0t51dBLV4=
Received: by 10.143.44.17 with SMTP id w17mr640072wfj.255.1242857611268;
        Wed, 20 May 2009 15:13:31 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 32sm558637wfc.14.2009.05.20.15.13.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 15:13:30 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 25/27] Flush RAS and BTB for CPU predictively execution
Date:	Thu, 21 May 2009 06:13:19 +0800
Message-Id: <ec6d663033a9b96ace364b87ff5980794b4b31b9.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This is directly picked from the to-mips branch of
http://dev.lemote.com/code/linux_loongson

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/stackframe.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index db0fa7b..8b92e56 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -117,6 +117,20 @@
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
+#ifdef CONFIG_CPU_LOONGSON2
+		move k0, ra
+		jal	2008f
+		nop
+2008 :		jal	2008f
+		nop
+2008 :		jal	2008f
+		nop
+2008 :		jal	2008f
+		nop
+2008 :		move	ra, k0
+		li	k0, 3
+		mtc0	k0, $22
+#endif
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
 #else
-- 
1.6.2.1
