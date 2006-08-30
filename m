Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2006 22:29:14 +0100 (BST)
Received: from mail04.hansenet.de ([213.191.73.12]:36293 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20037772AbWH3V3M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Aug 2006 22:29:12 +0100
Received: from [213.39.208.35] (213.39.208.35) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44EC4423001DFCEF; Wed, 30 Aug 2006 23:28:48 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 24DA52C410;
	Wed, 30 Aug 2006 23:28:48 +0200 (CEST)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
To:	"Russell King" <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] RM9000 serial driver
Date:	Wed, 30 Aug 2006 23:28:47 +0200
User-Agent: KMail/1.9.3
Cc:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	"Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>,
	linux-serial@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org,
	Thomas =?iso-8859-1?q?K=F6ller?= <thomas@koeller.dyndns.org>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608300100.32836.thomas.koeller@baslerweb.com> <20060830121216.GA25699@flint.arm.linux.org.uk>
In-Reply-To: <20060830121216.GA25699@flint.arm.linux.org.uk>
Organization: Basler AG
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200608302328.47944.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Wednesday 30 August 2006 14:12, Russell King wrote:

> iotype is all about the access method used to access the registers of
> the device, be it by byte or word, and it also takes account of any
> variance in the addressing of the registers.
>
> It does not refer to features or bugs in any particular implementation.

That's what I assumed, too - it seemed obvious. And it seemed equally
obvious that it is the port type that encodes the the implementation's
peculiarities. Among these are the register offset mapping requirements,
so I assumed these should depend on the port type as well.

Now Sergei strongly insist that it's the iotype that should be checked
whenever to get to the hardware type. I still do not quite understand how
that is supposed to work. If I have a PCI device, for example, then the
iotype will always be either UPIO_MEM or UPIO_PORT, so how could I learn
something about the hardware implementation by looking at these values?
Or is the assumption that devices on a standard bus will always be of
a standard type?

Thomas

-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
