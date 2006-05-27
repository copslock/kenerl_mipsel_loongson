Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 May 2006 02:45:14 +0200 (CEST)
Received: from nevyn.them.org ([66.93.172.17]:31165 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133902AbWE0ApH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 27 May 2006 02:45:07 +0200
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FjmvO-0003n7-KC; Fri, 26 May 2006 20:45:02 -0400
Date:	Fri, 26 May 2006 20:45:02 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Tony Lin <lin.tony@gmail.com>
Cc:	Johannes Stezenbach <js@linuxtv.org>,
	ashley jones <ashley_jones_2000@yahoo.com>,
	linux-mips@linux-mips.org
Subject: Re: Can't debug core files with GDB
Message-ID: <20060527004502.GA14534@nevyn.them.org>
References: <404548f40605171139i67084776pd9ae7c34ec19ec95@mail.gmail.com> <20060524081406.90333.qmail@web38407.mail.mud.yahoo.com> <404548f40605241844y41b897b6sb8a7512feb8655f6@mail.gmail.com> <20060525133529.GA31379@nevyn.them.org> <404548f40605251750s2708df73td50a4e9db755408f@mail.gmail.com> <20060526024540.GA16815@nevyn.them.org> <20060526113943.GB14036@linuxtv.org> <404548f40605261721r411b8321gdda239d82feace18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404548f40605261721r411b8321gdda239d82feace18@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, May 26, 2006 at 05:21:44PM -0700, Tony Lin wrote:
> Is it possible that since I cross-compiled gdb on an i386, it used the
> local gcc/libc to compile and didn't have the right registers header
> file? I know during configuration it was complaining that it didn't
> find greg_t definitions etc. I suppose this why you guys can compile
> it correctly on the native mips-linux while I have issues
> cross-compiling on i386-linux.

No.  I build both cross and native debuggers, of course.

-- 
Daniel Jacobowitz
CodeSourcery
