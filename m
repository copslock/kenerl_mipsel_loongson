Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9E20m424723
	for linux-mips-outgoing; Sat, 13 Oct 2001 19:00:48 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9E20cD24718
	for <linux-mips@oss.sgi.com>; Sat, 13 Oct 2001 19:00:39 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id E1499125C0; Sat, 13 Oct 2001 19:00:34 -0700 (PDT)
Date: Sat, 13 Oct 2001 19:00:34 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Leonard N. Zubkoff" <lnz@dandelion.com>
Cc: binutils@sourceware.cygnus.com, gcc@gcc.gnu.org,
   GNU C Library <libc-alpha@sourceware.cygnus.com>,
   Kenneth Albanowski <kjahds@kjahds.com>, Mat Hostetter <mat@lcs.mit.edu>,
   Andy Dougherty <doughera@lafcol.lafayette.edu>,
   Warner Losh <imp@village.org>, linux-mips@oss.sgi.com,
   Ron Guilmette <rfg@monkeys.com>,
   "Polstra; John" <linux-binutils-in@polstra.com>,
   "Hazelwood; Galen" <galenh@micron.net>,
   Ralf Baechle <ralf@mailhost.uni-koblenz.de>,
   Linas Vepstas <linas@linas.org>, Feher Janos <aries@hal2000.terra.vein.hu>,
   Leonard Zubkoff <lnz@dandelion.com>, "Steven J. Hill" <sjhill@cotw.com>,
   linux-gcc@vger.kernel.org, amodra@bigpond.net.au
Subject: binutils 2.11.92.0.5 is broke (Re: Binutils Bug)
Message-ID: <20011013190034.A27019@lucon.org>
References: <200110131452.f9DEq7Q0032358@dandelion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110131452.f9DEq7Q0032358@dandelion.com>; from lnz@dandelion.com on Sat, Oct 13, 2001 at 07:52:07AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Oct 13, 2001 at 07:52:07AM -0700, Leonard Zubkoff wrote:
> HJ,
> 
> In recompiling my whole system with your latest binutils-2.11.92.0.5, I
> received the following error while linking telnetd from the netkit-telnet-0.17
> package:
> 
> gcc  telnetd.o state.o termstat.o slc.o sys_term.o utility.o global.o setproctitle.o -lutil -lutil -o telnetd
> /usr/bin/ld: BFD internal error, aborting at elf32-i386.c line 646 in elf_i386_copy_indirect_symbol
> 
> /usr/bin/ld: Please report this bug.
> 
> collect2: ld returned 1 exit status
> 
> Thought you'd want to know...
> 

Hi Alan,

This patch

http://sources.redhat.com/ml/binutils/2001-10/msg00035.html

is incomplete. You cannot do any backend processing when

if (dir == ind->weakdef)

I will double check all backend xxx_hash_copy_indirect.

I am planning to make binutils 2.11.92.0.6 within a week.

Sorry for that.



H.J.
