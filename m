Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 13:55:21 +0100 (BST)
Received: from [IPv6:::ffff:217.157.19.70] ([IPv6:::ffff:217.157.19.70]:51210
	"EHLO jehova.dsm.dk") by linux-mips.org with ESMTP
	id <S8225497AbTJIMzR>; Thu, 9 Oct 2003 13:55:17 +0100
Received: (qmail 16562 invoked by uid 1000); 9 Oct 2003 12:55:12 -0000
Date: Thu, 9 Oct 2003 13:55:12 +0100 (BST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	<linux-mips@linux-mips.org>
Subject: Re: [PATCH] Proposed NMI handling interface...
In-Reply-To: <20031008160600.GA19102@linux-mips.org>
Message-ID: <Pine.LNX.4.40.0310091354230.16550-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <th@jehova.dsm.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@horsten.com
Precedence: bulk
X-list: linux-mips

On Wed, 8 Oct 2003, Ralf Baechle wrote:

> That hook you're proposing isn't even necessary in generic code.  NMI
> on MIPS hardware is a fairly odd type of exception - it goes straight to
> 0xbfc00000 which usually is a a firmware address - and lots of firmware
> doesn't even offer an NMI hook.  So for those cases where it's possible,
> you need to do something firmware anyway before jumping to Linux's NMI
> handler.  An additional problem with the NMI design of MIPS is it's using
> ErrorEPC, just like cache errors so you better pray - or simply design
> systems only to rely on NMI for debugging and catastrophic failures.

On Lasat boards NMI is used to reboot into Service Mode. There's no hook
to override this behaviour.

// Thomas
