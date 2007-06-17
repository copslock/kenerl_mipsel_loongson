Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2007 09:07:09 +0100 (BST)
Received: from agave.telenet-ops.be ([195.130.137.77]:45289 "EHLO
	agave.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022472AbXFQIHF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 Jun 2007 09:07:05 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by agave.telenet-ops.be (Postfix) with SMTP id D15C867D50;
	Sun, 17 Jun 2007 10:07:04 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by agave.telenet-ops.be (Postfix) with ESMTP id D71C367D3F;
	Sun, 17 Jun 2007 10:07:03 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-4) with ESMTP id l5H871xs005074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 17 Jun 2007 10:07:02 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l5H86w39005069;
	Sun, 17 Jun 2007 10:06:59 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Sun, 17 Jun 2007 10:06:55 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
cc:	linux-mips@linux-mips.org, qemu-devel@nongnu.org
Subject: Re: 2.6.21 kernel on emulated/real Malta board
In-Reply-To: <20070616204834.GA610@farad.aurel32.net>
Message-ID: <Pine.LNX.4.64.0706171005470.4497@anakin>
References: <20070616204834.GA610@farad.aurel32.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sat, 16 Jun 2007, Aurelien Jarno wrote:
> Since I switch to 2.6.21 kernel on my emulated Malta board (QEMU), I
> have noticed something strange. The kernel starts to boot up to the
> timer calibration, and then it restart the boot again. A small example:
> 
>   ...
> 
>   Primary data cache 0kB, 4-way, linesize 0 bytes.
>   Synthesized TLB refill handler (36 instructions).
>   Synthesized TLB load handler fastpath (48 instructions).
>   Synthesized TLB store handler fastpath (48 instructions).
>   Synthesized TLB modify handler fastpath (47 instructions).
>   Enable cache parity protection for MIPS 20KC/25KF CPUs.
>   PID hash table entries: 512 (order: 9, 4096 bytes)
>   CPU frequency 100.00 MHz
>   Using 100.003 MHz high precision timer.
>   Linux version 2.6.21.1 (aurel32@i386) (gcc version 4.1.1 ()) #1 Tue May 15 12:22:07 CEST 2007
> 
>   LINUX started...
>   CPU revision is: 000182a0
>   FPU revision is: 000f8200
> 
>   ...
> 
> I have traced the problem down to the CONFIG_EARLY_PRINTK option. 
> Disabling it in the .config file (be aware that running make *config 
> will reenable this function), removes the problem.

I guess it's just the printk buffer that's being output again to the new
console, when the console subsystem switches from early console to real
console.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
