Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2008 04:03:33 +0200 (CEST)
Received: from web38804.mail.mud.yahoo.com ([209.191.125.95]:42597 "HELO
	web38804.mail.mud.yahoo.com") by lappi.linux-mips.net with SMTP
	id S531983AbYCaCD3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Mar 2008 04:03:29 +0200
Received: (qmail 48216 invoked by uid 60001); 31 Mar 2008 02:02:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=bjjBYVO6w2d0i0B0D+PtzjTMzSx0bvRtKoQ7GP6RCGPmOksiopnC61ov+e9Adt5Z/xjY2Ycx6daTLKAG3IsIY3/j66oh7lMrh6VJejTJvbfK6cHLibS18wjNmuyepLC50PJ1N67EmSF+oX0Z6bAUC/Mg9nPE1JTdC1qC5ayg0yA=;
X-YMail-OSG: JArq3YwVM1l4iP64LHT.HfXo0BGUUC_Z9yr4gC5GA6vkM3r4lZga_85Gkjz1vDoDizRPhpelQWJIeDfIuU7IRFPBnGHZEbPULULv3e2BZEJKCBU-
Received: from [24.34.110.3] by web38804.mail.mud.yahoo.com via HTTP; Sun, 30 Mar 2008 19:02:12 PDT
Date:	Sun, 30 Mar 2008 19:02:12 -0700 (PDT)
From:	Larry Stefani <lstefani@yahoo.com>
Subject: Re: SB1250 locking up in init on current 2.6.16 kernel
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080328171146.GA23320@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <117918.44850.qm@web38804.mail.mud.yahoo.com>
Return-Path: <lstefani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lstefani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Thiemo,

I went back to 2.6.16.60, reverted your patch changes,
then removed the

  if (cpu_has_dc_aliases) {

conditional expression in three places in
include/asm-mips/mach-generic/ide.h.

Unfortunately, I get the same lockup as before.

- Larry

--- Thiemo Seufer <ths@networkno.de> wrote:

> Larry Stefani wrote:
> > Hi Thiemo,
> > 
> > I applied your patch (from
> >
>
http://www.linux-mips.org/archives/linux-mips/2008-03/msg00001.html)
> > on 2.6.16.60, and also patched
> arch/mips/mm/c-sb1.c to
> > remove:
> > 
> >           local_flush_data_cache_page = (void *)
> > sb1_nop;
> > 
> > in order to compile after your changes to cache.c
> and
> > cacheflush.h.  However, this did not work on my
> board,
> > and I experienced the same lockup as before.
> 
> Stick with the original 2.6.16.60 code but try to
> remove the
> 
>    if (cpu_has_dc_aliases) {
> 
> conditional in ide.h _without_ using my patch. This
> is what made
> it boot for me.
> 
> > >>Keep in mind that this is a crude workaround on
> top
> > of other cache code hacks for the SB-1.
> > 
> > What other "cache code hacks for SB-1"?  Are there
> > additional changes required to 2.6.16.60 to make
> SB1
> > work properly?  Did you post those hacks
> somewhere?
> 
> No, what I meant to say is that the old sb-1 cache
> code isn't quite
> the most trustibe code, it had some holes which were
> papered over
> by doing more cache flushes than necessary.
> 
> 
> Thiemo
> 




      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ
