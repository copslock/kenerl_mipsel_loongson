Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2003 11:15:09 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:16604 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225210AbTFMKPG>;
	Fri, 13 Jun 2003 11:15:06 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h5DAEtpI019303
	for <linux-mips@linux-mips.org>; Fri, 13 Jun 2003 12:14:57 +0200 (MEST)
Date: Fri, 13 Jun 2003 12:14:55 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Corruption in 2.4.x
In-Reply-To: <Pine.GSO.4.21.0306111738200.6450-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.4.21.0306131209200.11546-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 11 Jun 2003, Geert Uytterhoeven wrote:
> Recently we started seeing slight file corruption and random segmentation
> faults with the 2.4.x MIPS kernel from CVS. The problems appeared after
> upgrading from 2.4.20 (CVS 2003-01-13) to 2.4.21-pre4 (CVS 2003-05-06), which
> introduced the new cache/tlb optimizations.
> 
> Most prominent indication of the file corruption is the corruption of
> /etc/motd, of which the non-first lines are rewritten by the startup scripts on
> every boot up.

Just to keep you informed...

Apparently this problem was not caused by Linux, but by the hardware. A few
hours after I sent the previous mail, my IDE disk started showing unrecoverable
read errors on some blocks.  According to the e2fsck badblocks test, /etc/motd
was on a bad block. So most probably the disk started returning wrong data
about one month ago, without detecting there was a read error (lousy ECC and
bad block remapping?).

Now the bad blocks are no longer in active use, everything works fine! Sorry
for the noise.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
