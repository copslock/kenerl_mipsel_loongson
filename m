Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16LeT000359
	for linux-mips-outgoing; Wed, 6 Feb 2002 13:40:29 -0800
Received: from foghorn.airs.com (IDENT:qmailr@foghorn.airs.com [63.201.54.26])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16LeQA00356
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 13:40:26 -0800
Received: (qmail 7673 invoked by uid 10); 6 Feb 2002 21:40:25 -0000
Received: (qmail 29608 invoked by uid 269); 6 Feb 2002 21:40:20 -0000
Mail-Followup-To: hjl@lucon.org,
  linux-mips@oss.sgi.com,
  binutils@sources.redhat.com,
  echristo@redhat.com
To: Eric Christopher <echristo@redhat.com>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
   binutils@sources.redhat.com
Subject: Re: PATCH: Modify the mips gas behavior for -g -O
References: <yov5ofj65elj.fsf@broadcom.com>
	<15454.22661.855423.532827@gladsmuir.algor.co.uk>
	<20020204083115.C13384@lucon.org>
	<15454.47823.837119.847975@gladsmuir.algor.co.uk>
	<20020204172857.A22337@lucon.org>
	<20020204215804.A2095@nevyn.them.org> <20020205113017.A6144@lucon.org>
	<20020205135407.A8309@lucon.org>
	<20020206113259.A15431@dea.linux-mips.net>
	<20020206124538.A28632@lucon.org> <20020206130037.A29208@lucon.org>
	<1013030208.19162.6.camel@ghostwheel.cygnus.com>
From: Ian Lance Taylor <ian@airs.com>
Date: 06 Feb 2002 13:40:20 -0800
In-Reply-To: <1013030208.19162.6.camel@ghostwheel.cygnus.com>
Message-ID: <si665ap9vf.fsf@daffy.airs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Eric Christopher <echristo@redhat.com> writes:

> > Here is a patch which does what I want. Any comments?
> > 
> 
> Does anyone care if we have MIPS compatibility? I remember seeing this a
> few years ago and wondering why we were doing it this way. I remember at
> one time debuggers had problems with optimized code, but gdb has come a
> long way since then. Is there any reason to have this code in there at
> all now, i.e. should we just go off of optimization level and not debug
> level at all?

In general the reason for this sort of compatibility is for easier gcc
support.  It's normally more convenient if the GNU assembler and the
native assembler present the same interface, so that you don't have to
use --with-gnu-assembler to get the right result when configuring gcc.

It's far more common to invoke the assembler via the compiler than to
invoke it directly, so making it work correctly when invoked via the
compiler is normally best.

H.J., my question on this patch would be: why is -g being passed to
the assembler?

Ian
