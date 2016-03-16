Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2016 21:28:02 +0100 (CET)
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38370 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024762AbcCPU2BVQFvc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2016 21:28:01 +0100
Received: by mail-wm0-f42.google.com with SMTP id l68so89094937wml.1;
        Wed, 16 Mar 2016 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=4pOJX64tKZDQTEVlL1hutHe8v2GkLOkNemI5x2YDmv8=;
        b=dKz9fgfJlaMRi2NKlVoAkFg8z2vNKa+hDh0IfefZdAZi4y8acqdY2uQVRur1NhlU9L
         iJ8PEM5ewxSHSiZYteWk4Kab5MHJQ+Kq/UsQqnh3qJbXeYA6ciUCgU6aA3ne+4EXirVI
         ehRRR0unqyhgL2JfEXQv4Sl6s+rl/ep5Y8ir+d7rGBjmXkbpdiEmVFROX8Zp3ghP7LO5
         BrlG5sI6fMGvexmOrUYGCk/KKTNzrNql2OcXYRsQrF5K/peseOKKoK3e1ZGeMk/ZFYcO
         P2eeFcNBwK5v7BsvnHWzQCuml3bH95g9aVwHByeKTgodl6W7YNzjtV3d4RqAL8mnH0Xd
         7RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4pOJX64tKZDQTEVlL1hutHe8v2GkLOkNemI5x2YDmv8=;
        b=Z9qeg8eltuO937FODZ3iVU0c5wQVHkl5/Yrz1hhA/kp+VgetTYgtUHWCtdijnMdFnV
         6PgzB71QXC3Gm4xkTC7B8/W0wqi1q+7A4YoG8h+Fs5nW5E2700Oh6Yqn9/AyFDTX1aa/
         5D4UCf/Gtu4+wkq2gur1TV1k54dCaqLp/xhNY7+T0Pv1AjExgBO9/U0wmxrn4l4/byQI
         QAlwQGLaxbF5guGiGrfLXL9Vr8F35IJOEGwQIh3lHutWqKsKsCYUavuK3Q8PSwEZ0RzC
         j8JvbXcealpiEH299vLGaVQ4TvpH8abAZLRjGKsJW/L4F8XboWgMWZ5iU07SrMI+C4b+
         INFg==
X-Gm-Message-State: AD7BkJI9Pu4wmWidJdQbxFMaUIbmOaExDLT6ub59jzvK01KrUNYDQvMh5bk8ou0fvL+RxA==
X-Received: by 10.28.173.71 with SMTP id w68mr33289200wme.88.1458160075403;
        Wed, 16 Mar 2016 13:27:55 -0700 (PDT)
Received: from Qaiss-MacBook-Pro.local (host81-157-242-128.range81-157.btcentralplus.com. [81.157.242.128])
        by smtp.gmail.com with ESMTPSA id a16sm27094670wmi.0.2016.03.16.13.27.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Mar 2016 13:27:54 -0700 (PDT)
Subject: Re: linux-next: Tree for Mar 14 (mips qemu failure bisected)
To:     Guenter Roeck <linux@roeck-us.net>
References: <20160314174037.0097df55@canb.auug.org.au>
 <20160314143729.GA31845@roeck-us.net> <20160315052659.GA9320@roeck-us.net>
 <56E884BA.5050103@gmail.com> <20160316001713.GA4412@roeck-us.net>
 <20160316132210.GA21918@roeck-us.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
From:   Qais Yousef <qsyousef@gmail.com>
Message-ID: <56E9C1CA.7050208@gmail.com>
Date:   Wed, 16 Mar 2016 20:27:54 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160316132210.GA21918@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <qsyousef@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52609
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



On 16/03/2016 13:22, Guenter Roeck wrote:
> On Tue, Mar 15, 2016 at 05:17:13PM -0700, Guenter Roeck wrote:
>> On Tue, Mar 15, 2016 at 09:55:06PM +0000, Qais Yousef wrote:
>>> Hi Guenter,
>>>
> [ ... ]
>>>>> Qemu test results:
>>>>> 	total: 96 pass: 69 fail: 27
>>>>> Failed tests:
>>>> [ ... ]
>>>>> 	mips:mips_malta_smp_defconfig
>>>> I bisected this failure to commit bb11cff327e54 ("MIPS: Make smp CMP, CPS and MT
>>>> use the new generic IPI functions". Bisect log is attached.
>>> Thanks for bisecting this. I tested this on a real Malta system but not
>>> qemu. I'll try to reproduce.
>>>
>> I run the tests with only a single CPU core enabled. Maybe that causes
>> problems with your code ?
>>
> I ran another qemu test (this time on mainline) with "-smp 2", but the only
> difference is that the image now gets stuck even earlier.
>
> Also, I ran another set of bisects, this time with both mips and mips64
> on mainline (after your patch landed), with the same results.
>
> Guenter
>

OK thanks for the info. The offending commit just enables using quite a 
few of the newly added code before that. So the problem could be in any 
of the newly added code.

Unfortunately I can only look at this during my limited time in the 
evening and I have to setup my system to compile and run this, so I 
won't be able to get to the bottom of this as fast as I'd like to.

Qais
