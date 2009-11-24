Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 00:43:56 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46159 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493623AbZKXXnx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2009 00:43:53 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAONi7mP022485;
        Tue, 24 Nov 2009 23:44:09 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAONi6he022483;
        Tue, 24 Nov 2009 23:44:06 GMT
Date:   Tue, 24 Nov 2009 23:44:06 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Adam Nielsen <a.nielsen@shikadi.net>
Cc:     linux-mips@linux-mips.org
Subject: Re: Can you add a signature to the kernel ELF image?
Message-ID: <20091124234406.GB20316@linux-mips.org>
References: <4B0C625B.5070408@shikadi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B0C625B.5070408@shikadi.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 25, 2009 at 08:46:51AM +1000, Adam Nielsen wrote:

> I'm trying to port the kernel to an NCD HMX X-Terminal (MIPS R4600), but 
> the one thing I have to do before I can actually boot the image is attach 
> a signature to it. I have the signature 'code' in assembly[1], but I'm 
> not sure how to link it so that it ends up as the first bit of code in 
> the ELF image (the very first instruction is a 'b' to jump over the 
> actual signature text.)
>
> Without this the boot monitor will refuse to boot the kernel.  Any 
> suggestions as to how I might accomplish this?

Take a look at arch/mips/kernel/head.S.  This file will be the first on
the final linker call's command line, that is head.S's .text section will
end at the lowest address.

In head.S there is this

#ifdef CONFIG_BOOT_RAW
        /*
         * Give us a fighting chance of running if execution beings at the
         * kernel load address.  This is needed because this platform does
         * not have a ELF loader yet.
         */
FEXPORT(__kernel_entry)
        j       kernel_entry
#endif

ifdef.  Add your own magic stuff there, something like

#ifdef CONFIG_NCD_HMX
	b	1f
	nop
	nop
	.word	0x20
	.asciz	"XncdHMX"
	.word	0, 0, 0
#endif

> [1] http://www.linux-mips.org/wiki/HMX

The wiki page says something about a CRC but just poking a 0x20 into a
constant address is not exactly a CRC calculation.  Not sure how this
really is meant.

  Ralf
