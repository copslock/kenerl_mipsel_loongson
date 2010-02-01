Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 10:28:14 +0100 (CET)
Received: from mail-ew0-f209.google.com ([209.85.219.209]:60368 "EHLO
        mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491968Ab0BAJ2J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 10:28:09 +0100
Received: by ewy1 with SMTP id 1so934305ewy.26
        for <multiple recipients>; Mon, 01 Feb 2010 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:organization:to:cc:content-type
         :content-transfer-encoding:message-id;
        bh=5TKzJZl21hUDpkOFhz206kqhzn2qGGreMr/Xg/3Ki0M=;
        b=aKmb5pTcq2Pw8XU3WWPQkchjFHpVQjdkkcGnTk3FzAPQ1kb8hefdLwhMSEWPsnCMGJ
         /pFOW2oGbnvZjRjDeioRep4iUpZWkSOraIE/O+zw8dJlJYapwOGhLuKMnP8SmQl3QujY
         7ri69UggtPJ8mWkEqWh/7jGTsaxNxcd+NkCD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:organization
         :to:cc:content-type:content-transfer-encoding:message-id;
        b=fO3VBh6txjCRm+i7hg3ntdD3awcqn/ktstXRmPIFOu2vgo9reRxQAj4g5Lj6U7BRaU
         z/OPTR4hc72+l7QQC6rDUtfpiDu8aZoG7fwGX0rUlmxSeIfqdFCgmw8K5p1hMYaVYoNF
         oUtrvZvx52IRVBAiBoi/sBYGh7zAwSu7VnwV8=
Received: by 10.213.66.5 with SMTP id l5mr4107762ebi.15.1265016483381;
        Mon, 01 Feb 2010 01:28:03 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 16sm3513328ewy.10.2010.02.01.01.28.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 01:28:02 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Mon, 1 Feb 2010 10:27:37 +0100
Subject: [PATCH urgent] MIPS: fix micro-assembly overflow in set_except_vector
MIME-Version: 1.0
X-UID:  166
X-Length: 1852
Organization: OpenWrt
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201002011027.37521.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Commit 24a6d9866c5f15ba7e5b14dc17be4b6edba21d0e broke
the installation of handlers for boards which have their
handlers above a 1 << 26 address. Fix this by making sure that
jump_mask does not excess 0xfc000000 and add the missing ~ operator
to jump_mask when jumping to the handler address.

Reported-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7693929..40d94c3 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1279,11 +1279,11 @@ void __init *set_except_vector(int n, void *addr)
 
 	exception_handlers[n] = handler;
 	if (n == 0 && cpu_has_divec) {
-		unsigned long jump_mask = ~((1 << 28) - 1);
+		unsigned long jump_mask = ~((1 << 26) - 1);
 		u32 *buf = (u32 *)(ebase + 0x200);
 		unsigned int k0 = 26;
 		if ((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
-			uasm_i_j(&buf, handler & jump_mask);
+			uasm_i_j(&buf, handler & ~jump_mask);
 			uasm_i_nop(&buf);
 		} else {
 			UASM_i_LA(&buf, k0, handler);
