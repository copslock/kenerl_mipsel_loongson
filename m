Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2005 16:48:40 +0000 (GMT)
Received: from balu1.urz.unibas.ch ([IPv6:::ffff:131.152.1.51]:40682 "EHLO
	balu1.urz.unibas.ch") by linux-mips.org with ESMTP
	id <S8225934AbVCDQsY>; Fri, 4 Mar 2005 16:48:24 +0000
Received: from [131.152.55.200] (baobab.cs.unibas.ch [131.152.55.200])
	by balu1.urz.unibas.ch (8.12.10/8.12.10) with ESMTP id j24GmMTL025605
	for <linux-mips@linux-mips.org>; Fri, 4 Mar 2005 17:48:22 +0100
Message-ID: <4228916F.9070600@unibas.ch>
Date:	Fri, 04 Mar 2005 17:48:47 +0100
From:	Christophe Jelger <Christophe.Jelger@unibas.ch>
Organization: University of Basel
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Newbie : Cross-compiling module for wrt54g
References: <42272589.7000802@unibas.ch> <1109867344.9625.74.camel@localhost.localdomain>
In-Reply-To: <1109867344.9625.74.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SMTP-Vilter-Version: 1.1.8
X-SMTP-Vilter-Virus-Backend: savse
X-SMTP-Vilter-Status: clean
X-SMTP-Vilter-savse-Virus-Status: clean
X-SMTP-Vilter-Unwanted-Backend:	attachment
X-SMTP-Vilter-attachment-Unwanted-Status: clean
Return-Path: <Christophe.Jelger@unibas.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Christophe.Jelger@unibas.ch
Precedence: bulk
X-list: linux-mips

Thanks to people who replied ... I will spend some time trying to build 
the module and see what happens !

JP, I don't know if you meant compiling a standard (or a mips ?) 2.4 
kernel with gcc 3.4.1, but I know it works with gcc 3.3.5 for the 
standard kernel.

Regards
Christophe

JP wrote:
> (...)
> 
> You might need an older toolchain to build 2.4 kernels.
> Anyone have any success on build 2.4.x with gcc 3.x?
> 
> Don't take my word for it though I've been using a recentish gcc-3.4.1
> built using uclibc's buildroot to build 
> It was pretty easy to get working and install.
> 
> For our 2.4 kernels I used a montavista toolchain for the last few
> years. mvista.com requires you register.
> 
> Happy hacking
> 
