Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2016 23:17:49 +0100 (CET)
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35386 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013694AbcCPWRsiSxjB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2016 23:17:48 +0100
Received: by mail-wm0-f48.google.com with SMTP id l68so205483084wml.0;
        Wed, 16 Mar 2016 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=yE0WK/iU4921hSadYAgg8hlEq9GrLtjH12+tpvFX06M=;
        b=CbSKI6OIZq7etT7494uvLw55fwdEq9OaJrHJUWyZw8f1LrnIln/M/3H+VI+Of7U9GH
         5PB8xfcw4ElXyn4/H0hgZG/JHSORr0xIJTItKsdujwuOGUqHfj+GK57t/Zb2mgytpU9Q
         7X1r59uM2uXQnXL+enQ9d9FDkeMir46ZDzEYJqpDSfU8t/kJI2KTT3kpJSCA2tjvO7Cl
         U5a1v3gnOe99OiQG8HMdl9lw1ss3dQiu/xP0xbDwtmbaQ+CWvo1mILlCZbc8i5DWUWW/
         GtDfzq3k+mEBVCgul+N/Jxq1n7+yL/wsUvhDfSe/Rr84gw1DskxLBPlhbUU85pwHy91m
         fhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=yE0WK/iU4921hSadYAgg8hlEq9GrLtjH12+tpvFX06M=;
        b=fnNQ4Xp4ItOn+qCJ5FEJxzu6haxbIIMM3zTXvBjXBV37LoNBbBelcc9EVoaoea72Dl
         X4KLfYN23HF0HpqEytoCUbPTHo4BDO2YVs9eV6aNDsrbQzB48Bzquyw0trjfgl2QkMgo
         eOKj7RIezCmpoRp8hjUXHk2mv3DsdiI77ey/olE7DshmVBxBeTbMiW2H7EWWr1Zc+JRp
         qwvYWvr8p0ylEOjWDggfgsHKEC7BqX9nKu7ADc1fNmAuO8QHFXh3E7mXRNyYAbIMMxxC
         qV/A+8O6dTW3gKsSnm1dofMs9gSQdhYCEe39CU6IXoDodFTK5nQvOxsR31b6D2poKRxq
         /avA==
X-Gm-Message-State: AD7BkJITAKFbKuKzAIVok8LXk8AvsX6mNWtiJMGaLNbgnyS1T40HQUAj1Bl/jVzJ45djcg==
X-Received: by 10.28.95.131 with SMTP id t125mr32886882wmb.80.1458166663360;
        Wed, 16 Mar 2016 15:17:43 -0700 (PDT)
Received: from Qaiss-MacBook-Pro.local (host81-157-242-128.range81-157.btcentralplus.com. [81.157.242.128])
        by smtp.gmail.com with ESMTPSA id bg1sm4893880wjc.27.2016.03.16.15.17.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Mar 2016 15:17:42 -0700 (PDT)
Subject: Re: linux-next: Tree for Mar 14 (mips qemu failure bisected)
To:     Guenter Roeck <linux@roeck-us.net>
References: <20160314174037.0097df55@canb.auug.org.au>
 <20160314143729.GA31845@roeck-us.net> <20160315052659.GA9320@roeck-us.net>
 <56E884BA.5050103@gmail.com> <20160316001713.GA4412@roeck-us.net>
 <20160316132210.GA21918@roeck-us.net> <56E9C1CA.7050208@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
From:   Qais Yousef <qsyousef@gmail.com>
Message-ID: <56E9DB85.9090405@gmail.com>
Date:   Wed, 16 Mar 2016 22:17:41 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56E9C1CA.7050208@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070206070600080600020506"
Return-Path: <qsyousef@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qsyousef@gmail.com
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

This is a multi-part message in MIME format.
--------------070206070600080600020506
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 16/03/2016 20:27, Qais Yousef wrote:
>
>
> On 16/03/2016 13:22, Guenter Roeck wrote:
>> On Tue, Mar 15, 2016 at 05:17:13PM -0700, Guenter Roeck wrote:
>>> On Tue, Mar 15, 2016 at 09:55:06PM +0000, Qais Yousef wrote:
>>>> Hi Guenter,
>>>>
>> [ ... ]
>>>>>> Qemu test results:
>>>>>>     total: 96 pass: 69 fail: 27
>>>>>> Failed tests:
>>>>> [ ... ]
>>>>>>     mips:mips_malta_smp_defconfig
>>>>> I bisected this failure to commit bb11cff327e54 ("MIPS: Make smp 
>>>>> CMP, CPS and MT
>>>>> use the new generic IPI functions". Bisect log is attached.
>>>> Thanks for bisecting this. I tested this on a real Malta system but 
>>>> not
>>>> qemu. I'll try to reproduce.
>>>>
>>> I run the tests with only a single CPU core enabled. Maybe that causes
>>> problems with your code ?
>>>
>> I ran another qemu test (this time on mainline) with "-smp 2", but 
>> the only
>> difference is that the image now gets stuck even earlier.
>>
>> Also, I ran another set of bisects, this time with both mips and mips64
>> on mainline (after your patch landed), with the same results.
>>
>> Guenter
>>
>
> OK thanks for the info. The offending commit just enables using quite 
> a few of the newly added code before that. So the problem could be in 
> any of the newly added code.
>
> Unfortunately I can only look at this during my limited time in the 
> evening and I have to setup my system to compile and run this, so I 
> won't be able to get to the bottom of this as fast as I'd like to.
>
> Qais

OK I was up and running faster than I thought I would be. Can you 
confirm that you're hitting a BUG_ON() in mips_smp_ipi_init()?

What I see is that BUG_ON() is hit because we couldn't find an ipidomain 
to allocate the ipis from. The reason of whih is that the qemu malta 
machine doesn't have a GIC though the config is compiled with GIC on. 
Also if I remember correctly qemu malta doesn't really support SMP. I 
think that was the reason I never ran this on qemu.

I'm not sure what's the best way forward here. I can add a check to 
verify gic_present inside this function and return early. Patch attached.

Ralf, thoughts?

Thanks,
Qais

--------------070206070600080600020506
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="0001-MIPS-Fix-broken-malta-qemu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-MIPS-Fix-broken-malta-qemu.patch"
