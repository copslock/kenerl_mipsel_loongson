Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 15:06:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:10711 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022806AbXCZOF7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 15:05:59 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2QE5iKT014503;
	Mon, 26 Mar 2007 15:05:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2QE5gD7014502;
	Mon, 26 Mar 2007 15:05:42 +0100
Date:	Mon, 26 Mar 2007 15:05:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ravi Pratap <Ravi.Pratap@hillcrestlabs.com>
Cc:	David Daney <ddaney@avtrex.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, miklos@szeredi.hu,
	linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
Message-ID: <20070326140542.GA14354@linux-mips.org>
References: <46046AC9.5070306@avtrex.com> <36E4692623C5974BA6661C0B18EE8EDF6CD3FA@MAILSERV.hcrest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36E4692623C5974BA6661C0B18EE8EDF6CD3FA@MAILSERV.hcrest.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 26, 2007 at 09:33:10AM -0400, Ravi Pratap wrote:

> > >> Thanks so much! Will this go into 2.6.15 by any chance?
> > > 
> > > I don't recall that there every has been such a kernel release ;-)
> > > 
> > > But seriously, 2.6.15 is as dead as Tutankhamun.
> > 
> > Some chip vendors only support that version, so I am assuming 
> > that that was the reason for the question.
> 
> That's correct, actually :-)
> 
> > It is a classic case of what happens when people do ports 
> > that are not merged.  They say it is good enough as is and 
> > then never move forward or fix bugs.
> 
> True, and I don't know why these vendors do it. I wish too that they
> didn't.

Talk to them.  Be prepared to reiterate.

> > The good news I guess is that we have the source, so we could 
> > forward port it if we were really motivated.
> 
> Yes, but isn't it a lot of work considering the lack of a
> flush_anon_page in 2.6.15?

David wrote about forward porting the patches in your vendor kernel
to a more modern kernel.  That would require some work but the
flush_anon_page() thing would be the least of your worries.

Otherwise, you'd need to backport the about following changesets into
your kernel to get flush_anon_page:

03beb07664d768db97bf454ae5c9581cd4737bb4
df7c814ea6385fea8ccf54c80ec78326f78b743e
f036773e8760a79ad9fdeea6665f86d3493d40d1
4c40981a5c0fe1ee5c755a55a4a8e5e3527f0bca

  Ralf
