Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2009 23:18:04 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:53557 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493230AbZHDVR6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2009 23:17:58 +0200
Received: by ewy12 with SMTP id 12so5377071ewy.0
        for <multiple recipients>; Tue, 04 Aug 2009 14:17:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QHFcoNbUWZ2eOIC2I7ZbSHE3Zf++pAnchmmtoa6BW64=;
        b=XOyqR4ILvJO5f3wh1Xkn2BV/URxkXtZA3he5oxDA3TbmoFiVABFqW5z28VghR3wgvV
         /rtRVmyVjfNs30Q3h5Hy/x6+5WP68cOOA+/xIKRF+NsXdJIPrgBggcXDd0vf59CKWxOU
         gsNXKM0s4ZFCu+dJb/54ztHF09e1y8YRZ0vgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=KVYZ8t2KJ1UeJY4VdB2wpd6tnognb0q/9oYv7mN0pTW8I8gSXGgICTBIgCG0aDAnzo
         NTNr0IJnb5vHxj0OoBCem+EFew/qFYATHtEqvkKA9j/BGLjUXvhUuCEIolYtyj3jARXL
         m0TSbnddBS6fxgNC8cQqHbX+gKqxOHuiKmm+Y=
Received: by 10.210.57.3 with SMTP id f3mr9503807eba.91.1249420672612;
        Tue, 04 Aug 2009 14:17:52 -0700 (PDT)
Received: from florian (135.87.196-77.rev.gaoland.net [77.196.87.135])
        by mx.google.com with ESMTPS id 28sm1467282eye.34.2009.08.04.14.17.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 14:17:51 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 4 Aug 2009 23:17:49 +0200
Subject: [PATCH 6/5] cpmac: unmark as broken
MIME-Version: 1.0
X-UID:	1164
X-Length: 1251
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908042317.49497.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi David,

I realised afterwards that unmarking cpmac as BROKEN
should have been part of the previous patch series that I sent.

Sorry about that.
--
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 6/5] cpmac: unmark as broken

Starting with version 0.5.1, cpmac is no longer broken.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 5f6509a..9948fa2 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1774,7 +1774,7 @@ config SC92031
 
 config CPMAC
 	tristate "TI AR7 CPMAC Ethernet support (EXPERIMENTAL)"
-	depends on NET_ETHERNET && EXPERIMENTAL && AR7 && BROKEN
+	depends on NET_ETHERNET && EXPERIMENTAL && AR7
 	select PHYLIB
 	help
 	  TI AR7 CPMAC Ethernet support
