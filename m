Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0RLCub18361
	for linux-mips-outgoing; Sun, 27 Jan 2002 13:12:56 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0RLCoP18358;
	Sun, 27 Jan 2002 13:12:51 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 16Uvqu-0002X7-00; Sun, 27 Jan 2002 20:24:36 +0000
Subject: Re: thread-ready ABIs
To: dan@debian.org (Daniel Jacobowitz)
Date: Sun, 27 Jan 2002 20:24:36 +0000 (GMT)
Cc: kevink@mips.com (Kevin D. Kissell), dom@algor.co.uk (Dominic Sweetman),
   ralf@oss.sgi.com (Ralf Baechle), drepper@redhat.com (Ulrich Drepper),
   uhler@mips.com (Mike Uhler),
   linux-mips@oss.sgi.com ("MIPS/Linux List (SGI)"),
   hjl@lucon.org (H . J . Lu)
In-Reply-To: <20020122121330.A16110@nevyn.them.org> from "Daniel Jacobowitz" at Jan 22, 2002 12:13:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Uvqu-0002X7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Which it is.  Fork shares no memory regions; vfork/clone share all
> memory regions.  AFAIK there is no share-heap-but-not-stack option in
> Linux.

Thats a design decision. At the point you don't have identical mappings for
both threads you need two sets of page tables and you take all the
performance hits that go with changing current tables on a schedule.

Its a lot cheaper to use a different %esp for each thread
