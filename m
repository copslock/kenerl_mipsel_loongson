Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2003 13:07:36 +0000 (GMT)
Received: from p508B7812.dip.t-dialin.net ([IPv6:::ffff:80.139.120.18]:40092
	"EHLO p508B7812.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225247AbTCJNHf>; Mon, 10 Mar 2003 13:07:35 +0000
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:19847 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S869610AbTCJNCH>; Mon, 10 Mar 2003 14:02:07 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2ACtVL26908;
	Mon, 10 Mar 2003 13:55:31 +0100
Date: Mon, 10 Mar 2003 13:55:31 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: Kip Walker <kwalker@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [pathch] kernel/sched.c bogon?
Message-ID: <20030310135531.B2206@linux-mips.org>
References: <3E67EF64.152CFC6C@broadcom.com> <20030306174001.K26071@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030306174001.K26071@mvista.com>; from jsun@mvista.com on Thu, Mar 06, 2003 at 05:40:01PM -0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 06, 2003 at 05:40:01PM -0800, Jun Sun wrote:

> I reported this bug last May.  Apparently it is still not
> taken up-stream.   Ralf, why don't we fix it here and push
> it up from you?
> 
> BTW, this bug actually has effect on real-time performance under
> preemptible kernel.

< = 2.4.x preemptible kernel is OPP.

>  It can delay the execution of the highest
> priority real-time process from execution up to 1 jiffy.

Quite a number of users get_cycles() in the kernel assume it to return a
64-bit number.  I guess we'll have to fake a 64-bit counter in software ...

  Ralf
