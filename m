Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 20:54:25 +0000 (GMT)
Received: from pD9562292.dip.t-dialin.net ([IPv6:::ffff:217.86.34.146]:24497
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225253AbULGUyU>; Tue, 7 Dec 2004 20:54:20 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iB7KsHUW028575;
	Tue, 7 Dec 2004 21:54:17 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iB7KsH8k028573;
	Tue, 7 Dec 2004 21:54:17 +0100
Date: Tue, 7 Dec 2004 21:54:17 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Pavel Kiryukhin <savl@dev.rtsoft.ru>
Cc: linux-mips@linux-mips.org
Subject: Re: i/o and memory space enable bits in PCI-PCI bridge
Message-ID: <20041207205417.GC13264@linux-mips.org>
References: <41B608FD.7070209@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B608FD.7070209@dev.rtsoft.ru>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 07, 2004 at 10:48:13PM +0300, Pavel Kiryukhin wrote:

> Can somebody give me a hint:  - what part of 2.6 (mips) code is 
> responsible for setting i/o and memory space enable bits in PCI-PCI 
> bridge config. space command register?
> On my board those bits are not set after bridge is configured.
> Currently I'm using the following change in "pcibios_enable_resources" 
> to work with devices behind the bridge.
> --- arch/mips/pci/pci.c_org    2004-12-06 18:20:50.000000000 +0300
> +++ arch/mips/pci/pci.c    2004-12-06 18:21:22.000000000 +0300
> @@ -164,7 +164,7 @@
> 
>    pci_read_config_word(dev, PCI_COMMAND, &cmd);
>    old_cmd = cmd;
> -    for(idx=0; idx<6; idx++) {
> +    for(idx=0; idx<=PCI_BRIDGE_RESOURCES; idx++) {
>        /* Only set up the requested stuff */
>        if (!(mask & (1<<idx)))
>            continue;
> 
> but I think there should be some legal way I missed.

We had a discussion a while ago where somebody did suggest an afair
identical patch a while ago.  The problem with this patch is it fixes
things for a few platforms and breaks things for a few others.

  Ralf
