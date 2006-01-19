Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 20:04:23 +0000 (GMT)
Received: from p549F7826.dip.t-dialin.net ([84.159.120.38]:16548 "EHLO
	p549F7826.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8134432AbWASUDr (ORCPT <rfc822;Linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 20:03:47 +0000
Received: from palrel11.hp.com ([IPv6:::ffff:156.153.255.246]:33943 "EHLO
	palrel11.hp.com") by linux-mips.net with ESMTP id <S870877AbWASUC0>;
	Thu, 19 Jan 2006 21:02:26 +0100
Received: from cacrelint01.ptp.hp.com (cacrelint01.ptp.hp.com [15.1.29.21])
	by palrel11.hp.com (Postfix) with ESMTP id E047A3647D;
	Thu, 19 Jan 2006 12:01:39 -0800 (PST)
Received: from hplms2.hpl.hp.com (hplms2.hpl.hp.com [15.0.152.33])
	by cacrelint01.ptp.hp.com (Postfix) with ESMTP id 7D8A13401C;
	Thu, 19 Jan 2006 12:01:39 -0800 (PST)
Received: from frankl.hpl.hp.com (frankl.hpl.hp.com [15.4.89.73])
	by hplms2.hpl.hp.com (8.13.1/8.13.1/HPL-PA Hub) with ESMTP id k0JK1cRF028702;
	Thu, 19 Jan 2006 12:01:39 -0800 (PST)
Received: from frankl.hpl.hp.com (localhost [127.0.0.1])
	by frankl.hpl.hp.com (8.12.8/8.12.8) with ESMTP id k0JJxIvH021173;
	Thu, 19 Jan 2006 11:59:18 -0800
Received: (from eranian@localhost)
	by frankl.hpl.hp.com (8.12.8/8.12.8/Submit) id k0JJxIUM021171;
	Thu, 19 Jan 2006 11:59:18 -0800
Date:	Thu, 19 Jan 2006 11:59:18 -0800
From:	Stephane Eranian <eranian@hpl.hp.com>
To:	Philip Mucci <mucci@cs.utk.edu>
Cc:	perfmon@napali.hpl.hp.com, Linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [perfmon] Re: 2.6.13-rc2 perfmon2 new code base with MIPS5K/20K support + libpfm available
Message-ID: <20060119195918.GW19622@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <1137666602.6648.80.camel@localhost.localdomain> <20060119133609.GA3398@linux-mips.org> <20060119181608.GP19622@frankl.hpl.hp.com> <1137695936.6648.268.camel@localhost.localdomain> <20060119191403.GV19622@frankl.hpl.hp.com> <1137699033.15290.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137699033.15290.36.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail:	eranian@hpl.hp.com
Return-Path: <eranian@frankl.hpl.hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 10004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eranian@hpl.hp.com
Precedence: bulk
X-list: linux-mips

On Thu, Jan 19, 2006 at 08:30:33PM +0100, Philip Mucci wrote:
> Yup...just looked at the code...should be simple to adapt...I'll give it
> a spin on perfmon2...the only thing that seems to be obviously wrong are
> the missing arguments to PFM_CREATE_CONTEXT.
> 
Yes, they are using the old perfmon2 interface available just
on IA-64. This perfmonctl() call is still available for backward
compatibility reason but ONLY on Ia-64. For all other
platforms you need to use the pfm_*() system calls. In fact, I think
that even on IA-64 they should eventaully migrate to this model.
