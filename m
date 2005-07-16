Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2005 12:26:42 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.188]:43759
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226776AbVGPL01>; Sat, 16 Jul 2005 12:26:27 +0100
Received: from pD95281BF.dip0.t-ipconnect.de [217.82.129.191] (helo=gaspode.madsworld.lan)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwh2-1Dtkpj473w-0001wU; Sat, 16 Jul 2005 13:27:51 +0200
Received: from mad by gaspode.madsworld.lan with local (Exim 4.50)
	id 1Dtkpe-0003TA-3H
	for linux-mips@linux-mips.org; Sat, 16 Jul 2005 13:27:46 +0200
Date:	Sat, 16 Jul 2005 13:27:46 +0200
From:	Markus Dahms <mad@automagically.de>
To:	linux-mips@linux-mips.org
Subject: Re: New VINO video drivers for Indy
Message-ID: <20050716112745.GA12716@gaspode.automagically.de>
References: <42D4BF49.4040907@mbnet.fi> <20050715110021.GA15740@gaspode.automagically.de> <42D83063.3060505@mbnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D83063.3060505@mbnet.fi>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:896705dcda322f33ae3752a7fdb3dc09
Return-Path: <mad@automagically.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mad@automagically.de
Precedence: bulk
X-list: linux-mips

Hello again,

>> I only get a bla[nc]k image ...
> That's strange. There might be some problems with IndyCam initialization 
> (register values),
> but usually you should be able to get at least a very dark picture.
> Removing and reinstalling the module (indycam.ko) reinitializes the
> camera so you can try that. IndyCam seems to use some very odd logic
> to decide how bright the picture should be.
> Try bringing some very bright light sources near the camera ?

For some reason it's working now. It's not significantly brighter, I
just checked the camera with kernel 2.4.x before booting 2.6.12.
If I can reproduce the failure I'll write it.
The picture has the same "quality" as with the other driver except
there _are_ fewer horizontal lines (they appear mostly on fast-moving
pictures).

Markus
