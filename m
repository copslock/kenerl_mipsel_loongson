Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 17:07:16 +0100 (BST)
Received: from mail04.hansenet.de ([213.191.73.12]:21438 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20037824AbWHLQHP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Aug 2006 17:07:15 +0100
Received: from [213.39.177.93] (213.39.177.93) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44DC82C700039978; Sat, 12 Aug 2006 18:07:06 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 177DF1770E9;
	Sat, 12 Aug 2006 18:07:06 +0200 (CEST)
From:	Thomas Koeller <thomas@koeller.dyndns.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Date:	Sat, 12 Aug 2006 18:06:02 +0200
User-Agent: KMail/1.9.3
Cc:	wim@iguana.be, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200608102319.13679.thomas@koeller.dyndns.org> <1155326835.24077.116.camel@localhost.localdomain>
In-Reply-To: <1155326835.24077.116.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608121806.02844.thomas@koeller.dyndns.org>
Return-Path: <thomas@koeller.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@koeller.dyndns.org
Precedence: bulk
X-list: linux-mips

On Friday 11 August 2006 22:07, Alan Cox wrote:
> > +	printk(KERN_WARNING "%s: watchdog expired - resetting system\n",
> > +	       wdt_gpi_name);
> > +
> > +	*(volatile char *) flagaddr |= 0x01;
> > +	*(volatile char *) resetaddr = powercycle ? 0x01 : 0x2;
> > +	iob();
> > +	while (1) continue;
>
> cpu_relax();

I tried to find out about the purpose of cpu_relax(). On MIPS, at least,
it maps to barrier(). I do not quite understand why I would need a
barrier() in this place. Would you, or someone else, care to
enlighten me?

I am sending a revised patch in a separate mail.

Thomas
-- 
Thomas Koeller
thomas@koeller.dyndns.org
