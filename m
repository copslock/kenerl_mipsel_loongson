Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2KHbJU04340
	for linux-mips-outgoing; Wed, 20 Mar 2002 09:37:19 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g2KHbE904337
	for <linux-mips@oss.sgi.com>; Wed, 20 Mar 2002 09:37:14 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g2KHcgf07579;
	Wed, 20 Mar 2002 09:38:42 -0800
Date: Wed, 20 Mar 2002 09:38:42 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: David Christensen <dpchrist@holgerdanske.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Fw: hello
Message-ID: <20020320093842.B7190@dea.linux-mips.net>
References: <017701c1cf99$a7d9a890$0b01a8c0@w2k30g>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <017701c1cf99$a7d9a890$0b01a8c0@w2k30g>; from dpchrist@holgerdanske.com on Tue, Mar 19, 2002 at 02:55:22PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Mar 19, 2002 at 02:55:22PM -0800, David Christensen wrote:

> As an aside, is anybody using a VMware virtual machine for their
> development host?

While it can be done there is not much point in doing so unless you hate
performance ;)

> > and native compile for apps.
> 
> OK  that sounds like a safe bet.

Which is the primary reason for native compiles.

> >> 3.  What is the preferred toolchain...
> > This is what we use for cross Kernel compiles (toolchain from oss):
> >
> > /home/hartvige> gcc -v
> > Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> > gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)
> 
> Hmmm.  That looks like a native i386 compiler.  I'm surprised its not
> something like "mips-elf-gcc".

Yes, that's his native compiler.  mips-elf-gcc however should not be used,
there are subtle differences between the various ELF/MIPS targets that
would turn your life into hell ...

> I'll assume the cross-compile toolchain was built per
> http://oss.sgi.com/mips/mips-howto.html section 10.

That's roughly the procedure, though the procedure described is not 100%
suitable for the recommended compiler version.  So I recommend downloading
the binary rpms.

> 
> Leo Przybylski <leop@engr.arizona.edu> wrote:
> > Well, all Linux/MIPS stuff on on oss.sgi.com is maintained largely by
> > Ralf Baechle who is also contributor to numerous Linux/MIPS projects
> > on sourceforge. As far as I know he is also a huge part of the
> > sourceforge Linux/MIPS. You may have noticed that Bradley D. LaRonde
> > is also a huge contributor.

No.  I don't touch or follow the Sourceforge project at all.

  Ralf
