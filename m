Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g17AcLn19426
	for linux-mips-outgoing; Thu, 7 Feb 2002 02:38:21 -0800
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g17AcGA19420
	for <linux-mips@oss.sgi.com>; Thu, 7 Feb 2002 02:38:17 -0800
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id DA9371E8CA; Thu,  7 Feb 2002 11:38:10 +0100 (MET)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
Mail-Copies-To: never
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Not use branch likely on mips
References: <20020205180243.A11993@lucon.org>
From: Andreas Jaeger <aj@suse.de>
Date: Thu, 07 Feb 2002 11:38:09 +0100
In-Reply-To: <20020205180243.A11993@lucon.org> ("H . J . Lu"'s message of
 "Tue, 5 Feb 2002 18:02:43 -0800")
Message-ID: <hoadulk25q.fsf@gee.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> This patch removes branch likely.

Please update the copyright years next time.

I've committed the patch,

Andreas

>
> H.J.
> ----
> 2002-02-05  H.J. Lu  <hjl@gnu.org>
>
> 	* sysdeps/mips/pspinlock.c (__pthread_spin_lock): Not use
> 	branch likely.
> 	* sysdeps/mips/pt-machine.h (testandset): Liekwise.
> 	(__compare_and_swap): Liekwise.
>
> 2002-02-05  H.J. Lu  <hjl@gnu.org>
>
> 	* sysdeps/mips/atomicity.h (exchange_and_add): Not use branch
> 	likely.
> 	(atomic_add): Likewise.
> 	(compare_and_swap): Likewise.
> 	* sysdeps/unix/sysv/linux/mips/sys/tas.h (_test_and_set):
> 	Likewise.
> [...]
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
