Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 02:04:58 +0100 (BST)
Received: from host104-225-dynamic.0-79-r.retail.telecomitalia.it ([79.0.225.104]:11174
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20021491AbXJBBEt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Oct 2007 02:04:49 +0100
Received: from localhost ([127.0.0.1] helo=sgi)
	by eppesuigoccas.homedns.org with smtp (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IcW8k-00010C-U4
	for linux-mips@linux-mips.org; Tue, 02 Oct 2007 03:01:36 +0200
Date:	Tue, 2 Oct 2007 03:01:33 +0200
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Subject: Re: Using PCI bridges on sgi-ip32: CONFIG_PCI_DEBUG
Message-Id: <20071002030133.fd5f6315.giuseppe@eppesuigoccas.homedns.org>
In-Reply-To: <Pine.LNX.4.64N.0710011559410.27280@blysk.ds.pg.gda.pl>
References: <1190973427.11251.17.camel@scarafaggio>
	<1191141276.7160.44.camel@scarafaggio>
	<Pine.LNX.4.64N.0710011559410.27280@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; mips-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Maciej,

On Mon, 1 Oct 2007 16:05:11 +0100 (BST) "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
[...]
>  I suggest you rebuild with CONFIG_PCI_DEBUG enabled and if you are unable 
> to deduce the reason from the resulting verbose bootstrap log, then send 
> it here so that others may have a look.

Thanks for this suggestion. Here is the relevant log:

[...]
MACE PCI rev 1
registering PCI controller with io_map_base unset
SCSI subsystem initialized
PCI: Scanning bus 0000:00
PCI: Found 0000:00:01.0 [9004/8078] 000100 00
PCI: Found 0000:00:02.0 [9004/8078] 000100 00
PCI: Found 0000:00:03.0 [9710/9250] 000604 01
PCI: Calling quirk ffffffff801da1e0 for 0000:00:03.0
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:03.0, config ffffff, pass 0
PCI: Scanning behind PCI bridge 0000:00:03.0, config 000000, pass 1
PCI: Scanning bus 0000:01
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
PCI: Bus scan for 0000:00 returning with max=01
  got res [280000000:28000ffff] bus [80000000:8000ffff] flags 7200 for BAR 6 of 0000:00:01.0
  got res [280010000:28001ffff] bus [80010000:8001ffff] flags 7200 for BAR 6 of 0000:00:02.0
  got res [280020000:280020fff] bus [80020000:80020fff] flags 200 for BAR 1 of 0000:00:01.0
PCI: moved device 0000:00:01.0 resource 1 (200) to 80020000
  got res [280021000:280021fff] bus [80021000:80021fff] flags 200 for BAR 1 of 0000:00:02.0
PCI: moved device 0000:00:02.0 resource 1 (200) to 80021000
  got res [1000:10ff] bus [1000:10ff] flags 101 for BAR 0 of 0000:00:01.0
PCI: moved device 0000:00:01.0 resource 0 (101) to 1000
  got res [1400:14ff] bus [1400:14ff] flags 101 for BAR 0 of 0000:00:02.0
PCI: moved device 0000:00:02.0 resource 0 (101) to 1400
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Enabling bus mastering for device 0000:00:03.0
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: fixup irq: (0000:00:01.0) got 9
PCI: fixup irq: (0000:00:02.0) got 10
PCI: fixup irq: (0000:00:03.0) got 0
[...]
PCI: Calling quirk ffffffff801db928 for 0000:00:01.0
PCI: Calling quirk ffffffff80262f70 for 0000:00:01.0
PCI: Calling quirk ffffffff801db928 for 0000:00:02.0
PCI: Calling quirk ffffffff80262f70 for 0000:00:02.0
PCI: Calling quirk ffffffff801db928 for 0000:00:03.0
PCI: Calling quirk ffffffff80262f70 for 0000:00:03.0
[...]
PCI: Enabling device 0000:00:01.0 (0046 -> 0047)
[...]
PCI: Enabling device 0000:00:02.0 (0046 -> 0047)
[...]
