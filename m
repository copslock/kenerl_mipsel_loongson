Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f95HvGc12002
	for linux-mips-outgoing; Fri, 5 Oct 2001 10:57:16 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f95HvED11999
	for <linux-mips@oss.sgi.com>; Fri, 5 Oct 2001 10:57:14 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f95HxpB32123;
	Fri, 5 Oct 2001 10:59:51 -0700
Message-ID: <3BBDF25F.1A0F2283@mvista.com>
Date: Fri, 05 Oct 2001 10:48:15 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim@jtan.com
CC: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: test machines; illegal instructions
References: <20010926221223.A17628@neurosis.mit.edu> <20010926202610.B7962@lucon.org> <20011004011632.A19472@neurosis.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jim Paris wrote:
> 
> > > seen anything similar?  It's quite possibly a buggy cross compiler
> >
> > I won't recommend gcc 3.0.1 for mips. My RedHat 7.1 port has everyting
> > you need for cross/native compiling.
> 
> Even with the glibc and fileutils binaries from your port, 'rm' still
> either segfaults or gives an illegal instruction, so it's pretty
> certain that this is a kernel or CPU issue somehow.  Have you seen
> anything like this?  'rm' does work if I compile fileutils with -O0,
> but there still seems to be a larger problem at hand.
> 

If your cpu does not have ll/sc instruction, you might be suffering the famous
sysmips() problem.  The latest kernel should get you going.

There is also FPU emulation bug which may cause this problem, but that only
happens on heavy context switches and FPU usages.

Jun
