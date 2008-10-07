Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2008 11:29:42 +0100 (BST)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57298 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S20812506AbYJGK3e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Oct 2008 11:29:34 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id m97ATWhR013912;
	Tue, 7 Oct 2008 11:29:32 +0100
Date:	Tue, 7 Oct 2008 11:29:32 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH] serial: Add Cavium OCTEON UART definitions.
Message-ID: <20081007112932.165fce27@lxorguk.ukuu.org.uk>
In-Reply-To: <48EAAF97.8050307@caviumnetworks.com>
References: <48EAAF97.8050307@caviumnetworks.com>
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
X-archive-position: 20694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> +#ifdef CONFIG_CPU_CAVIUM_OCTEON
> +	/* UPF_FIXED_PORT indicates an internal UART.  */
> +	if (up->port.flags & UPF_FIXED_PORT)
> +		up->port.type = PORT_OCTEON;
> +	else
> +#endif

Not nice. Please keep CPU specific ifdefs out of the 8250 core code. Can
you not set a port flag for UPF_BROKEN_OCTEON or similar to clean that up
and also make the other tests that need things doing (eg the always
calling IRQ code use port flags of a more generic nature ?)
