Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 17:15:57 +0200 (CEST)
Received: from vsat-148-63-243-254.c004.g4.mrt.starband.net ([148.63.243.254]:49669
	"EHLO lahoo.mshome.net") by linux-mips.org with ESMTP
	id <S1123963AbSI0PP4>; Fri, 27 Sep 2002 17:15:56 +0200
Received: from prefect.mshome.net ([192.168.0.188] helo=prefect)
	by lahoo.mshome.net with smtp (Exim 3.12 #1 (Debian))
	id 17uwkz-0003OD-00; Fri, 27 Sep 2002 11:10:17 -0400
Message-ID: <048701c26638$bb357640$bc00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "atul srivastava" <atulsrivastava9@rediffmail.com>,
	<linux-mips@linux-mips.org>
References: <20020927144641.23180.qmail@mailweb33.rediffmail.com>
Subject: Re: mips kseg1 mapping..
Date: Fri, 27 Sep 2002 11:15:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <brad@ltc.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@ltc.com
Precedence: bulk
X-list: linux-mips

----- Original Message -----
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: <linux-mips@linux-mips.org>
Sent: Friday, September 27, 2002 10:46 AM
Subject: mips kseg1 mapping..


> 1.PCI BAR 1 of my eepro100 card has been initialised with
> address 0x18800100 for 64 bytes.
> this is a valid PCI IO address as per manual.
>
> 2.what i understand is that lower 0 - 512 MB physical is mapped to
> 0xa000-0000 to 0xb7ff-ffff virtual and also access to this range
> in uncached.
>
> 3.when i am loading my eepro100 driver , in do_eeprom_cmd() when
> it refers the address( ioaddr + SCBeeprom) my kernel panicks with
> message "unable to handle kernel paging request at 0xd100010e.
>
> this virtual address is in range 0xa000-0000 to 0xb7ff-ffff.

KSEG1 is always mapped (you can think of it as wired).

PCI bus addresses should be remapped through ioremap.  Is ioremap returning
the address you expect?

Regards,
Brad
