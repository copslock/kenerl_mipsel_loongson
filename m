Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8J8cO421414
	for linux-mips-outgoing; Wed, 19 Sep 2001 01:38:24 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8J8cIe21408
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 01:38:18 -0700
Message-Id: <200109190838.f8J8cIe21408@oss.sgi.com>
Received: (qmail 30892 invoked from network); 19 Sep 2001 08:32:27 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 19 Sep 2001 08:32:27 -0000
Date: Wed, 19 Sep 2001 16:37:35 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8J8cIe21409
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,Jun Sun£¬
ÔÚ 2001-09-18 10:09:00 you wrote£º
>Zhang Fuxin wrote:
>> 
>> hi,all
>>   I have finally been able to get a copy of sgi cvs code:).Now I have
>> changed my p6032 code to use new[time,pci,irq] code and it seems a
>> lot cleaner.But still problems.
>
>Cool.  Very glad to hear that.
Thank you for encourage:). I am new to mips and kernel programming,the code 
may still look very dirty for your eyes.But i will try my best.
>
>>   I keep seeing spurious interrupt when starting xwindows.And
>> sometimes without x. If the machine is doing heavy io(e.g.,unzip &
>> untar mozilla source) when I startx,it will probably enter an
>> endless loop of spurious interrupt or lead to unaligned instruction
>> access shortly after(with epc=0x1,ra=0x1) and die.
>>   I have seen spurious IRQ1,IRQ7 and IRQ12,and the endless loop case
>> is IRQ12--ps2 mouse interrupt.
>>   Can somebody give me a clue? What I know is that 8259 may generate
>> spurious IRQ7 & IRQ15. But how can the others happen,buggy hw?And
>> what may cause a kernel unaligned instruction access?
>
>Are you using arch/mips/i8259.c file?
Yes.
>
>One possibility is your irq dispatching code.  If it loops to deliver all
>pending interrupts, what you described may happen (assuming there is a real
>hardware connecting to those irq sources).
I have checked the p6032 manual.It says it has an intel FW82371AB("PIIX 4") 
south bridge chip,a National Semiconductor PC97307-ICE/VUL multi I/O 
controller which includes dual serial ports and rtc,PC mouse/keyb etc,connect 
to the PIIX 4.

 My irq dispatching code is very simple,it just read the IRR,count the first
irq number and call do_IRQ.
  /*
 * the first level int-handler will jump here if it is a 8259A irq
 */
asmlinkage void i8259A_irqdispatch(struct pt_regs *regs)
{
        int isr, irq;

        isr = inb(0x20);

        irq = ffz (~isr);

        if (irq == 2) {
                isr = inb(0xa0);
                irq = 8 + ffz(~isr);
        }

        do_IRQ(irq,regs);
}


 
>
>> 
>>   My hw is p6032 rev.B eval board with idtRC64474 cpu.
>> 
>>   BTW,is that current code has no support for different PCI & CPU
>> address space?In p6032 default setting,PCI memory address 0 is
>> CPU physical address 0x10000000,and main memory is 0-0x10000000
>> for CPU,but 0x80000000-0x90000000 for pci. So I have to change
>> ioremap,virt_to_bus & bus_to_virt. I think this problem should
>> exist in many nonpc hw,could you point me a clean way?
>> 
>
>For now, we do assume PCI memeory space is identical to physical address
>space.  To remove the restriction cleanly is not a small task.
>
>It is typically much easier to modify PCI device BARS so that they do coincide
>with the same physical address.   You can control that by using the correct
>starting address for PCI MEM space in pci_auto.c resource assignment.  
It seems a good way to solve the ioremap problem and X problem.But virt_to_bus
& bus_to_virt problem remains?

Thank you very much.

>
>Jun

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
