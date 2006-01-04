Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2006 13:02:55 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:3292 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133500AbWADNCi
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jan 2006 13:02:38 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k04D4kml013356;
	Wed, 4 Jan 2006 05:04:47 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k04D4iJq010899;
	Wed, 4 Jan 2006 05:04:45 -0800 (PST)
Message-ID: <43BBC85C.4040405@mips.com>
Date:	Wed, 04 Jan 2006 14:06:36 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To:	Sathesh Babu Edara <satheshbabu.edara@analog.com>
CC:	linux-mips-bounce@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: 
References: <200601041250.k04CoGaZ025481@lilac.hdcindia.analog.com>
In-Reply-To: <200601041250.k04CoGaZ025481@lilac.hdcindia.analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Sathesh Babu Edara wrote:
>  
> 
> Hi,
>    We have ported linux-2.6.12 kernel onto MIPS processor (LX4189) and the
> processor speed is 200Mhz.
> By default Linux-2.6.12 kernel comes with HZ value 1000.Will this HZ value
> cause an overhead on the 200MHZ CPU.Can someone advise me on whether going
> back to HZ vaule of 100 like Linux-2.4 will reduce the overhead on this
> CPU.What are the side effects this change can cause?.

The 1000Hz clock should not actually cause any problems with a 200MHz
CPU, but it will suck up an annoyingly high percentage of available
cycles. Backing off to 100Hz may cause some degradation of some
real-time/interactive response times, but the improved overall
performance will probably more than make up for it.  I never build
with a HZ value greater than 100 these days, but then again, I'm
mostly running on FPGAs and other hardware emulators where the CPU
clock frequencies may be less than 1MHz, and are never more than 33MHz.
Note that a HZ  value of less than 100 may cause some kernel macros
to generate divide-by-zero operations/exceptions.

		Regards,

		Kevin K.
