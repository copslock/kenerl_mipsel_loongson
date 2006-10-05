Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2006 12:14:31 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:46758 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S20039152AbWJELO0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2006 12:14:26 +0100
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k95BEMQe012566;
	Thu, 5 Oct 2006 13:14:22 +0200 (MEST)
Date:	Thu, 5 Oct 2006 13:14:21 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	"Kota, Ramgopal" <Ramgopal.Kota@analog.com>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: R300 Mips Question
In-Reply-To: <7D453D0504B6A2429F98F4D72CBEDE490D7D8795@nwd2exm5.ad.analog.com>
Message-ID: <Pine.LNX.4.62.0610051309560.23535@pademelon.sonytel.be>
References: <7D453D0504B6A2429F98F4D72CBEDE490D7D8795@nwd2exm5.ad.analog.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 5 Oct 2006, Kota, Ramgopal wrote:
> I am new to MIPS and uclinux port.I am getting familiarised with 2.6.18
> linux code.
> I see the following code in asm/mips/kernel/genex.S &
> asm/mips/kernel/traps.c
> 
> ++++++++++++ Genex.S  +++++++++++++
> NESTED(except_vec3_generic, 0, sp)
>         .set    push
>         .set    noat
> #if R5432_CP0_INTERRUPT_WAR
>         mfc0    k0, CP0_INDEX
> #endif
>         mfc0    k1, CP0_CAUSE
>         andi    k1, k1, 0x7c
> #ifdef CONFIG_64BIT
>         dsll    k1, k1, 1
> #endif
>         PTR_L   k0, exception_handlers(k1)
>         jr      k0
>         .set    pop
>         END(except_vec3_generic)
> 
> +++++++++++++ traps.c +++++++++++++++
>         set_except_vector(0, handle_int);
>         set_except_vector(1, handle_tlbm);
>         set_except_vector(2, handle_tlbl);
>         set_except_vector(3, handle_tlbs);
> 
>         set_except_vector(4, handle_adel);
>         set_except_vector(5, handle_ades);
> 
>         set_except_vector(6, handle_ibe);
>         set_except_vector(7, handle_dbe);
> 
>         set_except_vector(8, handle_sys);
>         set_except_vector(9, handle_bp);
>         set_except_vector(10, handle_ri);
>         set_except_vector(11, handle_cpu);
>         set_except_vector(12, handle_ov);
>         set_except_vector(13, handle_tr);
> 
> In R3000 manual , bits 2-6 indicate exception code value. In genex.S ,
> the cause register is anded with 0x7c to extract 2-6 bits. 
> I am not able to understand why it is not shifted the last 2 bits.
> 
> Please try to educate me why this is not done.

The exception code value is used to obtain a pointer from the
exception_handlers array. Since pointers are 32 bit, you have to convert the
index into the array to an offset for the array by multiplying by 4. This
nullifies the shift.

On 64-bit platforms, pointers are 64 bit and the index is converted to an
offset by multiplying by 8. Since the value is already shifted 2 positions to
the left, only 1 shift remains to be done (cfr. the dsll).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
