Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2010 16:02:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34724 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492386Ab0CQPCL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Mar 2010 16:02:11 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2HF28H5006552;
        Wed, 17 Mar 2010 16:02:09 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2HF28ef006550;
        Wed, 17 Mar 2010 16:02:08 +0100
Date:   Wed, 17 Mar 2010 16:02:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Subject: Re: [PATCH v3 3/3] Loongson-2F: Fixup of problems introduced by
 -mfix-loongson2f-jump of binutils 2.20.1
Message-ID: <20100317150207.GB4554@linux-mips.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
 <169f2daa3d623fe56c5b0be30feeda10bc79a478.1268453720.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169f2daa3d623fe56c5b0be30feeda10bc79a478.1268453720.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 13, 2010 at 12:34:17PM +0800, Wu Zhangjin wrote:

> -	/* reboot via jumping to boot base address */
> +	/* reboot via jumping to boot base address
> +	 *
> +	 * ".set noat" and ".set at" are used to ensure the address not break
> +	 * by the -mfix-loongson2f-jump option provided by binutils 2.20.1 (or
> +	 * higher version) which try to change the jumping address to "addr &
> +	 * 0xcfffffff" via the at($1) register, this is totally wrong for
> +	 * 0xbfc00000 (LOONGSON_BOOT_BASE).
> +	 */
> +	__asm__ __volatile__(".set noat\n");
>  	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
> +	__asm__ __volatile__(".set at\n");

Ouch.  This is fragile and totally puts the kernels fate at the mercy of
gcc and the ioremap_nocache() implementation.  GCC might emit a .set noat
at any time.  Something like

void loongson_restart(char *command)
{
	void (*func)(void);

	/* do preparation for reboot */
	mach_prepare_reboot();

	/* reboot via jumping to boot base address */
	func = (void *) ioremap_nocache(LOONGSON_BOOT_BASE, 4);

	__asm__ __volatile__(
	"	.set	noat						\n"
	"	jr	%[func]						\n"
	"	.set	at						\n"
	: /* No outputs */
	: [func] "r" (func));
}

should be safe against -mfix-loongson2f-jump I think.

The workaround in http://sourceware.org/ml/binutils/2009-11/msg00387.html
will also cause problems calling functions with bits 28..29 set, that is
in the ranges 0x81000000..0xbffffff and 0xd0000000..0xffffffff.  The
first range is not much of a problem as only the kernel proper resides
there and the kernel load address is manually selected in the Makefile.
The 2nd range might be used for under certain circumstances.

  Ralf
