Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2008 11:20:44 +0000 (GMT)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44438 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S24048736AbYLBLUh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Dec 2008 11:20:37 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mB2BKAT1024973;
	Tue, 2 Dec 2008 11:20:10 GMT
Date:	Tue, 2 Dec 2008 11:20:10 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-serial@vger.kernel.org, akpm@linux-foundation.org,
	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 1/4] 8250: Don't clobber spinlocks.
Message-ID: <20081202112010.6b25af1c@lxorguk.ukuu.org.uk>
In-Reply-To: <1228175368-5536-1-git-send-email-ddaney@caviumnetworks.com>
References: <4934774E.6080805@caviumnetworks.com>
	<1228175368-5536-1-git-send-email-ddaney@caviumnetworks.com>
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
X-archive-position: 21485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Mon,  1 Dec 2008 15:49:25 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> In serial8250_isa_init_ports(), the port's lock is initialized.  We
> should not overwrite it.  In early_serial_setup(), only copy in the
> fields we need.  Since the early console code only uses a subset of
> the fields, these are sufficient.

> -	serial8250_ports[port->line].port.ops	= &serial8250_pops;

You seem to drop the assignment of port.ops ?
