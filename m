Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 19:06:41 +0100 (BST)
Received: from clock-tower.bc.nu ([81.2.110.250]:52679 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133549AbVJUSGY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Oct 2005 19:06:24 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id j9LIZ9RH004241;
	Fri, 21 Oct 2005 19:35:09 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id j9LIZ6la004239;
	Fri, 21 Oct 2005 19:35:06 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Patch: ATI Xilleon port 10/11 Xilleon IDE controller support
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	ddaney@avtrex.com
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <17239.48184.340986.463557@dl2.hq2.avtrex.com>
References: <17239.48184.340986.463557@dl2.hq2.avtrex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Fri, 21 Oct 2005 19:35:05 +0100
Message-Id: <1129919705.3542.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Iau, 2005-10-20 at 08:48 -0700, David Daney wrote:

> +int xilleon_ide_proc;
> +
> +static struct pci_dev *bmide_dev;
> +
> +/* #define DEBUG 1 */
> +
> +#if defined(CONFIG_PROC_FS)
> +static u8 xilleon_proc = 0;

The proc interfaces have been dropped so this chunk can all go away

> +
> +/**
> + *	xilleon_ide_get_info		-	generate xilleon /proc file 
> + *	@buffer: buffer for data
> + *	@addr: set to start of data to use
> + *	@offset: current file offset
> + *	@count: size of read
