Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8K2QBG10778
	for linux-mips-outgoing; Wed, 19 Sep 2001 19:26:11 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8K2Q6e10774
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 19:26:06 -0700
Message-Id: <200109200226.f8K2Q6e10774@oss.sgi.com>
Received: (qmail 14593 invoked from network); 20 Sep 2001 02:20:10 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 20 Sep 2001 02:20:10 -0000
Date: Thu, 20 Sep 2001 10:25:0 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8K2Q6e10776
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,Ralf Baechle£¬

    The mannual says:

     Tips on programming south bridge interrupt controller(s)

  The interrupt controllers inside the south bridge chip have to be software-compatible with the dual Intel 8259 controllers fitted to ver y old 
PCs.There are two 8-bit controllers inside the south bridge,aslave whose
interrupt output becomes one of the eight inputs of the master controller.
The 8259 is a ver y old device,dating from around 1980. Under the influence 
of contemporar y minicomputer designs,the 8259 made a brave attempt to build 
an interrupt prior ity system in hardware for Intel 8-bit and 8086 CPUs.With 
the benefit of 20 years hindsight, we can see this was pretty silly (but that
¡¯s a lot of hindsight, and the people who did it were much younger then).
When separated from its Intel CPU,the 8259 is unable to do exciting things like automatically causing the CPU to vector to an appropriate interrupt 
vector location. Experience shows that allowing it to do anything complicated 
is likely to lead to trouble,so we suggest:
   1. Don¡¯t use the 8259¡¯s prior ity logic. Instead, place both the master and slave controller into what the Intel manuals call Special Mask Mode.This disables all interrupt prior itisation; now any active and unmasked
interr upt input will activate the interrupt output, which is enough.

2. Do not ever read the ISR (¡®¡®in-ser vice¡¯¡¯) registers.They don¡¯t make sense outside of the prior ity scheme.If you want to know what individual interrupt lines are doing, look in the IRR (¡®¡®interr upt request¡¯¡¯) registers instead.

3. Conclude each interrupt service routine with a ¡®¡®Specific end-of-interrupt (EOI)¡¯¡¯ command to the 8259. In special mask mode this does
n't do anything to the priority,but it does serve to clear a latched 
interrupt, if there is one.(There are other ways of doing this).

-----------------
 I have tried to put both 8259 into Special mask mode( write OCW3=0x6a to 0x20
and 0xa0).But it doesn't stop spurious IRQ12.But so far I have see only IRQ7
and IRQ12.
  A skim over 82371(PIIX) manual I find something that may relate: XBCS 
register(0x4e),which can control mouse support at IRQ12,and keyb,rtc support.
Because p6032 use multi-IO controller to provide keyb,mouse,rtc,I guess
it may lead to some problem; 0x60,a read to it clear mouse/keyb interrupt
if mouse/keyb support is enabled in XBCS; 0x4d0,0x4d1,set level/edge sense
mode per interrupt.
  But sadly up to now i have tried several combination,none can stop spurious
IRQ12. I have to add a read to 0x60 to prevent endless spurious IRQ12 when it 
happens.
  Another fact is the 82371 manual is 82371FB & 82371SB,but the chip on the
board is 82371EB.I will try to find the exact manual later.
 

ÔÚ 2001-09-19 18:41:00 you wrote£º
>On Wed, Sep 19, 2001 at 11:27:14AM +0100, Phil Thompson wrote:
>
>> Make sure you read the section in the P6032 manual "Tips on programming
>> south bridge interrupt controller(s)" - page 31. I don't see how the 8259
>> code that's part of the MIPS tree can ever be used without changes.
>
>Can you elaborate?  It's actually being used without problems.
>
>  Ralf

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
