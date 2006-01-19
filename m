Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 14:00:59 +0000 (GMT)
Received: from shu.cs.utk.edu ([160.36.56.39]:44190 "EHLO shu.cs.utk.edu")
	by ftp.linux-mips.org with ESMTP id S8134393AbWASOAf (ORCPT
	<rfc822;Linux-mips@linux-mips.org>); Thu, 19 Jan 2006 14:00:35 +0000
Received: from localhost (shu [127.0.0.1])
	by shu.cs.utk.edu (Postfix) with ESMTP id AD09513B29;
	Thu, 19 Jan 2006 09:04:21 -0500 (EST)
Received: from shu.cs.utk.edu ([127.0.0.1])
 by localhost (shu [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08262-01; Thu, 19 Jan 2006 09:04:20 -0500 (EST)
Received: from dhcp-221-85.pdc.kth.se (dhcp-221-85.pdc.kth.se [130.237.221.85])
	by shu.cs.utk.edu (Postfix) with ESMTP id BFE3E13B1D;
	Thu, 19 Jan 2006 09:04:19 -0500 (EST)
Subject: Re: 2.6.13-rc2 perfmon2 new code base with MIPS5K/20K support +
	libpfm available
From:	Philip Mucci <mucci@cs.utk.edu>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-mips@linux-mips.org, perfmon@napali.hpl.hp.com,
	Stephane Eranian <eranian@hpl.hp.com>
In-Reply-To: <20060119133609.GA3398@linux-mips.org>
References: <1137666602.6648.80.camel@localhost.localdomain>
	 <20060119133609.GA3398@linux-mips.org>
Content-Type: text/plain
Organization: Innovative Computing Laboratory
Date:	Thu, 19 Jan 2006 15:04:17 +0100
Message-Id: <1137679457.6648.137.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new with ClamAV and SpamAssasin at cs.utk.edu
Return-Path: <mucci@cs.utk.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 9990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mucci@cs.utk.edu
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Thanks for the link on the wiki...

I'm sure Stefane can answer this question more accurately, but I do know
that oprofile and perfmon have coexisted quite happily for a while in
the IA64 line..Of course, you can't use both at the same time. oprofile
takes over the counters and uses them from a 'global' context, and you
need to be root to set them. 

perfmon is intended up be used for performance tuning in production
multiprogrammed environments, although it also has system-wide and
per-cpu counting modes. So you can have multiple people using the
counters inside their processes and threads and all the counts are
preserved as the state and the full 64 bit values are part of the
process context, for the per-thread monitoring modes.

Again, this is a laymans answer and I'll let Stefane fill in the gaps of
how oprofile and perfmon2 are integrated on the IA64 platform and how we
make that work similarly on the MIPS platform. 

As I haven't updated my tree quite yet to 2.6.15, I haven't yet seen the
oprofile code for the below...but it integration should be quite simple.
(My tree only has the rm9000). As soon as I reintegrate to 2.6.15, I'll
be sure to make sure oprofile and perfmon2 play nice.

Anyways, glad to hear other folks are as interested in performance
analysis!

Regards,

Philip

> More recently myself and others have verified that Oprofile is working
> on the 5K, 20K, 24K, 25K cores and the SB1 and SB1A cores in the Sibyte
> SOCs - and a few more in the queue.  So now I wonder how perfmon2 is
> going to interfear with oprofile which already is in the kernel?
> 
> I've put a quick page into the wiki at http://www.linux-mips.org/wiki/Perfmon2
> It's really just a starting point but people should know what's there.
> 
>   Ralf
