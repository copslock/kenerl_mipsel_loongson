Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 20:05:15 +0100 (CET)
Received: from mail-pb0-f53.google.com ([209.85.160.53]:63355 "EHLO
        mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816521Ab3ADTFOfCl9C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 20:05:14 +0100
Received: by mail-pb0-f53.google.com with SMTP id jt11so9314620pbb.26
        for <multiple recipients>; Fri, 04 Jan 2013 11:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ORHSDGg59oCKhIKA9/cwFsuJVM/1NJ1zxemBLh1Y7Bo=;
        b=DZ+ynN3bFLXzm28YK2mHiSUZNq4BQQMiyNy8u4aJalgOp4LE4mssmuX2eId+5UNHhn
         u8lPqFZUfr1F2Ei6TWkEoyXn7JX908y87g3Hv+zdBwh7BuZ72dtR5dsjhvWROJ7o7aEK
         iDVartADHjNV7kwXbBJvGeriMBIcFbT3WsPmi3Z2L2UXdVy5K9Nys0O+tUkeenC5LdXu
         zAnUAaTLw7IclCT9kL7+iO9UyX9zgqMmfboP/Kn69DsaM6ZWRm+Y6R/VQ7CQNSFkvB5q
         v0Z8ICaex2yRy4nMz4T3LxwZwvvRGE6lmn8o9zHrxRrxIXGriczEekraMZr0gp75XbvN
         gxeQ==
X-Received: by 10.68.209.230 with SMTP id mp6mr163572503pbc.8.1357326307601;
        Fri, 04 Jan 2013 11:05:07 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pm8sm32665936pbb.29.2013.01.04.11.05.06
        (version=SSLv3 cipher=OTHER);
        Fri, 04 Jan 2013 11:05:06 -0800 (PST)
Message-ID: <50E727E1.8040604@gmail.com>
Date:   Fri, 04 Jan 2013 11:05:05 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Hill, Steven" <sjhill@mips.com>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH v4] MIPS: Make CP0 config registers readable via sysfs.
References: <1355436915-24381-1-git-send-email-sjhill@mips.com> <alpine.LFD.2.02.1212132325180.5950@eddie.linux-mips.org>,<50CA6712.1060809@gmail.com> <31E06A9FC96CEC488B43B19E2957C1B801146AF10B@exchdb03.mips.com>
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B801146AF10B@exchdb03.mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35372
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/04/2013 10:38 AM, Hill, Steven wrote:
>> You're exporting privileged context outside the kernel -- have all the
>> security implications been considered?
>>
> Maciej,
>
> I have gone through the config registers bit-by-bit and I do not see
> where there are any security implications.

[...]

> Unless you can provide a counterexample,
> this patch does not compromise the system in anyway.
>

The patch stands alone.  Any security problems it might have are 
completely unrelated to any hypothetical Counter Examples.

David Daney
