Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 10:08:23 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:21246 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S3465568AbVJSJIB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2005 10:08:01 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j9J97tva023500;
	Wed, 19 Oct 2005 11:07:55 +0200 (MEST)
Date:	Wed, 19 Oct 2005 11:07:55 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	John Levon <levon@movementarian.org>
cc:	David Daney <ddaney@avtrex.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	oprofile-list@lists.sourceforge.net,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [Patch] Fix lookup_dcookie for MIPS o32
In-Reply-To: <20051018233653.GA1044@trollied.org>
Message-ID: <Pine.LNX.4.62.0510191107420.25580@numbat.sonytel.be>
References: <17236.6951.865559.479107@dl2.hq2.avtrex.com>
 <20051018114526.GC2656@linux-mips.org> <20051018232442.GA29235@trollied.org>
 <435586D8.4040407@avtrex.com> <20051018233653.GA1044@trollied.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 19 Oct 2005, John Levon wrote:
> On Tue, Oct 18, 2005 at 04:35:52PM -0700, David Daney wrote:
> > I just did a cvs update and see no change.  Perhaps I misunderstand. 
> > Would you like me to make and test a patch?  I could...
> 
> anoncvs takes a while to update I think.

AFAIK, it's no longer updated. Use git.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
