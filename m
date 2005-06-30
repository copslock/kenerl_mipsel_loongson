Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 23:11:00 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:57566 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8226113AbVF3WKl>; Thu, 30 Jun 2005 23:10:41 +0100
Received: from zidane.cc.vt.edu (IDENT:mirapoint@[10.1.1.13])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j5UM9GNQ003605;
	Thu, 30 Jun 2005 18:09:26 -0400
Received: from [192.168.1.2] (68-232-96-93.chvlva.adelphia.net [68.232.96.93])
	by zidane.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id DMW00949 (AUTH spbecker);
	Thu, 30 Jun 2005 18:09:10 -0400 (EDT)
Message-ID: <42C46D85.9050104@gentoo.org>
Date:	Thu, 30 Jun 2005 18:09:09 -0400
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050625)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
References: <20050630173409Z8226102-3678+735@linux-mips.org> <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org>
In-Reply-To: <20050630210357.GA23456@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips


> Bryan seems to be using the original Red Hat gnupro 64-bit toolchain. 
> I don't know how well that works nowadays; but current CVS versions do
> work, or did when I last tested (a month or two ago).
> 

Hmm, well with respect to my problem, I'm using a pretty recent
toolchain, with gcc 3.4.4, binutils-2.16.1, glibc-2.3.5, and headers
from a linux-mips 2.6.11 snapshot.  Interestingly, I tried to reproduce
Bryan's segfault, but could not.  That code ran without error when I
linked with libpthread.  Any thoughts?

-Steve
