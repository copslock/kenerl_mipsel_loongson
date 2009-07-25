Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jul 2009 23:41:21 +0200 (CEST)
Received: from rv-out-0708.google.com ([209.85.198.242]:53201 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493451AbZGYVlP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Jul 2009 23:41:15 +0200
Received: by rv-out-0708.google.com with SMTP id l33so617726rvb.24
        for <linux-mips@linux-mips.org>; Sat, 25 Jul 2009 14:41:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=cz+LCdHkWc/NhKDdbVfBVXytJ6RpDJk2q8on5ej7Ebg=;
        b=g1HVcFY1kw12u3euAmi11R5Q0IwMO5H7dxYVB3iac+zXVEk3QvhEiaqEnvWExXgaRD
         HIpIHfOm7gDraaOiKtHkxGM4S0Cyg1IZBF/nScu8kzp6NqaLaCwa5MHZIRsUykkiN1uk
         9sLsYq/sxuDKu0O4T3fgAPhflCLJci+Rz05k4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=i9gUr1XAjDF49UeY7+1EAbdYmaz4LYq+GYJ/7xPxelg4gG31GYMp2f8vB7HZUOnOXs
         F2UkBy5pzSKKSqgU5/Gz2huqfXpeqtnIL+8zNQyNQ/O+8Cuucxanu5fwJxig1ecL8/M1
         kf3OtvZc3dftBo1c5gWLMNpcD6TmTywkuwLKk=
Received: by 10.141.37.8 with SMTP id p8mr3139140rvj.239.1248558073395;
        Sat, 25 Jul 2009 14:41:13 -0700 (PDT)
Received: from mailhub.coreip.homeip.net (c-24-6-153-137.hsd1.ca.comcast.net [24.6.153.137])
        by mx.google.com with ESMTPS id k2sm11799351rvb.32.2009.07.25.14.41.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Jul 2009 14:41:12 -0700 (PDT)
References: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com> <20090725191037.GE14062@dtor-d630.eng.vmware.com> <200907252139.30674.rjw@sisk.pl> <200907252221.45407.elendil@planet.nl>
Message-Id: <6090EAB2-5A74-4324-9B0C-1A70A871D293@gmail.com>
From:	Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:	Frans Pop <elendil@planet.nl>
In-Reply-To: <200907252221.45407.elendil@planet.nl>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
X-Mailer: iPhone Mail (7A341)
Mime-Version: 1.0 (iPhone Mail 7A341)
Subject: Re: [PATCH V2] au1xmmc: dev_pm_ops conversion
Date:	Sat, 25 Jul 2009 14:41:03 -0700
Cc:	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Arnaud Faucher <arnaud.faucher@gmail.com>,
	Erik Ekman <erik@kryo.se>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

On Jul 25, 2009, at 1:21 PM, Frans Pop <elendil@planet.nl> wrote:

> On Saturday 25 July 2009, Rafael J. Wysocki wrote:
>>>>> Was suspend to disk tested? It requires freeze()/thaw().
>>>>
>>>> Is that a regression introduced by this patch then? If so, many
>>>> more of the recent dev_pm_ops conversion patches would need to be
>>>> revisited.
>>
>> Yes, they would.  In general, you'd probably want to do something  
>> like
>> this:
>>
>> static struct dev_pm_ops au1xmmc_pmops = {
>>         .resume         = au1xmmc_resume,
>>         .suspend                = au1xmmc_suspend,
>>         .freeze         = au1xmmc_resume,
>>         .thaw           = au1xmmc_suspend,
>>         .restore                = au1xmmc_resume,
>>         .poweroff       = au1xmmc_suspend,
>> };
>>
>> but in this particular case it's probably better to define separate
>> callbacks for .freeze() and .thaw() at least.
>>
>> During hibernation we call .freeze() and .thaw() before and after
>> creating the image, respectively, and then .poweroff() is called  
>> right
>> after the image has been saved.  During resume .freeze() is called
>> after the image has been loaded and before the control goes to the
>> image kernel, which then calls .restore().
>
> Yes, I see that in drivers/base/platform.c (legacy) .suspend  
> resp. .resume
> also got called for those cases?
> Ouch :-(
>
> I've added others who've submitted dev_pm_ops patches in CC.
>
>> I'll fix up the floppy and hp-wmi patches.
>
> Note that those are already in mainline, as is pcspkr.
>


Pcspkr should be fine as is since we just want to shut it off and with  
s2d it will happen automatically when we power down.

-- 
Dmitry
