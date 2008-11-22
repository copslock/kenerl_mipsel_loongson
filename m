Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 07:05:49 +0000 (GMT)
Received: from verein.lst.de ([213.95.11.210]:20130 "EHLO verein.lst.de")
	by ftp.linux-mips.org with ESMTP id S23827912AbYKVHFm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Nov 2008 07:05:42 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id mAM75YIF003602
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 22 Nov 2008 08:05:35 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id mAM75Ywh003600;
	Sat, 22 Nov 2008 08:05:34 +0100
Date:	Sat, 22 Nov 2008 08:05:34 +0100
From:	Christoph Hellwig <hch@lst.de>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 01/26] MIPS: Add Cavium OCTEON processor support files to arch/mips/cavium-octeon/executive and asm/octeon.
Message-ID: <20081122070534.GA3063@lst.de>
References: <49233FDE.3010404@caviumnetworks.com> <1227047013-4785-1-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1227047013-4785-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

> +#
> +# Makefile for the Cavium Octeon specific kernel interface routines
> +# under Linux.
> +#
> +# This file is subject to the terms and conditions of the GNU General Public
> +# License.  See the file "COPYING" in the main directory of this archive
> +# for more details.
> +#
> +# Copyright (C) 2005-2008 Cavium Networks
> +#
> +
> +
> +source:=$(srctree)/arch/mips/include/asm/octeon
> +EXTRA_CFLAGS	+= -I$(source) -I$(source)/config

Just use the proper

#include <asm/octeon/*.h>

or 

#include <asm/octeon/config/*.h>

include statements instead.

> +
> +executive-files := cvmx-bootmem.o
> +executive-files += cvmx-l2c.o
> +executive-files += cvmx-sysinfo.o
> +executive-files += octeon-model.o
> +obj-y := $(executive-files)

This shoud be:

obj-y	+= cvmx-bootmem.o cvmx-l2c.o cvmx-sysinfo.o octeon-model.o

> +executive-obj-files := $(executive-files:%=$(obj)/%)
> +executive-src-files := $(executive-obj-files:%.o=%.c)

And these aren't needed at all.

> +/**
> + * @file
> + * Simple allocate only memory allocator.  Used to allocate memory at application
> + * start time.
> + *
> + */

This is not a proper kerneldoc comment, so please remove the /** comment
start that would confuse the kernel-doc tool, and the @file thingy.

> +#undef	MAX
> +#define MAX(a, b)  (((a) > (b)) ? (a) : (b))
> +
> +#undef	MIN
> +#define MIN(a, b)  (((a) < (b)) ? (a) : (b))

Please use the kernel min/max/min_t/max_t helpers.

> +#define ALIGN_ADDR_UP(addr, align)     (((addr) + (~(align))) & (align))

Please use __ALIGN_MASK from kernel.h

> +	return cvmx_bootmem_alloc_named_range (size, address,
> +					       address + size, 0, name);

No space before the ( please.  Did you run these patches through
checkpath.pl at all?  It should have complained about a few of those
things.

> +				/* adjust prev ptr or head to remove this entry from list */

Please make sur all lines are under 80 characters.  Again, checkpatch
would have caught this.

> +	cvmx_spinlock_unlock((cvmx_spinlock_t *) &(cvmx_bootmem_desc->lock));

This could just be:

	cvmx_spinlock_unlock((cvmx_spinlock_t *) &cvmx_bootmem_desc->lock);

But given that you case it all the time, and mostly use the
CVMX_BOOTMEM_FLAG_NO_LOCKING flag around it a proper helper that hides
the details from the callers would be even better.

> +void cvmx_bootmem_lock(void)
> +{
> +	cvmx_spinlock_lock((cvmx_spinlock_t *) &(cvmx_bootmem_desc->lock));
> +}
> +
> +void cvmx_bootmem_unlock(void)
> +{
> +	cvmx_spinlock_unlock((cvmx_spinlock_t *) &(cvmx_bootmem_desc->lock));
> +}

Well, there already are some helpers, just not used..

