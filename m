Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 19:48:40 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.206]:30595 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226313AbVGGSsS> convert rfc822-to-8bit;
	Thu, 7 Jul 2005 19:48:18 +0100
Received: by wproxy.gmail.com with SMTP id i31so263579wra
        for <linux-mips@linux-mips.org>; Thu, 07 Jul 2005 11:48:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WS9OfUrZWqV2sGr0B7m58WEnWoG9GlPlh6bvShbtDZuffTwYkAoV5+opvcasHzHGtsiQwoGgfpmsw3q5hwc+scK4EVhc6zZQm03GPTvrHJUIWg/LY5qjLIPygC3Zbi41F0zd7Fm7lehmUevIzVf9UbiQQ5qalL7eBZfOuchIytQ=
Received: by 10.54.36.46 with SMTP id j46mr971268wrj;
        Thu, 07 Jul 2005 11:48:42 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 7 Jul 2005 11:48:42 -0700 (PDT)
Message-ID: <2db32b72050707114833af8dcf@mail.gmail.com>
Date:	Thu, 7 Jul 2005 11:48:42 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	ppopov@embeddedalley.com
Subject: Re: compiling error of linux 2.6.12 recent cvs head for db1550 using defconfig
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <1120694886.5724.134.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b7205070616124fa47ef3@mail.gmail.com>
	 <1120694886.5724.134.camel@localhost.localdomain>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Another error:

"No rule to make target `drivers/pcmcia/bulkmem.s`, needed by
`drivers/pcmcia/bulkmem.o`. Stop"

I think the rule is in the top level Makefile. Why this error comes out?

thanks


On 7/6/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> 
> On Wed, 2005-07-06 at 16:12 -0700, rolf liu wrote:
> > I use gcc 3.4.4 to compile the recent 2.6.12, got the following errors:
> >
> >   CC      arch/mips/au1000/common/setup.o
> > In file included from include/asm/io.h:29,
> >                  from include/asm/mach-au1x00/au1000.h:43,
> >                  from arch/mips/au1000/common/setup.c:42:
> > include/asm-mips/mach-au1x00/ioremap.h:25: warning: static declaration
> > of 'fixup_bigphys_addr' follows non-static declaration
> > include/asm/pgtable.h:363: warning: 'fixup_bigphys_addr' declared
> > inline after being called
> > include/asm/pgtable.h:363: warning: previous declaration of
> > 'fixup_bigphys_addr' was here
> > include/asm-mips/mach-au1x00/ioremap.h: In function `fixup_bigphys_addr':
> > include/asm-mips/mach-au1x00/ioremap.h:26: warning: implicit
> > declaration of function `__fixup_bigphys_addr'
> > arch/mips/au1000/common/setup.c: At top level:
> > arch/mips/au1000/common/setup.c:159: error: conflicting types for
> > '__fixup_bigphys_addr'
> > include/asm-mips/mach-au1x00/ioremap.h:26: error: previous implicit
> > declaration of '__fixup_bigphys_addr' was here
> > make[1]: *** [arch/mips/au1000/common/setup.o] Error 1
> > make: *** [arch/mips/au1000/common] Error 2
> >
> > Not sure if it is just compiler's problem
> 
> No, it's not. Looks like Maciej's patch on Thursday broke the above.
> 
> Maciej, I assume you built a kernel for one of the Au1x boards before
> you applied the patch ;)?
> 
> Pete
> 
>
