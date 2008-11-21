Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 18:12:02 +0000 (GMT)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33984 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S23819584AbYKUSLz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Nov 2008 18:11:55 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mALIC64U011674;
	Fri, 21 Nov 2008 18:12:06 GMT
Date:	Fri, 21 Nov 2008 18:12:05 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash
 interface.
Message-ID: <20081121181205.7c9da385@lxorguk.ukuu.org.uk>
In-Reply-To: <4926F1EB.8090506@ru.mvista.com>
References: <49261BE5.2010406@caviumnetworks.com>
	<4926F1EB.8090506@ru.mvista.com>
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
X-archive-position: 21372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

>     About the 8-bit mode: you need to issue the Set Features command with 
> opcode 1 to enable that mode -- libata currently doesn't do that, so it won't 
> work I suppose...

That depends on the hardware interface. I have worked with at least one
board that is 8bit to the CPU for data transfers and 16bit to the disk.
Also Set Features 8bit is strictly for TrueIDE mode (see CF 4.0 spec pg
150).

Alan
