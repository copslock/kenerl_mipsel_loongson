Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9ABdEo15635
	for linux-mips-outgoing; Wed, 10 Oct 2001 04:39:14 -0700
Received: from dea.linux-mips.net (a1as04-p174.stg.tli.de [195.252.186.174])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9ABd8D15632
	for <linux-mips@oss.sgi.com>; Wed, 10 Oct 2001 04:39:09 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9ABcWT13778;
	Wed, 10 Oct 2001 13:38:32 +0200
Date: Wed, 10 Oct 2001 13:38:32 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Shuanglin Wang <swang@mmc.atmel.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: MIPS and pci_alloc_consistent()?
Message-ID: <20011010133832.B13349@dea.linux-mips.net>
References: <3BC36AE4.4D1EE63E@mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC36AE4.4D1EE63E@mmc.atmel.com>; from swang@mmc.atmel.com on Tue, Oct 09, 2001 at 04:23:49PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Oct 09, 2001 at 04:23:49PM -0500, Shuanglin Wang wrote:

> I tried to use the pci_alloc_consistent() to allocate one-page  DMA'able
> memory for my device driver.  But, when booting up the system, it was
> always  failed to execute the pci_alloc_consistent() by showing some
> memory errors.
>
> I traced the code to the function __alloc_page() in the file
> mm/page_alloc.c, and found the system called  "wakeup_kswapd()".  But at
> that time,  the kswapd process pointer is a NULL pointer and the
> wakeup-related codes don't check the pointer is NULL or not,  so the
> system was stopped because of dereferencing the null pointer.

This sounds like either memory corruption has overwritten the kernel pointer
or you're trying to use pci_alloc_consistent before the memory managment
is initialized.

> Anybody has some ideas about the problem?  Or are there other convenient
> methods to allocate DMA'able memory?

Anything else than the pci_alloc_* functions isn't portable.

  Ralf
