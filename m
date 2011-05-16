Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 21:41:07 +0200 (CEST)
Received: from astoria.ccjclearline.com ([64.235.106.9]:51725 "EHLO
        astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491069Ab1EPTlC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2011 21:41:02 +0200
Received: from [4.79.116.67] (helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1QM3ew-00067n-Uu; Mon, 16 May 2011 15:40:55 -0400
Date:   Mon, 16 May 2011 15:40:18 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost6.localdomain6
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: reference to non-existent CONFIG_HAVE_GPIO_LIB variable?
In-Reply-To: <20110516155721.GA27664@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1105161538510.7547@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105141904410.13343@localhost6.localdomain6> <20110516155721.GA27664@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips

On Mon, 16 May 2011, Ralf Baechle wrote:

> On Sat, May 14, 2011 at 07:05:58PM -0400, Robert P. J. Day wrote:
>
> >   the current kernel source contains a Makefile reference to the above
> > Kconfig variable that does not appear to be defined anywhere.
>
> Commit 7444a72effa632fcd8edc566f880d96fe213c73b ["gpiolib: allow
> user- selection"] plus the fixups in commit
> 09cd9527d621640d4dd231dff77b681e711d8e4b ["gpiolib: fix
> HAVE_GPIO_LIB leftovers in asm-generic/gpio.h"] and maybe others
> changed the symbol name.  Somehow this instance was missed - maybe
> because the code was merged around the same timeframe.

  well, i'll just leave this with someone here, you can decide the
best way to resolve this.

rday

p.s.  if memory serves, there was another MIPS-related config variable
that was unreferenced.  i'll see if i can track it down.


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
