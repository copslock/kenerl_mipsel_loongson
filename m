Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2007 14:34:19 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:19140 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S28573925AbXACOeR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jan 2007 14:34:17 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1H27C1-0003u9-Up
	for linux-mips@linux-mips.org; Wed, 03 Jan 2007 06:34:13 -0800
Message-ID: <8141727.post@talk.nabble.com>
Date:	Wed, 3 Jan 2007 06:34:13 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH][respin] pnx8550: fix system timer support
In-Reply-To: <20070103.225713.74752439.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
References: <20061228171405.b1e3eed8.vitalywool@gmail.com> <20061229.011621.05599370.anemo@mba.ocn.ne.jp> <acd2a5930612280820l43639382x1f573386f2752d18@mail.gmail.com> <8124491.post@talk.nabble.com> <20070103.010650.25910215.anemo@mba.ocn.ne.jp> <8127168.post@talk.nabble.com> <20070103.225713.74752439.anemo@mba.ocn.ne.jp>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips




Atsushi Nemoto wrote:
> 
> On Tue, 2 Jan 2007 09:17:32 -0800 (PST), Daniel Laird
> <danieljlaird@hotmail.com> wrote:
>> Thanks, thats the build problem removed, I now have a kernel that builds
>> properly! (issues 1 and 2 appear to be closed)
>> Only issue remaining is that I still have a long hang (10 seconds ish) 
>> after this
>> Memory: 53540k/57344k available (2156k kernel code, 3744k reserved, 383k
>> data, 128k init, 0k highmem)
>>  I am investigating but any help is appreciated...
> 
> Does this patch (on top of Vitaly's patch) solve remaining problem?
> 
> diff --git a/arch/mips/philips/pnx8550/common/time.c
> b/arch/mips/philips/pnx8550/common/time.c
> index 08ebc3d..9d9fc71 100644
> --- a/arch/mips/philips/pnx8550/common/time.c
> +++ b/arch/mips/philips/pnx8550/common/time.c
> @@ -80,6 +80,7 @@ void pnx8550_time_init(void)
>  	 */
>  	mips_hpt_frequency = 27UL * ((1000000UL * n)/(m * pow2p));
>  	cpj = (mips_hpt_frequency + HZ / 2) / HZ;
> +	write_c0_count(0);
>  	timer_ack();
>  
>  	/* Setup Timer 2 */
> 

I too caqme to this conclusion and you are correct it does indeed fix the
problem.  The kernel now boots straight through to the prompt.
Thanks
Dan
-- 
View this message in context: http://www.nabble.com/-PATCH--respin--pnx8550%3A-fix-system-timer-support-tf2890537.html#a8141727
Sent from the linux-mips main mailing list archive at Nabble.com.
