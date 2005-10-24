Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2005 23:11:25 +0100 (BST)
Received: from smtp3-g19.free.fr ([212.27.42.29]:43414 "EHLO smtp3-g19.free.fr")
	by ftp.linux-mips.org with ESMTP id S8133519AbVJXWLD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Oct 2005 23:11:03 +0100
Received: from groumpf (str90-1-82-238-123-182.fbx.proxad.net [82.238.123.182])
	by smtp3-g19.free.fr (Postfix) with ESMTP id AB95B3744A;
	Tue, 25 Oct 2005 00:10:58 +0200 (CEST)
Received: from jekyll ([192.168.1.1])
	by groumpf with esmtp (Exim 4.50)
	id 1EUAWw-00011b-03; Tue, 25 Oct 2005 00:10:58 +0200
Received: from arnaud by jekyll with local (Exim 4.50)
	id 1EUAWv-0007sU-UC; Tue, 25 Oct 2005 00:10:57 +0200
To:	linux-mips@linux-mips.org
Cc:	linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Parallel port support for SGI O2
References: <871x2d3wyc.fsf@groumpf.homeip.net>
From:	Arnaud Giersch <arnaud.giersch@free.fr>
X-Face:	&yL?ZRfSIk3zaRm*dlb3R4f.8RM"~b/h|\wI]>pL)}]l$H>.Q3Qd3[<h!`K6mI=+cWpg-El
 B(FEm\EEdLdS{2l7,8\!RQ5aL0ZXlzzPKLxV/OQfrg/<t!FG>i.K[5isyT&2oBNdnvk`~y}vwPYL;R
 y)NYo"]T8NlX{nmIUEi\a$hozWm#0GCT'e'{5f@Rl"[g|I8<{By=R8R>bDe>W7)S0-8:b;ZKo~9K?'
 wq!G,MQ\eSt8g`)jeITEuig89NGmN^%1j>!*F8~kW(yfF7W[:bl>RT[`w3x-C
Date:	Tue, 25 Oct 2005 00:10:57 +0200
In-Reply-To: <871x2d3wyc.fsf@groumpf.homeip.net> (Arnaud Giersch's message
 of "Sun, 23 Oct 2005 02:20:59 +0200")
Message-ID: <873bmq36ry.fsf@groumpf.homeip.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <arnaud.giersch@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.giersch@free.fr
Precedence: bulk
X-list: linux-mips

Dimanche le 23 octobre 2005, vers 02:20:59 (CEST), j'ai écrit:

> I wrote a low-level parallel port driver for the built-in port on SGI
> O2 (a.k.a. IP32).
[...]
>   http://arnaud.giersch.free.fr/parport_ip32/parport_ip32-latest.patch.gz
>   http://arnaud.giersch.free.fr/parport_ip32.html

I uploaded a new version which fixes some bugs in FIFO transfer mode.

        Arnaud
