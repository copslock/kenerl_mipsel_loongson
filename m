Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 16:41:30 +0200 (CEST)
Received: from [203.199.83.245] ([203.199.83.245]:44244 "HELO
	mailweb33.rediffmail.com") by linux-mips.org with SMTP
	id <S1123909AbSI0Ol3>; Fri, 27 Sep 2002 16:41:29 +0200
Received: (qmail 23181 invoked by uid 510); 27 Sep 2002 14:46:41 -0000
Date: 27 Sep 2002 14:46:41 -0000
Message-ID: <20020927144641.23180.qmail@mailweb33.rediffmail.com>
Received: from unknown (202.54.89.98) by rediffmail.com via HTTP; 27 Sep 2002 14:46:41 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: mips kseg1 mapping..
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

I am relatively new on MIPS architecture.
working on BSP for MIPS R32xx on IDT .

i have a basic question.

1.PCI BAR 1 of my eepro100 card has been initialised with
address 0x18800100 for 64 bytes.
this is a valid PCI IO address as per manual.

2.what i understand is that lower 0 - 512 MB physical is mapped to 
0xa000-0000 to 0xb7ff-ffff virtual and also access to this range 
in uncached.

3.when i am loading my eepro100 driver , in do_eeprom_cmd() when 
it refers the address( ioaddr + SCBeeprom) my kernel panicks with 
message "unable to handle kernel paging request at 0xd100010e.

this virtual address is in range 0xa000-0000 to 0xb7ff-ffff.

now my question is what all i have to do so that this access is 
passed i mean i get a valid virtual-physical mapping for this 
address.

where i need to take care of kseg1 translation in my BSP
Best Regards,
Ashish



__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
