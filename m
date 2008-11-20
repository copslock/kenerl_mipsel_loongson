Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2008 20:02:55 +0000 (GMT)
Received: from [81.2.110.250] ([81.2.110.250]:17373 "EHLO lxorguk.ukuu.org.uk")
	by ftp.linux-mips.org with ESMTP id S23796355AbYKTUCp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2008 20:02:45 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mAKK2DZ7024975;
	Thu, 20 Nov 2008 20:02:13 GMT
Date:	Thu, 20 Nov 2008 20:02:12 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 20/26] 8250: Serial driver changes to support future
 Cavium OCTEON serial patches.
Message-ID: <20081120200212.17e67add@lxorguk.ukuu.org.uk>
In-Reply-To: <1227047057-4911-2-git-send-email-ddaney@caviumnetworks.com>
References: <49233FDE.3010404@caviumnetworks.com>
	<1227047057-4911-2-git-send-email-ddaney@caviumnetworks.com>
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
X-archive-position: 21347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Tue, 18 Nov 2008 14:24:14 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> In order to use Cavium OCTEON specific serial i/o drivers, we first
> patch the 8250 driver to use replaceable I/O functions.  Compatible
> I/O functions are added for existing iotypeS.
> 
> An added benefit of this change is that it makes it easy to factor
> some of the existing special cases out to board/SOC specific support
> code.
> 
> The alternative is to load up 8250.c with a bunch of OCTEON specific
> iotype code and bug work-arounds.

Neither are pretty but this looks the better option I agree. Only niggle
is the use of "_fn" - Linux generally doesn't put types into variable
names.
