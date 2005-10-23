Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Oct 2005 01:21:26 +0100 (BST)
Received: from smtp1-g19.free.fr ([212.27.42.27]:59291 "EHLO smtp1-g19.free.fr")
	by ftp.linux-mips.org with ESMTP id S3465746AbVJWAVE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 23 Oct 2005 01:21:04 +0100
Received: from groumpf (str90-1-82-238-123-182.fbx.proxad.net [82.238.123.182])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 34AF75E019;
	Sun, 23 Oct 2005 02:21:00 +0200 (CEST)
Received: from jekyll ([192.168.1.1])
	by groumpf with esmtp (Exim 4.50)
	id 1ETTbg-000168-5T; Sun, 23 Oct 2005 02:21:00 +0200
Received: from arnaud by jekyll with local (Exim 4.50)
	id 1ETTbf-0004nP-Sb; Sun, 23 Oct 2005 02:20:59 +0200
To:	linux-mips@linux-mips.org, linux-parport@lists.infradead.org
Cc:	linux-kernel@vger.kernel.org
Subject: [PATCH] Parallel port support for SGI O2
From:	Arnaud Giersch <arnaud.giersch@free.fr>
X-Face:	&yL?ZRfSIk3zaRm*dlb3R4f.8RM"~b/h|\wI]>pL)}]l$H>.Q3Qd3[<h!`K6mI=+cWpg-El
 B(FEm\EEdLdS{2l7,8\!RQ5aL0ZXlzzPKLxV/OQfrg/<t!FG>i.K[5isyT&2oBNdnvk`~y}vwPYL;R
 y)NYo"]T8NlX{nmIUEi\a$hozWm#0GCT'e'{5f@Rl"[g|I8<{By=R8R>bDe>W7)S0-8:b;ZKo~9K?'
 wq!G,MQ\eSt8g`)jeITEuig89NGmN^%1j>!*F8~kW(yfF7W[:bl>RT[`w3x-C
Date:	Sun, 23 Oct 2005 02:20:59 +0200
Message-ID: <871x2d3wyc.fsf@groumpf.homeip.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.giersch@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.giersch@free.fr
Precedence: bulk
X-list: linux-mips

Hello,

I wrote a low-level parallel port driver for the built-in port on SGI
O2 (a.k.a. IP32).

The parallel port is driven by a standard ECP chipset, with
memory-mapped I/O registers.  That's why it was not possible to use
the parport_pc module which assumes port-mapped I/O registers.

What works:
    * Basic modes are supported: PCSPP, PS2.
    * Compatibility mode with FIFO support is present.
    * FIFO can be driven with or without interrupts.

What does not work: 
    * DMA support is not implemented (lack of documentation). If you
      have any information, please tell me.
    * EPP and ECP modes are not implemented (lack of interest). I
      currently do not own any peripheral supporting this extended
      modes. It should not be too difficult to do.

All tests were done with an HP LaserJet 5MP connected to a R5000 SGI
O2.

The module is named parport_ip32.  The patch is not included in this
mail because it is not very small (2383 lines, 73 Kb).  It is however
avalaible from:

  http://arnaud.giersch.free.fr/parport_ip32/parport_ip32-latest.patch.gz

The patch is against the latest Linux/MIPS kernel (2.6.14-rc2 as of
today).  If you prefer that I post it on a mailing list, please just
tell me where, and how (inlined, or gzip'ed attached file).

Further informations are available on:

  http://arnaud.giersch.free.fr/parport_ip32.html

Regards,

        Arnaud Giersch
