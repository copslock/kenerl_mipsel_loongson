Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2007 16:32:28 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:40150 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20021952AbXEHPcX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 May 2007 16:32:23 +0100
Received: from pony1.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l48FWCr5004424
	for <linux-mips@linux-mips.org>; Tue, 8 May 2007 11:32:12 -0400
Received: (from apache@localhost)
	by pony1.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l48FWCf6000304;
	Tue, 8 May 2007 11:32:12 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 8 May 2007 11:32:12 -0400 (EDT)
Message-ID: <55716.129.133.92.31.1178638332.squirrel@webmail.wesleyan.edu>
In-Reply-To: <Pine.LNX.4.64.0705080920150.24717@anakin>
References: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu>
    <876473x0jx.wl@betelheise.deep.net>
    <Pine.LNX.4.64.0705080920150.24717@anakin>
Date:	Tue, 8 May 2007 11:32:12 -0400 (EDT)
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
X-archive-position: 14996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

> On Tue, 8 May 2007, Samium Gromoff wrote:
>> At Tue, 8 May 2007 02:24:20 -0400 (EDT),
>> sknauert@wesleyan.edu wrote:
>> [snip]
>> > 3) I tried a Voodoo 1, ATI Mach 64, S3 Virge DX, GX, etc., I actually
>> have
>> > a Millenium I but it won't fit in the O2.
>>
>> Are you sure those have/need not to have proper BIOSen flashed onto
>> them?
>>
>> As i imagine, a videocard with x86 cr^Bode flashed into it is pretty
>> useless,
>> or worse than useless, on anything but x86...
>
> You can run the x86 emulator to execute the BIOS code. IIRC, (some version
> of)
> the X server has such an emulator included.  But that indeeds need `legacy
> I/O
> port' access to work.
>
> It's a pity the Millenium doesn't fit, as matroxfb is about the only
> frame buffer device that can initialize a graphics card from scratch,
> without help from the BIOS...
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
> 							    -- Linus Torvalds
>

X.org should have the x86 emulation, it's called Int10 and I have enabled
it. However, I get the following errors:

(EE) end of block range 0x1ffffef < begin 0xfffffff0
(EE) end of block range 0xfef < begin 0xffffff0

with all my cards when I try to use it. These are repeated many times, I
can provide full error logs if anybody wants. My guess is this is
indicating I'm lacking proper support for the emulation to work correctly,
whether this is framebuffer support or purely legacy addressing.
