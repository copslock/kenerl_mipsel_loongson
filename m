Received:  by oss.sgi.com id <S42217AbQIVJwt>;
	Fri, 22 Sep 2000 02:52:49 -0700
Received: from [131.188.77.254] ([131.188.77.254]:4868 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S42204AbQIVJwX>;
	Fri, 22 Sep 2000 02:52:23 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869540AbQIUNgb>;
        Thu, 21 Sep 2000 15:36:31 +0200
Date:   Thu, 21 Sep 2000 15:36:31 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     Brady Brown <bbrown@ti.com>,
        SGI news group <linux-mips@oss.sgi.com>
Subject: Re: ELF/Modutils problem
Message-ID: <20000921153631.A1238@bacchus.dhis.org>
References: <39C7FEBC.5DB355A2@ti.com> <1289.969409465@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1289.969409465@kao2.melbourne.sgi.com>; from kaos@melbourne.sgi.com on Wed, Sep 20, 2000 at 11:24:25AM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Sep 20, 2000 at 11:24:25AM +1100, Keith Owens wrote:

> On Tue, 19 Sep 2000 18:03:08 -0600, 
> Brady Brown <bbrown@ti.com> wrote:
> >I'm having trouble getting modutils 2.3.10 to work on a little endian
> >MIPS box running a 2.4.0-test3 kernel. I am cross compiling the kernel
> >and modules on an i386 using egcs1.0.3a-2 and binutils2.8.1-1. It
> >appears that the symbol table format in the ELF file created by
> >mipsel-linux-gcc during a module build is incorrect.
> >
> >As I read the ELF 1.1 spec - all symbols with STB_LOCAL bindings should
> >precede all other symbols (weak and global) in the symbol table.
> 
> modutils 2.3.11 includes a sanity check on the number of local symbols
> precisely because of this MIPS problem.  I agree with you that mips gcc
> is violating the ELF standard, 2.3.11 just detects this and issues an
> error message instead of overwriting memory but gcc needs to be fixed.

And gcc has nothing to with it so it won't need to be fixed ...

  Ralf
