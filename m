Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Feb 2008 11:20:09 +0000 (GMT)
Received: from vs166246.vserver.de ([62.75.166.246]:3772 "EHLO
	vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20025911AbYBQLUG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 Feb 2008 11:20:06 +0000
Received: from t343f.t.pppool.de ([89.55.52.63] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1JQhYx-00055U-HT; Sun, 17 Feb 2008 11:20:03 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	Andrew Sharp <andy.sharp@onstor.com>
Subject: Re: Linux MIPS PCI resource sanity check
Date:	Sun, 17 Feb 2008 12:19:41 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
References: <200802161139.10791.mb@bu3sch.de> <47B6BFD4.5050404@ru.mvista.com> <20080216153530.7a426a73@ripper.onstor.net>
In-Reply-To: <20080216153530.7a426a73@ripper.onstor.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200802171219.42251.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Sunday 17 February 2008 00:35:30 Andrew Sharp wrote:
> Actually, IIRC, resources are based on what the device requested, so a
> device behind a bridge could request a resource starting at 0.  I had
> to change this for a system as well.  I changed it to
> 
> if (!r->start && !r->end) {
> 
> because I couldn't see anything in the code that made r->start == 0 an
> improper thing.  Not to mention I couldn't access the device any other
> way.  Both being 0 is definitelty bogus.

I think what's happening for me is the following:
I have a PCI bridge and behind that bridge is one device.
This has a fixed location and fixed size memory window (hardwired).

register_pci_controller() requires me to pass some io_resource
and mem_resource in the controller struct. So I pass the memory window
which is assigned to the controller and the devices behind it.
Later I fixup the bases and sizes for each resource in the
pcibios_plat_dev_init() routine.

So, well. I still don't know where the mips PCI subsystem would
detect this resource conflict and what that means to me.
If I simply rip out the check everything works fine, as I fixup
the addresses and sizes later anyway. (I fixup more stuff like the
IRQ routing an so on, too).

The code is in drivers/ssb/driver_pcicore.c

-- 
Greetings Michael.
