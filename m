Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2004 15:59:52 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:11251 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225220AbUBDP7v>;
	Wed, 4 Feb 2004 15:59:51 +0000
Received: from [10.2.2.20] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id HAA24476;
	Wed, 4 Feb 2004 07:59:49 -0800
Subject: Re: R4600 V1.7 errata
From: Pete Popov <ppopov@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>
In-Reply-To: <20040204154801.GB704@icm.edu.pl>
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org>
	 <20040131030435.GA24228@linux-mips.org> <20040131141027.GA11048@ballina>
	 <20040201045258.GA4601@linux-mips.org>
	 <20040203113928.GA28340@linux-mips.org> <20040203114252.GA27810@icm.edu.pl>
	 <20040204154801.GB704@icm.edu.pl>
Content-Type: text/plain
Organization: 
Message-Id: <1075910389.1170.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 04 Feb 2004 07:59:49 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2004-02-04 at 07:48, Dominik 'Rathann' Mierzejewski wrote:
> On Tue, Feb 03, 2004 at 12:42:53PM +0100, Dominik 'Rathann' Mierzejewski wrote:
> [...]
> > I assume it's safe to test it now? I'll build it for my R4600 V2.0 and
> > report in a while. Stay tuned.
> 
> Works now. Thanks, guys.

The latest cache updates break the Au1x kernel. I don't know yet exactly
what the problem is, but I tested with a snapshot before and after the
updates.

Pete
