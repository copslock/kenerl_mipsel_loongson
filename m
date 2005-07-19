Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 19:19:35 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.186]:24543
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226897AbVGSSTR>; Tue, 19 Jul 2005 19:19:17 +0100
Received: from pD952892F.dip0.t-ipconnect.de [217.82.137.47] (helo=gaspode.madsworld.lan)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML29c-1DuwiC1hHh-0000T7; Tue, 19 Jul 2005 20:21:00 +0200
Received: from mad by gaspode.madsworld.lan with local (Exim 4.50)
	id 1DuwiE-00011A-Uh; Tue, 19 Jul 2005 20:21:02 +0200
Date:	Tue, 19 Jul 2005 20:21:02 +0200
From:	Markus Dahms <mad@automagically.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
Message-ID: <20050719182102.GA3727@gaspode.automagically.de>
References: <20050627100757.GA27679@gaspode.automagically.de> <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl> <20050627141842.GA28236@gaspode.automagically.de> <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl> <20050628062107.GA8665@gaspode.automagically.de> <Pine.LNX.4.61L.0506280918380.13758@blysk.ds.pg.gda.pl> <20050628102013.GA10442@gaspode.automagically.de> <Pine.LNX.4.61L.0506281204190.13758@blysk.ds.pg.gda.pl> <20050628170425.GA5189@gaspode.automagically.de> <Pine.LNX.4.61L.0506291747550.31188@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506291747550.31188@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:896705dcda322f33ae3752a7fdb3dc09
Return-Path: <mad@automagically.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mad@automagically.de
Precedence: bulk
X-list: linux-mips

Hello Maciej,

[R4600PC problems]
> Well, they are not meant to be errata-compatible. ;-)  I haven't been 
> able to locate any reference for tlbp being problematic on the R4600, in 
> particular not in the chip errata document, and the old handlers used to 
> have a nop before that instruction unconditionally (perhaps just in case 
> ;-) ), so the problem was covered.  If it fixes the problem for you, then 
> it should probably be applied, too.

I just built a 64-bit kernel from clean CVS and had to apply the patch
below again to get it to userspace. Maybe it just hides the real error
but at least "it works for me" [tm].
Please apply to CVS if there are no objections.

Markus

--- a/arch/mips/mm/tlbex.c    2005-07-19 20:12:32.000000000 +0200
+++ b/arch/mips/mm/tlbex.c    2005-07-19 20:10:29.000000000 +0200
@@ -779,6 +779,7 @@
 static __init void __attribute__((unused)) build_tlb_probe_entry(u32 **p)
 {
    switch (current_cpu_data.cputype) {
+   case CPU_R4600:
    case CPU_R5000:
    case CPU_R5000A:
    case CPU_NEVADA:
