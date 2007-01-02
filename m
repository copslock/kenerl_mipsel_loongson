Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2007 17:17:43 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:2538 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S28575680AbXABRRi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2007 17:17:38 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1H1nGW-0000to-3K
	for linux-mips@linux-mips.org; Tue, 02 Jan 2007 09:17:32 -0800
Message-ID: <8127168.post@talk.nabble.com>
Date:	Tue, 2 Jan 2007 09:17:32 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH][respin] pnx8550: fix system timer support
In-Reply-To: <20070103.010650.25910215.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
References: <20061228171405.b1e3eed8.vitalywool@gmail.com> <20061229.011621.05599370.anemo@mba.ocn.ne.jp> <acd2a5930612280820l43639382x1f573386f2752d18@mail.gmail.com> <8124491.post@talk.nabble.com> <20070103.010650.25910215.anemo@mba.ocn.ne.jp>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips



Atsushi Nemoto wrote:
> 
> On Tue, 2 Jan 2007 06:05:55 -0800 (PST), Daniel Laird
> <danieljlaird@hotmail.com> wrote:
>> First things first, if I do use the line 
>> clocksource_mips.read = hpt_read; 
>> It does not compile as this symbol is not in a header file and is a
>> static
>> struct in arch/mips/kernel/time.c
>> I can make it not static and extern it from pnx8550/common/time.c is this
>> how I should do it?
> 
> To fix the build problem, use latest linux-mips.org git-tree or use
> 2.6.20-rc3 from kernel.org, or import these patches:
> 
> http://www.linux-mips.org/git?p=linux.git;a=commit;h=c87b6ebaea034c0e0ce86127870cf1511a307b64
> http://www.linux-mips.org/git?p=linux.git;a=commit;h=005985609ff72df3257fde6b29aa9d71342c2a6b
> 
> ---
> Atsushi Nemoto
> 
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


-- 
View this message in context: http://www.nabble.com/-PATCH--respin--pnx8550%3A-fix-system-timer-support-tf2890537.html#a8127168
Sent from the linux-mips main mailing list archive at Nabble.com.
