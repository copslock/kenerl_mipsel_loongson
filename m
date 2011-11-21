Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 19:51:38 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:55355 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903796Ab1KUSvR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 19:51:17 +0100
Received: by yenr8 with SMTP id r8so5355216yen.36
        for <multiple recipients>; Mon, 21 Nov 2011 10:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jP3CX7Qf5LRpsJGnNuHq5GZQGccUwdaQeF183TbvFUc=;
        b=q/BHGRQXkfe3kLc6NC/Jm8sygtI63KHKhnyO4UirIUjrB2DSJac2ShstNOvwTnLvkw
         xqWJc08X+kN8kKtvzuutTHE+3WRa+R26zaC+cwyaMeFGm2/6LzI4q7emgwDwYVN1YJ2i
         Qd5j7U1yxfN/KCt4ljrMHk/qFC0P4f74hQBPI=
Received: by 10.236.77.233 with SMTP id d69mr21576368yhe.84.1321901470631;
        Mon, 21 Nov 2011 10:51:10 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id i31sm31606129anm.19.2011.11.21.10.51.06
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 10:51:07 -0800 (PST)
Message-ID: <4ECA9D9A.5040006@gmail.com>
Date:   Mon, 21 Nov 2011 10:51:06 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "H. Peter Anvin" <hpa@kernel.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-embedded@vger.kernel.org, x86@kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH RFC 1/5] scripts: Add sortextable to sort the kernel's
 exception table.
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com> <1321645068-20475-2-git-send-email-ddaney.cavm@gmail.com> <4EC98C97.50604@kernel.org>
In-Reply-To: <4EC98C97.50604@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17644

On 11/20/2011 03:26 PM, H. Peter Anvin wrote:
> On 11/18/2011 11:37 AM, David Daney wrote:
>> From: David Daney<david.daney@cavium.com>
>>
>> Using this build-time sort saves time booting as we don't have to burn
>> cycles sorting the exception table.
>>
>
> If we're going to do this at build time, I would suggest using a
> collisionless hash instead.  The lookup time for those are O(1), but
> they definitely need to be done at build time.
>

It is my understanding that such a hash table would be sparsely 
populated, so space would have to be reserved for the empty buckets. 
The current patch, which works in-place on the fully linked vmlinux, 
doesn't have to worry about finding enough space for the table.

If we were to do the collisionless hash, we would somehow have to 
reserve space for the empty buckets.

On my test kernel, there were only 1453 entries in the exception table, 
So doing the binary search takes a maximum of 11 loads.

So, I guess I am not strongly opposed to using a collisionless hash, but 
I think it may not be worth the extra effort.

David Daney
