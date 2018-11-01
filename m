Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2018 18:00:05 +0100 (CET)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:45897
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991096AbeKAQ7lY5XnS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2018 17:59:41 +0100
Received: by mail-pg1-x541.google.com with SMTP id s3-v6so9289686pga.12;
        Thu, 01 Nov 2018 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uiasgtM/p2VjObQyowWTRMYBJV4UN1vpzjydvWmpilw=;
        b=CsL5aqC3fgiWUT/vnO3c3Iz6dowQUJGH0LtWvq37CQkceZVg7q9lfb2nJokjeut3eg
         uutEzFXPiRF2SuEDNe2tOGJKEA0GpbIi8xfgI3bb5neR91zQr0opxUxOoe0FdWE849nL
         ThYqgTV7KEg6hDd0vXnCAUXj/zZbx3bwxlwqUd8G9+1mw8Hrepwn695WW+cHC11z6UTk
         B/sCZmZHaElfOybrgyjSqI/jzdQLygz8ed7V5A1XiKETD/2kKExaQPTlAuirLMj7Ucv8
         +8bGff0edSwtGLkq56+AGyWh5lVKRWshTvFVXf5FSn1hQOog04TCVgw+d04fvk5y51bK
         PsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uiasgtM/p2VjObQyowWTRMYBJV4UN1vpzjydvWmpilw=;
        b=Rb+DadaTuAfMnkbe/tUoD4ncTSqA0Su5NU2KR1SNSulg+/JHnVNLqAiVpIeM+TIlVK
         Iz8CJJgIo1o18O/u8wCsxQLFssZ6V5sEm0p79s6xR3sUgYioDC0hN55jhLAk1rKUGSbZ
         7z4zEOlG3xsDQIxejaturB8rBT1WBv8H5viVRwPsv7bVAeZz7nRjiyov2LZbOtx6Lndw
         pIOwix4VUWgt2njU321JjWsSfpjYy5hDEwz71EK0MX9MOBDzdtU6OU61JcTYuH5NBPR9
         gCbTw3YG7O5KbQs5bZ9WmTg9AUxjh+Zx8Eru7j+VrhhtRMhUxEQw1KaXpz9GFP30G+Fy
         Lxtw==
X-Gm-Message-State: AGRZ1gJxM/kSFErTRZU8zGBxp2S7jhHVWZbWRcnkkeCeJ/ng3wvDgU/D
        MKId9QBewG3TuzKmVLa5wbo=
X-Google-Smtp-Source: AJdET5dZ17VY146v8M8MAXofuxvt+4Be+sC26ENz/XUmO6FhZfoX1HeV6Bo7f7nv+PI/WAq9YyKzJQ==
X-Received: by 2002:a62:9f90:: with SMTP id v16-v6mr8498448pfk.207.1541091580382;
        Thu, 01 Nov 2018 09:59:40 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id u62-v6sm53459766pfu.69.2018.11.01.09.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:59:39 -0700 (PDT)
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
To:     Peter Zijlstra <peterz@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "paul.burton@mips.com" <paul.burton@mips.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        aryabinin@virtuozzo.com, dvyukov@google.com
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <b0160f4b-b996-b0ee-405a-3d5f1866272e@gmail.com>
Date:   Thu, 1 Nov 2018 09:59:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181101163212.GF3159@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <eric.dumazet@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.dumazet@gmail.com
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



On 11/01/2018 09:32 AM, Peter Zijlstra wrote:

>> Anyhow, if the atomic maintainers are willing to stand up and state for
>> the record that the atomic counters are guaranteed to wrap modulo 2^n
>> just like unsigned integers, then I'm happy to take Paul's patch.
> 
> I myself am certainly relying on it.


Could we get uatomic_t support maybe ?

This reminds me of this sooooo silly patch :/

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adb03115f4590baa280ddc440a8eff08a6be0cb7
