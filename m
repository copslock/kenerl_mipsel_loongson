Received:  by oss.sgi.com id <S42399AbQH0Rj6>;
	Sun, 27 Aug 2000 10:39:58 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:2573 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42253AbQH0Rjb>;
	Sun, 27 Aug 2000 10:39:31 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E130E82E; Sun, 27 Aug 2000 19:42:45 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 7AA688FF5; Sun, 27 Aug 2000 19:38:20 +0200 (CEST)
Date:   Sun, 27 Aug 2000 19:38:20 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:     linux-mips@oss.sgi.com
Subject: Re: decstation boot loader
Message-ID: <20000827193820.B325@paradigm.rfc822.org>
References: <20000826220608.J3009@paradigm.rfc822.org> <XFMail.000827191949.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <XFMail.000827191949.Harald.Koerfgen@home.ivm.de>; from Harald.Koerfgen@home.ivm.de on Sun, Aug 27, 2000 at 07:19:49PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Aug 27, 2000 at 07:19:49PM +0200, Harald Koerfgen wrote:
> 
> The PROM knows nothing about partitions or such so these extends refer
> obviously to the start of the disk.
> 

Good

> 
> Yes. "mipsel-linux-objcopy --output-target=binary" is your friend.
>  

Even worse ...

Compilation - Relocation - Stripping - 

start.b: start.r
        objcopy --remove-section=.bss \
                --remove-section=.data \
                --remove-section=.reginfo \
                --remove-section=.mdebug \
                --output-target=binary start.r start.b 

start.r: start.o
        ld -Ttext=0x80020000 -Tdata=0x80020000 -Tbss=0x80020000 \
                start.o -o start.r

start.o: start.S        
        gcc -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -c start.S


> >   4. Does the MS-DOS disklabel and the DEC bootblock interfer in any
> >      kind that its impossible to have a diskloader with MS-DOS Disklabels 
> 
> No, that should work as long as the the the boot map is short enough not to
> overwrite the partition information.
>  

Does that mean that the limit of the boot_map in the bootprep
is arbitrary and the DEC firmware bootloader would continue
read/process boot_maps in the whole first block ?

> I have successfully booted Linux kernels with bootprep. Depending on
> the code you want to load, for example a second stage bootloader, you
> may need to adjust "boot_block->loadAddr" and "boot_block->execAddr".

Yep - I guessed so - loadAddr hasnt changed but i guess execAddr
needs to point to kernel_entry ...

> > I thought of a bootloader much like the silo - Capable of reading
> > an ext2 filesystem via libext2 etc.
> 
> That's what I always wanted to do but I never found the time...

:) - Well see - I got someone else i donated a Decstation to
whom i gave the first goal of writing a boot loader for the donation :)

The problem right now which i have is that i cant seem to load
ANYTHING - Not raw instructions not elf not ecoff - Even simplest
instruction like a tight loop (Wouldnt go back into prom)
dont seem to get executed. 

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
