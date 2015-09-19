Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Sep 2015 04:49:32 +0200 (CEST)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:32985 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006749AbbISCtabmUUy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Sep 2015 04:49:30 +0200
Received: by oixx17 with SMTP id x17so35860139oix.0;
        Fri, 18 Sep 2015 19:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=RaV9W5iiAC+XtuJL0t1pdrK3KUNh2olj5NrsznHI0LQ=;
        b=EZomeOQejbK0TSI5TkphCsS2sH94iZQG0aNoZ8v/7dVeU2BGyx8SByn2eF5bt1soNe
         2Dl1+Z8wcow3XeBQBg68jxcydBMol89kOILH6Jmh3EfdUN7UaBwcuRDiERNcQlrsIhXZ
         hQjxDuEMNcbQSLbJyCYnug3nXwMR7vbBbUbANsLTi6EWBRKxEOK9JrGwm/F5GRW94Nz9
         QnM6srov0/IpywqeUFEQBNF8UcVITiRHB8fb3jB0EJV34XE5kfAlMmf7U7GPES68T3e4
         8+IUjCRcfa0azyJJAyu8y18tWuAD3RYkO0a84h9Ad8CC3RQUaWM0dPmP7YqXpWaR+BYK
         cxhQ==
X-Received: by 10.202.202.14 with SMTP id a14mr5377606oig.73.1442630964601;
        Fri, 18 Sep 2015 19:49:24 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:5c26:d82f:7660:27f? ([2001:470:d:73f:5c26:d82f:7660:27f])
        by smtp.googlemail.com with ESMTPSA id c185sm5750085oif.17.2015.09.18.19.49.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2015 19:49:23 -0700 (PDT)
Subject: Re: [PATCH v2] LED/MIPS: Move SEAD3 LED driver to where it belongs.
To:     Paul Burton <paul.burton@imgtec.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>
References: <20150803150401.GD2843@linux-mips.org>
 <55FA7BA0.4080706@samsung.com> <20150918210549.GD16992@NP-P-BURTON>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Bryan Wu <cooloney@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-leds@vger.kernel.org, linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <55FCCD31.7020505@gmail.com>
Date:   Fri, 18 Sep 2015 19:49:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20150918210549.GD16992@NP-P-BURTON>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Le 09/18/15 14:05, Paul Burton a écrit :
> On Thu, Sep 17, 2015 at 10:36:48AM +0200, Jacek Anaszewski wrote:
>> Hi Ralf,
>>
>> This patch got stuck somewhere in my mailbox and just
>> recently showed up to my eyes again, so I applied it to v4.3-rc1, but when
>> tried to compile-test it, I got following errors:
>>
>> arch/mips/kernel/signal.c: In function 'sc_to_extcontext':
>> arch/mips/kernel/signal.c:143:12: error: 'struct ucontext' has no member
>> named 'uc_extcontext'
>>   return &uc->uc_extcontext;
>>             ^
> 
> <snip...>
> 
>> Compilation succeeds with v4.2-rc8.
>> Is it a known issue?
> 
> Hi Jacek,
> 
> The patches adding the MSA extended context added a MIPS-specific
> ucontext.h, where we were previously were using the generic one. Kbuild
> doesn't automatically remove the old generated header that includes the
> generic version, so could you try either cleaning your working tree or
> removing arch/mips/include/generated and trying again?

I stumbled on that problem as well before, do you think there is
anything that could be done to track down the dependency here and
re-generate arch/mips/include/generated/ucontext.h? This build error is
not that easy to correlate with changes in ucontext.h.

Thanks!
-- 
Florian
