Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 May 2003 22:51:25 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:3794
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225193AbTEKVvX>; Sun, 11 May 2003 22:51:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id AD54D2BC36
	for <linux-mips@linux-mips.org>; Sun, 11 May 2003 23:51:20 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 01509-09
 for <linux-mips@linux-mips.org>; Sun, 11 May 2003 23:51:20 +0200 (CEST)
Received: from bogon.sigxcpu.org (kons-d9bb55c8.pool.mediaWays.net [217.187.85.200])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id C5C332BC35
	for <linux-mips@linux-mips.org>; Sun, 11 May 2003 23:51:19 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id DEB7D1737F; Sun, 11 May 2003 23:48:01 +0200 (CEST)
Date: Sun, 11 May 2003 23:48:01 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: compiling glibc
Message-ID: <20030511214801.GC3889@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <200305092145.43690.benmen@gmx.de> <20030511092828.GA3889@bogon.ms20.nix> <200305111252.52661.benmen@gmx.de> <200305111300.50226.benmen@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200305111300.50226.benmen@gmx.de>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Sun, May 11, 2003 at 01:00:50PM +0200, Benjamin Menküc wrote:
> I have to put some optimization flag into CFLAG="" because otherwise I get the 
> error: glibc can't be compiled without optimization...
> 
> what should I do?
Does it work when you don't set CFLAGS at all? Please use LC_ALL=C for
the error messages.
 -- Guido
