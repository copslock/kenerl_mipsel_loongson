Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 17:26:38 +0100 (CET)
Received: from mail-px0-f177.google.com ([209.85.212.177]:61349 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492024Ab0KIQ0P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Nov 2010 17:26:15 +0100
Received: by pxi7 with SMTP id 7so1575158pxi.36
        for <multiple recipients>; Tue, 09 Nov 2010 08:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RISbGM1lH/WpSOoAomKG1Of2r0UtBzMEeihqWvMEWt0=;
        b=ho9iCWu5aDpbe0QmMo21UDIpAtsk5fPf7s0i9yXrfBvUeC0NzZHe8UjtDBfDtb57mB
         NoH4keEzoxLVnEVoPThXQ8cuGNhfiWMb9+tRXE7SHO57+up/ehDq9lzrCumDUgUQlVfE
         U/EmxidwkDpGHF5dFGNP7xHLLX7/hAR7WVtZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vwIhyQvunt9Qr0KDmxI1qBwdflerqz8PbL0/6PkaOHv2bfub7cbLWGN2YveUwCVf/X
         9AaIsioAEEOEr/RcNzyYZFdUx5rMm/g40AHvxjuWAENL/U5dadmbh9IhsJYRMJuzysap
         dID90DZaeAH/AJRDW737LgE61Mr/jAualcaxQ=
Received: by 10.142.229.18 with SMTP id b18mr5665018wfh.414.1289319969011;
        Tue, 09 Nov 2010 08:26:09 -0800 (PST)
Received: from localhost.localdomain ([221.220.250.231])
        by mx.google.com with ESMTPS id x35sm1882369wfd.1.2010.11.09.08.26.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 08:26:08 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 1/2] MIPS: Remove useless comment about kprobe from arch/mips/Makefile
Date:   Wed, 10 Nov 2010 00:25:53 +0800
Message-Id: <81fc5055a5980ee2877004944553387ed8bdb2b8.1289319749.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The commit "MIPS: kprobe: Add support." introduced an useless comment, drops it
here.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Makefile |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 7c1102e..4a7bfa7 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -259,9 +259,6 @@ endif
 vmlinux.32: vmlinux
 	$(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
 
-
-#obj-$(CONFIG_KPROBES)		+= kprobes.o
-
 #
 # The 64-bit ELF tools are pretty broken so at this time we generate 64-bit
 # ELF files from 32-bit files by conversion.
-- 
1.7.1
