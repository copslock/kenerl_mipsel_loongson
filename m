Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 06:34:11 +0100 (BST)
Received: from host160-223-dynamic.15-87-r.retail.telecomitalia.it ([87.15.223.160]:9370
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20022347AbXJEFeD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 06:34:03 +0100
Received: from localhost ([127.0.0.1] helo=sgi)
	by eppesuigoccas.homedns.org with smtp (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1Idfou-000151-P8; Fri, 05 Oct 2007 07:33:54 +0200
Date:	Fri, 5 Oct 2007 07:33:49 +0200
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
Message-Id: <20071005073349.4a95ac75.giuseppe@eppesuigoccas.homedns.org>
In-Reply-To: <20071004153217.GF6897@linux-mips.org>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org>
	<Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl>
	<20071004130318.GC28928@linux-mips.org>
	<1191508413.10050.26.camel@scarafaggio>
	<20071004151951.GD6897@linux-mips.org>
	<Pine.LNX.4.64N.0710041624450.10573@blysk.ds.pg.gda.pl>
	<20071004153217.GF6897@linux-mips.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; mips-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Oct 2007 16:32:17 +0100 Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Oct 04, 2007 at 04:27:57PM +0100, Maciej W. Rozycki wrote:
> > On Thu, 4 Oct 2007, Ralf Baechle wrote:
> > > The entire testing done by chkslot() is probably not needed, so I suggest
> > > you try to simply dump the thing entirely and test.
> > 
> >  Exactly what I wrote too. :-)  Though I would imagine it was introduced 
> > for a reason, like a bug in the host bridge or something, as already 
> > suggested.  Otherwise what would the point have been?
> 
> I suspect cut-and-paste-o-mania, probably originally started by the
> necessity of doing so for the Galileo chips.

After removing the chkslot() call, I get these errors when booting:
[...]
SCSI subsystem initialized
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00008000 (C)
MACEPCI: Master abort at 0x00010000 (C)
MACEPCI: Master abort at 0x00020000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
MACEPCI: Master abort at 0x00000000 (C)
PCI: Bridge: 0000:00:03.0
  IO window: 1000-1fff
  MEM window: 80000000-800fffff
  PREFETCH window: 80100000-801fffff
PCI: Enabling device 0000:00:03.0 (0000 -> 0003)
[...]

It seems all probes to devfn=0 fails. There is even a call on bus=2, that I really don't understand. the current lspci output is:

00:01.0 SCSI storage controller: Adaptec AIC-7880U
00:02.0 SCSI storage controller: Adaptec AIC-7880U
00:03.0 PCI bridge: NetMos Technology Unknown device 9250 (rev 01)
01:08.0 USB Controller: NEC Corporation USB (rev 43)
01:08.1 USB Controller: NEC Corporation USB (rev 43)
01:08.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
01:09.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 61)
01:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)

So probably, the test was correct.  Should I restore the same check or only check for devfn==0?

Bye,
Giueppe
