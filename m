Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 15:30:59 +0100 (CET)
Received: from verein.lst.de ([213.95.11.210]:56005 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491061Ab1ASOa4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jan 2011 15:30:56 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
        by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id p0JEUnE5004876
        (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
        Wed, 19 Jan 2011 15:30:49 +0100
Received: (from hch@localhost)
        by verein.lst.de (8.12.3/8.12.3/Debian-7.2) id p0JEUnFR004875;
        Wed, 19 Jan 2011 15:30:49 +0100
Date:   Wed, 19 Jan 2011 15:30:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: add CONFIG_VIRTUALIZATION for virtio support
Message-ID: <20110119143049.GA4820@lst.de>
References: <1295349645-16805-1-git-send-email-aurelien@aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295349645-16805-1-git-send-email-aurelien@aurel32.net>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Tue, Jan 18, 2011 at 12:20:44PM +0100, Aurelien Jarno wrote:
> Add CONFIG_VIRTUALIZATION to the MIPS architecture and include the
> the virtio code there. Used to enable the virtio drivers under QEMU.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  arch/mips/Kconfig |   16 ++++++++++++++++

> +menuconfig VIRTUALIZATION
> +	bool "Virtualization"
> +	default n
> +	---help---
> +	  Say Y here to get to see options for using your Linux host to run other
> +	  operating systems inside virtual machines (guests).
> +	  This option alone does not add any kernel code.
> +
> +	  If you say N, all options in this submenu will be skipped and disabled.

This item seems rather misleading as you're using virtio drivers as a
guest.  I think the right fix is to just remove the VIRTUALIZATION
dependency for the qemu drivers and just include them from
drivers/Kconfig for all architectures.  There aren't a whole lot Linux
architectures that don't have a qemu emulation these days.
