Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 01:07:51 +0100 (BST)
Received: from smtp008.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.74]:58712
	"HELO smtp008.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8226160AbVGGAHg>; Thu, 7 Jul 2005 01:07:36 +0100
Received: (qmail 25007 invoked from network); 7 Jul 2005 00:08:00 -0000
Received: from unknown (HELO ?192.168.1.107?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp008.bizmail.sc5.yahoo.com with SMTP; 7 Jul 2005 00:07:59 -0000
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
Date:	Wed, 06 Jul 2005 17:08:06 -0700
Message-Id: <1120694886.5724.134.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


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

No, it's not. Looks like Maciej's patch on Thursday broke the above. 

Maciej, I assume you built a kernel for one of the Au1x boards before
you applied the patch ;)?

Pete
