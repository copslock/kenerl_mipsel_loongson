Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MJ8MS27516
	for linux-mips-outgoing; Tue, 22 Jan 2002 11:08:22 -0800
Received: from skip-ext.ab.videon.ca (skip-ext.ab.videon.ca [206.75.216.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MJ8JP27512
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 11:08:19 -0800
Received: (qmail 18247 invoked from network); 22 Jan 2002 18:08:16 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by skip-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <kevink@mips.com>; 22 Jan 2002 18:08:16 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16T5LD-0005OL-00; Tue, 22 Jan 2002 11:08:15 -0700
Date: Tue, 22 Jan 2002 11:08:15 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
To: "Kevin D. Kissell" <kevink@mips.com>
cc: linux-mips@oss.sgi.com
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
In-Reply-To: <005301c1a368$87d27ed0$10eca8c0@grendel>
Message-ID: <Pine.LNX.3.96.1020122110419.20690A-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Tue, 22 Jan 2002, Kevin D. Kissell wrote:

> The idea leverages off the fact that a branch likely
> instruction performs a kind of conditional execution.
> The instruction in the delay slot is executed only if
> the branch is taken.  This can be used to synthesize
> a conditional store.  The user level code for a simple
> atomic increment, for example, would look something
> like this:

Hmm, could you use this to take the race out of the kernel wait loop 
too? Ie use current->need_resched as the test and 'wait' as the
conditional operation.

Jason
