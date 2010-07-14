Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2010 20:02:24 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:52757 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491064Ab0GNSCU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Jul 2010 20:02:20 +0200
Received: by ewy9 with SMTP id 9so8784ewy.36
        for <multiple recipients>; Wed, 14 Jul 2010 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3F1T+FQHQ7AeDBBZadZ96Sc1sf4eSvcD9tZbSFHj628=;
        b=HzuKXdtTuJrmoxkywurqgG2Wcb+EIFHmUzPjUeOJz8QdazO4UdfZ8aaaPPHrikBYWP
         I13Dz8fPnfuCD3dEwe3qjJoe+ZzkLEt/5t2eIJRWL+N1AG4PLOunulsqFqpHa+H0zVSL
         axOWSJ1WAQxgtteg3ty2UtQbUvqJFFxp8v31Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jwFtquRpwiwUVM5YBNRnEjSmP6FdYF/FCeFXHKl76umpaOFbjetWhNKoaBH902MxfA
         WRpgYieuk76hmqosZlw5gdMP1riAKQQJLLiGRrEBkUASEaPEBlJnUbkUhNCfRVTPn/IU
         1qLE8iDD7wRkYCTxKbgwz5KLm4WOWD73+t0Yc=
Received: by 10.213.5.5 with SMTP id 5mr12393647ebt.72.1279130539343;
        Wed, 14 Jul 2010 11:02:19 -0700 (PDT)
Received: from localhost ([213.87.81.7])
        by mx.google.com with ESMTPS id x54sm161885eeh.5.2010.07.14.11.02.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 11:02:17 -0700 (PDT)
From:   Kulikov Vasiliy <segooon@gmail.com>
To:     kernel-janitors@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Chris Dearman <chris@mips.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Rusty Russell <rusty@rustcorp.com.au>,
        =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] arch/mips/kernel/smtc.c: formatting of pointers in printk()
Date:   Wed, 14 Jul 2010 22:01:42 +0400
Message-Id: <1279130502-10777-1-git-send-email-segooon@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <segooon@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: segooon@gmail.com
Precedence: bulk
X-list: linux-mips

Use %p instead of %08x in printk().

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 arch/mips/kernel/smtc.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index a95dea5..cfeb2c1 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -975,8 +975,7 @@ void ipi_decode(struct smtc_ipi *pipi)
 			ipi_call_interrupt();
 			break;
 		default:
-			printk("Impossible SMTC IPI Argument 0x%x\n",
-				(int)arg_copy);
+			printk("Impossible SMTC IPI Argument %p\n", arg_copy);
 			break;
 		}
 		break;
-- 
1.7.0.4
