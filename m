Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g08CDGc01671
	for linux-mips-outgoing; Tue, 8 Jan 2002 04:13:16 -0800
Received: from oval.algor.co.uk (oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g08CCpg01663
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 04:13:00 -0800
Received: from gladsmuir.algor.co.uk (IDENT:root@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g08BCJt09706;
	Tue, 8 Jan 2002 11:12:19 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.11.0/8.8.7) id g08BC8a01332;
	Tue, 8 Jan 2002 11:12:08 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15418.54280.707286.147408@gladsmuir.algor.co.uk>
Date: Tue, 8 Jan 2002 11:12:08 +0000 (GMT)
To: Phil Thompson <phil@river-bank.demon.co.uk>
Cc: linux-mips@oss.sgi.com
Subject: Re: How to Handle PCI Bridge Buffers?
In-Reply-To: <3C39EE20.57513318@river-bank.demon.co.uk>
References: <3C39EE20.57513318@river-bank.demon.co.uk>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Phil,

> I am working with some hardware that has a "feature" that I'd like some
> advice on how to handle. The PCI bridge has a read-ahead buffer between
> the PCI bus and system memory - used by PCI bus masters. The buffer can
> only be invalidated from software.

So it also acts as a cache.  Interesting.

> An example of the problem it causes is an ethernet device is kicked off
> to go through its ring buffers. The first one has a flag saying there is
> no data, so it stops. The kernel then puts data in the buffer, toggles
> the flag, and kicks off the ethernet device again. The old value of the
> flag is still in the read-ahead buffer so the device stops again. The
> fix is obviously to invalidate the read-ahead buffer before kicking off
> the device. The question is, how to do this in a generic way?

This is analogous to the problem you get when accessing device buffers
through the MIPS cache; so we know there's no easy fix.  You'll have
to locate every write made to a shared memory structure, and then
invalidate the cache in the bridge.  If you're mapping the shared
memory cached, that would be just after doing a forced write-back of
the CPU cache... but the shared memory is more likely accessed
uncached.

But as a result of the MIPS cache experience there are a collection of
cache-safety buffer functions (rely on a proper Linux expert to tell
you about them, sorry).  So you can update your driver to call them,
then change your local implementation of the functions to invalidate
the bridge's cache too.  You still have to change all the
non-compliant drivers, of course, but at least you have the warm
feeling that you're *improving* them.

[Just a note: I suppose you've checked you're not accidentally working
 through a "writeback" CPU cache, which would cause the identical
 symptom?  This feature would cause such routine trouble
 in a bridge that I'm surprised it isn't at least easy to disable...]

> I don't want to modify the driver for every PCI device that might be
> used. The only other way seems to be to add the buffer invalidation code
> to outb() etc. (and hope that no driver wants to use memory mapped
> registers).
 
But lots of drivers use memory mapped registers.  x86 I/O space
(inb/outb etc) maps to PCI I/O space, the use of which is deprecated
except for legacy software.

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / home: +44 20 7226 0032
http://www.algor.co.uk
