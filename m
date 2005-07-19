Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 19:34:16 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.171]:33023
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226897AbVGSSd7>; Tue, 19 Jul 2005 19:33:59 +0100
Received: from pD952892F.dip0.t-ipconnect.de [217.82.137.47] (helo=gaspode.madsworld.lan)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKxQS-1DuwwR3Lk8-0006SS; Tue, 19 Jul 2005 20:35:43 +0200
Received: from mad by gaspode.madsworld.lan with local (Exim 4.50)
	id 1DuwwU-00011n-JH
	for linux-mips@linux-mips.org; Tue, 19 Jul 2005 20:35:46 +0200
Date:	Tue, 19 Jul 2005 20:35:46 +0200
From:	Markus Dahms <mad@automagically.de>
To:	linux-mips@linux-mips.org
Subject: module loading on 64-bit kernel
Message-ID: <20050719183546.GA3923@gaspode.automagically.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:896705dcda322f33ae3752a7fdb3dc09
Return-Path: <mad@automagically.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mad@automagically.de
Precedence: bulk
X-list: linux-mips

Hello together,

do I need other module-init-tools for a 64-bit kernel than I need for
32-bit?
When trying to load a module I get the following output:
| insmod: error inserting \
| '/lib/modules/2.6.13-rc3-mad-mips-1-64/kernel/fs/isofs/isofs.ko': -1 \
| Cannot allocate memory

in dmesg:
| allocation failed: out of vmalloc space - use vmalloc=<size> to increase \
| size.

It happens with every module. If I'd need other tools these messages are
confusing. I didn't try "vmalloc=..." as I think module loading wouldn't
be "disabled" in such a way by default...

If I need special 64-bit module-init-tools, is there a way to build them
without a 64-bit glibc as all of my userspace stuff is 32-bit?

Markus
