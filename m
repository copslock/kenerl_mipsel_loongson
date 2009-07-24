Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2009 13:19:30 +0200 (CEST)
Received: from mail-ew0-f207.google.com ([209.85.219.207]:41171 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492207AbZGXLTM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Jul 2009 13:19:12 +0200
Received: by mail-ew0-f207.google.com with SMTP id 3so1144208ewy.0
        for <multiple recipients>; Fri, 24 Jul 2009 04:19:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GcCS5NigdtBX69dXXLshrB3XrEtRSo4eASWJUCDY1hA=;
        b=SLESlwpylC+G7y6KBhJjrCYKnfHrja+/agCHSHY8bmkeQDgwO7E0RfPIbvPvCXXwJR
         rAHy8SDxXpXUObKpJbpX8q2zZ1vsksl3zfZqEpUsLrRYGmZOi94vnsGSMH5jBAPMkyYA
         ihJUqTf/ksje0aoTcorzV9hU2TJjCEo59nFEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=cUdsqs3WQ9dQrHd98o/QHKwKMzWkxAK1B0AFxLcYH8ESVhe+o6u5pIUxfk7SsBA3IE
         rkWOQyQN/fihoUGI46JuBXP5SB4VNy9Pitb6b0B+H+51c9Fo8MrC9oFlUD5d9ybCEGIt
         uCbC8LgpzGyq7x3ySfUC8T3Sclrtsarw3h1/k=
Received: by 10.210.62.12 with SMTP id k12mr4107517eba.19.1248434352644;
        Fri, 24 Jul 2009 04:19:12 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 7sm667060eyg.6.2009.07.24.04.19.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 04:19:12 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 24 Jul 2009 13:19:10 +0200
Subject: [PATCH 3/3] ar7: override CFLAGS with -Werror
MIME-Version: 1.0
X-UID:	773
X-Length: 1155
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907241319.10902.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Now that we have removed all warnings from the ar7 board
code we can use -Werror like on other MIPS boards.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/Makefile b/arch/mips/ar7/Makefile
index 7435e44..26bc5da 100644
--- a/arch/mips/ar7/Makefile
+++ b/arch/mips/ar7/Makefile
@@ -8,3 +8,4 @@ obj-y := \
 	platform.o \
 	gpio.o \
 	clock.o
+EXTRA_CFLAGS += -Werror
