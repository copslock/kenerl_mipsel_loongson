Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 14:03:09 +0100 (BST)
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:28583 "HELO
	deliver-1.mx.triera.net") by linux-mips.org with SMTP
	id <S8225250AbVIGNCx>; Wed, 7 Sep 2005 14:02:53 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 0A30DC0AB
	for <linux-mips@linux-mips.org>; Wed,  7 Sep 2005 15:09:43 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id C65E41BC07B
	for <linux-mips@linux-mips.org>; Wed,  7 Sep 2005 15:09:45 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 9BBBC1A18AD
	for <linux-mips@linux-mips.org>; Wed,  7 Sep 2005 15:09:46 +0200 (CEST)
Subject: MIPS SF toolchain
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Wed, 07 Sep 2005 15:09:44 +0200
Message-Id: <1126098584.12696.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

Can somebody tell me, what is the right way to make a soft float
toolchain. I tried with crosstool with different flags for configure
and gcc, but the resulting binaries still contains the FP instructions, 
like swc1.

I used --with-float=soft and --nfp for gcc configure,
--without-fp for glibc configure, and compiled glibc
with -msoft-float flag.

Am I missing something, or am I using the wrong flags?

GCC: 3.3.5
GLIBC: 2.3.5
BINUTILS: 2.15

BR,
Matej
