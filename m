Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 01:26:06 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:8716 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225209AbUJKA0B>; Mon, 11 Oct 2004 01:26:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6597BF5945; Mon, 11 Oct 2004 02:25:58 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12010-07; Mon, 11 Oct 2004 02:25:58 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 2FB3AE1D01; Mon, 11 Oct 2004 02:25:58 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.12.11) with ESMTP id i9B0QCKU012026;
	Mon, 11 Oct 2004 02:26:13 +0200
Date: Mon, 11 Oct 2004 01:25:58 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH
In-Reply-To: <4169BCA6.1080102@embeddedalley.com>
Message-ID: <Pine.LNX.4.58L.0410110102440.4217@blysk.ds.pg.gda.pl>
References: <1097428659.4627.10.camel@localhost.localdomain>
 <Pine.GSO.4.61.0410102000530.5826@waterleaf.sonytel.be>
 <Pine.LNX.4.58L.0410102004190.4217@blysk.ds.pg.gda.pl> <4169BCA6.1080102@embeddedalley.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 10 Oct 2004, Pete Popov wrote:

> > If not, why not use a data type that covers
> > valid offsets only when passing addresses to bus access functions? 
> 
> The attribute and memory pcmcia addresses are just stored in these 
> variables, and then the upper pcmcia stack layer calls ioremap on these 
> addresses. Thus, you need the 36 bit I/O address patch, as well as the 
> tiny pcmcia patch.
> 
> The pcmcia I/O address is ioremapped at the socket driver level. If that 
> was the case with the mem and attribute addresses, I wouldn't need this 
> 64 bit pcmcia patch. But since it's the upper pcmcia layer that ioremaps 
> these addresses, I need to store tham in 64 bit types.

 OK, but then phys_t should be used for ioaddr_t universally, shouldn't
it?  Any architecture can have the controller seen in a 64-bit memory
space, after all.

  Maciej
