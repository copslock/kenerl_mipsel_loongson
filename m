Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 11:54:31 +0200 (CEST)
Received: from alg133.algor.co.uk ([62.254.210.133]:38638 "EHLO
	oval.algor.co.uk") by linux-mips.org with ESMTP id <S1122958AbSIDJya>;
	Wed, 4 Sep 2002 11:54:30 +0200
Received: from mudchute.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g849s1r08509;
	Wed, 4 Sep 2002 10:54:01 +0100 (BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id KAA17466;
	Wed, 4 Sep 2002 10:53:55 +0100 (BST)
Date: Wed, 4 Sep 2002 10:53:55 +0100 (BST)
Message-Id: <200209040953.KAA17466@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "Matthew Dharm" <mdharm@momenco.com>
Cc: "Jun Sun" <jsun@mvista.com>,
	"Linux-MIPS" <linux-mips@linux-mips.org>
Subject: RE: Interrupt handling....
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIEEMBCIAA.mdharm@momenco.com>
References: <3D6E87EB.4010000@mvista.com>
	<NEBBLJGMNKKEEMNLHGAIEEMBCIAA.mdharm@momenco.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Return-Path: <dom@mudchute.algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 72
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Matthew,

> Okay... I think I've got a problem that isn't covered by the usual
> examples.

Possibly this is too simple an answer and is stuff you know quite well
already...

> Which, as you can see, attempts to access address 0xfc00000c.

But that address is in the MIPS CPU's 'kseg2' region.  Addresses there
are always translated by the TLB, and you haven't got an entry.

Registers from things like the 2nd level interrupt controller are
memory mapped I/O locations, and you need to do an uncached access to
the appropriate physical address.

Most MIPS hardware has registers mapped between 0-512Mbyte
(0-0x1fff.ffff) physical, because a MIPS CPU can do uncached accesses
to that using the 'kseg1' window, which occupies the 

  0xa000.0000-0xbfff.ffff  (CPU virtual address)
  0x0000.0000-0x1fff.ffff  (physical address).

There are macros defined for translating a physical address into a
kseg1 address (just add 0xa000.0000, really).

You could read the book ("See MIPS Run")...

-- 
Dominic Sweetman, 
MIPS Technologies (UK) - formerly Algorithmics
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
