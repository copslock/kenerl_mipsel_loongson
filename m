Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2004 16:00:31 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:53266 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8224931AbUIWPA1>; Thu, 23 Sep 2004 16:00:27 +0100
Received: from dagger.cc.vt.edu (IDENT:mirapoint@evil-dagger [10.1.1.11])
	by lennier.cc.vt.edu (8.12.8/8.12.8) with ESMTP id i8NF0Pol261709;
	Thu, 23 Sep 2004 11:00:25 -0400 (EDT)
Received: from [128.173.184.75] (gs75.geol.vt.edu [128.173.184.75])
	by dagger.cc.vt.edu (MOS 3.4.8-GR)
	with ESMTP id BQW64953;
	Thu, 23 Sep 2004 11:00:21 -0400 (EDT)
Message-ID: <4152E4FC.8000408@gentoo.org>
Date: Thu, 23 Sep 2004 11:00:12 -0400
From: "Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuart Longland <stuartl@longlandclan.hopto.org>
CC: linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
References: <4152D58B.608@longlandclan.hopto.org>
In-Reply-To: <4152D58B.608@longlandclan.hopto.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

> 	Using a MIPS64 config (built using gas-abi=o32 as suggested by Kumba),
> it doesn't even get that far:

This is certainly wrong.  What you really want is gas-abi=o64.  Take a 
look at the O2 minimum patchset at http://www.total-knowledge.com, as 
the arch/mips/Makefile changes are what you need.  Using a 64-bit kernel 
on your indy is pointless unless you want to run n32 userland anyhow.

As of this moment (may change in the future), 2.4 kernels are much 
better for ip22 anyhow.  Serial console, indycam, and sound all work 
properly in 2.4.  In 2.6, serial console is broken, there is no indycam 
support, and I'm running into some issues with sound where the cpu usage 
runs way up.

Steve
