Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2007 21:49:20 +0000 (GMT)
Received: from smtp4-g19.free.fr ([212.27.42.30]:14042 "EHLO smtp4-g19.free.fr")
	by ftp.linux-mips.org with ESMTP id S20022833AbXCQVtT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 Mar 2007 21:49:19 +0000
Received: from groumpf.homeip.net (lns-bzn-50f-62-147-179-239.adsl.proxad.net [62.147.179.239])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 0F9C58860;
	Sat, 17 Mar 2007 22:48:48 +0100 (CET)
Received: from jekyll.localnet ([192.168.1.1])
	by groumpf.homeip.net with esmtp (Exim 4.63)
	(envelope-from <arnaud.giersch@free.fr>)
	id 1HSglb-0006UI-IV; Sat, 17 Mar 2007 22:48:47 +0100
Received: from arnaud by jekyll.localnet with local (Exim 4.63)
	(envelope-from <arnaud.giersch@free.fr>)
	id 1HSglb-0008NX-Aq; Sat, 17 Mar 2007 22:48:47 +0100
From:	Arnaud Giersch <arnaud.giersch@free.fr>
To:	Kumba <kumba@gentoo.org>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP32 prom crashes due to __pa() funkiness
References: <45D8B070.7070405@gentoo.org>
	<cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
	<45FC46F0.3070300@gentoo.org>
Date:	Sat, 17 Mar 2007 22:48:47 +0100
In-Reply-To: <45FC46F0.3070300@gentoo.org> (kumba@gentoo.org's message of
	"Sat, 17 Mar 2007 15:52:16 -0400")
Message-ID: <87irczzglc.fsf@groumpf.homeip.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <arnaud.giersch@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.giersch@free.fr
Precedence: bulk
X-list: linux-mips

Samedi 17 mars 2007, vers 20:52:16 (+0100), Kumba a écrit:

> So with the changes brought in by __pa(), I suppose a new,
> RightWay(TM) to build IP32 (and conversely, 64bit IP22) kernels needs
> to be found.

I don't know if it is the RightWay(TM), but I am running here a fresh
IP32 kernel (l.m.o git updated yesterday).  It was compiled with
CONFIG_BUILD_ELF64=n, and I am using vmlinux.

$ file /boot/vmlinux-2.6.21-rc3-g839fd555 
/boot/vmlinux-2.6.21-rc3-g839fd555: ELF 64-bit MSB executable, MIPS, MIPS-IV version 1 (SYSV), statically linked, not stripped

If it makes a difference, I am using arcboot.

        Arnaud
