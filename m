Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 16:27:42 +0000 (GMT)
Received: from p508B7C79.dip.t-dialin.net ([IPv6:::ffff:80.139.124.121]:32905
	"EHLO p508B7C79.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225203AbTCGQ1l>; Fri, 7 Mar 2003 16:27:41 +0000
Received: from tomts8.bellnexxia.net ([IPv6:::ffff:209.226.175.52]:16854 "EHLO
	tomts8-srv.bellnexxia.net") by ralf.linux-mips.org with ESMTP
	id <S869085AbTCGQ1i>; Fri, 7 Mar 2003 17:27:38 +0100
Received: from amdk62400 ([209.226.97.64]) by tomts8-srv.bellnexxia.net
          (InterMail vM.5.01.04.19 201-253-122-122-119-20020516) with SMTP
          id <20030307162727.FSVU3032.tomts8-srv.bellnexxia.net@amdk62400>
          for <linux-mips@linux-mips.org>; Fri, 7 Mar 2003 11:27:27 -0500
Message-ID: <000f01c2e4c6$65818600$0400a8c0@amdk62400>
Reply-To: "HG" <henri@broadbandnetdevices.com>
From: "HG" <henri@broadbandnetdevices.com>
To: <linux-mips@linux-mips.org>
Subject: mips-linux-ld related question
Date: Fri, 7 Mar 2003 11:25:14 -0500
Organization: BND
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Return-Path: <henri@broadbandnetdevices.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: henri@broadbandnetdevices.com
Precedence: bulk
X-list: linux-mips

Hi All

I installed the binutils-mips-linux-2.13.1.i386.rpm and
egcs-mips-linux-1.1.2-4.i386.rpm from the linux-mips ftp site on a caldera
distribution 3.11 linux box to crosscompile a 2.4 kernel.
no error message while compiling , i get the following error while linking :
 mips-linux-ld: target elf32-bigmips not found

is there some env variable or path that I missed that needs to be set ????

thanks for any help.

Henri
