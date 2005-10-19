Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 19:13:18 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:15046 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S3465669AbVJSSNC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Oct 2005 19:13:02 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j9JICMw4029421;
	Wed, 19 Oct 2005 11:12:23 -0700 (PDT)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j9JICK17026041;
	Wed, 19 Oct 2005 11:12:20 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fwd: How to improve performance of 2.6 kernel
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date:	Wed, 19 Oct 2005 11:12:22 -0700
Message-ID: <3CB54817FDF733459B230DD27C690CEC01049446@Exchange.MIPS.COM>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fwd: How to improve performance of 2.6 kernel
thread-index: AcXUxX2y0mnnzCcXTLO9luuevAhL2AAEZ46A
From:	"Mitchell, Earl" <earlm@mips.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"kernel coder" <lhrkernelcoder@gmail.com>
Cc:	<linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.39
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips


If you are looking at network performance ...
A while back I briefly looked at this and it
looked like the per packet processing time had
gone up significantly between 2.4.20 and
2.6.x. Problem was not NAPI which switches
from interrupt to polling mode when you get a burst 
of packets. I actually traced a single packet from Rx 
to Tx. Unfortunately I didn't save my data and did 
not isolate where increased time was being spent. 

-earlm

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Ralf Baechle
> Sent: Wednesday, October 19, 2005 8:54 AM
> To: kernel coder
> Cc: linux-mips@linux-mips.org
> Subject: Re: Fwd: How to improve performance of 2.6 kernel
> 
> 
> On Wed, Oct 19, 2005 at 10:55:01AM +0500, kernel coder wrote:
> 
> > I did lmbench benchmarks tests... and the results i got were pretty
> > weird.. I am attaching the jpegs :) of the graphs i made in 
> MS Excel.
> 
> We're happy with cold, raw ASCII numbers :)
> 
> > Btw, I have implemented NAPI in both 2.4.20 and 2.6.10. I ported the
> > code to linux-2.6 in order to increase the board's 
> efficiency but I'm
> > quite dissapointed with the results so far :(.
> 
> NAPI is doing it's job which is keeping a system responsive 
> under extreme
> loads very well.  The pre-NAPI behaviour was simply locking 
> up thus making
> systems easily DOS-able.  NAPI is not meant to improve 
> latency; it isn't
> meant but frequently mistaken to.
> 
>   Ralf
> 
> 
