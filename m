Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 17:31:14 +0100 (CET)
Received: from mail-fx0-f216.google.com ([209.85.220.216]:57111 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1492785AbZKXQbL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 17:31:11 +0100
Received: by fxm8 with SMTP id 8so7043426fxm.27
        for <linux-mips@linux-mips.org>; Tue, 24 Nov 2009 08:31:05 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Q5nXpjy1Mf4U4c5Gee/7imrPsdyeK1jK1hCR5lGLHYA=;
        b=hQO4f0XGt5Dhnd0KEiN2Cy9WK/QR+LQ+c/vnrhdlbdoqTdU6lxG723z2Dp8Kge0lrR
         u0r4W6MShISPdW0XlSItatRMoe8WodYWN9LS3eNF9p65fGQybnptiHKpfcYLspAeh1Ka
         lbU+bm9tEOl1TGiBPrWC0omjxgA6k9Dg2h8HA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JafC+0q8ugmdcVu9+H5PcsqW8rUVgxcPxKYnZWc3hUb9f+lF3wE9PbVc/hCTzew4wb
         JovpD+vJ9GEEFdm4/kAETh4oWFM4YqWygfcLffFskPrme7kQ54rDNeMYrYftplHw/dge
         GmmSQ4gire7V3S9e2xojhNwNSe4RaYnliCJIU=
Received: by 10.216.88.21 with SMTP id z21mr2101008wee.60.1259080265596;
        Tue, 24 Nov 2009 08:31:05 -0800 (PST)
Received: from localhost.localdomain (p5496F4B9.dip.t-dialin.net [84.150.244.185])
        by mx.google.com with ESMTPS id t2sm12403705gve.9.2009.11.24.08.31.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 08:31:05 -0800 (PST)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: add au1210 to cpu type detector.
Date:	Tue, 24 Nov 2009 17:31:09 +0100
Message-Id: <1259080269-3631-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Au1210 is an au1200 with slightly crippled media engine and a
different PRId.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Ralf please fold this one into "MIPS: Alchemy: Simple cpu subtype detector"
if its not too much trouble. Thanks!

 arch/mips/include/asm/mach-au1x00/au1000.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index e049d15..088c8e0 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -153,6 +153,7 @@ static inline int alchemy_get_cputype(void)
 		return ALCHEMY_CPU_AU1550;
 		break;
 	case 0x04030000:
+	case 0x05030000:
 		return ALCHEMY_CPU_AU1200;
 		break;
 	}
-- 
1.6.5.3
