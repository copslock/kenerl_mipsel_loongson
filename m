Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4A62SS22364
	for linux-mips-outgoing; Wed, 9 May 2001 23:02:28 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4A62RF22361
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 23:02:27 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 684FCF1A9; Wed,  9 May 2001 23:01:24 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 3D2291F42A; Wed,  9 May 2001 23:01:54 -0700 (PDT)
Date: Wed, 9 May 2001 23:01:54 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Configuration of PCI Video card on a BIOS-less board
Message-ID: <20010509230154.E15089@foobazco.org>
References: <20010510055512.96321.qmail@web11902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010510055512.96321.qmail@web11902.mail.yahoo.com>; from wgowcher@yahoo.com on Wed, May 09, 2001 at 10:55:12PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 09, 2001 at 10:55:12PM -0700, Wayne Gowcher wrote:

> I can probe the Base Address Register successfully,
> determine the cards memory requirement and that it is
> memory rather than mapped IO. But when I try to write
> the address I have allocated to the PCI card ( eg
> 0xC000 0000 ) the address will not latch in the base
> address register.

Is that a valid bus address on your system?

> Does anyone know of any code that carries out PCI
> probing similar to that found on x86 PC's ?

Look in drivers/pci - that can scan the bus and such - it's generic
code used on many architectures.  Many systems lack "bios" and work
fine in linux.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
