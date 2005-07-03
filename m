Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jul 2005 15:06:21 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.171]:44488
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226118AbVGCOGE>; Sun, 3 Jul 2005 15:06:04 +0100
Received: from pD95294ED.dip0.t-ipconnect.de [217.82.148.237] (helo=gaspode.madsworld.lan)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML2Dk-1Dp56m1X9L-0002mD; Sun, 03 Jul 2005 16:06:08 +0200
Received: from mad by gaspode.madsworld.lan with local (Exim 4.50)
	id 1Dp56p-0007jl-Ku
	for linux-mips@linux-mips.org; Sun, 03 Jul 2005 16:06:11 +0200
Date:	Sun, 3 Jul 2005 16:06:11 +0200
From:	Markus Dahms <mad@automagically.de>
To:	linux-mips@linux-mips.org
Subject: GIO is alive
Message-ID: <20050703140611.GA29571@gaspode.automagically.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:896705dcda322f33ae3752a7fdb3dc09
Return-Path: <mad@automagically.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mad@automagically.de
Precedence: bulk
X-list: linux-mips

Hi,

I'm playing around with the SGI GIO bus driver stuff removed from the
kernel almost two and a half years ago.
Recently I got a GIO card for my Indy ("SCSI based printer card" -
http://www.g-lenerz.de/storage/images/sgistuff/indy/printer.jpg), but
no idea what to do with it (and less than no information about it).
Mostly driven by educational reasons I reimplemented parts of the
bus driver as a kernel module for kernel 2.6.x.
It's propably useless, but if somebody interested in such stuff you
can get it at http://automagically.de/?gio where you
also can find some more information.
Of course it's incomplete and buggy but it should not crash the
kernel anymore ;-).
It would be nice if somebody could test it.

Markus
