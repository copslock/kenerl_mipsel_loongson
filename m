Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1S06SQ22972
	for linux-mips-outgoing; Wed, 27 Feb 2002 16:06:28 -0800
Received: from skip-ext.ab.videon.ca (skip-ext.ab.videon.ca [206.75.216.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1S06P922969
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 16:06:25 -0800
Received: (qmail 26592 invoked from network); 27 Feb 2002 23:06:22 -0000
Received: from unknown (HELO wakko.debian.net) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by skip-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <kph@ayrnetworks.com>; 27 Feb 2002 23:06:22 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.debian.net ident=jgg)
	by wakko.debian.net with smtp (Exim 3.16 #1 (Debian))
	id 16gD9R-0008Ag-00; Wed, 27 Feb 2002 16:06:21 -0700
Date: Wed, 27 Feb 2002 16:06:21 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.debian.net
Reply-To: Jason Gunthorpe <jgg@debian.org>
To: Kevin Paul Herbert <kph@ayrnetworks.com>
cc: linux-mips@oss.sgi.com
Subject: Re: CONFIG_CPU_HAS_WB (or to sync or to nop)
In-Reply-To: <a05100303b8a2f8b89aed@[192.168.1.5]>
Message-ID: <Pine.LNX.3.96.1020227160136.31394A-100000@wakko.debian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Wed, 27 Feb 2002, Kevin Paul Herbert wrote:

> What is the intention of CONFIG_CPU_HAS_WB? On an RM7000, am I better 
> off doing a pipeline flush (the nops in wbflush.h) or a sync 
> instruction? Also, any guidance on whether I should go out and ensure 
> writes have completed in PCI host adapters and bridges, or whether 
> this is excessive paranoia.

The conclusion seems to have been that CPU_HAS_WB is only for a particular
kind of WB that did not maintain PCI-type ordering rules on uncached
accesses. RM7K assures ordering of uncached reads/writes and does not
return read data from the WB so the WB is transparent.

The MB fixup patch that Maciej has seems to clean up most of the rest of
the issues with WB's and MB's by using sync in the proper places.

Linux has no primitives that assure memory operations have been flushed
through the entire PCI bus tree (there is no PCI op that will do this)..

Jason
