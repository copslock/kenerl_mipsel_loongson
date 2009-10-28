Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 20:09:28 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:55994 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493400AbZJ1TJW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 20:09:22 +0100
Received: by ewy12 with SMTP id 12so1125806ewy.0
        for <multiple recipients>; Wed, 28 Oct 2009 12:09:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1Ew/CskWQIWczkE93PjJgNFTwJJyyZ6eo4DeQPrWhBU=;
        b=GHo1Yxt83kj7cT/vH5RCzMHg/u4hBVoPVwRu4n4Oqy17uv+M/WvdKEdEIPxGteQScL
         jzSKSdaaI5joCGbpVYBYxB/wDkrmK1pw5oyvhEQ34Yg8w5Cd+vpxfC3XmVpvTkJs9+hG
         nzfRVGfJUjUbZnxOjQ8mRDmdwBk0WV0M+DHYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DB1wUTg8Km3rUCEuumV/2k6qZ2g1guHk6k7BeIxnf6pCgJhVeCh6ga9m9eHsly4qkN
         3hqjk1/QswM2kox6BxBxSl81OED7S+atn92Adp1bRwZBWPPxN/Ufv2fgjMEbWKBxX/2j
         v8ivi0KWwTGljChnzkuiWgIHieLsR6UqY/x0w=
Received: by 10.216.88.85 with SMTP id z63mr106513wee.129.1256756956380;
        Wed, 28 Oct 2009 12:09:16 -0700 (PDT)
Received: from localhost.localdomain (p5496FE70.dip.t-dialin.net [84.150.254.112])
        by mx.google.com with ESMTPS id x6sm4428359gvf.1.2009.10.28.12.09.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 12:09:15 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/2] serial: 8250: reduce Alchemy serial port space size
Date:	Wed, 28 Oct 2009 20:09:13 +0100
Message-Id: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

This patch limits the amount of address space claimed for Alchemy serial
ports to 0x1000.  On the Au1300, ports are only 0x1000 apart, and the
registers only extend to 0x110 at most on all supported alchemy models.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
I'm not sure who to send this patch to; I added Ralf Baechle because
he always takes my alchemy patches, 8250 is unmaintained and this
patch is required for adding support for a new alchemy model (this patch
gets me a working serial console on the DB1300).

 drivers/serial/8250.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index b1ae774..2ff81eb 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2429,7 +2429,7 @@ serial8250_pm(struct uart_port *port, unsigned int state,
 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
 	if (pt->port.iotype == UPIO_AU)
-		return 0x100000;
+		return 0x1000;
 #ifdef CONFIG_ARCH_OMAP
 	if (is_omap_port(pt))
 		return 0x16 << pt->port.regshift;
-- 
1.6.5
