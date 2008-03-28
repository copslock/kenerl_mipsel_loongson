Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 17:39:21 +0100 (CET)
Received: from web38813.mail.mud.yahoo.com ([209.191.125.104]:28782 "HELO
	web38813.mail.mud.yahoo.com") by lappi.linux-mips.net with SMTP
	id S528921AbYC1QjR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Mar 2008 17:39:17 +0100
Received: (qmail 71770 invoked by uid 60001); 28 Mar 2008 16:38:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Fmv1M4lH6f87HeG+Na6+WyCIKzNkWqBYwmXAvY7VJM9ZlEBda57wFaHIKFDEiBcKObkvGoKoxsIMMHoMoKeaZqswoEoEqdIGJfef8cigj8l724hJ6BAONvUT0GNTbX1vjfLIMyhInxE4r3Is2IX2Ekb2dLEOILVrCDJd0oD8Bac=;
X-YMail-OSG: 9H.BJv4VM1lFrrM7I7gYqqm_1eu1EURTDzRmGZZF
Received: from [68.236.82.170] by web38813.mail.mud.yahoo.com via HTTP; Fri, 28 Mar 2008 09:38:11 PDT
Date:	Fri, 28 Mar 2008 09:38:11 -0700 (PDT)
From:	Larry Stefani <lstefani@yahoo.com>
Subject: Re: SB1250 locking up in init on current 2.6.16 kernel
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080328134317.GA21099@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <54971.71316.qm@web38813.mail.mud.yahoo.com>
Return-Path: <lstefani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lstefani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Thiemo,

I applied your patch (from
http://www.linux-mips.org/archives/linux-mips/2008-03/msg00001.html)
on 2.6.16.60, and also patched arch/mips/mm/c-sb1.c to
remove:

          local_flush_data_cache_page = (void *)
sb1_nop;

in order to compile after your changes to cache.c and
cacheflush.h.  However, this did not work on my board,
and I experienced the same lockup as before.

>>Keep in mind that this is a crude workaround on top
of other cache code hacks for the SB-1.

What other "cache code hacks for SB-1"?  Are there
additional changes required to 2.6.16.60 to make SB1
work properly?  Did you post those hacks somewhere?

Thanks,
Larry


--- Thiemo Seufer <ths@networkno.de> wrote:

> Larry Stefani wrote:
> > Hi Ralf,
> > 
> > I used git bisect and narrowed the lockup to the
> > "[MIPS] Retire flush_icache_page from mm use."
> patch
> > (see git results below).  This is consistent with
> my
> > earlier testing and what Thiemo reported March 3
> on
> > the linux.debian.kernel list.  I tried his patch
> (mark
> > pages tainted by PIO IDE as dirty) on 2.6.16.60,
> but
> > it didn't prevent the lockup.
> 
> ISTR I got 2.6.16.60 to work by always enabling the
> cache flush in
> ide.h (it is currently only run to clean out
> aliases). Keep in mind
> that this is a crude workaround on top of other
> cache code hacks for
> the SB-1.
> 
> 
> Thiemo
> 



      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
