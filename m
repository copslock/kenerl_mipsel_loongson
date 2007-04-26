Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2007 03:08:10 +0100 (BST)
Received: from smtp1.linux-foundation.org ([65.172.181.25]:51391 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20023095AbXDZCII (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Apr 2007 03:08:08 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3Q27s25025321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Apr 2007 19:07:56 -0700
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l3Q27rKQ018592;
	Wed, 25 Apr 2007 19:07:54 -0700
Date:	Wed, 25 Apr 2007 19:07:53 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	"Aeschbacher, Fabrice" <Fabrice.Aeschbacher@siemens.com>
Cc:	"lkml" <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Subject: Re: pcmcia - failed to initialize IDE interface
Message-Id: <20070425190753.fb8c272d.akpm@linux-foundation.org>
In-Reply-To: <D7810733513F4840B4EBAAFA64D9C6A4012D5E5F@stgw002a.ww002.siemens.net>
References: <D7810733513F4840B4EBAAFA64D9C6A4012D5E5F@stgw002a.ww002.siemens.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 25 Apr 2007 15:27:26 +0200 "Aeschbacher, Fabrice" <Fabrice.Aeschbacher@siemens.com> wrote:

> Hi,
> 
> [kernel 2.6.20.7, arch=mips, processor=amd au1550]
> 
> I'm trying to install a 2.6 kernel on an Alchemy au1550, and having
> problem with the pcmcia socket, where I plugged a CompactFlash card. The
> card seems to be recognized by the kernel, appears in
> /sys/bus/pcmcia/devices, but not in /proc/bus/pccard, and I can't access
> the device (/dev/hda).
> 
> The relevant console messages:
> ----------------------------------------------------------------
> pccard: PCMCIA card inserted into slot 0
> pcmcia: registering new device pcmcia0.0
> hda: SanDisk SDCFB-64, CFA DISK drive
> ide0: Disabled unable to get IRQ 35.
> ide0: failed to initialize IDE interface
> ide0: I/O resource 0x10200E-0x10200E not free.
> ide0: ports already in use, skipping probe
> ide0: I/O resource 0x10200E-0x10200E not free.
> ide0: ports already in use, skipping probe
> ide0: I/O resource 0x10200E-0x10200E not free.
> ide0: ports already in use, skipping probe
> ide0: I/O resource 0x10200E-0x10200E not free.
> ide0: ports already in use, skipping probe
> ide0: I/O resource 0x10200E-0x10200E not free.
> ide0: ports already in use, skipping probe
> ide0: I/O resource 0x10200E-0x10200E not free.
> ide0: ports already in use, skipping probe
> ide0: I/O resource 0x10200E-0x10200E not free.
> ide0: ports already in use, skipping probe
> ide0: I/O resource 0x10200E-0x10200E not free.
> ide0: ports already in use, skipping probe
> ide0: I/O resource 0x10200E-0x10200E not free.
> ide0: ports already in use, skipping probe
> ide-cs: ide_register() at 0x102000 & 0x10200e, irq 35 failed
> ----------------------------------------------------------------
> 
> Here is the relevant part of the kernel config:
> CONFIG_IDE=y
> CONFIG_IDE_GENERIC=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDECS=y
> CONFIG_PCCARD=y
> CONFIG_PCMCIA_DEBUG=y
> CONFIG_PCMCIA=y
> CONFIG_PCMCIA_AU1X00=y
> 

(cc'ed linux-mips)

Perhaps /proc/ioports will tell us where the conflict lies.

The output of `dmesg -s 1000000' might also be needed.
