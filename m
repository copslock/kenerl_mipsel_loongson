Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Mar 2004 12:22:31 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:44854
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225489AbUCTMW3>; Sat, 20 Mar 2004 12:22:29 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1B4fUg-0003uu-00; Sat, 20 Mar 2004 13:22:26 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1B4fUg-0003mw-00; Sat, 20 Mar 2004 13:22:26 +0100
Date: Sat, 20 Mar 2004 13:22:26 +0100
To: "Martin C. Barlow" <mips@martin.barlow.name>
Cc: linux-mips@linux-mips.org
Subject: Re: hwclock and df seg fault
Message-ID: <20040320122225.GK25832@rembrandt.csv.ica.uni-stuttgart.de>
References: <000201c40e62$e9d104f0$6500a8c0@colombia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201c40e62$e9d104f0$6500a8c0@colombia>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Martin C. Barlow wrote:
[snip]
> Barcelona:/var/log# hwclock
> Mar 21 19:11:20 Barcelona kernel: bad: scheduling while atomic!
[snip]
> Mar 21 19:11:20 Barcelona kernel: note: hwclock[369] exited with
> preempt_count 2

So this was with CONFIG_PREEMPT, I guess. Does it happen also without
that?


Thiemo