> +typedef union {

No typedefs for structures please.  Again, please run your patches
through checkpatch.pl

> +	if (OCTEON_IS_MODEL(OCTEON_CN56XX) ||
> +	    OCTEON_IS_MODEL(OCTEON_CN52XX) ||
> +	    OCTEON_IS_MODEL(OCTEON_CN58XX) ||
> +	    OCTEON_IS_MODEL(OCTEON_CN50XX) || OCTEON_IS_MODEL(OCTEON_CN38XX))
> +		l2_assoc = 8;
> +	else if (OCTEON_IS_MODEL(OCTEON_CN31XX) ||
> +		 OCTEON_IS_MODEL(OCTEON_CN30XX))
> +		l2_assoc = 4;
> +	else {
> +		cvmx_dprintf("Unsupported OCTEON Model in %s\n", __FUNCTION__);
> +		l2_assoc = 8;
> +	}

This would be much better with a switch on the mode, eh?

> +/**
> + * This function is used in non-simple executive environments (such as
> + * Linux kernel, u-boot, etc.)  to configure the minimal fields that
> + * are required to use simple executive files directly.
> + *
> + * Locking (if required) must be handled outside of this
> + * function
> + *
> + * @phy_mem_desc_ptr:
> + *                   Pointer to global physical memory descriptor
> + *                   (bootmem descriptor) @board_type: Octeon board
> + *                   type enumeration
> + *
> + * @board_rev_major:
> + *                   Board major revision
> + * @board_rev_minor:
> + *                   Board minor revision
> + * @cpu_clock_hz:
> + *                   CPU clock freqency in hertz
> + *

Again, not proper kerneldoc comments.  Please make sure the kerne-doc
script doesn't barf up on your code.

> + */
> +int cvmx_sysinfo_minimal_initialize(void *phy_mem_desc_ptr,
> +				    uint16_t board_type,
> +				    uint8_t board_rev_major,
> +				    uint8_t board_rev_minor,
> +				    uint32_t cpu_clock_hz)
> +{
> +
> +	/* The sysinfo structure was already initialized */
> +	if (state.sysinfo.board_type)
> +		return 0;
> +
> +	memset(&(state.sysinfo), 0x0, sizeof(state.sysinfo));
> +	state.sysinfo.phy_mem_desc_ptr = phy_mem_desc_ptr;
> +	state.sysinfo.board_type = board_type;
> +	state.sysinfo.board_rev_major = board_rev_major;
> +	state.sysinfo.board_rev_minor = board_rev_minor;
> +	state.sysinfo.cpu_clock_hz = cpu_clock_hz;
> +
> +	return 1;

Why isn't this just merged into the (AFAICS) only caller?

> +const char *octeon_model_get_string(uint32_t chip_id)
> +{
> +	static char buffer[32];
> +	return octeon_model_get_string_buffer(chip_id, buffer);
> +}

This doesn't seem like a particularly useful helper.  Better keep
a buffer in every potential caller instead of adding latent concurrency
problems.

> +#define CVMX_BREAK asm volatile ("break")
> +#define CVMX_SYNC asm volatile ("sync" : : :"memory")
> +/* String version of SYNCW macro for using in inline asm constructs */
> +#define CVMX_SYNCW_STR "syncw\nsyncw\n"
> +#ifdef __OCTEON__
> +
> +/* Deprecated, will be removed in future release */
> +#define CVMX_SYNCIO asm volatile ("nop")
> +
> +#define CVMX_SYNCIOBDMA asm volatile ("synciobdma" : : :"memory")
> +
> +/* Deprecated, will be removed in future release */
> +#define CVMX_SYNCIOALL asm volatile ("nop")

So what exactly does this buy over adding the asm statements inline?

> +#define CVMX_MT_AES_ENC_CBC0(val)   asm volatile ("dmtc2 %[rt],0x0108"                   :                 : [rt] "d" (val))
> +#define CVMX_MT_AES_ENC_CBC1(val)   asm volatile ("dmtc2 %[rt],0x3109"                   :                 : [rt] "d" (val))
> +#define CVMX_MT_AES_ENC0(val)       asm volatile ("dmtc2 %[rt],0x010a"                   :                 : [rt] "d" (val))

Lots of this stuff doesn't seem to be used at all..

> +#if (CVMX_BOOTINFO_MAJ_VER == 1)
> +#define CVMX_BOOTINFO_OCTEON_SERIAL_LEN 20
> +/* This structure is populated by the bootloader.  For binary
> +** compatibility the only changes that should be made are
> +** adding members to the end of the structure, and the minor
> +** version should be incremented at that time.
> +** If an incompatible change is made, the major version
> +** must be incremented, and the minor version should be reset
> +** to 0.

If this is populated by the bootloader you need to support all versions
in one build at runtime.

> +typedef struct {


No typedefs again, please.  But checkpatch.pl will catch this.

> +/**
> + * Allocate a block of memory from the free list that was passed
> + * to the application by the bootloader, and assign it a name in the
> + * global named block table.  (part of the cvmx_bootmem_descriptor_t structure)
> + * Named blocks can later be freed.
> + *
> + * @size:      Size in bytes of block to allocate
> + * @alignment: Alignment required - must be power of 2
> + * @name:      name of block - must be less than CVMX_BOOTMEM_NAME_LEN bytes
> + *
> + * Returns pointer to block of memory, NULL on error
> + */

Please make these proper kernel-doc comments and move them to the
implementation where the kernel-doc script expects them. 

> +#define CVMX_L2_ASSOC     cvmx_l2c_get_num_assoc()	/* Deprecated macro, use function */
> +#define CVMX_L2_SET_BITS  cvmx_l2c_get_set_bits()	/* Deprecated macro, use function */
> +#define CVMX_L2_SETS      cvmx_l2c_get_num_sets()	/* Deprecated macro, use function */
> +

So kill the bloody macros.

> +/* This file defines macros for use in determining the current
> +    building environment. It defines a single CVMX_BUILD_FOR_*
> +    macro representing the target of the build. The current
> +    possibilities are:
> +	CVMX_BUILD_FOR_UBOOT
> +	CVMX_BUILD_FOR_LINUX_KERNEL
> +	CVMX_BUILD_FOR_LINUX_USER
> +	CVMX_BUILD_FOR_LINUX_HOST
> +	CVMX_BUILD_FOR_VXWORKS
> +	CVMX_BUILD_FOR_STANDALONE */
> +/* We are in the Linux kernel on Octeon */

So kill all this junk..

> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <stdarg.h>

And move these into the files that need them.

> +/**
> + * @file
> + *
> + * Implementation of spinlocks.
> + *
> + */

Well, magic hw/hypervisor/whatever shared spinlocks.  That shoud be
mentioned for sure..

> +#define cvmx_warn(format, ...) pr_warning(format, ##__VA_ARGS__)
> +#define cvmx_warn_if(expression, format, ...) if (expression) cvmx_warn(format, ##__VA_ARGS__)

Just opencode these two, please.

> + * __builtin_expect GCC operation to control branch
> + * probabilities for a conditional. For example, an "if"
> + * statement in the code that will almost always be
> + * executed should be written as "if (cvmx_likely(...))".
> + * If the "else" section of an if statement is more
> + * probable, use "if (cvmx_unlikey(...))".
> + */
> +#define cvmx_likely(x)      __builtin_expect(!!(x), 1)
> +#define cvmx_unlikely(x)    __builtin_expect(!!(x), 0)

Please use the native ones.

> +#ifndef TRUE
> +#define FALSE   0
> +#define TRUE    (!(FALSE))
> +#endif

Please use the proper C99 bool types as the rst of the kernel.

> +/* These macros for used by 32 bit applications */

WTF

> + * Convert a memory pointer (void*) into a hardware compatable
> + * memory address (uint64_t). Octeon hardware widgets don't
> + * understand logical addresses.

Should be done using the normal mm helpers..



Please review all these headers for unused junk that crept in from
previous embedded projects.  And please also apply all the suggestions
to other code in case it's up to similar "quality" standards.

And remember, checkpath.pl and the kernel-doc script are your friends..
