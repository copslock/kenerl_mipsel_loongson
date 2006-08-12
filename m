Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 18:46:08 +0100 (BST)
Received: from mail04.hansenet.de ([213.191.73.12]:29592 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20037843AbWHLRqH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Aug 2006 18:46:07 +0100
Received: from [213.39.177.93] (213.39.177.93) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44DC82C70003CD7D; Sat, 12 Aug 2006 19:45:52 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 6A5361770B1;
	Sat, 12 Aug 2006 19:45:52 +0200 (CEST)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Date:	Sat, 12 Aug 2006 19:45:52 +0200
User-Agent: KMail/1.9.3
Cc:	wim@iguana.be, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200608102319.13679.thomas@koeller.dyndns.org> <1155326835.24077.116.camel@localhost.localdomain>
In-Reply-To: <1155326835.24077.116.camel@localhost.localdomain>
Organization: Basler AG
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608121945.52202.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Friday 11 August 2006 22:07, Alan Cox wrote:
> Also if this is a software watchdog why is it better than using
> softdog ?
>

This is _not_ a software watchdog. If the timer expires, an interrupt
is generated, and the timer is reset to count through another cycle.
If it expires again, it resets the CPU.

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
