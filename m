Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16JIgS29229
	for linux-mips-outgoing; Wed, 6 Feb 2002 11:18:42 -0800
Received: from dea.linux-mips.net (a1as20-p202.stg.tli.de [195.252.194.202])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16JIcA29226
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 11:18:38 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g165Tjm13904;
	Wed, 6 Feb 2002 06:29:45 +0100
Date: Wed, 6 Feb 2002 06:29:45 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: Hartvig Ekner <hartvige@mips.com>, linux-mips@oss.sgi.com
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
Message-ID: <20020206062945.A13634@dea.linux-mips.net>
References: <200202051747.SAA21696@copsun18.mips.com> <3C6044A7.13FEB2E2@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C6044A7.13FEB2E2@cotw.com>; from sjhill@cotw.com on Tue, Feb 05, 2002 at 02:46:31PM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 05, 2002 at 02:46:31PM -0600, Steven J. Hill wrote:

> > One note: Many MIPS32 implementations choose not to implement all 36 PA
> > bits, but limit themselves to 32 bits. This saves a few bits in the TLB
> > and a few address lines.
> > 
> So, if someone did want 36 PA bits on Linux, the TLB exception handlers
> and a little of the page table construction/management code would have to
> change. The userspace contraints and such would still remain. Cool.

Basically the whole code is already in place except a few bugs fixes that
still need to go in.

  Ralf
