Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2003 21:23:07 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:50641 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225243AbTCCVXG>;
	Mon, 3 Mar 2003 21:23:06 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id WAA18717;
	Mon, 3 Mar 2003 22:22:26 +0100 (MET)
Date: Mon, 3 Mar 2003 22:22:31 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Improper handling of unaligned user address access?
In-Reply-To: <3E63B17C.8000403@realitydiluted.com>
Message-ID: <Pine.GSO.4.21.0303032219100.12650-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 3 Mar 2003, Steven J. Hill wrote:
> I am having some issues using 'copy_from_user' in a driver. The issue
> is that instead of returning a EFAULT for a bad address, it throws a
> kernel panic and then proceeds to segfault the application. I am doing
> a test on the module where I pass in an invalid user source address:
> 
>     copy_from_user(&dst, src, sizeof(dst));
> 
> where 'src' is equal to '0xa'. Now for the interesting part. When it
> goes to do the copy, in 'arch/mips/lib/memcpy.S' it correctly jumps
> to 'src_unaligned_dst_aligned' and then to 'cleanup_src_unaligned'
> and we have the following code:
> 
>     8025f004 <cleanup_src_unaligned>:
>     8025f004:       10c00017        beqz    a2,8025f064 <done>
>     8025f008:       30d80003        andi    t8,a2,0x3
>     8025f00c:       13060009        beq     t8,a2,8025f034 <copy_bytes>
>     8025f010:       88a80000        lwl     t0,0(a1)
> 
> The instruction at 8025f00c is the offending instruction, however, the
                     ^^^^^^^^
Don't you mean 8025f010?

> kernel oops that kills the process shows:
> 
>     Unable to handle kernel paging request at virtual address 0000000a,
>     epc == 8025f00c, ra == 8011c3c8
>     Oops in fault.c:do_page_fault, line 199:
>     $0 : 00000000 00000012 0000001a 0000001a 87887f10 0000000a 00000008 
> 00000001
>     $8 : 00000000 00000000 00000000 00001116 802ec2f0 fffffffe ffffffff 
> 00000010
>     $16: 0000000a 7fff7d68 87887f10 00000000 004009b4 00000000 00000000 
> 00000000
>     $24: 00000000 87887e18                   87886000 87887f00 7fff7d30 
> 8011c3c8
>     Hi : 00000000
>     Lo : 00000000
>     epc  : 8025f00c    Not tainted
>     Status: 3000fc03
>     Cause : 90000008
> 
> I am using the last version of the 2.4.18 Linux/MIPS kernel. It looks
> like there was a possible fix for this in 'arch/mips/kernel/unaligned.c'
> by Ralf, but it did not seem to work. Any thoughts on this?

This looks like the unaligned access in a branch delay slot problem I
experienced a while ago, where the CPU doesn't set the BD flag if the branch is
not taken. Can you please try the patch I posted?

BTW, what kind of CPU is this? A VR41xx?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
