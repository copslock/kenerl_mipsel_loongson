Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 10:28:31 +0000 (GMT)
Received: from ftp.ckdenergo.cz ([IPv6:::ffff:80.95.97.155]:58033 "EHLO simek")
	by linux-mips.org with ESMTP id <S8225223AbTCMK2X>;
	Thu, 13 Mar 2003 10:28:23 +0000
Received: from ladis by simek with local (Exim 3.36 #1 (Debian))
	id 18tPvs-0001JV-00; Thu, 13 Mar 2003 11:27:28 +0100
Date: Thu, 13 Mar 2003 11:27:18 +0100
To: Vincent =?iso-8859-2?Q?Stehl=E9?= <vincent.stehle@stepmind.com>
Cc: linux-mips@linux-mips.org
Subject: Re: PROM variables
Message-ID: <20030313102718.GA5032@simek>
References: <3E7057A6.60007@stepmind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E7057A6.60007@stepmind.com>
User-Agent: Mutt/1.5.3i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 13, 2003 at 11:04:22AM +0100, Vincent Stehlé wrote:
> Hi all,
> 
> Is there a way to get/set PROM variables under Linux ?

no.

> I have an indigo2 with no display, and setting the variables without 
> reverting to the monitor through the serial line would be very handy.
> 
> As I doubt there is currently a solution, I was thinking about 
> implementing this as a /proc subdir. What do you think ?

we discussed this issue on #irc yesterday. it seems that conclusion was
implement it as ioctl on some /dev/prom (?).

	ladis
