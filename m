Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 17:22:30 +0200 (CEST)
Received: from p508B64E2.dip.t-dialin.net ([80.139.100.226]:16525 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123986AbSI0PWa>; Fri, 27 Sep 2002 17:22:30 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g8RFMJZ01132;
	Fri, 27 Sep 2002 17:22:19 +0200
Date: Fri, 27 Sep 2002 17:22:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: atul srivastava <atulsrivastava9@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mips kseg1 mapping..
Message-ID: <20020927172219.E29970@linux-mips.org>
References: <20020927144641.23180.qmail@mailweb33.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020927144641.23180.qmail@mailweb33.rediffmail.com>; from atulsrivastava9@rediffmail.com on Fri, Sep 27, 2002 at 02:46:41PM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 27, 2002 at 02:46:41PM -0000, atul srivastava wrote:

> 0xa000-0000 to 0xb7ff-ffff virtual and also access to this range 
> in uncached.
> 
> 3.when i am loading my eepro100 driver , in do_eeprom_cmd() when 
> it refers the address( ioaddr + SCBeeprom) my kernel panicks with 
> message "unable to handle kernel paging request at 0xd100010e.
> 
> this virtual address is in range 0xa000-0000 to 0xb7ff-ffff.

Your numbers are wrong - KSEG1 is 0xa0000000 to 0xbfffffff.

  Ralf
