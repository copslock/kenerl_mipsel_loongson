Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 04:57:17 +0000 (GMT)
Received: from host181-209-dsl.dols.net.pk ([IPv6:::ffff:202.147.181.209]:42489
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225207AbVANE5E>; Fri, 14 Jan 2005 04:57:04 +0000
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2448.0)
	id <C459ANJL>; Fri, 14 Jan 2005 09:47:01 +0500
Message-ID: <1B701004057AF74FAFF851560087B1610646A7@1aurora.enabtech>
From: Mudeem Iqbal <mudeem@Quartics.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: compressed kernel image for mips
Date: Fri, 14 Jan 2005 09:47:00 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <mudeem@Quartics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mudeem@Quartics.com
Precedence: bulk
X-list: linux-mips

Hi
I am cross compiling kernel 2.6.9 (downloaded from linux-mips.org). If I run

#make ARCH=mips CROSS_COMPILE=mipsel-linux-

The compilation is successful however running

#make ARCH=mips CROSS_COMPILE=mipsel-linux- zImage 

return "no rule to make target 'zImage'

same is the case from bzImage. Now when I googled this problem I found 
https://www.redhat.com/archives/axp-list/2000-October/msg00184.html
which basically says that "Both the zImage and bzImage targets are
x86-specific, while the boot target is available for all archs". but 
"make boot" is also not available. So the question is how can i generate a
compressed kernel image for mips? 

I have built my own toolchain using 

binutils-2.15.94.0.2
gcc-3.4.3
glibc-2.3.3
linux-2.6.9	(from linux-mips.org)
 
Thanx in advance

Mudeem
