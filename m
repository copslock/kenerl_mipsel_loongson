Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2002 10:24:52 +0200 (CEST)
Received: from apollo.bingo-ev.de ([213.70.214.67]:16341 "EHLO
	apollo.bingo-ev.de") by linux-mips.org with ESMTP
	id <S1123899AbSIXIYw>; Tue, 24 Sep 2002 10:24:52 +0200
Received: from fake by apollo.bingo-ev.de with local (Exim 3.35 #1 (Debian))
	id 17tkzs-0007Pb-00
	for <linux-mips@linux-mips.org>; Tue, 24 Sep 2002 10:24:44 +0200
Date: Tue, 24 Sep 2002 10:24:44 +0200
From: FrAnKenstEin <fake@bingo-ev.de>
To: linux-mips@linux-mips.org
Subject: EF_MIPS_ABI and EF_MIPS_ABI2 undefined in 2.4.20-pre7
Message-ID: <20020924082444.GA28416@apollo.bingo-ev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Return-Path: <fake@apollo.bingo-ev.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fake@bingo-ev.de
Precedence: bulk
X-list: linux-mips

hi,

ralf, since your sync in pre7 of the 2.4 kernel, i get 2 missing defines 
(in include/linux/elf.h if i am not mistaken)... EF_MIPS_ABI and EF_MIPS_ABI2. 

in the latest binutils mips.h and in /usr/include/elf.h those are defined.
whats up? ;)

i also have problems with unresolved symbols in ip22-setup.o since 2.4.18 - 
setup_console is unresolved, but that is devfs-specific if i am not mistaken...
i will have a look at it as i find some spare time.

thanks in advance,

FAKE
