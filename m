Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fATJN9r24096
	for linux-mips-outgoing; Thu, 29 Nov 2001 11:23:09 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fATJN3o24092;
	Thu, 29 Nov 2001 11:23:03 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA01414; Thu, 29 Nov 2001 10:23:02 -0800 (PST)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fATIIcB00594;
	Thu, 29 Nov 2001 10:18:38 -0800
Message-ID: <3C067BD4.6B132389@mvista.com>
Date: Thu, 29 Nov 2001 10:17:56 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: calibrating MIPS counter frequency
References: <3C05646B.51BF79FB@mvista.com> <20011130020240.F638@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Wed, Nov 28, 2001 at 02:25:47PM -0800, Jun Sun wrote:
> 
> > In the future, I think mips counter frequency really should go to mips_cpu
> > structure.  If we always know the counter frequency, either by board setup
> > routine or runtime calibration, we can get rid of the gettimeoffset
> > calibration routines.
> 
> Better stick with the calibration procedure.  The crystal oscilators used
> in most computer systems don't provide the high accuracy of frequency
> that is required to keep the clock accurately over long time. 

The drifting clock effect won't happen here because the base value (timerlo)is
reset at each jiffies change.  So it is as accurate as your system timer, plus
minor skew within a jiffy period.

The existing calibration routines actually use the same oscilator and a
similar algorithm, except calibration is done in an "amortized" fashion.  It
will suffer the same within-jiffy skew caused by irregular osilator.

The existing code calibrates over a longer time.  So potentially it can be
more accurate.  On the other hand, the calibration routine takes a longer
time, which affects the accuracy the other way.

My current patch uses 20 jiffy cycles as the calibration period.  On ddb5476
board, the result is off by 1/100,000, which should well preserve the 1us
resolution.

It would be interesting to see the actual result from existing calibrations. 
In any case, the skews are probably so small that it won't be an issue here.

Jun
