Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2006 06:27:48 +0200 (CEST)
Received: from smtp.osdl.org ([65.172.181.4]:32964 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S8126484AbWE1E1i (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 May 2006 06:27:38 +0200
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4S4RU2g009395
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 May 2006 21:27:30 -0700
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k4S4RTT7027050;
	Sat, 27 May 2006 21:27:30 -0700
Date:	Sat, 27 May 2006 21:31:50 -0700
From:	Andrew Morton <akpm@osdl.org>
To:	Kumba <kumba@gentoo.org>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f (on_each_cpu():
 disable local interrupts) Breaks SGI IP32
Message-Id: <20060527213150.33443188.akpm@osdl.org>
In-Reply-To: <4479250E.3080604@gentoo.org>
References: <4478C0F1.8000006@gentoo.org>
	<20060528010603.GA24997@linux-mips.org>
	<20060527194243.a8157338.akpm@osdl.org>
	<4479250E.3080604@gentoo.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

On Sun, 28 May 2006 00:20:30 -0400
Kumba <kumba@gentoo.org> wrote:

> > suggest you should open-code an smp_call_function() and put a big comment
> > over it explaining why it's done this way, and why it isn't deadlocky.
> > 
> > <tries to remember what the deadlock is>
> > 
> > If CPU A is running smp_call_function() it's waiting for CPU B to run the
> > handler.
> > 
> > But if CPU B is presently _also_ running smp_call_function(), it's waiting
> > for CPU A to run the handler.
> > 
> > If either of those CPUs is waiting for the other with local interrupts
> > disabled, that CPU will never respond to the other CPU's IPI and they'll
> > deadlock.
> 
> The catch is, the system being affected here is strictly a UP machine.  It's 
> impossible to make an O2 go SMP.

Yup.  But again, the reasons for that change to on_each_cpu() were to make
all instances of the the callback function run under the same environment
in all cases.  That's a good change.

If the platform _knows_ that it's safe to do normally-unsafe things then as
I say, it shold special-case that case.

Here, if the call is in O2-only code then we don't need on_each_cpu() at
all - just call the function instead.

If the call is in board-neutral MIPS code then things get more complicated.
Sure, the code is safe on UP, but it might be deadlocky on SMP.  It needs
to be thought about and a suitable UP&&SMP fix needs to be found.

Can someone point me at the code we're talking about here?  file-n-line?
