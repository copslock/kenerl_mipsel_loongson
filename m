Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5J0YC804705
	for linux-mips-outgoing; Mon, 18 Jun 2001 17:34:12 -0700
Received: from dea.waldorf-gmbh.de (u-95-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.95])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5J0Y9V04696
	for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 17:34:10 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5J0Xo128779;
	Tue, 19 Jun 2001 02:33:50 +0200
Date: Tue, 19 Jun 2001 02:33:50 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: [patch flood] Debugging patches
Message-ID: <20010619023350.A28059@bacchus.dhis.org>
References: <20010616124102.A31141@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010616124102.A31141@nevyn.them.org>; from dan@debian.org on Sat, Jun 16, 2001 at 12:41:02PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 16, 2001 at 12:41:02PM -0700, Daniel Jacobowitz wrote:

> The biggest one was the fact that passing arguments to the inferior in
> floating point registers just didn't work.  I tracked this down to at least
> three separate problems:
>   - We would set last_task_used_math without clearing the ST0_CU1 bit in
>     the previous task owning the FPU.  When that previous task swapped
>     in again, it would use the existing FP registers, and lazy_fpu_switch
>     would never be called.  This happened in signal.c and in ptrace.c.

First signal.c segment - calling restore_fp_context should result in a
proper FPU context switch.

>   - ptrace didn't look for the FP registers in the right places.  This's
>     been broken since the FPU emulator merge a while back.

>   - We would create new processes with the ST0_CU1 bit already set if
>     their parent process had it set.

No, copy_thread clears CU1.

(Have to breed about this patch a bit more, stuff for the plane ...)

> Of course, the lazy switching isn't quite as useful as it could be, since
> every program will eventually use the FPU if not build -msoft-float - I
> think it's happening in glibc.  But we can possibly work around that later. 
> It still does save a great number of switches, so it's worthwhile - when it
> works.

Newer libcs shouldn't try to initialize $fcr31 to zero because that's
already the default.

> Other patches in my directory that I'm submitting along with that one:
>  - kgdb-crash-resistant.diff
>  - mips-gdb-with-kgdb.diff
>  - mips-rtsignal.diff

These three look good, applied.

  Ralf
