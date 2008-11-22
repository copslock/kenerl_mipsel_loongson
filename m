Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 14:52:09 +0000 (GMT)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:18399 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S23834658AbYKVOvy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Nov 2008 14:51:54 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mAMEq4xg002473;
	Sat, 22 Nov 2008 14:52:05 GMT
Date:	Sat, 22 Nov 2008 14:52:04 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash
 interface.
Message-ID: <20081122145204.52270dbe@lxorguk.ukuu.org.uk>
In-Reply-To: <49280FC5.3040608@ru.mvista.com>
References: <49261BE5.2010406@caviumnetworks.com>
	<49280FC5.3040608@ru.mvista.com>
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
X-archive-position: 21388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

>    But if you're saying that there is only DMA completion inetrrupt, you 
> *cannot* completely emulate SFF-8038i BMDMA since its interrupt status 
> is the (delayed) IDE INTRQ status. I suggest that you move away from the 
> emulation -- Alan has said it's possible.

I don't see whats wrong with treating it that way if it keeps the amount
of code needed down.
