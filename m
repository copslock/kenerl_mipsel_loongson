Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBQLggM26247
	for linux-mips-outgoing; Wed, 26 Dec 2001 13:42:42 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBQLgZX26233
	for <linux-mips@oss.sgi.com>; Wed, 26 Dec 2001 13:42:35 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBQKfU701248
	for linux-mips@oss.sgi.com; Wed, 26 Dec 2001 18:41:30 -0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBMClnA05968;
	Sat, 22 Dec 2001 10:47:49 -0200
Date: Sat, 22 Dec 2001 10:47:49 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jim Paris <jim@jtan.com>, Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011222104749.J1437@dea.linux-mips.net>
References: <20011218135712.B11726@neurosis.mit.edu> <Pine.GSO.4.21.0112191031050.28694-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0112191031050.28694-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Wed, Dec 19, 2001 at 10:34:04AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Dec 19, 2001 at 10:34:04AM +0100, Geert Uytterhoeven wrote:

> IMHO you should create isa_{check,request,release}_mem_region().
> 
> I said it many times before on linux-kernel, but it doesn't help :-(
> I'm facing the same problem on PPC, where ISA memory space is not at address 0.

Sounds good to me.  That would also solve certain problems on machine like
the RM200C where we have to cheat a little bit to get things to work.

  Ralf
