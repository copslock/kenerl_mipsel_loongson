Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 00:12:29 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.193]:54599 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226160AbVGFXMO> convert rfc822-to-8bit;
	Thu, 7 Jul 2005 00:12:14 +0100
Received: by wproxy.gmail.com with SMTP id 71so69108wri
        for <linux-mips@linux-mips.org>; Wed, 06 Jul 2005 16:12:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=r8yJSaVLsZXTc6SpW/saA7djCgG7m2zHhFuIVZLka1zBFXyuHF1w/K8qK0WOltRI2Gv9KBaQCJ1JyjI3b4wG67VkH+tjHJRJb00B9b/Ox6up7v+Deh1PMrJxx6R3RXHAfwlFvhRWnRYGiBNR5iSqhrMLWV7/HmljWUrjcFDzsJc=
Received: by 10.54.16.77 with SMTP id 77mr130694wrp;
        Wed, 06 Jul 2005 16:12:39 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Wed, 6 Jul 2005 16:12:39 -0700 (PDT)
Message-ID: <2db32b7205070616124fa47ef3@mail.gmail.com>
Date:	Wed, 6 Jul 2005 16:12:39 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: compiling error of linux 2.6.12 recent cvs head for db1550 using defconfig
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I use gcc 3.4.4 to compile the recent 2.6.12, got the following errors:

  CC      arch/mips/au1000/common/setup.o
In file included from include/asm/io.h:29,
                 from include/asm/mach-au1x00/au1000.h:43,
                 from arch/mips/au1000/common/setup.c:42:
include/asm-mips/mach-au1x00/ioremap.h:25: warning: static declaration
of 'fixup_bigphys_addr' follows non-static declaration
include/asm/pgtable.h:363: warning: 'fixup_bigphys_addr' declared
inline after being called
include/asm/pgtable.h:363: warning: previous declaration of
'fixup_bigphys_addr' was here
include/asm-mips/mach-au1x00/ioremap.h: In function `fixup_bigphys_addr':
include/asm-mips/mach-au1x00/ioremap.h:26: warning: implicit
declaration of function `__fixup_bigphys_addr'
arch/mips/au1000/common/setup.c: At top level:
arch/mips/au1000/common/setup.c:159: error: conflicting types for
'__fixup_bigphys_addr'
include/asm-mips/mach-au1x00/ioremap.h:26: error: previous implicit
declaration of '__fixup_bigphys_addr' was here
make[1]: *** [arch/mips/au1000/common/setup.o] Error 1
make: *** [arch/mips/au1000/common] Error 2

Not sure if it is just compiler's problem

thanks
