Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2004 18:00:55 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:766 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225299AbUCVSAy>;
	Mon, 22 Mar 2004 18:00:54 +0000
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i2MI0mx6030375;
	Mon, 22 Mar 2004 10:00:48 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i2MI0guX030373;
	Mon, 22 Mar 2004 10:00:42 -0800
Date: Mon, 22 Mar 2004 10:00:42 -0800
From: Jun Sun <jsun@mvista.com>
To: "Martin C. Barlow" <mips@martin.barlow.name>
Cc: "'Thiemo Seufer'" <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: hwclock and df seg fault
Message-ID: <20040322100042.C30193@mvista.com>
References: <20040320122225.GK25832@rembrandt.csv.ica.uni-stuttgart.de> <000001c40e96$adbdb1f0$6500a8c0@colombia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000001c40e96$adbdb1f0$6500a8c0@colombia>; from mips@martin.barlow.name on Sun, Mar 21, 2004 at 03:16:14AM +1100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Sun, Mar 21, 2004 at 03:16:14AM +1100, Martin C. Barlow wrote:
> Thiemo
> 
> With PREEMP turned off, the hwclock command works again. Looks like the
> new scheduler may have a little problem.
> The df problem is still there. This may be just a user space
> mis-configuration error. I'll see if I can find the problem.
> Let me know if you need any dumps.
> 

df works fine here with PREEMPT, both UP and SMP.

There are still some holes in PREEMPT, but mostly are theorectical ones
and you won't hit thme easily.

Jun
