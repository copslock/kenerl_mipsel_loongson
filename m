Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 14:02:46 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36427 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993922AbdFZMCjy0BQA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jun 2017 14:02:39 +0200
Received: by mail-wm0-f65.google.com with SMTP id y5so1070815wmh.3;
        Mon, 26 Jun 2017 05:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RUgQ/uRFrVSpCh0L9mi5NrAXwwqyJ2a1SUHxpWtEidg=;
        b=B2JMGTgQQA9BLj6zJ/dmawl+g4HDs9UynT7NsITErTukOnh+WwyAdER6wkbOfnWcdj
         ZQIM3yVTFz7vii7wyxnfvQS8h2IAWv49tXrwpxoXEVpkwKpPfh8aad8V4Hzb3zjz2Pdn
         fuUz1xr/kEeVQpRgRct5lEe6ptYhrUewZo7LIH/vIaRe8qOoxWm5mIgOLws5mS76GvbA
         i2Yz3FjjteZhe4kdGOW9x7FVSPHIu/TLFRkcFc3qPQ21Xy/B+ESqdS6zmvVlD8ttM3bH
         yup2LTAFsERr4LedPS7ZLMdgvFBHSKdOgybviuHXO3EYKadzRF6MIg8GyucN8Ral5nvC
         p/Og==
X-Gm-Message-State: AKS2vOxd5Z9lKFNOZnJ7BiHuMKRg9dY06xUXkSW8O7OsJI7d78If6nK7
        ZU27TXEzxX+hOg==
X-Received: by 10.28.234.152 with SMTP id g24mr12793810wmi.43.1498478554426;
        Mon, 26 Jun 2017 05:02:34 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::c92? ([2a01:4240:2e27:ad85:aaaa::c92])
        by smtp.gmail.com with ESMTPSA id 92sm22560584wrb.55.2017.06.26.05.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 05:02:33 -0700 (PDT)
Subject: Re: [PATCH 1/1] futex: remove duplicated code and fix UB
To:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
References: <20170621115318.2781-1-jslaby@suse.cz>
 <alpine.DEB.2.20.1706230017520.2221@nanos>
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <80af8d81-4522-de2d-8289-1ab46565505a@suse.cz>
Date:   Mon, 26 Jun 2017 14:02:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1706230017520.2221@nanos>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 06/23/2017, 09:51 AM, Thomas Gleixner wrote:
> On Wed, 21 Jun 2017, Jiri Slaby wrote:
>> diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
>> index f32b42e8725d..5bb2fd4674e7 100644
>> --- a/arch/arm64/include/asm/futex.h
>> +++ b/arch/arm64/include/asm/futex.h
>> @@ -48,20 +48,10 @@ do {									\
>>  } while (0)
>>  
>>  static inline int
>> -futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> 
> That unsigned int seems to be a change from the arm64 tree in next. It's
> not upstream and it'll cause a (easy to resolve) conflict.

Ugh, I thought the arm64 is in upstream already. Note that this patch
just takes what is in this arm64 fix and makes it effective for all
architectures. So I will wait with v2 until it merges upstream.

So, Will, will you incorporate Thomas' comments into your arm64 fix?

...

> Yes, we probably can't change that anymore, but at least we should make it
> very explicit and add a comment to that effect.

Something like this or do you want a comment yet?
        unsigned int op =         (encoded_op & 0x70000000) >> 28;
        unsigned int cmp =        (encoded_op & 0x0f000000) >> 24;
        int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
        int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);

thanks,
-- 
js
suse labs
