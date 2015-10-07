Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2015 07:51:16 +0200 (CEST)
Received: from mail-io0-f169.google.com ([209.85.223.169]:32917 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007640AbbJGFvO7STwj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Oct 2015 07:51:14 +0200
Received: by iofh134 with SMTP id h134so11260149iof.0
        for <linux-mips@linux-mips.org>; Tue, 06 Oct 2015 22:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OQkwSPMdjSSZNRSyMo29nZFO40q+skQTMqb91qE2eJ0=;
        b=g+46G4XlLQLBxeYi4g5yBZCKAobit9sDrhLIODwF/1oyiavqayxHS8LQGPyeiaO1E1
         qy5zCeRrQRHomD0rxsiGkHYJpGeLBGad8KcYStcVGGfV9vkYz4+ASkbyaD49OLfzodTp
         8Vh1Btab5V11X0rXi+XKmvH2F1S7Na+jxDUvpNfwRPXWhmyNnAvH0KkEBRPGPXrr5YHa
         73Z6T+o5PgOBLm1R3+3XUCEDpASTZFbCNv3yRbytm10+Wx93BwEIodxqOJ8lCzFlWTIw
         3qAp/jk4GJwfEn3YqIiwzVSLF1T1bvifLfTTSJZSZ96A/+/5Vq37zrHduBysoy4zC55a
         VAew==
X-Gm-Message-State: ALoCoQmTqIpOXOsc8qG7sE3/qej1lp/8kgjdCCGg55QCUKdj8cwBI0gUIw1RJShd5z2c6UTehety
X-Received: by 10.107.12.94 with SMTP id w91mr36663021ioi.33.1444197067990;
        Tue, 06 Oct 2015 22:51:07 -0700 (PDT)
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com. [209.85.223.171])
        by smtp.gmail.com with ESMTPSA id h8sm577781igh.7.2015.10.06.22.51.07
        for <linux-mips@linux-mips.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2015 22:51:07 -0700 (PDT)
Received: by ioiz6 with SMTP id z6so11050011ioi.2
        for <linux-mips@linux-mips.org>; Tue, 06 Oct 2015 22:51:07 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.107.7.41 with SMTP id 41mr42538495ioh.48.1444197067217; Tue,
 06 Oct 2015 22:51:07 -0700 (PDT)
Received: by 10.79.116.75 with HTTP; Tue, 6 Oct 2015 22:51:07 -0700 (PDT)
In-Reply-To: <1444038751-25105-1-git-send-email-matt.redfearn@imgtec.com>
References: <1444038751-25105-1-git-send-email-matt.redfearn@imgtec.com>
Date:   Wed, 7 Oct 2015 11:21:07 +0530
Message-ID: <CABB6SOg3CfFdqP0PopHxae=O_1vUrK=n25b7RjEzhtFEDQF32w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Relocatable Kernel
From:   Silesh C V <svellattu@mvista.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <svellattu@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svellattu@mvista.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello Matt,

On Mon, Oct 5, 2015 at 3:22 PM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> Hi,
> This patch series is a prerequisite of adding KASLR support for MIPS.
> So far this supports 32/64 bit big/little endian CPUs and has been
> tested in Qemu for Malta. It has not been tested on real hardware yet.
> It is presented here as an early RFC for issues that people can forsee with
> the many platforms, memory layouts etc that it must support.
>
> Here is a description of how relocation is achieved:
> * Kernel is compiled & statically linked as normal (no position independent code).
> * The linker flag --emit-relocs is added to the linker command line, causing ld
>   to include additional ".rel" sections in the output elf
> * A tool is used to parse the ".rel" sections and create a binary table of
>   relocations. Each entry in the table is 32bits, comprised of a 24bit offset
>   and 8bit relocation type.
> * The table is appended to the kernel binary image, with some space in the
>   memory map reserved for it in the linker script
> * At boot, the kernel memcpy()s itself elsewhere in memory, then goes through
>   the table performing each relocation on the new image
> * If all goes well, control is passed to the entry point of the new kernel.
>

We (at MontaVista) also have a working KASLR implementation (albeit on
3.10.x kernel on which our distribution is based) which has been/is
being tested only on Cavium Octeon2. We used the following approach
based on a compressed image(like what x86_64 does). This makes the
whole thing dependent on SYS_SUPPORTS_ZBOOT though.

During build:

1. Statically link the kernel but generate relocations with
--emit-relocs (As you have done).
2. Use the relocs hostprog (Again, derived from x86 relocs tool) to
parse and optimize the relocations generated after vmlinux is built.
The final relocation entries are of the form  (64 bit rel_offset,8bit
rel_type). (I see you record only the offset from start of .text in
the offset field, Nice way to save some space :) ).
3. The final relocation information/table is compressed together with
vmlinux.bin to generate vmlinuz.
4. We have some logic in the relocs tool to record the size of
vmlinux.bin so that the decompressor routine can find the start of
relocation table at runtime after decompression.

At runtime:

4. The decompressor stub decompresses the vmlinux(along with the
relocation table) into a random location rather than to
VMLINUX_LOAD_ADDRESS_ULL.
5. The entropy is generated using LSBs of CP0 count register.
6. After decompression, a routine handle_relocations finds the start
of the relocation table in the decompression buffer (see 4 above) and
processes the relocations based on the link-load offset. (x86_64 goes
to the end of the buffer and works backwards using 0 as a seperator
between the relocation table and uncompressed vmlinux ).
7. Return the load offset to arch/mips/boot/compressed/head.S.
8. Based on this load offset, fixup KERNEL_ENTRY in compressed/head.S
and jump to that address.

With this approach, the only places where we needed to touch the
kernel proper code was

1. We do not relocate the entries in ex_table at bootup but resort to
fixing them up runtime (I am not proud of that code :)). My initial
plan was to use relative entries in the ex_table  (Like what x86_64
has). This will make the entries not to be relocated at bootup(will
also make them half the size). But the compiler would not let me do
that because "operation combines symbols in different segments".

2. The entries in kcrctab gets relocated during bootup so that during
module insertion a crc mismatch will arise and the module will not get
installed. Fixed this the PowerPC way using ARCH_RELOCATES_KCRCTAB and
using _text - VMLINUX_LOAD_ADDRESS as reloc_start. Maybe the relocs
tool could take care of this. (I see that you have not taken care of
this or maybe you have and I missed it).

There is one issue with our approach. As our objective was only KASLR,
the vmlinuz is linked at a constant address (and I have not made the
decompressor stub -fPIC) ignoring calc_vmlinuz_load_addr . To have a
RELOCATABLE binary, I think we will need to have a -fPIC decompressor
stub.

 I have not forward ported/tested my changes on newer kernels, so I do
not have a RFC patch set yet.

Thanks,
Silesh.
