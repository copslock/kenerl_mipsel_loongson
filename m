Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA61L0B32073
	for linux-mips-outgoing; Mon, 5 Nov 2001 17:21:00 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA61Kv032070
	for <linux-mips@oss.sgi.com>; Mon, 5 Nov 2001 17:20:57 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fA61LvB28782;
	Mon, 5 Nov 2001 17:21:57 -0800
Subject: Re: Arguments for kernel_entry?
From: Pete Popov <ppopov@mvista.com>
To: Richard Hodges <rh@matriplex.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <Pine.BSF.4.10.10111051659510.600-100000@mail.matriplex.com>
References: <Pine.BSF.4.10.10111051659510.600-100000@mail.matriplex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.01.15.16 (Preview Release)
Date: 05 Nov 2001 17:21:17 -0800
Message-Id: <1005009677.27128.300.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2001-11-05 at 17:09, Richard Hodges wrote:
> Would anyone be able to provide information on the arguments
> to kernel_entry (in head.S)?
> 
> The first two look pretty straightforward, argument count and
> string vectors.  I assume that argument zero is actually the
> first argument, and not "vmlinux"?
> 
> What are the third (ulong) and fourth (int *) arguments?  I have
> read head.S and searched for days trying to find this info :-(
> 
> I thought PMON would be a decent reference, but run_target() only
> seems to set $4 and $5, before calling _go().

That's boot code specific. MIPS Tech's yamon passes:

0: number of arguments
1: pointer to first arg
2: pointer to environment variables
3: pointer to prom routines you can call


Pete
