Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f971deQ03445
	for linux-mips-outgoing; Sat, 6 Oct 2001 18:39:40 -0700
Received: from dea.linux-mips.net (a1as06-p182.stg.tli.de [195.252.187.182])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f971dbD03442
	for <linux-mips@oss.sgi.com>; Sat, 6 Oct 2001 18:39:37 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f971dAc11109;
	Sun, 7 Oct 2001 03:39:10 +0200
Date: Sun, 7 Oct 2001 03:39:10 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: jim@jtan.com, "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: test machines; illegal instructions
Message-ID: <20011007033910.C4228@dea.linux-mips.net>
References: <20010926221223.A17628@neurosis.mit.edu> <20010926202610.B7962@lucon.org> <20011004011632.A19472@neurosis.mit.edu> <3BBDF25F.1A0F2283@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BBDF25F.1A0F2283@mvista.com>; from jsun@mvista.com on Fri, Oct 05, 2001 at 10:48:15AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Oct 05, 2001 at 10:48:15AM -0700, Jun Sun wrote:

> If your cpu does not have ll/sc instruction, you might be suffering the famous
> sysmips() problem.  The latest kernel should get you going.
> 
> There is also FPU emulation bug which may cause this problem, but that only
> happens on heavy context switches and FPU usages.

I've checked in a major bundle of FPU emu fixes last week.  The kernel
fp code should now produce accurate results and handle exceptions and
the Flush to Zero bit as per spec.

I have a load more fp fixes pending which I'll checking as soon as I'm
absolutely convinced they'll do the right thing.

  Ralf
