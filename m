Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 18:59:00 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:50507 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012068AbaJUQ67HHO2s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 18:58:59 +0200
Received: by mail-ig0-f175.google.com with SMTP id uq10so1737930igb.8
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kpm55myASKZ+OUynEBlbz4oZ9+4WHaxjLYfox5+vdrw=;
        b=KAWghNwn78Qjpz/TGsTZQCITm8DnXPdAU2bWbUfPou+/pQtXC8hDg/8A48F/xPZOb2
         6wvwyNS6vgYnkUQf7+wtxuvr6kV3t72IRPcbzG0dbYJHM/34eObzUp9MHdX+Gee18z1h
         5VyNwsfbncbEpF/Ud542+tM/K4oRGHjxjXDYDGjM7KPEZ7f6qdKFzTlMwxMLR4hAcs+9
         eE0VmLJmC8pGyLKprsCgc2ma5i/2ogcCqnJ36IUloDNzfhlGnLZZ30Up8tX+7VLxGXVD
         9/EOYfN17TrKncB6M3F8kFmX+Do692cZ8A7yDTiQkpgHUHNEy9w7WT+z7MvKYHdBN8M4
         DtRA==
X-Received: by 10.107.15.224 with SMTP id 93mr4543073iop.86.1413910733269;
        Tue, 21 Oct 2014 09:58:53 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id k141sm6315899iok.13.2014.10.21.09.58.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 09:58:52 -0700 (PDT)
Message-ID: <544690CB.4030307@gmail.com>
Date:   Tue, 21 Oct 2014 09:58:51 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     richardcochran@gmail.com, markos.chandras@imgtec.com,
        linux-mips@linux-mips.org, corbet@lwn.net, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ptp: Fix build failure on MIPS cross builds
References: <1413794538-28465-1-git-send-email-markos.chandras@imgtec.com>        <20141021110724.GA16479@netboy> <20141021.123544.9516812519754063.davem@davemloft.net>
In-Reply-To: <20141021.123544.9516812519754063.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 10/21/2014 09:35 AM, David Miller wrote:
> From: Richard Cochran <richardcochran@gmail.com>
> Date: Tue, 21 Oct 2014 13:07:25 +0200
>
>> On Mon, Oct 20, 2014 at 09:42:18AM +0100, Markos Chandras wrote:
>>> diff --git a/Documentation/ptp/Makefile b/Documentation/ptp/Makefile
>>> index 293d6c09a11f..397c1cd2eda7 100644
>>> --- a/Documentation/ptp/Makefile
>>> +++ b/Documentation/ptp/Makefile
>>> @@ -1,5 +1,15 @@
>>>   # List of programs to build
>>> +ifndef CROSS_COMPILE
>>>   hostprogs-y := testptp
>>> +else
>>> +# MIPS system calls are defined based on the -mabi that is passed
>>> +# to the toolchain which may or may not be a valid option
>>> +# for the host toolchain. So disable testptp if target architecture
>>> +# is MIPS but the host isn't.
>>> +ifndef CONFIG_MIPS
>>> +hostprogs-y := testptp
>>> +endif
>>> +endif
>>
>> It seems like a shame to simply give up and not compile this at all.
>> Is there no way to correctly cross compile this for MIPS?
>
> Yeah seriously, we should try to make this work instead of throwing our
> hands in the air.
>

We cross compile things successfully all the time for all the various 
MIPS ABIs.

It is a simple matter of having the Makefile setup for cross compiling.

What I don't understand is why we are using hostprogs in this Makefile. 
  Isn't this a program that would run on the target, not the build host?

David Daney
