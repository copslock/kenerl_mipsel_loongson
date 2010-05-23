Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 21:55:25 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.156]:16339 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491960Ab0EWTw1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 21:52:27 +0200
Received: by fg-out-1718.google.com with SMTP id 22so1361831fge.6
        for <multiple recipients>; Sun, 23 May 2010 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=8cgnOfyYbaWL/7UE7vZUdRqkYnEEFV6yymyJvMea0FY=;
        b=E7uAx0qYnPM1omOZp9rPM3haWykph1Rd/8UOkRtFhqt5+fGgnB30ofw9fwcFZ2XzS4
         4fbd0Ip8aaHKWHxW9P++2o6tTgsXSiMNJtXwVa1+UXSimya/wQfuRrTrA95MZe6oqHzY
         CicNzYGofeTEDdF+K1X29/4zS6VexxNd4oHno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=ZbsSIEobXf8UHCv1Pppketv/FKR3qvwTfBtwpLlv1B1INRpGiq+zCFX5RbZD3UHBFY
         Gzf+XFDILmQSjb0uo639ONm2RCC3EiNj/UwKaZxjpbXtIx4nrRFzMkhDnLD8wOpeRBt2
         NJ2MtaA8cHcAPFfTtKYlKz6LRBV+A+DI/vTqk=
Received: by 10.86.22.31 with SMTP id 31mr7242065fgv.24.1274644347218;
        Sun, 23 May 2010 12:52:27 -0700 (PDT)
Received: from localhost.localdomain (net-93-145-200-9.t2.dsl.vodafone.it [93.145.200.9])
        by mx.google.com with ESMTPS id d6sm6081796fga.3.2010.05.23.12.52.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 12:52:26 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 168/199] arch/mips/math-emu/sp_tint.c: Checkpatch cleanup
Date:   Sun, 23 May 2010 21:52:09 +0200
Message-Id: <1274644332-23964-8-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.1.251.gf80a2
In-Reply-To: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/math-emu/sp_tint.c:76: ERROR: else should follow close brace '}'

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/math-emu/sp_tint.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/sp_tint.c b/arch/mips/math-emu/sp_tint.c
index 1d73d2a..352dc3a 100644
--- a/arch/mips/math-emu/sp_tint.c
+++ b/arch/mips/math-emu/sp_tint.c
@@ -72,8 +72,7 @@ int ieee754sp_tint(ieee754sp x)
 			round = 0;
 			sticky = residue != 0;
 			xm = 0;
-		}
-		else {
+		} else {
 			/* Shifting a u32 32 times does not work,
 			* so we do it in two steps. Be aware that xe
 			* may be -1 */
-- 
1.7.1.251.gf80a2
