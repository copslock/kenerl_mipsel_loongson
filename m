Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 01:17:37 +0100 (BST)
Received: from smtp001.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.125]:62302
	"HELO smtp001.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226704AbVGNARS>; Thu, 14 Jul 2005 01:17:18 +0100
Received: (qmail 21400 invoked from network); 14 Jul 2005 00:18:26 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp001.bizmail.yahoo.com with SMTP; 14 Jul 2005 00:18:26 -0000
Subject: Re: compiling error of linux 2.6.12 recent cvs head for db1550
	using defconfig
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	rolf liu <rolfliu@gmail.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <2db32b7205070616124fa47ef3@mail.gmail.com>
References: <2db32b7205070616124fa47ef3@mail.gmail.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Wed, 13 Jul 2005 17:18:35 -0700
Message-Id: <1121300315.4797.318.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


Try again, I just fixed it and one other compile error in 2.6.13-rc3.

Pete

On Wed, 2005-07-06 at 16:12 -0700, rolf liu wrote:
> I use gcc 3.4.4 to compile the recent 2.6.12, got the following errors:
> 
>   CC      arch/mips/au1000/common/setup.o
> In file included from include/asm/io.h:29,
>                  from include/asm/mach-au1x00/au1000.h:43,
>                  from arch/mips/au1000/common/setup.c:42:
> include/asm-mips/mach-au1x00/ioremap.h:25: warning: static declaration
> of 'fixup_bigphys_addr' follows non-static declaration
> include/asm/pgtable.h:363: warning: 'fixup_bigphys_addr' declared
> inline after being called
> include/asm/pgtable.h:363: warning: previous declaration of
> 'fixup_bigphys_addr' was here
> include/asm-mips/mach-au1x00/ioremap.h: In function `fixup_bigphys_addr':
> include/asm-mips/mach-au1x00/ioremap.h:26: warning: implicit
> declaration of function `__fixup_bigphys_addr'
> arch/mips/au1000/common/setup.c: At top level:
> arch/mips/au1000/common/setup.c:159: error: conflicting types for
> '__fixup_bigphys_addr'
> include/asm-mips/mach-au1x00/ioremap.h:26: error: previous implicit
> declaration of '__fixup_bigphys_addr' was here
> make[1]: *** [arch/mips/au1000/common/setup.o] Error 1
> make: *** [arch/mips/au1000/common] Error 2
> 
> Not sure if it is just compiler's problem
> 
> thanks
> 
