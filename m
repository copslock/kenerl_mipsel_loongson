Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jun 2010 09:53:35 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:52460 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492116Ab0FPHwr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jun 2010 09:52:47 +0200
Received: by pxi6 with SMTP id 6so763981pxi.36
        for <multiple recipients>; Wed, 16 Jun 2010 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/EFG4AiCrkP//cMiirI+V6fF1hO1J4uq7VvhhpVRWV0=;
        b=K5IHwbt2XkBzjyLl6fTZ/sKq3/BcRT0SmDRkZsEShb3o0lZ6kschqowWIZRL1zGw9A
         +/D8uH3B4+EVPsQca8zdySxvtfIQfnqP1vc8O/Xbt43crELI9b/rx9cV+GRRyvc3z6FG
         CKIYuSGV8+HLg4cgubS/SfTEFH7bTb0ZrcCfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H86WDO5jPT0VTxVlQjwu8vyecJJ7REg8nSY9zTA07b2qIfX2VeosJJpte7clK/pwJr
         dKN+4MliaUMAikfSpDWi4Br+1l2p95OCnI65C0o7YysejrSjwowQsJuh8u+lCnkVwX4a
         4kOpdsB3yMKw5INhlNYp6AuHrcJKT/fvGpcXo=
Received: by 10.114.187.29 with SMTP id k29mr6733084waf.208.1276674759774;
        Wed, 16 Jun 2010 00:52:39 -0700 (PDT)
Received: from localhost.localdomain ([182.18.29.11])
        by mx.google.com with ESMTPS id c1sm78670395wam.7.2010.06.16.00.52.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jun 2010 00:52:39 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: strip the un-needed sections of vmlinuz
Date:   Wed, 16 Jun 2010 15:52:21 +0800
Message-Id: <1276674753-30240-2-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <7a966ffadcf2a4600c098c3ac47ef1f645790946.1276674390.git.wuzhangjin@gmail.com>
References: <7a966ffadcf2a4600c098c3ac47ef1f645790946.1276674390.git.wuzhangjin@gmail.com>
X-archive-position: 27143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11031

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch use "strip -s" to strip the .symtab and .strtab sections of
vmlinuz.

Note: This patch is based on http://patchwork.linux-mips.org/patch/1324/

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 9ef6e2f..1910702 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -65,8 +65,11 @@ vmlinuzobjs-y += $(obj)/piggy.o
 
 quiet_cmd_zld = LD      $@
       cmd_zld = $(LD) $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T $< $(vmlinuzobjs-y) -o $@
+quiet_cmd_strip = STRIP   $@
+      cmd_strip = $(STRIP) -s $@
 vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/calc_vmlinuz_load_addr
 	$(call cmd,zld)
+	$(call cmd,strip)
 
 #
 # Some DECstations need all possible sections of an ECOFF executable
-- 
1.7.0.4
