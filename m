Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 13:28:45 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:25351 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133436AbWBTN2g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 13:28:36 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1KDZUtP013462;
	Mon, 20 Feb 2006 13:35:30 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1KDZRaM013459;
	Mon, 20 Feb 2006 13:35:27 GMT
Date:	Mon, 20 Feb 2006 13:35:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rojhalat Ibrahim <imr@rtschenk.de>
Cc:	Mark E Mason <mark.e.mason@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: Tracking down exception in sched.c
Message-ID: <20060220133527.GA10598@linux-mips.org>
References: <7E000E7F06B05C49BDBB769ADAF44D0773A636@NT-SJCA-0750.brcm.ad.broadcom.com> <43F9B168.6090105@rtschenk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9B168.6090105@rtschenk.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 01:09:12PM +0100, Rojhalat Ibrahim wrote:

> I tracked this one down to 88a2a4ac6b671a4b0dd5d2d762418904c05f4104
> (percpu data: only iterate over possible CPUs). I don't know if this
> is the correct way to fix this, but the following patch makes the
> problem go away for me.
> 
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -6021,7 +6021,7 @@ void __init sched_init(void)
>         runqueue_t *rq;
>         int i, j, k;
> 
> -       for_each_cpu(i) {
> +       for (i = 0; i < NR_CPUS; i++) {
>                 prio_array_t *array;
> 
>                 rq = cpu_rq(i);
> 
> Any other suggestions, how to fix this?

Almost certainly wrong - like almost any loop iterating over 0..NR_CPUS.
I'm looking into this now.  Part of what is blowing up is this piece of
legacy code

  #define cpu_possible_map        phys_cpu_present_map

in include/asm-mips/smp.h.  Time to clean that and I fear it's not going
to be pretty ...

  Ralf
