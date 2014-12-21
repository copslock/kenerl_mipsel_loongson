Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2014 18:02:59 +0100 (CET)
Received: from mail-qc0-f173.google.com ([209.85.216.173]:47256 "EHLO
        mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009413AbaLURC5sVH6n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Dec 2014 18:02:57 +0100
Received: by mail-qc0-f173.google.com with SMTP id i17so2564066qcy.4;
        Sun, 21 Dec 2014 09:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=54lrAt1VuFMkhFdVvTyDjxcdAIX8Tt11FbHk6MDvYEA=;
        b=ykNmcL5PO1d69bfkXInX7a83+Fu4YcbFlO3+ujHkSOVdoKT1CxSj14DBZeRI4x/WMq
         +YLiz/rKeLozRGhAyOYTbNA5LQh0pMqkDt/BFyLOUSuXrEKPrh8Z27Sk6yBQbiSbJU94
         aZFVlaAyn/YdilvS/qlnAE5PrOnPonjwzhw9F+mCpq3TWZLIrJeWQO8gWNvIW+BUN5nP
         ZityoEH5k8AwmudjB2x332AxdV6q9oiQNkaed2HHWzGc5RmYrYh/oTQzTX6ssoProDc+
         DdGpjftkAPEYEkQ24gYce9EWR8ZPeVC4pwwJnIqkkaDMWktltGSg1c8hMKG5j0Qoh2nA
         DqlA==
X-Received: by 10.140.84.70 with SMTP id k64mr28566464qgd.76.1419181371988;
 Sun, 21 Dec 2014 09:02:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.82.48 with HTTP; Sun, 21 Dec 2014 09:02:31 -0800 (PST)
In-Reply-To: <CAGVrzcYaKF2M_pZTvB6kGM2czrTQq2KhV1BTKb0VkQivjMsNxg@mail.gmail.com>
References: <1418985621-4210-1-git-send-email-jaedon.shin@gmail.com> <CAGVrzcYaKF2M_pZTvB6kGM2czrTQq2KhV1BTKb0VkQivjMsNxg@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Sun, 21 Dec 2014 09:02:31 -0800
Message-ID: <CAJiQ=7AHKaFPe+UXSKphSrsQ6J9Fagaou6FZRE+deigeqwHjxw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BMIPS: fix overwriting without setting the bit
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Sun, Dec 21, 2014 at 2:41 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 2014-12-19 2:40 GMT-08:00 Jaedon Shin <jaedon.shin@gmail.com>:
>> To flush to readahead cache, set 8th bit in the RAC_CONFIG.
>>
>> The previous commit "MIPS: BMIPS: Flush the readahead cache after DMA"
>> has a problem overwriting to the original other configuration values.
>
> Right, after the the first write we would basically disable the RAC entirely.
>
>>
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

This looks fine to me, but I am not sure if any of Ralf's trees
actually contain my buggy commit yet.  Which branch did you use as a
baseline?

Anyway:

Acked-by: Kevin Cernekee <cernekee@gmail.com>
