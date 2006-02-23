Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 11:48:24 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:53510 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133438AbWBWLsQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 11:48:16 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1NBtSiP006850;
	Thu, 23 Feb 2006 11:55:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1NBtR3u006849;
	Thu, 23 Feb 2006 11:55:27 GMT
Date:	Thu, 23 Feb 2006 11:55:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rojhalat Ibrahim <imr@rtschenk.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [RFC] SMP initialization order fixes.
Message-ID: <20060223115527.GA6272@linux-mips.org>
References: <20060222190940.GA29967@linux-mips.org> <43FD85C8.5040801@rtschenk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FD85C8.5040801@rtschenk.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 23, 2006 at 10:52:08AM +0100, Rojhalat Ibrahim wrote:

> Works for me with a little fix. You need to set phys_cpu_present_map
> in yosemite/smp.c. Therefore the following two lines in the patch
> are unnecessary.
> 
> > -		cpu_set(i, phys_cpu_present_map);
> > +		cpu_set(i, cpu_present_map);

In include/asm-mips/smp.h we have the define:

  #define cpu_possible_map        phys_cpu_present_map

I meant to get rid of direct references to phys_cpu_present_map so really
should have done this:

> > -		cpu_set(i, phys_cpu_present_map);
> > +		cpu_set(i, cpu_possible_map);

Anyway, I dropped this for now and will commit the patch.

Thanks for testing & fix.

  Ralf
