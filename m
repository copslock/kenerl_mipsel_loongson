Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2007 16:05:25 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:50898 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20022226AbXEHPFX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 May 2007 16:05:23 +0100
Received: from pony1.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l48F26Ks000364
	for <linux-mips@linux-mips.org>; Tue, 8 May 2007 11:02:07 -0400
Received: (from apache@localhost)
	by pony1.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l48F261g025322;
	Tue, 8 May 2007 11:02:06 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 8 May 2007 11:02:06 -0400 (EDT)
Message-ID: <38827.129.133.92.31.1178636526.squirrel@webmail.wesleyan.edu>
In-Reply-To: <20070508140457.13458d63.attila@kinali.ch>
References: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu>
    <876473x0jx.wl@betelheise.deep.net>
    <Pine.LNX.4.64.0705080920150.24717@anakin>
    <20070508140457.13458d63.attila@kinali.ch>
Date:	Tue, 8 May 2007 11:02:06 -0400 (EDT)
Subject: Re: PCI video card on SGI O2
From:	sknauert@wesleyan.edu
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-Originating-IP: 129.133.6.192
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

> On Tue, 8 May 2007 09:22:02 +0200 (CEST)
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> It's a pity the Millenium doesn't fit, as matroxfb is about the only
>> frame buffer device that can initialize a graphics card from scratch,
>> without help from the BIOS...
>
> Why does the Millenium not fit?
> I'm asking because OGP might be a good replacement
> card for such systems (when it will be finished).
> And if the Millenium has some problems working in such
> systems, we could try not to do the same mistake with OGP.
>
> 			Attila Kinali
> --
> Praised are the Fountains of Shelieth, the silver harp of the waters,
> But blest in my name forever this stream that stanched my thirst!
>                          -- Deed of Morred
>
>
Wow, so many responses... I'll try to answer everyone. The O2, has a PCI
cage on a daughter card which is 6.875" deep. A 64-bit PCI card with no
overhang will just barely fit.

You can see images of the PCI cage here:
http://hardware.majix.org/computers/sgi.o2/images/o2.18.big.jpg
http://hardware.majix.org/computers/sgi.o2/images/o2.26.big.jpg

The Millenium I that I have does not fit, physically. It is 7.5" deep. I
already removed the metal cage (only using the daughter board), but the
end of the metal cage butts up against the metal housing, so while I might
be able to fit a 7.25" PCI card this way (though it would be unsupported
and this might not be the best idea) 7.5" is just too big. For example, I
have a 3ware Escalade 8500 which is 7" deep and does not fit. It would fit
without the metal cage (I only mention since its a PCI 64-bit card I have
handy, I know putting an SATA RAID card into an O2 would be silly).

If the Open Graphics Project (assuming this is the OGP you refer to) board
does not have overhang, i.e. it is just the size of a 32 or even 64 bit
PCI slot, it will fit the O2 just fine.
