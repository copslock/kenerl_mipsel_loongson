Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 22:48:58 +0100 (BST)
Received: from frank.harvard.edu ([IPv6:::ffff:140.247.122.99]:32423 "EHLO
	frank.harvard.edu") by linux-mips.org with ESMTP
	id <S8225208AbTDXVsx>; Thu, 24 Apr 2003 22:48:53 +0100
Received: from frank.harvard.edu (frank.harvard.edu [140.247.122.99])
	by frank.harvard.edu (8.11.6/8.11.6) with ESMTP id h3OLmpI18842;
	Thu, 24 Apr 2003 17:48:51 -0400
Date: Thu, 24 Apr 2003 17:48:51 -0400 (EDT)
From: Chip Coldwell <coldwell@frank.harvard.edu>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: linux-mips@linux-mips.org
Subject: Re: NCD900 port?
In-Reply-To: <011a01c30aab$b7748ce0$10eca8c0@grendel>
Message-ID: <Pine.LNX.4.44.0304241744520.18155-100000@frank.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <coldwell@frank.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: coldwell@frank.harvard.edu
Precedence: bulk
X-list: linux-mips

On Thu, 24 Apr 2003, Kevin D. Kissell wrote:
> 
> What PCI bridge is being used?  Galileo?

Good question.  Short answer: I don't know.  I'll pry off the hood
and take a peek at what's on the board, unless this is something that
shares a die with the CPU.

> I think it's probably doable, but if you want two reasons 
> why it might not be, I'd say they would be:
> 1) Undocumented/unsupported PCI or other interface
> 2) Not enough RAM

#1 is definitely a possible stumbling block, so my first task is to
identify the PCI bridge.  The box has 48 MB of RAM in it, which should
be enough for both a small RAM disk root filesystem (busybox?) and the
kernel; the rest could be NFS mounted.  I've converted old x86 PCs to
diskless X Terminals using exactly that trick.

Chip

-- 
Charles  M. "Chip" Coldwell
"Turn on, log in, tune out"
