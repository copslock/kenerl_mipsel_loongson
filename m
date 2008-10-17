Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2008 15:42:57 +0100 (BST)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49118 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S21720406AbYJQOmz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Oct 2008 15:42:55 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id m9HEgt3B027244;
	Fri, 17 Oct 2008 15:42:55 +0100
Date:	Fri, 17 Oct 2008 15:42:49 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	sshtylyov@ru.mvista.com
Subject: Re: [PATCH] ide: Add tx4939ide driver (v4)
Message-ID: <20081017154249.5fd0e7d3@lxorguk.ukuu.org.uk>
In-Reply-To: <20081017141310.GA14999@linux-mips.org>
References: <20081017.230825.95059872.anemo@mba.ocn.ne.jp>
	<20081017141310.GA14999@linux-mips.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; x86_64-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> Btw, I don't think architecture specific subdirectories in subsystems are
> generally usefull.  Just as in this example this IDE controller happens
> only to be in use on a particular MIPS-based SOC but there is nothing
> really architecture specific in most such devices.

Well drivers/ide is legacy stuff anyway and on its slow way out but it has
always had architecture subdirectories so it isn't a material change.

Alan
