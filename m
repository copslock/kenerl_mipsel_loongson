Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 08:56:43 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:23021 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133706AbWAII4X
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 08:56:23 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k098wuDR010905;
	Mon, 9 Jan 2006 00:58:57 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id k098wtYr002864;
	Mon, 9 Jan 2006 00:58:56 -0800 (PST)
Message-ID: <005a01c614fb$2fe76b00$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Sathesh Babu Edara" <satheshbabu.edara@analog.com>,
	<linux-mips-bounce@linux-mips.org>, <linux-mips@linux-mips.org>
References: <200601090742.k097gYaZ017304@lilac.hdcindia.analog.com>
Subject: Re: 
Date:	Mon, 9 Jan 2006 10:00:48 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

There is no "ideal" value for a given processor frequency.
The lower the value, the less interrupt processing overhead,
but the slower the response time to events that are detected
or serviced during clock interrupts. 1000 HZ *may* be a sensible
value (I have my doubts, personally) for 2+ GHz PC processors, 
but it's excessive (IMHO) for a 200MHz processor and unworkable 
for a 20MHz CPU. I think that 100HZ is still a reasonable value
for an embedded RISC CPU, but the "ideal" value is going to
be a function of the application.

        Regards,

        Kevin K.

----- Original Message ----- 
From: "Sathesh Babu Edara" <satheshbabu.edara@analog.com>
To: "'Kevin D. Kissell'" <kevink@mips.com>; <linux-mips-bounce@linux-mips.org>; <linux-mips@linux-mips.org>
Sent: Monday, January 09, 2006 8:43 AM
Subject: RE: 


> 
> Hi,
>   Appreciate your response .
> 
>   What is the ideal HZ value if the processor speed is 200Mhz?.
> 
> Regards,
> Sathesh
> -----Original Message-----
> From: Kevin D. Kissell [mailto:kevink@mips.com] 
> Sent: Wednesday, January 04, 2006 6:37 PM
> To: Sathesh Babu Edara
> Cc: linux-mips-bounce@linux-mips.org; linux-mips@linux-mips.org
> Subject: Re: 
> 
> Sathesh Babu Edara wrote:
> >  
> > 
> > Hi,
> >    We have ported linux-2.6.12 kernel onto MIPS processor (LX4189) and 
> > the processor speed is 200Mhz.
> > By default Linux-2.6.12 kernel comes with HZ value 1000.Will this HZ 
> > value cause an overhead on the 200MHZ CPU.Can someone advise me on 
> > whether going back to HZ vaule of 100 like Linux-2.4 will reduce the 
> > overhead on this CPU.What are the side effects this change can cause?.
> 
> The 1000Hz clock should not actually cause any problems with a 200MHz CPU,
> but it will suck up an annoyingly high percentage of available cycles.
> Backing off to 100Hz may cause some degradation of some
> real-time/interactive response times, but the improved overall performance
> will probably more than make up for it.  I never build with a HZ value
> greater than 100 these days, but then again, I'm mostly running on FPGAs and
> other hardware emulators where the CPU clock frequencies may be less than
> 1MHz, and are never more than 33MHz.
> Note that a HZ  value of less than 100 may cause some kernel macros to
> generate divide-by-zero operations/exceptions.
> 
> Regards,
> 
> Kevin K.
> 
> 
> 
