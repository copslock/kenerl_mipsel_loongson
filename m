Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 08:51:29 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.196]:50213 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20037748AbWHRHv1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 08:51:27 +0100
Received: by nz-out-0102.google.com with SMTP id s1so468434nze
        for <linux-mips@linux-mips.org>; Fri, 18 Aug 2006 00:51:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=TkFroIJEZbmoLEet4zrwMqgZiotBjGSO5N+hfLdJUa9aGsLwIrn1wiRJ7mhIB2j/4kHsgHwh+pHJbkpoKWCmhpUlgEPNTexCvEaIkOL4GfIYKKRAbUOJSVW8BsJPR0nn07V/e+wspTPoTCDsxOrsssjEh+ym3luu3T0y/XLKn4w=
Received: by 10.64.193.8 with SMTP id q8mr1808688qbf;
        Fri, 18 Aug 2006 00:51:23 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id q18sm190096qbq.2006.08.18.00.51.21;
        Fri, 18 Aug 2006 00:51:22 -0700 (PDT)
Message-ID: <44E57161.5060104@innova-card.com>
Date:	Fri, 18 Aug 2006 09:50:57 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mfinfo[64] used by get_wchan()
References: <44E475C8.5000105@innova-card.com> <20060818.115213.108739385.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060818.115213.108739385.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Thu, 17 Aug 2006 15:57:28 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> This array was used to 'cache' some frame info about scheduler
>> functions to speed up get_wchan(). This array was 1Ko size and
>> was only used when CONFIG_KALLSYMS was set but declared for all
>> configs.
>>
>> Rather than make the array statement conditional, this patches
>> removes this array and its uses. Indeed the common case doesn't
>> seem to use this array and get_wchan() is not a critical path
>> anyways.
> 
> It looks good basically, but a few fixes are required.
> 
>>  static int __init frame_info_init(void)
>>  {
>> -	int i;
>> +	unsigned long size = 0;
> 
> You must pass some non-zero size even if CONFIG_KALLSYMS was not set.
> Otherwise schedule_mfi will not be initialized as expected.  Actually,
> this is not a problem of this patch, but we missed this point on
> previous cleanups for the get_frame_info()...
> 

or maybe we can just fix get_frame_info() and make it more robust ?

>> +unsigned long get_wchan(struct task_struct *task)
>> +{
>> +	unsigned long stack_page = (unsigned long)task_stack_page(task);
> 
> This should be done after "if (!task ..." check.
> 
>> +	unsigned long pc = 0;
>> +#ifdef CONFIG_KALLSYMS
>> +	unsigned long sp = task->thread.reg29;
> 
> Same.  And you missed one stack level.
> 
> 	sp = task->thread.reg29 + schedule_mfi.frame_size;
> 

Absolutely. I'll cook up a new patch and will send it today.

Thanks

		Franck
