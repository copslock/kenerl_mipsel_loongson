Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2004 13:20:51 +0100 (BST)
Received: from hydrogen.boeventronie.net ([IPv6:::ffff:217.114.100.248]:53723
	"EHLO hydrogen.foonet") by linux-mips.org with ESMTP
	id <S8224945AbUFIMUr>; Wed, 9 Jun 2004 13:20:47 +0100
Received: from jorik by hydrogen.foonet with local (Exim 3.36 #1 (Debian))
	id 1BY24U-0004pI-00
	for <linux-mips@linux-mips.org>; Wed, 09 Jun 2004 14:20:46 +0200
Date: Wed, 9 Jun 2004 14:20:46 +0200
From: Jorik Jonker <linux-mips@boeventronie.net>
To: Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: VINO
Message-ID: <20040609122046.GB18364@hydrogen.boeventronie.net>
Mail-Followup-To: Linux MIPS <linux-mips@linux-mips.org>
References: <20040608125437.GC19965@hydrogen.boeventronie.net> <20040608220604.GA2578@umax645sx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608220604.GA2578@umax645sx>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <jorik@hydrogen.boeventronie.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@boeventronie.net
Precedence: bulk
X-list: linux-mips

On Wed, Jun 09, 2004 at 12:06:04AM +0200, Ladislav Michl wrote:
> If you're seriously considering to help with VINO development this link:
> http://www.ac3.edu.au/SGI_Developer/books/DevDriver_PG/sgi_html/ch09.html
> looks like a good starting point. It's easy, just write driver which
> allows you to read VINO registers while capture in progress :)

Well, it seems not that easy for me. As I told, it's very opaque matter to
me; ie I already figured out that a kernel driver must be built but I really
have no clue on how to do this. For instance, I don't know what call (if
there exists any) should access that memory.
My plan was on writing a driver which allows me (through an ioctl to a special
device) to read/write to the VINO registers. I think I saw a driver example
in the DevDriver_PG which shows how to communicate through ioctl with
userspace (or kernelspace, depends on how you look at it), but the part where
I do the actual 'talking' to the VINO is matter I don't have any clue on how
to do that.

-- 
Jorik Jonker
http://boeventronie.net/
