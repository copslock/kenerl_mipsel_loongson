Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Mar 2010 18:08:15 +0100 (CET)
Received: from mail-fx0-f216.google.com ([209.85.220.216]:43334 "EHLO
        mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492428Ab0CURIH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Mar 2010 18:08:07 +0100
Received: by fxm8 with SMTP id 8so4000945fxm.25
        for <linux-mips@linux-mips.org>; Sun, 21 Mar 2010 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=ABnITTmOU2e6D+SffjQ5RmkzU9xomC82KJLJXaD+gw8=;
        b=cPJ7R6FkTFb25EfOQN6txJ9GAsAmnv8xM3mUfaQp8zhOO2weoixgThPzrzDYNn4vet
         58yDzSMRq6+RcXucxlGMekzpfMAV5W+D2gPgZAePlFcvF2QTCZ91ZLcqh8F25kN2kU0r
         ZLkMcQHRjpUZEzPRdiAHDT+QoHk3oGMVUo6xA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=JfVYWmMqWrt+8byAgScaO/McwFGCiR1dc2HN1+AC/4xGjUvtqqc6hDaN39etd1euWg
         l8FYVyr/O3Ol4pEANA1WHUtZKvFJKl2M2F2vHw94VRIc/TYFy+i+GCVwQbfe8t/gszrT
         NA1Kz3rNYavUIZDtasvbH+S9/A65CClX6+QIc=
Received: by 10.103.7.31 with SMTP id k31mr9414507mui.132.1269191280861;
        Sun, 21 Mar 2010 10:08:00 -0700 (PDT)
Received: from debian.localnet (chello087206211117.chello.pl [87.206.211.117])
        by mx.google.com with ESMTPS id n7sm17969484mue.15.2010.03.21.10.07.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 10:08:00 -0700 (PDT)
From:   Adrian Byszuk <adebex@gmail.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] Fix kexec call on MIPS platform
Date:   Sun, 21 Mar 2010 17:06:47 +0000
User-Agent: KMail/1.12.4 (Linux/2.6.33.1-custom; KDE/4.3.4; i686; ; )
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201003211706.47373.adebex@gmail.com>
Return-Path: <adebex@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adebex@gmail.com
Precedence: bulk
X-list: linux-mips

Dear developers,

This kernel patch fixes problems with kexec call on some devices.
I tested it on Asus WL-500gP v2. I suppose it would behave well on all MIPS 
machines.
Applicable to 2.6.32 and 2.6.33

Signed-off-by: Adrian Byszuk <adebex_at_gmail.com>

---

--- a/arch/mips/kernel/machine_kexec.c	2010-03-15 15:52:04.000000000 +0000
+++ b/arch/mips/kernel/machine_kexec.c	2010-03-21 15:25:13.953615489 +0000
@@ -52,7 +52,8 @@
 	reboot_code_buffer =
 	  (unsigned long)page_address(image->control_code_page);
 
-	kexec_start_address = image->start;
+	kexec_start_address = 
+		(unsigned long) phys_to_virt(image->start);
 	kexec_indirection_page =
 		(unsigned long) phys_to_virt(image->head & PAGE_MASK);
 
