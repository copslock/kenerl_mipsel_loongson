Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 05:41:18 +0000 (GMT)
Received: from rrcs-central-24-123-115-44.biz.rr.com ([IPv6:::ffff:24.123.115.44]:14720
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225316AbTKDFlH>; Tue, 4 Nov 2003 05:41:07 +0000
Received: from radium ([192.168.0.20])
	by localhost.localdomain (8.12.8/8.12.8) with ESMTP id hA45eHmv004750;
	Mon, 3 Nov 2003 23:40:18 -0600
From: "Lyle Bainbridge" <lyle@zevion.com>
To: <yikok9@yahoo.com.cn>, "'linux-mips'" <linux-mips@linux-mips.org>
Subject: RE: boot pb1500 from flash through 16-bit data bus?
Date: Mon, 3 Nov 2003 23:41:26 -0600
Message-ID: <000001c3a296$4d51b3a0$1400a8c0@radium>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
In-Reply-To: <20031104021343Z8225402-1272+8745@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <lyle@zevion.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lyle@zevion.com
Precedence: bulk
X-list: linux-mips

Hi,

If you are building as little endian and booting from a 16bit ROM then
simply load your boot code into the 16 bit flash. You shouldn't need to
swap bytes and half words yourself. Here's why:

The Au1500 starts in big endian mode but the static bus controller
starts in little endian mode and will actually read the little endian
boot code correctly.  The very first thing you need to do in your boot
code is switch the Au1500 to little endian mode. Then you need to do the
other initial activities such as establishing the status register,
config0, cause register and initializing the caches and TLB.

If you are building as big endian it is a little more difficult. Place
the following block at the reset vector:

    .long 0xb4003c08 # lui t0,0xb400
    .long 0x10003508 # ori t0,t0,0x1000
    .long 0x00008d09 # lw t1,0(t0)
    .long 0x02003529 # ori t1,t1,0x200
    .long 0x0000ad09 # sw t1,0(t0)
    .long 0x00000000 # nop
    .long 0x00000000 # nop
    .long 0x00000000 # nop
    .long 0x00000000 # nop 

This is a small fragement of little endian code that switches the static
bus controller to big endian mode.  That way when the processor boots
and reads the big endian boot code as little endian, the first part will
be little endian and it will work.  Of course the code fragement above
immediately switches the static bus to BE and everything will continue
correctly.  I know it seems a little strange.

Hope this helps.  Email if you have any questions.

Cheers
Lyle


> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Wang Zaifang
> Sent: Monday, November 03, 2003 8:13 PM
> To: linux-mips
> Subject: boot pb1500 from flash through 16-bit data bus?
> 
> 
> hi, 
>   Does anyone have experience on writing 16-bit booting code 
> for PB1500?
>   I'm working on a customized au1500 board that has puzzled 
> us for serveral days, :-( The board is designed to boot from 
> flash using 16-bit data bus, however it seemed that the code 
> we stored in the flash does not run at all. There might be 
> some errors in our design, so we turn to the PB1500 eval-board.
>   I wrote a piece of testing code that sends 010101... series 
> to GPIO[0] continuousely after reset. The code runs well when 
> the SRAM data bus is set to 32-bit width, i.e. a square 
> waveform appears on GPIO[0]. Then I burn the code into flash 
> through YAMON, assuring the code only reside in one flash 
> chip of the two. Content of the flash looks like this in YAMON:
> 
> YAMON> dump bdc00000
> 
> BDC00000: 90 B1 00 00 08 3C 00 00 80 80 00 00 09 34 00 00  
> .±...<.......4..
> BDC00010: 2C 00 00 00 09 AD 00 00 FF FF 00 00 09 34 00 00  
> ,....-.......4..
> BDC00020: 00 01 00 00 09 AD 00 00 00 00 00 00 09 24 00 00  
> .....-.......$.. ...
> 
>   Each instruction word is split into two half-words, and put 
> into lower 16-bits of two words. Then I reset the PB1500 
> board, switch S15 to set the SRAM data bus to 16-bit mode, 
> switch S13 to boot from the specified flash chip. But the 
> code will not run, even after I swap the byte-order and the 
> halfword-order.
> 
>   Any advice will be appreciated, :-)
> 
> 　　　　　　　　Wang Zaifang
> 　　　　　　　　yikok9@yahoo.com.cn
> 　　　　　　　　　　2003-11-04
> 
