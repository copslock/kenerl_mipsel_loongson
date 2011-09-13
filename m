Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2011 12:39:34 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:34150 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1IMKja (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2011 12:39:30 +0200
Received: by wyh11 with SMTP id 11so385159wyh.36
        for <linux-mips@linux-mips.org>; Tue, 13 Sep 2011 03:39:24 -0700 (PDT)
Received: by 10.227.25.75 with SMTP id y11mr2134214wbb.112.1315910364562;
        Tue, 13 Sep 2011 03:39:24 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.91.184])
        by mx.google.com with ESMTPS id fa7sm1339672wbb.26.2011.09.13.03.39.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Sep 2011 03:39:23 -0700 (PDT)
Message-ID: <4E6F32AE.3040007@mvista.com>
Date:   Tue, 13 Sep 2011 14:38:38 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
MIME-Version: 1.0
To:     post@pfrst.de
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Impact video driver for SGI Indigo2
References: <Pine.LNX.4.64.1109131101530.4143@Indigo2.Peter>
In-Reply-To: <Pine.LNX.4.64.1109131101530.4143@Indigo2.Peter>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6301

Hello.

On 13-09-2011 13:39, peter fuerst wrote:

>> Date: Mon, 12 Sep 2011 13:56:36 +0400
>> From: Sergei Shtylyov <sshtylyov@mvista.com>
>> To: post@pfrst.de
>> Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
>> attilio.fiandrotti@gmail.com
>> Subject: Re: [PATCH] Impact video driver for SGI Indigo2

>> ...
>>> framebuffer device. Without the support of PCI & AGP.

>> It looks like the patch is spoiled as I'm seeing two spaces at the start
>> of line when looking at the message source.

> hmmm, that's a strange problem. The two spaces are not in the diff-file
> read into the eMail and are not displayed by the MUA (pine 4.64). But

    Indeed, they're not displayed (though due to "format=flowed" the patch is 
not diasplyed correctly for me anyway).

> indeed, where's a leading space in the diff, there's an additional space
> inserted into the eMail-body. Have to find out the best way to suppress
> this behaviour...

>>>
>>> ...

>> There are alos empty lines after each file in the patch -- which
>> shouldn't be there.

> These were intended for readability (reviewability :), but i can remove
> them easily (of course).

    These will prevent the patch from applying, AFAIK.

>>> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
>>> ...

>> The above should be a part of the driver patch, as you can't add Makefile
>> targets fow which no source files exist yet.

> Do you suggest to submit the ip22-setup.c-, impact.h-, impact.c-parts
> alone in a first patch and then,

    No, I suggest putting drivers/video/impact.* and drivers/video/*Kconfig 
and drivers/video/Makefile in one patch and leaving ip22-setup.c in another 
one -- the driver should be separate from the platform code IMO. The defconfig 
change should also be a patch of it's own, IMO.

> in a separate follow-up patch, the
> Kconfig- and Makefile-parts, or just to reorder the parts in this single
> patch?

    No, not reorder.

> with kind regards

> peter

WBR, Sergei
