Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jan 2003 14:31:48 +0000 (GMT)
Received: from p508B6FCB.dip.t-dialin.net ([IPv6:::ffff:80.139.111.203]:5604
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225192AbTAXObr>; Fri, 24 Jan 2003 14:31:47 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0OEVVt13856;
	Fri, 24 Jan 2003 15:31:31 +0100
Date: Fri, 24 Jan 2003 15:31:31 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: A question on Linux SMP and cache coherency
Message-ID: <20030124153131.A13615@linux-mips.org>
References: <71690137A786F7428FF9670D47CB95ED10DF6F@SJE4EXM01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <71690137A786F7428FF9670D47CB95ED10DF6F@SJE4EXM01>; from Adam_Kiepul@pmc-sierra.com on Thu, Jan 23, 2003 at 03:17:25PM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 23, 2003 at 03:17:25PM -0800, Adam Kiepul wrote:

> I would really appreciate if anyone could tell me whether
> Hardware-maintained cache coherency between processors is required for
> Linux SMP operation.

(Sending just one copy of a posting is sufficient ...)

There have been imho fairly ridiculous attempts at constructing dual-core
SMPs for the use with Linux/MIPS by changing the kernel to 16kB page
size [1] and using write through-caches plus some extra hacks.  Needless
to say the solution is about as stupid as something can be and is probably
going to perform worse than a uniprocessor ...

  Ralf

[1] good idea for other reasons but completly stupid in this context
