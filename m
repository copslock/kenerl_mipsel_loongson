Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 14:10:31 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:61448 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133570AbWAYOKO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 14:10:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0PEEPDi010909;
	Wed, 25 Jan 2006 14:14:25 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0PEEO4U010898;
	Wed, 25 Jan 2006 14:14:24 GMT
Date:	Wed, 25 Jan 2006 14:14:24 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Franck <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Message-ID: <20060125141424.GE3454@linux-mips.org>
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com> <20060125124738.GA3454@linux-mips.org> <cda58cb80601250534r5f464fd1v@mail.gmail.com> <43D78725.6050300@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D78725.6050300@mips.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 25, 2006 at 03:11:49PM +0100, Kevin D. Kissell wrote:

> >>>Comments ?
> >>Looks good aside of the one issue you've already raised yourself:
> >>
> >>>+/* FIXME: MIPS_R2 only */
> >
> >I was actually asking for advices :)
> >
> >I can see only two simple ways to do that:
> >(a) we can define a couple of new macro ie CONFIG_MIPS32_ISET_R[12]
> >that can be set depending on the selected CPU;
> >(b) define a new macro CONFIG_CPU_HAS_WSBH;
> 
> Don't we already have CONFIG_CPU_MIPS32R2?

We have CPU_MIPS32_R1, CPU_MIPS32_R2, CPU_MIPS64_R1, CPU_MIPS64_R2.
Based on those we also define CPU_MIPS32, CPU_MIPS64, CPU_MIPSR1,
and CPU_MIPSR2 as short cuts.

In this particular case

#include <linux/config.h>

#ifdef CONFIG_CPU_MIPSR2
...
#else
...

would be what we want.

  Ralf
