Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 13:17:09 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:58901 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133382AbWBCNQu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 13:16:50 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k13DMHL0005692;
	Fri, 3 Feb 2006 13:22:17 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k12MBW44008823;
	Thu, 2 Feb 2006 22:11:32 GMT
Date:	Thu, 2 Feb 2006 22:11:32 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
Message-ID: <20060202221132.GA8799@linux-mips.org>
References: <20060203.013401.41198517.anemo@mba.ocn.ne.jp> <43E25381.4060309@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E25381.4060309@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 02, 2006 at 09:46:25PM +0300, Sergei Shtylylov wrote:

> Atsushi Nemoto wrote:
> >If mfc0 $12 follows store and the mfc0 is last instruction of a
> >page and fetching the next instruction causes TLB miss, the result
> >of the mfc0 might wrongly contain EXL bit.
> 
>    Hmm, a TLB miss in fetching from KSEG0?!

It'll hit loadable modules which run in the mapped KSEG2/3 spaces.

  Ralf
