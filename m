Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jun 2008 18:23:16 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.179]:31879 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20050514AbYFURXF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 21 Jun 2008 18:23:05 +0100
Received: by py-out-1112.google.com with SMTP id z57so691210pyg.22
        for <linux-mips@linux-mips.org>; Sat, 21 Jun 2008 10:23:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject
         :message-id:date:from;
        bh=UeVZKdZIfkKwocFAV5OYgHeyq8imvtK5nZ0GVSS1DJY=;
        b=fcbR88xhIcXGvEezJWmCa+etSqI3pRqfrkGkEoFJZdrZr6WWibFJ/t93skO7RxVJB6
         7nrhfBnLnqB2+dNmaPYwjLMKdNtlorfZozawr0JVKMg5+DWqZIRBBit4H8ynYIEh/Wbm
         Rfh7Yi6GHTJOWqUWUKjYCD9oKsiCoAvDht/AY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:message-id:date:from;
        b=i1NjLVAqdqHXk1BLWpqlGa4yJmZspZNMryfOotcTuklrIrLj3+7CVfK6SLgwmgortP
         qk7tGrUcifV9IYOAvYY3cSc+bjF4Bfa+rgYBqhU1jved+xRmGujARARBGiAQrO3Ol9O1
         Qlh/bMyHofiHgfahfT7iy3CWVG6kqCptqtC7g=
Received: by 10.65.115.6 with SMTP id s6mr193428qbm.118.1214068982864;
        Sat, 21 Jun 2008 10:23:02 -0700 (PDT)
Received: from localhost ( [207.47.250.104])
        by mx.google.com with ESMTPS id e17sm3295726qba.1.2008.06.21.10.23.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Jun 2008 10:23:01 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.63)
	(envelope-from <shane@localhost>)
	id 1KA6ni-00081s-W8
	for linux-mips@linux-mips.org; Sat, 21 Jun 2008 11:22:59 -0600
To:	linux-mips@linux-mips.org
Subject: [MIPS] Correct section mismatch in arch/mips/mm/sc-rm7k.c
Message-Id: <E1KA6ni-00081s-W8@localhost>
Date:	Sat, 21 Jun 2008 11:22:58 -0600
From:	Shane McDonald <mcdonald.shane@gmail.com>
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

From: Shane McDonald <mcdonald.shane@gmail.com>

There is a section mismatch in the arch/mips/mm/sc-rm7k.c file.
The function rm7k_sc_init, defined with attribute __cpuinit,
calls rm7k_sc_enable, which is defined with attribute __init.
This patch defines them both as __cpuinit, as well as the function
__rm7k_sc_enable which is called by rm7k_sc_enable.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
 arch/mips/mm/sc-rm7k.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -uprN -X orig/Documentation/dontdiff orig/arch/mips/mm/sc-rm7k.c patched/arch/mips/mm/sc-rm7k.c
--- orig/arch/mips/mm/sc-rm7k.c	2008-06-21 05:37:08.000000000 -0600
+++ patched/arch/mips/mm/sc-rm7k.c	2008-06-21 05:40:06.000000000 -0600
@@ -86,7 +86,7 @@ static void rm7k_sc_inv(unsigned long ad
 /*
  * This function is executed in uncached address space.
  */
-static __init void __rm7k_sc_enable(void)
+static __cpuinit void __rm7k_sc_enable(void)
 {
 	int i;
 
@@ -107,7 +107,7 @@ static __init void __rm7k_sc_enable(void
 	}
 }
 
-static __init void rm7k_sc_enable(void)
+static __cpuinit void rm7k_sc_enable(void)
 {
 	if (read_c0_config() & RM7K_CONF_SE)
 		return;
