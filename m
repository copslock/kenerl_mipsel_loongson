Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 15:47:42 +0000 (GMT)
Received: from [62.38.115.213] ([62.38.115.213]:3972 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8133500AbWAQPrY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 15:47:24 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 4747B1F31B;
	Tue, 17 Jan 2006 17:50:39 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: undefined reference to `__lshrdi3' error with GCC 4.0
Date:	Tue, 17 Jan 2006 17:50:20 +0200
User-Agent: KMail/1.9
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
References: <20060117134838.GJ27047@deprecation.cyrius.com> <200601171617.16147.p_christ@hol.gr> <20060117151449.GF3336@linux-mips.org>
In-Reply-To: <20060117151449.GF3336@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601171750.22746.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Tuesday 17 January 2006 5:14 pm, Ralf Baechle wrote:
> On Tue, Jan 17, 2006 at 04:17:14PM +0200, P. Christeas wrote:
> > On Tuesday 17 January 2006 3:48 pm, Martin Michlmayr wrote:
> > > Has anyone else seen the following error when compiling a kernel with
> > > GCC 4.0 (GCC 3.3 works) and knows what to do about it?
> > >
> > > arch/mips/kernel/built-in.o: In function `time_init':
> > > : undefined reference to `__lshrdi3'
> >
> > I think I've solved it by copying the files
> > ashldi3.c ashrdi3.c lshrdi3.c
> > from arch/ppc/lib to arch/mips/lib
>
> No such files in arch/ppc/lib?  Oh well, doesn't matter.
It was from m68k  :S 

>
> > The patch for 2.6 is:
>
> struct DIstruct seems broken for little endian.
What consequences does that have?

>
>   Ralf
