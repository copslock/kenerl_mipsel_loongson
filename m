Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 06:27:39 +0000 (GMT)
Received: from ag-out-0708.google.com ([72.14.246.250]:95 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20023627AbYANG1b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 06:27:31 +0000
Received: by ag-out-0708.google.com with SMTP id 22so1361239agd.7
        for <linux-mips@linux-mips.org>; Sun, 13 Jan 2008 22:27:29 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=eVczlcz1j/XOUyCFiMx6zGZEkFIbcfYVgtXghvD7dMY=;
        b=WGPzlWW+BzFXbd7Z0UYJVjBxKOFbQAul+jGm3WaTpGmH8UcKhgUiuxuv4NqXxDsV6Ur2yOg60XKAB/+fEsbtf6b3MAr0c2hkw8SGskJVp8zE5dK4/2ZJLt1AJ/73Fg8uZoI1czTvlYMgeInSbh2S6ZEMwXfgliCnMop571yDbsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fFCnCwZhkYH/j2lhO7J2o0S41AMcmuN8CNRjXFo/RY6MfwaVqgNQlIud7kD2gAe0jgNQpKFMwX7tamoWN84nS33ebouhez4MeAs5Uz8SFOkW/UirA1O6j9B4U7CiSaSG5W52jTxNeGtIyVUz/tVhaYszEGygl4mqr7eNmkLqj8g=
Received: by 10.100.232.13 with SMTP id e13mr13335661anh.61.1200292049401;
        Sun, 13 Jan 2008 22:27:29 -0800 (PST)
Received: from localhost ( [123.128.42.225])
        by mx.google.com with ESMTPS id 34sm11669465nza.33.2008.01.13.22.27.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 22:27:28 -0800 (PST)
Date:	Mon, 14 Jan 2008 14:26:34 +0800
From:	WANG Cong <xiyou.wangcong@gmail.com>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	WANG Cong <xiyou.wangcong@gmail.com>,
	Andreas Schwab <schwab@suse.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org
Subject: Re: (Try #3) [Patch 2/8] MIPS: Remove 'TOPDIR' from Makefiles
Message-ID: <20080114062634.GB2537@hacking>
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
References: <20080101071311.GA2496@hacking> <20080101072238.GC2496@hacking> <20080101101540.GB28913@uranus.ravnborg.org> <jefxxhlkxb.fsf@sykes.suse.de> <20080101175754.GC31575@uranus.ravnborg.org> <20080102062135.GE2493@hacking> <20080111141754.GC19900@linux-mips.org> <20080111170204.GA28299@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080111170204.GA28299@uranus.ravnborg.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <xiyou.wangcong@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiyou.wangcong@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Jan 11, 2008 at 06:02:04PM +0100, Sam Ravnborg wrote:
>On Fri, Jan 11, 2008 at 02:17:54PM +0000, Ralf Baechle wrote:
>> On Wed, Jan 02, 2008 at 02:21:36PM +0800, WANG Cong wrote:
>> 
>> > >> Shouldn't that use $(LINUXINCLUDE), or $(KBUILD_CPPFLAGS)?
>> > >It would be better to use $(LINUXINCLUDE) as we then pull in all config
>> > >symbols too and do not have to hardcode kbuild internal names (include2).
>> > 
>> > OK. Refine this patch.
>> 
>> LDSCRIPT also needed fixing to get builds in a separate object directory
>> working again.
>> 
>> I've applied below fix.
>
>Great - I will drop it from my tree. 
>
>See small comment below.
>
>	Sam
>
>
>>   Ralf
>> 
>> From 8babf06e1265214116fb8ffc634c04df85597c52 Mon Sep 17 00:00:00 2001
>> From: WANG Cong <xiyou.wangcong@gmail.com>
>> Date: Wed, 2 Jan 2008 14:21:36 +0800
>> Subject: [PATCH] [MIPS] Lasat: Fix built in separate object directory.
>> 
>> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
>> 
>> [Ralf: The LDSCRIPT script needed fixing, too]
>> 
>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>> 
>> diff --git a/arch/mips/lasat/image/Makefile b/arch/mips/lasat/image/Makefile
>> index 5332449..7ccd40d 100644
>> --- a/arch/mips/lasat/image/Makefile
>> +++ b/arch/mips/lasat/image/Makefile
>> @@ -12,11 +12,11 @@ endif
>>  
>>  MKLASATIMG = mklasatimg
>>  MKLASATIMG_ARCH = mq2,mqpro,sp100,sp200
>> -KERNEL_IMAGE = $(TOPDIR)/vmlinux
>> +KERNEL_IMAGE = vmlinux
>>  KERNEL_START = $(shell $(NM) $(KERNEL_IMAGE) | grep " _text" | cut -f1 -d\ )
>>  KERNEL_ENTRY = $(shell $(NM) $(KERNEL_IMAGE) | grep kernel_entry | cut -f1 -d\ )
>>  
>> -LDSCRIPT= -L$(obj) -Tromscript.normal
>> +LDSCRIPT= -L$(srctree)/$(obj) -Tromscript.normal
>
>This needs to read:
>> +LDSCRIPT= -L$(srctree)/$(src) -Tromscript.normal
>
>
>(There is no difference between src and obj in normal cases but to be consistent
>it shuld be like above).

Agreed. Thank you!
