Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 13:56:57 +0000 (GMT)
Received: from host181-209-dsl.dols.net.pk ([IPv6:::ffff:202.147.181.209]:56045
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8224944AbVAFN4w>; Thu, 6 Jan 2005 13:56:52 +0000
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2448.0)
	id <ZYJ972J6>; Thu, 6 Jan 2005 18:47:13 +0500
Message-ID: <1B701004057AF74FAFF851560087B16106469D@1aurora.enabtech>
From: Mudeem Iqbal <mudeem@Quartics.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: mipes-linux-ld: final link failed: Bad value
Date: Thu, 6 Jan 2005 18:47:11 +0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <mudeem@Quartics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mudeem@Quartics.com
Precedence: bulk
X-list: linux-mips

hi,

I have built a toolchain using the following combination

binutils-2.15
gcc-3.4.3
glibc-2.3.3
linux-2.6.9	(from linux-mips.org)

I am cross compiling linux kernel for mips. I think the toolchain has been
successfully built. But when cross compiling the kernel I get the following
error

  CC      mm/fremap.o
mipsel-linux-ld: final link failed: Bad value
make[1]: *** [mm/fremap.o] Error 1
make: *** [mm] Error 2

Thanks in advance

Mudeem
