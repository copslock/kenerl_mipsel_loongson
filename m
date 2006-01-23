Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 15:47:35 +0000 (GMT)
Received: from [62.38.115.213] ([62.38.115.213]:16013 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S3465572AbWAWPrM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 15:47:12 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 2E14C1F742;
	Mon, 23 Jan 2006 17:51:10 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
Date:	Mon, 23 Jan 2006 17:50:53 +0200
User-Agent: KMail/1.9
Cc:	MIPS Linux List <linux-mips@linux-mips.org>
References: <20060123150507.GA18665@linux-mips.org> <200601231718.40581.p_christ@hol.gr> <20060123153715.GC18665@linux-mips.org>
In-Reply-To: <20060123153715.GC18665@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601231750.55246.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Monday 23 January 2006 5:37 pm, Ralf Baechle wrote:
> On Mon, Jan 23, 2006 at 05:18:38PM +0200, P. Christeas wrote:
> > On Monday 23 January 2006 5:05 pm, Ralf Baechle wrote:
> > > I'd appreciate if somebody with gcc 4.0.1 could test this kernel patch
> > > below.
> > >
> > >   Ralf
> >
> > Is that for 2.4?
>
> 2.4 is a no go for all architectures with gcc >= 4.0.0 and in case of MIPS
> even gcc 3.4 is somewhat dubious.
>
> > 2.6 doesn't seem to have that problem..
>
> It's probably a matter of configuration then.  Basically with our current
> uaccess.h and gcc >= 4.0.1 the attempt to pass a pointer to a const
> variable as the pointer argument to get_user or __get_user will blow up.
> It's always been a bug - but gcc before 4.0.1 were accepting this
> silently.
>
>   Ralf

I 've been compiling with gcc 4.0.2 (my tree is Linus') and haven't seen any 
message like that. It all compiles fine. Is there a point in testing your 
patch as well?
