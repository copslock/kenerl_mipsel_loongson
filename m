Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 02:44:00 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:8378 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8226915AbVGTBnn>;
	Wed, 20 Jul 2005 02:43:43 +0100
Received: from port-195-158-170-19.dynamic.qsc.de ([195.158.170.19] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1Dv3eI-0003dA-00; Wed, 20 Jul 2005 03:45:26 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1Dv3eH-0005Nc-Ij; Wed, 20 Jul 2005 03:45:25 +0200
Date:	Wed, 20 Jul 2005 03:45:25 +0200
To:	Markus Dahms <mad@automagically.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
Message-ID: <20050720014525.GI2071@hattusa.textio>
References: <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl> <20050627141842.GA28236@gaspode.automagically.de> <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl> <20050628062107.GA8665@gaspode.automagically.de> <Pine.LNX.4.61L.0506280918380.13758@blysk.ds.pg.gda.pl> <20050628102013.GA10442@gaspode.automagically.de> <Pine.LNX.4.61L.0506281204190.13758@blysk.ds.pg.gda.pl> <20050628170425.GA5189@gaspode.automagically.de> <Pine.LNX.4.61L.0506291747550.31188@blysk.ds.pg.gda.pl> <20050719182102.GA3727@gaspode.automagically.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719182102.GA3727@gaspode.automagically.de>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Markus Dahms wrote:
> Hello Maciej,
> 
> [R4600PC problems]
> > Well, they are not meant to be errata-compatible. ;-)  I haven't been 
> > able to locate any reference for tlbp being problematic on the R4600, in 
> > particular not in the chip errata document, and the old handlers used to 
> > have a nop before that instruction unconditionally (perhaps just in case 
> > ;-) ), so the problem was covered.  If it fixes the problem for you, then 
> > it should probably be applied, too.
> 
> I just built a 64-bit kernel from clean CVS and had to apply the patch
> below again to get it to userspace. Maybe it just hides the real error
> but at least "it works for me" [tm].
> Please apply to CVS if there are no objections.
> 
> Markus
> 
> --- a/arch/mips/mm/tlbex.c    2005-07-19 20:12:32.000000000 +0200
> +++ b/arch/mips/mm/tlbex.c    2005-07-19 20:10:29.000000000 +0200
> @@ -779,6 +779,7 @@
>  static __init void __attribute__((unused)) build_tlb_probe_entry(u32 **p)
>  {
>     switch (current_cpu_data.cputype) {
> +   case CPU_R4600:
>     case CPU_R5000:
>     case CPU_R5000A:
>     case CPU_NEVADA:

FWIW, this patch makes no difference for my Indy with R4600 v2.0, it still
hangs, usually while or shortly after mounting filesystems.


Thiemo
