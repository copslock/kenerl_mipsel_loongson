Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Mar 2004 19:54:05 +0000 (GMT)
Received: from p508B763E.dip.t-dialin.net ([IPv6:::ffff:80.139.118.62]:32556
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225515AbUCTTyE>; Sat, 20 Mar 2004 19:54:04 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2KJs2Mk009328;
	Sat, 20 Mar 2004 20:54:02 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2KJs1rL009327;
	Sat, 20 Mar 2004 20:54:01 +0100
Date: Sat, 20 Mar 2004 20:54:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Martin C. Barlow" <mips@martin.barlow.name>
Cc: "'Thiemo Seufer'" <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: hwclock and df seg fault
Message-ID: <20040320195401.GB5764@linux-mips.org>
References: <20040320122225.GK25832@rembrandt.csv.ica.uni-stuttgart.de> <000001c40e96$adbdb1f0$6500a8c0@colombia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c40e96$adbdb1f0$6500a8c0@colombia>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 21, 2004 at 03:16:14AM +1100, Martin C. Barlow wrote:

> With PREEMP turned off, the hwclock command works again. Looks like the
> new scheduler may have a little problem.
> The df problem is still there. This may be just a user space
> mis-configuration error. I'll see if I can find the problem.
> Let me know if you need any dumps.

No, the different locking code used for the preemptible kernel contains
assertions which simply detected the bug in the RTC driver.

  Ralf
