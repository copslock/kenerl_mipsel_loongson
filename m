Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jul 2005 00:09:49 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.201]:65011 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226180AbVGAXJd> convert rfc822-to-8bit;
	Sat, 2 Jul 2005 00:09:33 +0100
Received: by wproxy.gmail.com with SMTP id 70so446920wra
        for <linux-mips@linux-mips.org>; Fri, 01 Jul 2005 16:09:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F+opu++hZWxsj9cnBbBb+ZAVbAdDnyJhWoQUlVpgDnglp/HtGx6YUYqYl0vhv3Vq+zDB47u9R61Le5hu+jYVTlTWuCaeTBQhBhxB/3QzLMGiYjT4mJWvgNerb5/JOLXsNjHyutYFvLdciM2rjus2fDOasOWll2mIHBWVF5lbfrw=
Received: by 10.54.51.8 with SMTP id y8mr2035620wry;
        Fri, 01 Jul 2005 16:09:27 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Fri, 1 Jul 2005 16:09:26 -0700 (PDT)
Message-ID: <2db32b7205070116091240fcf4@mail.gmail.com>
Date:	Fri, 1 Jul 2005 16:09:26 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	Wolfgang Denk <wd@denx.de>
Subject: Re: glibc based toolchain for mips
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050701230056.D09EC353A36@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b72050630155831582cd7@mail.gmail.com>
	 <20050701230056.D09EC353A36@atlas.denx.de>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Sorry I didn't say it clearly.

The files in /opt/eldk/mips_4KCle are in little endian mips, for sure. 
What I want is a cross-development tools for i386-to-mipsel, including
the corss gcc, binutils, other libs. I couldn't find such tools :(

thanks



On 7/1/05, Wolfgang Denk <wd@denx.de> wrote:
> In message <2db32b72050630155831582cd7@mail.gmail.com> you wrote:
> >
> > I download the package. after installation,  the 4KCle is still
> > linking to the mips-linux-, which is big-endian.
> 
> Please explain exactly what you did.
> 
> We have kernel, all libraries and apps running in  this  environment,
> and if I check it looks very much like little endinan, for example:
> 
> $ file /opt/eldk/mips_4KCle/bin/bash
> /opt/eldk/3.1.1/mips_4KCle/bin/bash: ELF 32-bit LSB executable, MIPS, version 1 (SYSV), for GNU/Linux 2.4.0, dynamically linked (uses shared libs), stripped
> 
> versus
> 
> $ file /opt/eldk/mips_4KC/bin/bash
>  /opt/eldk/3.1.1/mips_4KC/bin/bash: ELF 32-bit MSB executable, MIPS, version 1 (SYSV), for GNU/Linux 2.4.0, dynamically linked (uses shared libs), stripped
> 
> 
> Best regards,
> 
> Wolfgang Denk
> 
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> CONSUMER NOTICE:  Because  of  the  "Uncertainty  Principle,"  It  Is
> Impossible  for  the  Consumer  to  Find  Out  at  the Same Time Both
> Precisely Where This Product Is and How Fast It Is Moving.
> 
>
