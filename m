Received:  by oss.sgi.com id <S553858AbRCHQh7>;
	Thu, 8 Mar 2001 08:37:59 -0800
Received: from u-45-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.45]:55556
        "EHLO u-45-19.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553719AbRCHQhw>; Thu, 8 Mar 2001 08:37:52 -0800
Received: from dea ([193.98.169.28]:899 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S867055AbRCHQhd>;
	Thu, 8 Mar 2001 17:37:33 +0100
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f28GbOG14462;
	Thu, 8 Mar 2001 17:37:24 +0100
Date:	Thu, 8 Mar 2001 17:37:24 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Jeff Harrell <jharrell@ti.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: Question concerning Assembler error
Message-ID: <20010308173724.A11107@bacchus.dhis.org>
References: <3AA7B13F.F918E1F8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AA7B13F.F918E1F8@ti.com>; from jharrell@ti.com on Thu, Mar 08, 2001 at 09:20:15AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Mar 08, 2001 at 09:20:15AM -0700, Jeff Harrell wrote:

>         /* Interrupt : For now we simply disable interrupts and
>      return */
> 
>              MFC0(   k0, C0_STATUS)
>              srl     k0, 1
>              sll     k0, 1
>              MTC0(   k0, C0_STATUS)
>              nop
>              .set    mips3
>      ==>  eret   <==
>              .set    mips2
>              nop
> 
> 
> Any information that anyone might have would be greatly appreciated.

I suggest to run this code through the preprocessor only using the
-E -C options.  The output will be somewhat cryptic but explain much better
what's wrong.

  Ralf
