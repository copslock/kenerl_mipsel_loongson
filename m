Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 18:12:20 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14317 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S3950149AbWATSLu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 18:11:50 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k0KIFi9N027700;
	Fri, 20 Jan 2006 18:15:44 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k0KIFhXr027696;
	Fri, 20 Jan 2006 18:15:43 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Time slowing down while doing IDE PIO transfer
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1137777997.16631.147.camel@sakura.staff.proxad.net>
References: <1137777997.16631.147.camel@sakura.staff.proxad.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Fri, 20 Jan 2006 18:15:38 +0000
Message-Id: <1137780938.24161.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2006-01-20 at 18:26 +0100, Maxime Bizon wrote:
> This is I guess related to the interrupts being disabled during pio
> transfer (I can't use unmaskirq btw).

Silly question - but why not ?

Alan
