Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2002 15:08:27 +0200 (CEST)
Received: from webmail25.rediffmail.com ([203.199.83.147]:11682 "HELO
	webmail25.rediffmail.com") by linux-mips.org with SMTP
	id <S1123930AbSJCNI1>; Thu, 3 Oct 2002 15:08:27 +0200
Received: (qmail 20896 invoked by uid 510); 3 Oct 2002 13:12:42 -0000
Date: 3 Oct 2002 13:12:42 -0000
Message-ID: <20021003131242.20895.qmail@webmail25.rediffmail.com>
Received: from unknown (203.197.186.247) by rediffmail.com via HTTP; 03 Oct 2002 13:12:42 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: idt-mips tlb initialisation for PCI access..
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

my understanding of PCI access and related TLB initialisation 
(from bootloader to OS) is as follow:-

1.typically in bootloader PCI bridge is initialised
for IO amd MEM space windows.

2.also TLB entry is setup for virtual - > physical mapping.
examplesake if my PCI memory window is at 0x40000000 .

I would setup a TLB entry for this with appropiate index VPN and 
PFN.

3.now i am all set to access PCI space ..am i right..?

now my question is that after OS comes up initially it calls 
tlb_flush_all() ..should it again explicitly initialise the TLB 
entries in xxx_setup()..

if yes does the the following lines are doing the same..
offcourse adresses may have to changed in my BSP.

/* map 0xe0000000 virtual to 0x40000000 phys for PCI */

write_32bit_cp0_register(CP0_WIRED, 0); /* clear any                     
                          previous stuff */
add_wired_entry(0x01000017, 0x01040017,xe0000000,PM_16M);

Best Regards,
Atul
__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
