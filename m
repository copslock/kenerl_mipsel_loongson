Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 13:25:12 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:41936 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225241AbUC3MZL>;
	Tue, 30 Mar 2004 13:25:11 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i2UCP6dU014251;
	Tue, 30 Mar 2004 14:25:07 +0200 (MEST)
Date: Tue, 30 Mar 2004 14:25:06 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ronen Shitrit <rshitrit@il.marvell.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: mips-linux cross-compiler
In-Reply-To: <40692540.9090800@il.marvell.com>
Message-ID: <Pine.GSO.4.58.0403301424160.7557@waterleaf.sonytel.be>
References: <40692540.9090800@il.marvell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 30 Mar 2004, Ronen Shitrit wrote:
> I have a mips-linux cross compiler on i686 host, which is using gcc 2.95.3 .
> This compiler doesn't support the MIPS 4 Instruction Set,
> So I'm trying to build a new mips-linux cross compiler using any gcc 3.3/2.*
> but without any luck,
> Did anyone succeed to build such a cross compiler??
> which gcc and binutils version did you use??
> what are the configure flags you used??
> Did you used any special steps?? (except for configure ... , make, make
> install )

`apt-get install toolchain-source' and follow the instructions in
/usr/share/doc/toolchain-source/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
