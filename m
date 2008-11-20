Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2008 20:06:33 +0000 (GMT)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:3790 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S23796450AbYKTUGX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Nov 2008 20:06:23 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mAKK6Vmd025044;
	Thu, 20 Nov 2008 20:06:31 GMT
Date:	Thu, 20 Nov 2008 20:06:30 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 23/26] Serial: UART driver changes for Cavium OCTEON.
Message-ID: <20081120200630.33111a2f@lxorguk.ukuu.org.uk>
In-Reply-To: <1227047057-4911-5-git-send-email-ddaney@caviumnetworks.com>
References: <49233FDE.3010404@caviumnetworks.com>
	<1227047057-4911-5-git-send-email-ddaney@caviumnetworks.com>
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
X-archive-position: 21348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> +		if ((up->bugs & UART_BUG_OCTEON_IIR) && (iir & 0xf) == 7) {
> +			/* Busy interrupt */
> +			serial_in(up, UART_OCTEON_USR);
> +			iir = serial_in(up, UART_IIR);
> +		}

Could this not be hidden in the register read method for the octeon and
thus kept out of core code ?
