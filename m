Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4J3Y5o15336
	for linux-mips-outgoing; Fri, 18 May 2001 20:34:05 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4J3Y3F15333
	for <linux-mips@oss.sgi.com>; Fri, 18 May 2001 20:34:03 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4J3N5C01285;
	Sat, 19 May 2001 00:23:05 -0300
Date: Sat, 19 May 2001 00:23:05 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Steven Liu <stevenliu@psdc.com>
Cc: Keith M Wesolowski <wesolows@foobazco.org>, linux-mips@oss.sgi.com
Subject: Re: mips-tfile
Message-ID: <20010519002305.B1209@bacchus.dhis.org>
References: <000801c0a572$b7471e40$dde0490a@BANANA> <20010305205516.A25870@foobazco.org> <001201c0df37$2befb920$dde0490a@pcs.psdc.com> <20010517223139.A19781@bacchus.dhis.org> <000801c0dff4$3870ba60$dde0490a@pcs.psdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000801c0dff4$3870ba60$dde0490a@pcs.psdc.com>; from stevenliu@psdc.com on Fri, May 18, 2001 at 04:42:37PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 18, 2001 at 04:42:37PM -0700, Steven Liu wrote:

> I have a question regarding MIPS Makefile.
> 
> In the Makefile of the Linux build directory, there are two Macros of C
> compiler flags: HOSTCFLAGS and CFLAGS.
> 
> What are their purpose and difference? In another words, what is host gcc?
> Why do we use host gcc in building the target kernel?

During the build process of the kernel some tools like scripts/mkdep and
others are built which are running on the compile machine, not the target
machine.  The variable HOSTCFLAGS takes some extra compiler options to be
passed for such compilations.

  Ralf
