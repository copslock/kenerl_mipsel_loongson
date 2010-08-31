Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Aug 2010 12:24:35 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:37652 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491152Ab0HaKYb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Aug 2010 12:24:31 +0200
Received: by fxm12 with SMTP id 12so4614380fxm.36
        for <multiple recipients>; Tue, 31 Aug 2010 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:cc
         :subject:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Y2NF4gRPzbqeC0mkYN6l0h6ka5HsLzPJhWIZGEbb0wE=;
        b=AIpC+48Xe2loCKY1lh7HGZZqOtHdTH+v8S0tr/hjV2dCwyCJWnU60canOJNrzeJEmZ
         Q0U5e33Xv2Ig2PitpLnxPKF8kNUDNHNjL1q7K0YF+j/6bFBDzGByTKWITQbjgKDFNItQ
         xBYUT4xSTeOhmjUrzyp2eYZjodJj5AABPLeYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:cc:subject:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=IL2tbyCxOfdeGNU9DjYArUbUz92UhozGzLbTDxYZkWEbcr0L+99dXHsmkSGqTOZvsR
         LeOdXYR6qG9SGAmfoRfX9TOnPK5htLStM+1W7aeMl3u2TMOgHoTfV69wRQwdtKCoAy99
         6kikw0hnHO89GEGKPBd4cauqTTc6N8o3yPGTg=
Received: by 10.223.115.13 with SMTP id g13mr3332208faq.41.1283250263450;
        Tue, 31 Aug 2010 03:24:23 -0700 (PDT)
Received: from pixies.home.jungo.com (wall-ext.jungo.com [194.90.113.98])
        by mx.google.com with ESMTPS id b11sm3870459faq.6.2010.08.31.03.24.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 03:24:22 -0700 (PDT)
Message-ID: <4c7cd856.cb71df0a.1986.ffffad0f@mx.google.com>
Date:   Tue, 31 Aug 2010 13:24:19 +0300
From:   Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     ralf@linux-mips.org, wuzhangjin@gmail.com,
        linux-mips@linux-mips.org
Cc:     alex@digriz.org.uk, manuel.lauss@googlemail.com, sam@ravnborg.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Calculate VMLINUZ_LOAD_ADDRESS based on the length of
 vmlinux.bin
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.18.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <shmulik.ladkani@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shmulik.ladkani@gmail.com
Precedence: bulk
X-list: linux-mips

Fix VMLINUZ_LOAD_ADDRESS calculation to be based on the length of vmlinux.bin,
the actual uncompressed kernel binary.

Previously it was based on the length of KBUILD_IMAGE (the unstripped ELF
vmlinux), which is bigger than vmlinux.bin.
As a result, vmlinuz was loaded into a memory address higher then actually
needed - a problem for small memory platforms.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index ed9bb70..5fd7f7a 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -59,7 +59,7 @@ $(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE
 hostprogs-y := calc_vmlinuz_load_addr
 
 VMLINUZ_LOAD_ADDRESS = $(shell $(obj)/calc_vmlinuz_load_addr \
-		$(objtree)/$(KBUILD_IMAGE) $(VMLINUX_LOAD_ADDRESS))
+		$(obj)/vmlinux.bin $(VMLINUX_LOAD_ADDRESS))
 
 vmlinuzobjs-y += $(obj)/piggy.o
 
-- 
Shmulik Ladkani
