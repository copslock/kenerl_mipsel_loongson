Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 22:44:46 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38597 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012326AbbD3UopIq0nS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2015 22:44:45 +0200
Received: by wiun10 with SMTP id n10so31244255wiu.1
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 13:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Yndjp3xZ0FVnhfRXg1oTYDqJJforrOqiOM+HwhRelr0=;
        b=IEzHThCQ7r6mkB16YGUnu4S2F18qd51kzi1BxRFnFazu8Gswk+tr+hshk+Mu73PXGl
         iVvnM04+fJvquDW/gLnxxvngwLqsG3zKnD5HCN+Csc28JC0jTO7AY8gO9zafrENfXTWV
         bZNg2fxjoipemc/zhdwVuRzhNaQ3ksMvqSJ9L7SBoTcW7UkAXF1HffPiwVeGix8d3ilC
         8hhxDo6OfIaVBJk/tefvXfZ7S6/tUiMPrEJOE4laWkkg95aypqD/qQ2VFLzF8EB1OL0j
         jY1nkaECatX4TudpzCP14qpjVo3iReUqNZ+RCmTuwsC1dBQ7hXhh8cRaF1n4+CvgRxEw
         KwPA==
X-Gm-Message-State: ALoCoQn1PL7zCKPj9TJwHuVfePwIqqxRl9UrkmEi9pmke+/IBNIZ3LTnqNWmEV7lZpzXvGWFUNec
X-Received: by 10.194.161.193 with SMTP id xu1mr11834488wjb.48.1430426681690;
        Thu, 30 Apr 2015 13:44:41 -0700 (PDT)
Received: from [192.168.0.45] ([190.2.108.156])
        by mx.google.com with ESMTPSA id n1sm4000345wix.0.2015.04.30.13.44.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 13:44:40 -0700 (PDT)
Message-ID: <5542937F.1050909@vanguardiasur.com.ar>
Date:   Thu, 30 Apr 2015 17:41:35 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Organization: VanguardiaSur
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Alban <albeu@free.fr>
CC:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] MIPS: ath79: Add OF support and DTS for TL-WR1043ND
References: <1429875679-14973-1-git-send-email-albeu@free.fr>   <553E3CC8.3070304@vanguardiasur.com.ar> <20150430010728.0331a736@tock>
In-Reply-To: <20150430010728.0331a736@tock>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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



On 04/29/2015 08:07 PM, Alban wrote:
> On Mon, 27 Apr 2015 10:42:32 -0300
> Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> 
>> On 04/24/2015 08:41 AM, Alban Bedel wrote:
>>> This series add OF bindings and code support for the interrupt
>>> controllers, clocks and GPIOs. However it was only tested on a
>>> TL-WR1043ND with an AR9132, others SoCs are untested, and a few are
>>> not supported at all.
>>>
>  
>> Hi Alban,
> 
> Hi,
> 
>> I've booted a Carambola2 using this (plus a custom devicetree and some
>> small changes):
>>
>> Tested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>>
>> Just a small comment/question: Shouldn't we allow to build all the
>> devicetree files, instead of just the one that will be built-in?
>>
>> I.e., something like this:
>>
>> dtb-$(CONFIG_MATCH_ATH79_DT)   += ar9132_tl_wr1043nd_v1.dtb
>> dtb-$(CONFIG_MACH_ATH79_DT)    += ar9331_carambola2.dtb
>>
>> It should be useful to catch errors, but also in general, as the
>> devicetree is supposed to be independent of the kernel and should be
>> built separate from it.
> 
> Yes, that would be better, I'll fix that.
> 
>> PS: This series depends on a previous patchset. It's usually useful to
>> mention this in the cover letter and make a poor tester's life
>> easier :)
> 
>>> Most code changes base on the previous bug fix series:
>>> [PATCH v2 0/5] MIPS: ath79: Various small fix to prepare OF support
> 
> Wasn't that clear enough?
> 

Ugh, somehow I managed to miss that.

Sorry for the noise,
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
