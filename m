Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 17:34:20 +0000 (GMT)
Received: from [81.2.110.250] ([81.2.110.250]:59088 "EHLO lxorguk.ukuu.org.uk")
	by ftp.linux-mips.org with ESMTP id S23910608AbYKYReP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2008 17:34:15 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mAPHY2pd011726;
	Tue, 25 Nov 2008 17:34:02 GMT
Date:	Tue, 25 Nov 2008 17:34:01 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] libata: New driver for OCTEON SOC Compact Flash
 interface (v2).
Message-ID: <20081125173401.44c28e17@lxorguk.ukuu.org.uk>
In-Reply-To: <492C3509.8010408@caviumnetworks.com>
References: <492B56B0.9030409@caviumnetworks.com>
	<1227577181-30206-2-git-send-email-ddaney@caviumnetworks.com>
	<492C2EE2.3090702@garzik.org>
	<492C3509.8010408@caviumnetworks.com>
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
X-archive-position: 21424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> system.  The only recourse is to cycle power to the board.  By allowing 
> DMA to be disabled, we eliminate this problem.

You can already do this via the existing libata option functions that
Tejun added a while back, or there is libata.dma=0 which is applied to
all interfaces.
