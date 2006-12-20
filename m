Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 15:46:34 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:27582 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S28583452AbWLTPq3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Dec 2006 15:46:29 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1Gx3eD-00078Y-1y
	for linux-mips@linux-mips.org; Wed, 20 Dec 2006 07:46:25 -0800
Message-ID: <7992266.post@talk.nabble.com>
Date:	Wed, 20 Dec 2006 07:46:24 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: 2.6.19 timer API changes
In-Reply-To: <20061221.002420.132303561.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
References: <7925588.post@talk.nabble.com> <7943218.post@talk.nabble.com> <20061219.233410.25911550.anemo@mba.ocn.ne.jp> <20061220.000113.59033093.anemo@mba.ocn.ne.jp> <7949125.post@talk.nabble.com> <20061220.021508.97296486.anemo@mba.ocn.ne.jp> <7987092.post@talk.nabble.com> <20061221.002420.132303561.anemo@mba.ocn.ne.jp>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips


hello, 


Atsushi Nemoto wrote:
> 
> On Wed, 20 Dec 2006 01:37:17 -0800 (PST), Daniel Laird
> <danieljlaird@hotmail.com> wrote:
>> Then I get  a normal startup.  i.e it boots fast (no 10second hang).  If
>> I
>> remove the write_c0_count then I get the 10 second hang.
> 
> I think Kevin's analysis about this 10 second hang is correct.  Then I
> think my last patch will work as well.
> 
>> I have no idea if gettimeofday is broken.  ANy ideas on testing this? Is
>> there a test package / application that will do this?  Before I write my
>> own
> 
> Calling gettimeofday() continuously many times (at least some tick
> periods) and calculates times between each call.  Those differences
> should be almost same.  Of course you must run this program on very
> idle system (or you must raise its priority).
> 
> ---
> Atsushi Nemoto
> 
Thanks guys I can see how Kevin has come to his conclusion (On 10 secs And I
think I agree)!  
I will try your 2nd proposed solution, I gave it a very quick go but it did
not work.  I will give this some proper time, I think some mips_clocksource
needed to be externed etc.  (and add linux/clocksource.h ) to
pnx8550/common/time.c.
Hopefullly this will make it compile, and then I can trace the problem a bit
more.  It might be after Christmas though before I come back to this
Again cheers for the help.
Dan
-- 
View this message in context: http://www.nabble.com/2.6.19-timer-API-changes-tf2838715.html#a7992266
Sent from the linux-mips main mailing list archive at Nabble.com.
