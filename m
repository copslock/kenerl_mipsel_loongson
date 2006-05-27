Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 May 2006 02:46:31 +0200 (CEST)
Received: from allen.werkleitz.de ([80.190.251.108]:53381 "EHLO
	allen.werkleitz.de") by ftp.linux-mips.org with ESMTP
	id S8134076AbWE0AqW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 May 2006 02:46:22 +0200
Received: from p54bddac2.dip.t-dialin.net ([84.189.218.194] helo=void.local)
	by allen.werkleitz.de with esmtpsa (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA1:24)
	(Exim 4.62)
	(envelope-from <js@linuxtv.org>)
	id 1FjmwR-0000uQ-VM; Sat, 27 May 2006 02:46:14 +0200
Received: from js by void.local with local (Exim 3.35 #1 (Debian))
	id 1FjmwQ-0004pJ-00; Sat, 27 May 2006 02:46:06 +0200
Date:	Sat, 27 May 2006 02:46:06 +0200
From:	Johannes Stezenbach <js@linuxtv.org>
To:	Tony Lin <lin.tony@gmail.com>
Cc:	Daniel Jacobowitz <dan@debian.org>,
	ashley jones <ashley_jones_2000@yahoo.com>,
	linux-mips@linux-mips.org
Message-ID: <20060527004606.GA18511@linuxtv.org>
References: <404548f40605171139i67084776pd9ae7c34ec19ec95@mail.gmail.com> <20060524081406.90333.qmail@web38407.mail.mud.yahoo.com> <404548f40605241844y41b897b6sb8a7512feb8655f6@mail.gmail.com> <20060525133529.GA31379@nevyn.them.org> <404548f40605251750s2708df73td50a4e9db755408f@mail.gmail.com> <20060526024540.GA16815@nevyn.them.org> <20060526113943.GB14036@linuxtv.org> <404548f40605261721r411b8321gdda239d82feace18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404548f40605261721r411b8321gdda239d82feace18@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 84.189.218.194
Subject: Re: Can't debug core files with GDB
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Return-Path: <js@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@linuxtv.org
Precedence: bulk
X-list: linux-mips

On Fri, May 26, 2006, Tony Lin wrote:
> Finally found the place in gdb to change the register values to read
> the coredump correctly. However I have a nagging feeling that I may
> not have configured gdb correctly , and my fix may not be the right
> one. But oh wells, at least it works!
> 
> cross-compiled on: i386-linux
> configured gdb using: ../gdb/configure --target=mips-linux
> gdb-6.4, kernel 2.6.6-rc3, gcc-3.4.3
> 
> *** mips-linux-tdep.c   2006-05-26 17:14:00.577339000 -0700
> --- mips-linux.tdep.c~  2006-05-26 17:15:53.723372000 -0700
> ***************
> *** 54,65 ****
> --- 54,76 ----
> +
> + /* NEW 2.6 style */
> + #define EF_CP0_STATUS         38
> + #define EF_LO                 39
> + #define EF_HI                 40
> + #define EF_CP0_BADVADDR               41
> + #define EF_CP0_CAUSE          42
> + #define EF_CP0_EPC            43
> +
> + /* OLD 2.4 style
>  #define EF_LO                 38
>  #define EF_HI                 39
>  #define EF_CP0_EPC            40
>  #define EF_CP0_BADVADDR               41
>  #define EF_CP0_STATUS         42
>  #define EF_CP0_CAUSE          43
> + */
> 
> Is it possible that since I cross-compiled gdb on an i386, it used the
> local gcc/libc to compile and didn't have the right registers header
> file? I know during configuration it was complaining that it didn't
> find greg_t definitions etc. I suppose this why you guys can compile
> it correctly on the native mips-linux while I have issues
> cross-compiling on i386-linux.

Maybe the change to the coredump format was reverted in later
2.6 kernels. If so, Ralf might remember.

Johannes
