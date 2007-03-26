Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 10:48:10 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:21987 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022653AbXCZJsH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2007 10:48:07 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id CE53CBB3BD;
	Mon, 26 Mar 2007 11:41:56 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HVliV-0003Bh-IQ; Mon, 26 Mar 2007 10:42:19 +0100
Date:	Mon, 26 Mar 2007 10:42:19 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, kumba@gentoo.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Message-ID: <20070326094219.GB23564@networkno.de>
References: <20070324.234727.25910303.anemo@mba.ocn.ne.jp> <20070324231602.GP2311@networkno.de> <46062400.8080307@gentoo.org> <20070326.011000.75185255.anemo@mba.ocn.ne.jp> <20070325164008.GA29334@linux-mips.org> <cda58cb80703260214y536d871dq20575ce32da9cd07@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80703260214y536d871dq20575ce32da9cd07@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> On 3/25/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> >Note IP27 works fine either way and the code size difference is 
> >considerable:
> >Here are numbers for ip27_defconfig with gcc 4.1.2 and binutils 2.17:
> >
> >   text    data     bss     dec     hex filename
> >3397944  415768  256816 4070528  3e1c80 vmlinux BUILD_ELF64=n
> >3774968  415768  248624 4439360  43bd40 vmlinux BUILD_ELF64=y
> >
> 
> Impressive figures !
> 
> However I can't understand why there's a such difference, I'm surely
> missing something. AFAIK, we're not doing so many symbol loads in the
> kernel ?

Yes we do, for many local symbols. It's the reason why the toolchain
has a -msym32 switch now.


Thiemo
