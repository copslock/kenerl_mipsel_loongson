Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAMB3qK08273
	for linux-mips-outgoing; Thu, 22 Nov 2001 03:03:52 -0800
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAMB3no08261
	for <linux-mips@oss.sgi.com>; Thu, 22 Nov 2001 03:03:49 -0800
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id 9EE17125C3; Thu, 22 Nov 2001 02:03:35 -0800 (PST)
Received: by lucon.org (Postfix, from userid 1000)
	id E7A8BEBC9; Thu, 22 Nov 2001 02:03:34 -0800 (PST)
Date: Thu, 22 Nov 2001 02:03:34 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Cross Compiler again
Message-ID: <20011122020334.A3320@lucon.org>
References: <86048F07C015D311864100902760F1DD01B5E3CA@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E3CA@dlfw003a.dus.infineon.com>; from Andre.Messerschmidt@infineon.com on Thu, Nov 22, 2001 at 10:08:44AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Nov 22, 2001 at 10:08:44AM +0100, Andre.Messerschmidt@infineon.com wrote:
> Hi.
> 
> For my environment I need a compiler that supports dwarf debug information.
> Sadly my precompiled version does not have this support so I tried it on my
> own, using Bradley D. LaRonde's  HowTo. 
> All went well but I had to learn that GCC 3.0.1 is not able to compile a
> current kernel. So I tried version 2.95.3, but I ran into the same problem
> that I had last time I tried such a thing. When compiling glibc the process
> failed because of a missing -D__PIC__ option. I was told that this has to do
> with a non-MIPS compiler that is used, but the compiler used is my previous
> build static version of gcc. 
> I don't know what else may be wrong or where to look. Can anybody enlighten
> me?
> 
> Or has anybody a precompiled gcc with dwarf support for download (That is
> able to compile a current kernel, of course. ;-) )?
> 

May I ask why you want dwarf? FWIW, gcc 2.96 in my RedHat 7.1 mips port
supports dwarf, but not as default. I don't know how well it works with
dwarf. Yes, both cross compiler running on RedHat/x86 7.1/7.2 and
native compiler are provided in my mips port.


H.J.
