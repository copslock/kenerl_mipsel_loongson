Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2005 17:28:32 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:795 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133742AbVKRR2K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Nov 2005 17:28:10 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAIHTmAF018549;
	Fri, 18 Nov 2005 17:29:48 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAIHTmlv018548;
	Fri, 18 Nov 2005 17:29:48 GMT
Date:	Fri, 18 Nov 2005 17:29:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>,
	Peter Horton <pdh@colonel-panic.org>
Subject: Re: MIPS - 64bit woes
Message-ID: <20051118172948.GE2707@linux-mips.org>
References: <436D0061.5070100@jg555.com> <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl> <4371B87A.9040101@jg555.com> <4371FB46.1000805@gentoo.org> <4372304A.9080608@jg555.com> <4379FBF4.1040505@jg555.com> <437D0AE2.9040706@jg555.com> <437D2C97.8070804@jg555.com> <20051118171706.GD2707@linux-mips.org> <437E0E68.7010008@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437E0E68.7010008@jg555.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 18, 2005 at 09:24:56AM -0800, Jim Gifford wrote:

> I'll give it a shot and send back results and a updated patch.
> 
> One more question, what is the future off the iomap.c file, I didn't 
> include it in my patch. Could it be simply be added to arch/mips/cobalt? 
> I can only speak for the RaQ2, but is it required for any of the other 
> MIPS based machines?

No.  It's broken for machines with multiple PCI busses and I've explicitly
rejected the patch which is in kernel.org before.

  Ralf
