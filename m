Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 10:28:11 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:27578
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225195AbTCMK2L>; Thu, 13 Mar 2003 10:28:11 +0000
Received: from bogon.sigxcpu.org (kons-d9bb5401.pool.mediaWays.net [217.187.84.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 40DE22BC2D; Thu, 13 Mar 2003 11:28:08 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 555DA1735C; Thu, 13 Mar 2003 11:26:02 +0100 (CET)
Date: Thu, 13 Mar 2003 11:26:01 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@stepmind.com>
Cc: linux-mips@linux-mips.org
Subject: Re: PROM variables
Message-ID: <20030313102601.GD24866@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@stepmind.com>,
	linux-mips@linux-mips.org
References: <3E7057A6.60007@stepmind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E7057A6.60007@stepmind.com>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

Hi Vincent,
On Thu, Mar 13, 2003 at 11:04:22AM +0100, Vincent Stehlé wrote:
> Is there a way to get/set PROM variables under Linux ?
Not for IP22.

> I have an indigo2 with no display, and setting the variables without 
> reverting to the monitor through the serial line would be very handy.
If you pull out the graphics board the machine will switch to the serial
line.

> As I doubt there is currently a solution, I was thinking about 
> implementing this as a /proc subdir. What do you think ?
What about multiple files in /proc/arcs which have the PROM variables as
name and its value as contents? When doing this I'd write into the NVRAM
directly instead of using the Arcs functions, I think the necessary info
is in the IRIX headers.
Regards,
 -- Guido
