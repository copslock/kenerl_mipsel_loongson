Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2002 10:29:15 +0200 (CEST)
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:7912 "EHLO
	columba.www.eur.3com.com") by linux-mips.org with ESMTP
	id <S1122978AbSICI3O>; Tue, 3 Sep 2002 10:29:14 +0200
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g838UZRG009451;
	Tue, 3 Sep 2002 09:30:41 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g838TeR07076;
	Tue, 3 Sep 2002 09:29:41 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256C29.002F1C4D ; Tue, 3 Sep 2002 09:34:34 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: "Stephen Mose Aaskov" <sma@2m.dk>
cc: linux-mips@linux-mips.org
Message-ID: <80256C29.002F1B7C.00@notesmta.eur.3com.com>
Date: Tue, 3 Sep 2002 09:28:29 +0100
Subject: Re: MTD drivers and byte/word mode
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <Jon_Burgess@eur.3com.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jon_Burgess@eur.3com.com
Precedence: bulk
X-list: linux-mips



> It looks as if the adresses calculated by
> cfi_build_cmd_addr() is the double of what my FLASH
> chips are using.
> eg. the CFI query is written to 0xaa where my chip
> in word mode expects the query command to be written
> to 0x55

We have just such a setup working in our product with a 16 bit AMD flash using
the CFI diver.

The 0xAA address as far as the programmer is concerned looks wrong, but the
flash chip is expecting addresses of 16bit data which are shifted 1 address line
from the address of 8 bit data. On our board the generic 8/16 bit bus address
lines are connected to the 16 bit flash as:
     Bus A0 -> Unused
     Bus A1 -> Flash A0,
     Bus A2 -> Flash A1
     etc,

When the CPU accesses addres 0xAA the flash will see 0x55.

     Jon
