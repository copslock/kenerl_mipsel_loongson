Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 12:11:27 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:11175 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21102885AbZA0MLZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 12:11:25 +0000
Received: (qmail 17157 invoked by uid 1000); 27 Jan 2009 13:11:23 +0100
Date:	Tue, 27 Jan 2009 13:11:23 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Frank Neuber <linux-mips@kernelport.de>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: AU1550 Kernel bug detected[#1]  clockevents_register_device
Message-ID: <20090127121123.GA17132@roarinelk.homelinux.net>
References: <1233045842.28527.459.camel@t60p> <20090127091107.GA15890@roarinelk.homelinux.net> <1233051181.28527.485.camel@t60p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1233051181.28527.485.camel@t60p>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Tue, Jan 27, 2009 at 11:13:01AM +0100, Frank Neuber wrote:
> Thank you all,
> now the head kernel comes up.
> Why is that fix not in the git? Maby I use the wrong git repository for
> MIPS kernel. At the moment I use the linus git:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

I sent a patch for this 2 weeks ago; Ralf is probably busy with other stuff
atm.

 
> Am Dienstag, den 27.01.2009, 10:11 +0100 schrieb Manuel Lauss:
> > > I just start with head and found a compile error:
> > > arch/mips/alchemy/common/time.c:93: error: incompatible types in
> > > initialization
> > > I comment this line ".cpumask        = CPU_MASK_ALL,"
> > 
> > you need to change it to "CPU_MASK_ALL_PTR".  Commenting it is not a very
> > good idea ;-)
> Yea sure, but it was a try ... ;-)
> 
> The PCI and PCMCIA problems are going on in the same way:
> I tested the CardBus. As you can see the two CardBus bridges maps the
> whole PCI memory into. If I plug in something it is not accessable
> because the 
> yenta_cardbus 0000:00:0d.0: No cardbus resource!
> error ...
> I think somting is wrong with PCI resource management here.
> I can't believe that nobody is using the PCI or Cardbus on the AU1550
> with the current kernel.

I'm no PCI expert, but I'm pretty sure resource assignment is done by
generic, not mips-specific, code.  Please try the linux-pci and/or
linux-kernel lists.

Beste Gruesse,
	Manuel Lauss
