Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2009 12:38:21 +0200 (CEST)
Received: from mail-ew0-f215.google.com ([209.85.219.215]:36561 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493251AbZGUKiM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2009 12:38:12 +0200
Received: by mail-ew0-f215.google.com with SMTP id 11so3068222ewy.0
        for <multiple recipients>; Tue, 21 Jul 2009 03:38:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DWrGsgTvtEHU82X89bEX8b00faKFRvmE9sbvMADAT6U=;
        b=Wu/DFhJ3ovvYHx6+2PNCowoHoSHtJgGMc44h7HIylmRjWMLZyC57sYMT2PfkogwCJU
         aVLUkTmMjKbG7laQa/LHNg5FsHOaDBmCaj4B0UDRxjUXrlJ7vK6DQL0liTa9NvhbnoR2
         TSLysV0Oh4eEV+5l8nEf8MtBzGRXH86lM0Cl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=W9PjZD8x60bEg/pn54bzIqadpeLXHbPSlhyv9zbSfOiuAyUVq2E1tp2pJ8IMr3d7MD
         70XgushGV90vbIpyUfxeA/c+azHC3CabGR8F5KZNJWxJcnWKhEPFRsn0f7zmlE8fCLRZ
         DIsbN0pF+PP2z2SGVbr37D90fEVVmT6toO5fk=
Received: by 10.210.36.8 with SMTP id j8mr5804339ebj.72.1248172692526;
        Tue, 21 Jul 2009 03:38:12 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 24sm3181787eyx.23.2009.07.21.03.38.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Jul 2009 03:38:12 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 21 Jul 2009 12:38:10 +0200
Subject: [PATCH 2/2] ar7: fix build warning on memory.c
MIME-Version: 1.0
X-UID:	722
X-Length: 1347
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907211238.10709.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch fixes the following build warning:
arch/mips/ar7/memory.c: In function 'memsize':
arch/mips/ar7/memory.c:55: warning: passing argument 1 of 'writel' makes integer from pointer without a cast

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/memory.c b/arch/mips/ar7/memory.c
index 46fed44..696c723 100644
--- a/arch/mips/ar7/memory.c
+++ b/arch/mips/ar7/memory.c
@@ -52,7 +52,7 @@ static int __init memsize(void)
 		size <<= 1;
 	} while (size < (64 << 20));
 
-	writel(tmpaddr, &addr);
+	writel((u32)tmpaddr, &addr);
 
 	return size;
 }
