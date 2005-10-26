Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2005 10:24:02 +0100 (BST)
Received: from p549F5CB2.dip.t-dialin.net ([84.159.92.178]:63403 "EHLO
	p549F5CB2.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133633AbVJZJWz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Oct 2005 10:22:55 +0100
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:47536 "HELO
	deliver-1.mx.triera.net") by linux-mips.net with SMTP
	id <S872531AbVJZGnY>; Wed, 26 Oct 2005 08:43:24 +0200
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id C56ECC02A
	for <linux-mips@linux-mips.org>; Wed, 26 Oct 2005 08:43:19 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id B5DAC1BC09E
	for <linux-mips@linux-mips.org>; Wed, 26 Oct 2005 08:43:19 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id E16751A18B0
	for <linux-mips@linux-mips.org>; Wed, 26 Oct 2005 08:43:18 +0200 (CEST)
Subject: Simple patch for dbau1200
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	linux-mips@linux-mips.org
Content-Type: multipart/mixed; boundary="=-EuiEFHkvV2jDcYlAojFZ"
Date:	Wed, 26 Oct 2005 08:43:11 +0200
Message-Id: <1130308991.4656.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips


--=-EuiEFHkvV2jDcYlAojFZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

This is simple patch, to get the correct text
output from :

# cat /proc/cpuinfo

for the DBAU1200 board.

BR,
Matej

--=-EuiEFHkvV2jDcYlAojFZ
Content-Disposition: attachment; filename=db1200-cpuinfo.patch
Content-Type: text/x-patch; name=db1200-cpuinfo.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Simple patch to get correct board name from /proc/cpuinfo.

Signed-off-by: Matej Kupljen <matej.kupljen@ultra.si>

--- linux-latest/arch/mips/au1000/pb1200/init.c	2005-10-24 13:36:24.000000000 +0200
+++ linux-20051025-dbau1200/arch/mips/au1000/pb1200/init.c	2005-10-26 08:22:58.215114088 +0200
@@ -43,7 +43,11 @@ extern char *prom_getenv(char *envname);
 
 const char *get_system_type(void)
 {
+#ifdef CONFIG_MIPS_DB1200
+	return "Alchemy Db1200";
+#else
 	return "Alchemy Pb1200";
+#endif
 }
 
 void __init prom_init(void)

--=-EuiEFHkvV2jDcYlAojFZ--
