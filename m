Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2003 22:00:30 +0000 (GMT)
Received: from p508B6D77.dip.t-dialin.net ([IPv6:::ffff:80.139.109.119]:53643
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225209AbTCXWA3>; Mon, 24 Mar 2003 22:00:29 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2OLxYX18162;
	Mon, 24 Mar 2003 22:59:34 +0100
Date: Mon, 24 Mar 2003 22:59:34 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.5]: move do_signal32 declaration upwards
Message-ID: <20030324225934.D16592@linux-mips.org>
References: <20030322212039.GA19984@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030322212039.GA19984@bogon.ms20.nix>; from agx@sigxcpu.org on Sat, Mar 22, 2003 at 10:20:39PM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 22, 2003 at 10:20:39PM +0100, Guido Guenther wrote:

> do_signal32 is needed in do_signal but declared after that function
> which makes this an implicit declaration. Moving the declaration upward
> fixes the warning. Patch attached, please apply.

Thanks, applied,

  Ralf
