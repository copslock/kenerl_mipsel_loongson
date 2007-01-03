Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2007 13:37:56 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:51639 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S20045273AbXACNhy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jan 2007 13:37:54 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1H26JN-0001zT-Tt
	for linux-mips@linux-mips.org; Wed, 03 Jan 2007 05:37:45 -0800
Message-ID: <8140851.post@talk.nabble.com>
Date:	Wed, 3 Jan 2007 05:37:45 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH][respin] pnx8550: fix system timer support
In-Reply-To: <8127168.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
References: <20061228171405.b1e3eed8.vitalywool@gmail.com> <20061229.011621.05599370.anemo@mba.ocn.ne.jp> <acd2a5930612280820l43639382x1f573386f2752d18@mail.gmail.com> <8124491.post@talk.nabble.com> <20070103.010650.25910215.anemo@mba.ocn.ne.jp> <8127168.post@talk.nabble.com>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips



Daniel Laird wrote:
> 
> 
Thanks, thats the build problem removed, I now have a kernel that builds
properly! (issues 1 and 2 appear to be closed)
Only issue remaining is that I still have a long hang (10 seconds ish) 
after this
Memory: 53540k/57344k available (2156k kernel code, 3744k reserved, 383k
data, 128k init, 0k highmem)
 I am investigating but any help is appreciated...
Dan


I have been debugging this and the delay is all due to the calibrate_delay
function.
If I use a preset lpj all works fine (fast start up)
If I let it calculate it using the logic
while ((loops_per_jiffy <<= 1) != 0) {
    /* wait for "start of" clock tick */
	ticks = jiffies;
    while (ticks == jiffies)
	/* nothing */;
    /* Go .. */
    ticks = jiffies;
    __delay(loops_per_jiffy);
    ticks = jiffies - ticks;
    if (ticks)
	break;
}
Then I get the hang so it seems this is the culprit function, however as for
why this is happening I am still debugging
Cheers
Dan
-- 
View this message in context: http://www.nabble.com/-PATCH--respin--pnx8550%3A-fix-system-timer-support-tf2890537.html#a8140851
Sent from the linux-mips main mailing list archive at Nabble.com.
