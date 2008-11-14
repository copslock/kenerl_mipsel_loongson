Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2008 01:18:46 +0000 (GMT)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35555 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S23665028AbYKNBSo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Nov 2008 01:18:44 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mAE1IpiB018730;
	Fri, 14 Nov 2008 01:18:52 GMT
Date:	Fri, 14 Nov 2008 01:18:51 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] New IDE/block driver for OCTEON SOC Compact Flash
 interface.
Message-ID: <20081114011851.1fa01a33@lxorguk.ukuu.org.uk>
In-Reply-To: <491CC0B6.8020400@ru.mvista.com>
References: <491C7F28.2070507@caviumnetworks.com>
	<491CC0B6.8020400@ru.mvista.com>
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
X-archive-position: 21288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> OTOH, CF support via self-contained driver is certainly a waste of code 
> since IDE core and (libata) are here to drive the CF devices as well. 
> What we need is a "normal" IDE or libata (at your option) driver.

A libata driver would be nice and probably easiest to do as you don't
have to pretend to be close to old style taskfile IDE for a PC.

I am not convinced there is no case for a 'dumb' small CF driver, but if
so the chipset code and the core code need to be separated as the other
requests I see for this are different embedded boxes wanting to keep
codesize down.

Alan
