Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f81IObv17067
	for linux-mips-outgoing; Sat, 1 Sep 2001 11:24:37 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f81IOWd17062
	for <linux-mips@oss.sgi.com>; Sat, 1 Sep 2001 11:24:33 -0700
Message-Id: <200109011824.f81IOWd17062@oss.sgi.com>
Received: (qmail 14979 invoked from network); 1 Sep 2001 18:18:59 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 1 Sep 2001 18:18:59 -0000
Date: Sun, 2 Sep 2001 2:24:39 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: set_except_vector question
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f81IOXd17063
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello,Lars Munch
 2001-09-01 18:10:00£º
>What do you mean by "synthesizing a jump"?
I think he means " making a jump instruction"
and yes.
the "j handler" instruction can be made that way:
    _______________________
    |opcode |   target     |
    -----------------------
    opcode for j is 000010,the target pc is computed as currentpc[31-28]||target||00
>
>My CPU is a 5Kc and it has a DIVEC which is set to the mipsIRQ function in
>/arch/mips64/mips-boards/generic/mipsIRQ.S to handle interrupts. But I still do
>not understand the address manipulation which is done before storing the
>function pointer (handler).
>
>Thanks
>Lars Munch
>
>On Sat, Sep 01, 2001 at 11:54:26AM -0400, Bradley D. LaRonde wrote:
>> Looks like it is synthesizing a jump (j) instruction to forward interrupt
>> exceptions to the interrupt handler for cpus that have a dedicated interrupt
>> vector (DIVEC).  arch/mips/kernel/setup.c sets the DIVEC option for certain
>> cpus.
>> 
>> Regards,
>> Brad
>> 
>> ----- Original Message -----
>> From: "Lars Munch" <lars@segv.dk>
>> To: <linux-mips@oss.sgi.com>
>> Sent: Saturday, September 01, 2001 10:58 AM
>> Subject: set_except_vector question
>> 
>> 
>> > Hi
>> >
>> > I have been looking at the set_except_vector function in
>> > arch/mips[64]/kernel/traps.c and wondering why the handler
>> > address is changed/recalculated before it is stored:
>> >
>> > *(volatile u32 *)(KSEG0+0x200) = 0x08000000 | (0x03ffffff & (handler >>
>> 2));
>> >
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> >
>> > Could someone please enlighten me?
>> >
>> > Thanks
>> > Lars Munch
>> >
>> 

Regards
            Fuxin Zhang
            fxzhang@ict.ac.cn
