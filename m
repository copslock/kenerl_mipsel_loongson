Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2015 09:20:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51043 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009852AbbJGHUdTESVL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Oct 2015 09:20:33 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t977KWfd012931;
        Wed, 7 Oct 2015 09:20:32 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t976dFTt012197;
        Wed, 7 Oct 2015 08:39:15 +0200
Date:   Wed, 7 Oct 2015 08:39:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Silesh C V <svellattu@mvista.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [RFC PATCH 0/7] Relocatable Kernel
Message-ID: <20151007063915.GA5425@linux-mips.org>
References: <1444038751-25105-1-git-send-email-matt.redfearn@imgtec.com>
 <CABB6SOg3CfFdqP0PopHxae=O_1vUrK=n25b7RjEzhtFEDQF32w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABB6SOg3CfFdqP0PopHxae=O_1vUrK=n25b7RjEzhtFEDQF32w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Oct 07, 2015 at 11:21:07AM +0530, Silesh C V wrote:

> Hello Matt,
> 
> On Mon, Oct 5, 2015 at 3:22 PM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> > Hi,
> > This patch series is a prerequisite of adding KASLR support for MIPS.
> > So far this supports 32/64 bit big/little endian CPUs and has been
> > tested in Qemu for Malta. It has not been tested on real hardware yet.
> > It is presented here as an early RFC for issues that people can forsee with
> > the many platforms, memory layouts etc that it must support.
> >
> > Here is a description of how relocation is achieved:
> > * Kernel is compiled & statically linked as normal (no position independent code).
> > * The linker flag --emit-relocs is added to the linker command line, causing ld
> >   to include additional ".rel" sections in the output elf
> > * A tool is used to parse the ".rel" sections and create a binary table of
> >   relocations. Each entry in the table is 32bits, comprised of a 24bit offset
> >   and 8bit relocation type.
> > * The table is appended to the kernel binary image, with some space in the
> >   memory map reserved for it in the linker script
> > * At boot, the kernel memcpy()s itself elsewhere in memory, then goes through
> >   the table performing each relocation on the new image
> > * If all goes well, control is passed to the entry point of the new kernel.

Due to the hefty size of the generated relocs we've decided to drop some
of the relocation information.  For one, due to a number of objects in
the kernel that need large alignment, such as init_thread_union, the
kernel needs at least 8k alignment anyway and that could be as large as
64k.  So if we allow relocation to addresses that are a multiple of 64
the KASLR address will lose a bit of entroy at the benefit of a
significantly smaller kernel.

Also for 64 bit objects the R_MIPS_HIGHER and R_MIPS_HIGHEST addends
will be zero if we only allow relocation within a 4GB segment.  Which
for many embedded systems may actually not be a limitation at all due
to physical memory limitations.

The highly bloated NABI relocation format that combines three relocs
into a single relocation record of which only one only ever seems to
get used allows for further space saving so so do the R_MIPS_NONE
records.

I say we because I was talking a lot with Matt about the implementation
but the code is 100% Matt's.

> We (at MontaVista) also have a working KASLR implementation (albeit on
> 3.10.x kernel on which our distribution is based) which has been/is
> being tested only on Cavium Octeon2. We used the following approach
> based on a compressed image(like what x86_64 does). This makes the
> whole thing dependent on SYS_SUPPORTS_ZBOOT though.
> 
> During build:
> 
> 1. Statically link the kernel but generate relocations with
> --emit-relocs (As you have done).
> 2. Use the relocs hostprog (Again, derived from x86 relocs tool) to
> parse and optimize the relocations generated after vmlinux is built.
> The final relocation entries are of the form  (64 bit rel_offset,8bit
> rel_type). (I see you record only the offset from start of .text in
> the offset field, Nice way to save some space :) ).
> 3. The final relocation information/table is compressed together with
> vmlinux.bin to generate vmlinuz.
> 4. We have some logic in the relocs tool to record the size of
> vmlinux.bin so that the decompressor routine can find the start of
> relocation table at runtime after decompression.
> 
> At runtime:
> 
> 4. The decompressor stub decompresses the vmlinux(along with the
> relocation table) into a random location rather than to
> VMLINUX_LOAD_ADDRESS_ULL.
> 5. The entropy is generated using LSBs of CP0 count register.
> 6. After decompression, a routine handle_relocations finds the start
> of the relocation table in the decompression buffer (see 4 above) and
> processes the relocations based on the link-load offset. (x86_64 goes
> to the end of the buffer and works backwards using 0 as a seperator
> between the relocation table and uncompressed vmlinux ).
> 7. Return the load offset to arch/mips/boot/compressed/head.S.
> 8. Based on this load offset, fixup KERNEL_ENTRY in compressed/head.S
> and jump to that address.
> 
> With this approach, the only places where we needed to touch the
> kernel proper code was
> 
> 1. We do not relocate the entries in ex_table at bootup but resort to
> fixing them up runtime (I am not proud of that code :)). My initial
> plan was to use relative entries in the ex_table  (Like what x86_64
> has). This will make the entries not to be relocated at bootup(will
> also make them half the size). But the compiler would not let me do
> that because "operation combines symbols in different segments".
> 
> 2. The entries in kcrctab gets relocated during bootup so that during
> module insertion a crc mismatch will arise and the module will not get
> installed. Fixed this the PowerPC way using ARCH_RELOCATES_KCRCTAB and
> using _text - VMLINUX_LOAD_ADDRESS as reloc_start. Maybe the relocs
> tool could take care of this. (I see that you have not taken care of
> this or maybe you have and I missed it).
> 
> There is one issue with our approach. As our objective was only KASLR,
> the vmlinuz is linked at a constant address (and I have not made the
> decompressor stub -fPIC) ignoring calc_vmlinuz_load_addr . To have a
> RELOCATABLE binary, I think we will need to have a -fPIC decompressor
> stub.
> 
>  I have not forward ported/tested my changes on newer kernels, so I do
> not have a RFC patch set yet.

I love competing implementations.  Let the better win :-)

  Ralf
