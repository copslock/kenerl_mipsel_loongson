Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2009 13:22:19 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:41823 "EHLO
        mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492907AbZLRMWP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2009 13:22:15 +0100
Received: by mail-gx0-f210.google.com with SMTP id 2so2717102gxk.4
        for <multiple recipients>; Fri, 18 Dec 2009 04:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=+sEYEUGzdZkVb+vMsCDdXe70Op57Tf23s/WNsshv7oE=;
        b=TOyuOOzy1LrbO7MMeriUmQztkF/Po0KrsIxcmola8YIcuCmHJe80OgtA4ECF1RJKRp
         tUeO+QYln5Xrt0p0tOuQuNF+4UOLy/CzZRVZ24cd8PVj+u/MQdurUkjaqcimIXcPiCDE
         jkgB1osyMianbTIGIJUC3peRk+Vf3yOgIJ0J4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=KROobzei4uTtcBt1JUYq0kZ6PIueqUYcLOUnYzQBdO35dmB+PxeS0kL0UlnYKMZJM0
         hp39n+xTN5QQUSm1UDrH6xdOWt/Sa0a4E35TVJyQWYLoPbPdkeex8CSZdl3NHHvuR7M3
         /mfCV8lrF7lQXCZgYXyTpuZePRyspcceJZgbE=
Received: by 10.91.18.39 with SMTP id v39mr4070029agi.66.1261138562150;
        Fri, 18 Dec 2009 04:16:02 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm955160gxk.8.2009.12.18.04.15.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 04:16:00 -0800 (PST)
Date:   Fri, 18 Dec 2009 21:13:17 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: vmlinux.ecoff directory move to arch/mips/boot
Message-Id: <20091218211317.45e5da2e.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

It moves to the same directory as vmlinux.bin and vmlinux.srec .

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 094bc84..e39a08e 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -28,7 +28,7 @@ VMLINUX = vmlinux
 all: vmlinux.ecoff vmlinux.srec
 
 vmlinux.ecoff: $(obj)/elf2ecoff $(VMLINUX)
-	$(obj)/elf2ecoff $(VMLINUX) vmlinux.ecoff $(E2EFLAGS)
+	$(obj)/elf2ecoff $(VMLINUX) $(obj)/vmlinux.ecoff $(E2EFLAGS)
 
 $(obj)/elf2ecoff: $(obj)/elf2ecoff.c
 	$(HOSTCC) -o $@ $^
-- 
1.6.5.7
