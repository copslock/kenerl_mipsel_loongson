Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FK07307396
	for linux-mips-outgoing; Fri, 15 Feb 2002 12:00:07 -0800
Received: from crack-ext.ab.videon.ca (crack-ext.ab.videon.ca [206.75.216.33])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FK03907389
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 12:00:03 -0800
Received: (qmail 7774 invoked from network); 15 Feb 2002 19:00:01 -0000
Received: from unknown (HELO wakko.debian.net) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by crack-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <kevink@mips.com>; 15 Feb 2002 19:00:01 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.debian.net ident=jgg)
	by wakko.debian.net with smtp (Exim 3.16 #1 (Debian))
	id 16bnaS-0002rM-00; Fri, 15 Feb 2002 12:00:00 -0700
Date: Fri, 15 Feb 2002 12:00:00 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.debian.net
To: "Kevin D. Kissell" <kevink@mips.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <006e01c1b606$27b1b060$0deca8c0@Ulysses>
Message-ID: <Pine.LNX.3.96.1020215104857.10921A-100000@wakko.debian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Fri, 15 Feb 2002, Kevin D. Kissell wrote:

> That is, I would say, a bug in the TX39 implementation of SYNC.
> The specification is states that all stores prior to the SYNC must 
> complete before any memory ops after the sync, and that the 
> definition of a store completing is that all stored values be 
> "visible to every other processor in the system", which pretty 
> clearly implies that the write buffers must be flushed.

Sorry, why? If the TX39 is the only processor in the system then write
buffers can be left alone. You can't consider PCI IO devices to be
processors because the bus protocols would never allow you to satisfy the
requirements for 'sync'.
 
IMHO the only time *mb should care about a write buffer is if the buffer
breaks PCI ordering semantics, by, say returning reads from posted write
data, re-ordering, etc.

Jason
