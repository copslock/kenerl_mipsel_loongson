Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2010 11:20:13 +0200 (CEST)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:38287 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491121Ab0EKJTo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 May 2010 11:19:44 +0200
Received: by wwb22 with SMTP id 22so2363077wwb.36
        for <multiple recipients>; Tue, 11 May 2010 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:organization:to:cc:content-type
         :content-transfer-encoding:message-id;
        bh=YzJloH84CeA6gRxYyBaw/R30Nz7cVx7M7JFuAEJKznA=;
        b=p0mT7kr5pyDHTpXWHN3v14/fyLY3+oCF5BqCIu3+KR77QgGuNeEyRACTkhM3j4Ne82
         uSyYmGzJuwuhDU3iOsHF6ez/VvM+Pk51WArgWynZ3LX2rY3fYifMtIqp4f6oiBEYvxw/
         w5iQRKGCh2oMVdg98FjqfX+p3f9KOv+omv0zE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:organization
         :to:cc:content-type:content-transfer-encoding:message-id;
        b=p/go7OT4tjCuNFhu1WI7sFk4hAqvKDKU7A9/E1ymncxJhiJhF/hBYHj0A4xr0nEdhU
         IxV52prIcrQ6B+SYyA6acJv64iabi/KDbSgEYimPT5ZqU6CsUL/7HRlk91HEB5aWRxsk
         WQgp/CCesHKbfs9BTvBu8k7FyglxAIG1CkWPI=
Received: by 10.216.154.140 with SMTP id h12mr3247273wek.193.1273569578558;
        Tue, 11 May 2010 02:19:38 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id g17sm1990000wee.5.2010.05.11.02.19.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 02:19:37 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Tue, 11 May 2010 11:20:14 +0200
Subject: [PATCH 2/2] AR7: prevent race between clock initialization and devices registration
MIME-Version: 1.0
X-UID:  65
X-Length: 1535
Organization: OpenWrt
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201005111120.14442.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

ar7_regiser_devices needs ar7_clocks_init to have been called first, however
clock.o is currently linked later due to its order in the Makefile, therefore
ar7_clocks_init always gets called later than ar7_register_devices because both
have the same initcall level. Fix this by moving ar7_register_devices to the right
initcall level.

Reported-by: Michael J. Evans <mjevans1983@gmail.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 1d4a466..566f2d7 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -647,4 +647,4 @@ static int __init ar7_register_devices(void)
 
 	return 0;
 }
-arch_initcall(ar7_register_devices);
+device_initcall(ar7_register_devices);
