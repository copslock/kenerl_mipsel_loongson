Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6G6dRv03855
	for linux-mips-outgoing; Sun, 15 Jul 2001 23:39:27 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6G6dGV03828;
	Sun, 15 Jul 2001 23:39:16 -0700
Received: from otr.mynet (fiendish.cygnus.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id XAA06808;
	Sun, 15 Jul 2001 23:39:12 -0700 (PDT)
Received: (from drepper@localhost)
	by otr.mynet (8.11.2/8.11.2) id f6G6Z5k20997;
	Sun, 15 Jul 2001 23:35:05 -0700
X-Authentication-Warning: otr.mynet: drepper set sender to drepper@redhat.com using -f
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Clean up the mips dynamic linker
References: <20010712182402.A10768@lucon.org>
	<20010713112635.A32010@bacchus.dhis.org> <m3lmlsu82u.fsf@otr.mynet>
	<20010713111010.A25902@lucon.org>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 15 Jul 2001 23:35:04 -0700
In-Reply-To: "H . J . Lu"'s message of "Fri, 13 Jul 2001 11:10:10 -0700"
Message-ID: <m38zhps7on.fsf@otr.mynet>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> 2001-07-13  H.J. Lu <hjl@gnu.org>
> 
> 	* sysdeps/mips/dl-machine.h (MAP_BASE_ADDR): Removed.
> 	(elf_machine_got_rel): Defined only if RTLD_BOOTSTRAP is not
> 	defined.
> 	(RESOLVE_GOTSYM): Rewrite to use RESOLVE.
> 
> 	* sysdeps/mips/rtld-ldscript.in: Removed.
> 	* sysdeps/mips/rtld-parms: Likewise.
> 	* sysdeps/mips/mips64/rtld-parms: Likewise.
> 	* sysdeps/mips/mipsel/rtld-parms: Likewise.

Is this the complete patch?  Nothing needed from the other patches?

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
