Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 13:45:23 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:33809 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226044AbVF1MpG>; Tue, 28 Jun 2005 13:45:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B2E9BE1C91; Tue, 28 Jun 2005 14:44:34 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31524-07; Tue, 28 Jun 2005 14:44:34 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 64E1FE1CA2; Tue, 28 Jun 2005 14:44:34 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5SCiZGm027653;
	Tue, 28 Jun 2005 14:44:35 +0200
Date:	Tue, 28 Jun 2005 13:44:42 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Stephen P. Becker" <geoman@gentoo.org>
Cc:	Markus Dahms <mad@automagically.de>, linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
In-Reply-To: <42C14151.5050209@gentoo.org>
Message-ID: <Pine.LNX.4.61L.0506281339080.13758@blysk.ds.pg.gda.pl>
References: <20050627100757.GA27679@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl>
 <20050627141842.GA28236@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl>
 <20050628062107.GA8665@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506280918380.13758@blysk.ds.pg.gda.pl>
 <20050628102013.GA10442@gaspode.automagically.de> <42C14151.5050209@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/959/Tue Jun 28 01:00:06 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Jun 2005, Stephen P. Becker wrote:

> I haven't tried a 32-bit kernel since 2.6.12_rc2 or so, however when I
> did, everything seemed to work just fine, while a 64-bit kernel compiled
> from the same checkout had the same problems I mention above.  At one
> point I was trying to work out when this was introduced, and I *think*
> it was the initial 2.6.11 merge, but I would have to double check that.
>  I've been running a 64-bit 2.6.10 checkout since the beginning of the
> year on that box, and the machine has been very stable.

 It's either not 2.6.11 or it must be something platform-specific (here 
meaning the specific CPU model and/or system type) as 2.6.12-rc1 as of the 
end of March seems to be rock-solid running 64-bit on the BCM1250.  Or 
perhaps SMP works and only UP does not. ;-)

  Maciej
