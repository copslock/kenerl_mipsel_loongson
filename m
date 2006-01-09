Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 21:49:35 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:20463 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133508AbWAIVtP
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 21:49:15 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k09LplR0013566;
	Mon, 9 Jan 2006 13:51:48 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k09LphYr015673;
	Mon, 9 Jan 2006 13:51:44 -0800 (PST)
Message-ID: <43C2DB61.7090704@mips.com>
Date:	Mon, 09 Jan 2006 22:53:37 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To:	Wolfgang Denk <wd@denx.de>
CC:	Sathesh Babu Edara <satheshbabu.edara@analog.com>,
	linux-mips@linux-mips.org
Subject: Re: [processor frequency]
References: <20060109212339.C8289353A66@atlas.denx.de>
In-Reply-To: <20060109212339.C8289353A66@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Wolfgang Denk wrote:
> In message <005a01c614fb$2fe76b00$10eca8c0@grendel> you wrote:
>> There is no "ideal" value for a given processor frequency.
>> The lower the value, the less interrupt processing overhead,
>> but the slower the response time to events that are detected
>> or serviced during clock interrupts. 1000 HZ *may* be a sensible
>> value (I have my doubts, personally) for 2+ GHz PC processors, 
>> but it's excessive (IMHO) for a 200MHz processor and unworkable 
>> for a 20MHz CPU. I think that 100HZ is still a reasonable value
>> for an embedded RISC CPU, but the "ideal" value is going to
>> be a function of the application.
> 
> We did some tests of the performance impact of 100 vs. 1000 Hz  clock
> frequency on low end systems (50 MHz PowerPC); for details please see
> http://www.denx.de/wiki/view/Know/Clock100vs1000Hz

My own results, on an SMP 2.6 kernel (as opposed to the uniprocessor
2.4 kernel used for the experiments reported) have been rather different.
Certainly the degradations I observed were far worse than the 5-10% reported
in the document you cite.  I'll try to repeat your experiment when I get
the time.

BTW, I'm puzzled by the "context switch" benchmark test results.  By what
mechanism - or by what definition of "context switch" - can having more
frequent interrupts make context switches happen more quickly?  It seems
to me that those results must be due to a systematic measurement error
being added/removed.

		Regards,

		Kevin K
