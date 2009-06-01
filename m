Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 13:00:01 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42468 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025130AbZFAL7z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 12:59:55 +0100
Received: by ewy19 with SMTP id 19so8027409ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 04:59:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3e1lmSTzSVnXkjpU42lXDYthx+baE/MVBgab+7ljVNA=;
        b=IV8uwDBYeNuTGEOhwnCqs3JRP005atQOCDenx1UuJtXgHUwa3mMVWBxo4gvygapYse
         XhlWf7FhGVqrPDLcHlOrE8rmgK06aEv4wfgjaLZvpcSr1DQTBRn4DbpDAZ/R4h1H1TOX
         3MnyTiN9GtY3sQoYaeku/hgSGWm62NLQfz0rM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=XmyzMFERWmaGgm4h1ilKn9yM5wU9NUiJT7fjkx6Gmv5OBg8IsNV+UcZt7oWWYmwOaE
         yCrdaBfwsdKnhgmH5gGuWLJzTGWEk0/stT/KP4bdvw01nur+qbTWMXViS5fKhNAANScZ
         3X9DFr6qng5VndFjJDVNyCJpar+85V8f+MPsc=
Received: by 10.210.35.5 with SMTP id i5mr6286821ebi.11.1243857589183;
        Mon, 01 Jun 2009 04:59:49 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 28sm7265148eyg.54.2009.06.01.04.59.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 04:59:48 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 1 Jun 2009 13:59:47 +0200
Subject: [PATCH 4/9] mips: deal with larger physical offsets
MIME-Version: 1.0
X-UID:	176
X-Length: 2051
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906011359.47216.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

TI AR7 has larger physical offsets than other MIPS-based
systems. A long jump to the target is required instead of
a short jump like on other systems.

Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e83da17..44f7141 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1256,9 +1256,22 @@ void *set_except_vector(int n, void *addr)
 
 	exception_handlers[n] = handler;
 	if (n == 0 && cpu_has_divec) {
-		*(u32 *)(ebase + 0x200) = 0x08000000 |
-					  (0x03ffffff & (handler >> 2));
-		local_flush_icache_range(ebase + 0x200, ebase + 0x204);
+		if ((handler ^ (ebase + 4)) & 0xfc000000) {
+			/* lui k0, 0x0000 */
+			*(u32 *)(ebase + 0x200) = 0x3c1a0000 | (handler >> 16);
+			/* ori k0, 0x0000 */
+			*(u32 *)(ebase + 0x204) =
+					0x375a0000 | (handler & 0xffff);
+			/* jr k0 */
+			*(u32 *)(ebase + 0x208) = 0x03400008;
+			/* nop */
+			*(u32 *)(ebase + 0x20C) = 0x00000000;
+			local_flush_icache_range(ebase + 0x200, ebase + 0x210);
+		} else {
+			*(u32 *)(ebase + 0x200) =
+				0x08000000 | (0x03ffffff & (handler >> 2));
+			local_flush_icache_range(ebase + 0x200, ebase + 0x204);
+		}
 	}
 	return (void *)old_handler;
 }
