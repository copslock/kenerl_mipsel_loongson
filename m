Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 21:49:53 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:57062 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493416AbZJ1Utr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 21:49:47 +0100
Received: by ewy12 with SMTP id 12so1228751ewy.0
        for <multiple recipients>; Wed, 28 Oct 2009 13:49:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rDKbGwNMf5qhMRUcwjfsa0duvvWXJIARIVHLMeJfqO8=;
        b=EMCUm8TjSM89LbONYC6VRm2HGwbf2bj1VAQQGjzltGl8gKTPDZql5HvCs0Ed6AoosR
         gvv5OEM+Hf3ZUeJd4kuyfyMokkYFldHtrE0eJccThCfvxBGwDDnvbhgKnEfMHo8kgkwC
         mrV2uCYV38Qh8LwEyus2xeE0Cyn1xS93iCCWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iPJs/yKtVKyAnAWVjHURPIGKxKfEgP4bCklPEAgaTWTpO1oMz6aATYvnjn7W4Z2YAp
         XYslQaD8Udq285OYGI6Thr+Me7FJRze6FrdIdm7d6JGWZtSjji54BGHLJpSninvfhIXU
         0mxaJP/3G58FD5VN3tddtutSPLFEJgqs2Ljag=
Received: by 10.216.91.69 with SMTP id g47mr1707252wef.167.1256762981529;
        Wed, 28 Oct 2009 13:49:41 -0700 (PDT)
Received: from localhost.localdomain (p5496FE70.dip.t-dialin.net [84.150.254.112])
        by mx.google.com with ESMTPS id j8sm237145gvb.19.2009.10.28.13.49.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 13:49:41 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH -queue v2] MIPS: Alchemy: UARTs are of type 16550A
Date:	Wed, 28 Oct 2009 21:49:46 +0100
Message-Id: <1256762986-4416-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

UART autodetection breaks on the Au1300 but the IP blocks are identical,
at least according to the datasheets.  Help the 8250 driver by passing
on uart type information via platform data.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
On top of the other alchemy patches in mips-queue.

 arch/mips/alchemy/common/platform.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 195e5b3..3be14b0 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -26,7 +26,9 @@
 		.irq		= _irq,				\
 		.regshift	= 2,				\
 		.iotype		= UPIO_AU,			\
-		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP |	\
+				  UPF_FIXED_TYPE,		\
+		.type		= PORT_16550A,			\
 	}
 
 static struct plat_serial8250_port au1x00_uart_data[] = {
-- 
1.6.5
