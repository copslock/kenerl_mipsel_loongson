Received:  by oss.sgi.com id <S553700AbQKRRVq>;
	Sat, 18 Nov 2000 09:21:46 -0800
Received: from u-248.karlsruhe.ipdial.viaginterkom.de ([62.180.21.248]:11528
        "EHLO u-248.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553671AbQKRRVb>; Sat, 18 Nov 2000 09:21:31 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868506AbQKRRVP>;
        Sat, 18 Nov 2000 18:21:15 +0100
Date:   Sat, 18 Nov 2000 18:21:15 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:     linux-cvs@oss.sgi.com, linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20001118182114.A19710@bacchus.dhis.org>
References: <20001118132233Z553804-494+838@oss.sgi.com> <XFMail.001118180639.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <XFMail.001118180639.Harald.Koerfgen@home.ivm.de>; from Harald.Koerfgen@home.ivm.de on Sat, Nov 18, 2000 at 06:06:39PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Nov 18, 2000 at 06:06:39PM +0100, Harald Koerfgen wrote:

> On 18-Nov-00 Ralf Baechle wrote:
> > CVSROOT:      /home/pub/cvs
> > Module name:  linux
> > Changes by:   ralf@oss.sgi.com        00/11/18 05:22:32
> > 
> > Modified files:
> >       Documentation  : Configure.help 
> >       arch/mips      : config.in 
> >       arch/mips/mm   : r4xx0.c 
> > 
> > Log message:
> >       New configuration option CONFIG_MIPS_UNCACHED.  Not yet selectable due
> >       to the manuals documenting ll/sc operation as undefined for uncached
> >       memory.
> 
> Wouldn't it make sense then to disable CONFIG_CPU_HAS_LLSC as well?

I'm waiting for authoritative answer from silicon guys before I deciede.
In the past I ran kernel entirely uncached and they seemed to work even
though the documentation made me assume the opposite.

  Ralf
