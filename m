Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2006 01:12:29 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([63.240.77.81]:52400 "EHLO
	sccrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133650AbWBRBMV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Feb 2006 01:12:21 +0000
Received: from [192.168.1.4] (unknown[69.140.185.48])
          by comcast.net (sccrmhc11) with ESMTP
          id <2006021801185701100kqnpie>; Sat, 18 Feb 2006 01:18:58 +0000
Message-ID: <43F67607.1030703@gentoo.org>
Date:	Fri, 17 Feb 2006 20:19:03 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
References: <20060217225824.GE20785@deprecation.cyrius.com>
In-Reply-To: <20060217225824.GE20785@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> When you try to shutdown or reboot an IP22 with 2.6.15 or 2.6.16-rc2,
> you see that the TERM signal is sent but then nothing happens.  At the
> beginning, the light on the Indy is green but after about 20 seconds
> it turns red.  Nothing happens on the console and the machine doesn't
> turn off.  Seen on Indy and Indigo2.
> 
> Anyone got a fix?
> 
> 
> sgi:~# shutdown -r now
> 
> Broadcast message from root (ttyS0) (Fri Feb 17 22:52:47 2006):
> 
> The system is going down for reboot NOW!
> INIT: Sending processes the TERM signal
> INIT: Sending proces
> 
> [and nothing more]
> 
> Or, according to an Indigo2 users, "The machine hangs on shutdown -r
> now after init sends the TERM signal; the LED stays green for a few
> seconds, then turns orange which definitely isn't good."

Turns red/orange and stays that color, or starts flashing?


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
