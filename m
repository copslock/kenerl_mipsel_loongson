Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2004 19:14:38 +0000 (GMT)
Received: from one.ldsys.net ([IPv6:::ffff:208.176.63.109]:53281 "EHLO
	one.chi.ldsys.net") by linux-mips.org with ESMTP
	id <S8225303AbUCPTOg>; Tue, 16 Mar 2004 19:14:36 +0000
Received: from sex-machine.chi.ldsys.net (sex-machine.chi.ldsys.net [10.0.1.4])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by one.chi.ldsys.net (Postfix) with ESMTP id 0D3A344
	for <linux-mips@linux-mips.org>; Tue, 16 Mar 2004 13:14:34 -0600 (CST)
Subject: Re: [PATCH 2.6] missing _raw_write_trylock
From: "Christopher G. Stach II" <cgs@ldsys.net>
To: linux-mips@linux-mips.org
In-Reply-To: <20040316190808.GA4944@lst.de>
References: <20040316070911.B29232@mvista.com>
	 <40571916.6060502@realitydiluted.com> <20040316175000.GB29803@mvista.com>
	 <20040316190808.GA4944@lst.de>
Content-Type: text/plain
Message-Id: <1079464464.27177.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 13:14:25 -0600
Content-Transfer-Encoding: 7bit
Return-Path: <cgs@ldsys.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cgs@ldsys.net
Precedence: bulk
X-list: linux-mips

    CONFIG_SMP and CONFIG_PREEMPT at the same time, as it's in
kernel/sched.c.

chris

On Tue, 2004-03-16 at 13:08, Christoph Hellwig wrote:
> On Tue, Mar 16, 2004 at 09:50:00AM -0800, Jun Sun wrote:
> > > Are you going to do a non-LLSC, or are we no longer concerned about
> > > those?
> > > 
> > 
> > For SMP machines we assume LLSC are present.  This function and its friends 
> > for SMP only.
> 
> doesn't CONFIG_PREEMPT (*shudder*) need it is aswell?
> 
> 
