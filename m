Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fATF8hh16709
	for linux-mips-outgoing; Thu, 29 Nov 2001 07:08:43 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fATF8eo16705
	for <linux-mips@oss.sgi.com>; Thu, 29 Nov 2001 07:08:41 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fATE8Gg07739;
	Fri, 30 Nov 2001 01:08:16 +1100
Date: Fri, 30 Nov 2001 01:08:16 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: RedHat 7.1 cross toolchain kernel build problem
Message-ID: <20011130010816.E638@dea.linux-mips.net>
References: <CBD6266EA291D5118144009027AA63353F9275@xboi05.boi.hp.com> <20011128132117.A27181@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011128132117.A27181@nevyn.them.org>; from dan@debian.org on Wed, Nov 28, 2001 at 01:21:17PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Nov 28, 2001 at 01:21:17PM -0500, Daniel Jacobowitz wrote:

> If you search the list archives, I've posted patches for this several
> times.  It's a compiler bug but can be worked around in io.h.  $5($3)
> is not a legal addressing mode.

The current kernel source has replaced the inline assembler functions in
include/asm-mips/io.h thus this is no longer necessary.

  Ralf
