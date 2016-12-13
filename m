Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 21:06:17 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33565 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993078AbcLMUGI5iBXD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Dec 2016 21:06:08 +0100
Received: by mail-pf0-f196.google.com with SMTP id 144so6436780pfv.0
        for <linux-mips@linux-mips.org>; Tue, 13 Dec 2016 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=PQ49PIPshedGGTbZXMMVfVrjmDj2g4AfqWM71TXCwjE=;
        b=AQ5IdnNNqQfTzpSFYww5JY6FBcctXjm84haE/206xJq9ZHF3vXpSB2TUr9+mWaKz2y
         evw4rGANr6jCqXNUemdkaZvrKJEQESVF5DgjJBwSwtYOE4QyZnxDfZf+VK5qgxyehXLV
         nqKeoEpU4E4EhfG83ZT+MEfTq0skz0dcowGspgQwdLmXII7C4iuo/zK11Po+WoKNHYPJ
         OP3AaQgWffdg5/iRB8J+DsCYXl2LQl3+S2BVfaTdYTSqjEFuvQoqe2M590VufL6Nav5e
         R+h8iblDuw2HQaSHSTB1WD/mwRVbgmtBu7AFIxefe2aG+ZdY99noGqFo4/0dgHRAkJQB
         Btrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=PQ49PIPshedGGTbZXMMVfVrjmDj2g4AfqWM71TXCwjE=;
        b=BiM6CKPtXfS5Xkc/Ctw2y7luAx+F9t9CBA/jR82w5/M0jNjwtIv23HIiUDkDR9O9wL
         lK8E+kl663qZ4qa4cr2YVV5Ff5f7q9XydgMOtof7+ze0rp14coDv0ncis6UlOV4ogTmD
         PUbtgDJySbasQq2ywnRVTnYLowPGowlEcMrWz7mWajZ7g/biMhnXBKUgW4ffW4E+gy3m
         /eUaOVFrmmLtscUH+minp2smRSheptme0gCQUMrgQJxvzYWVuiV93gHLGtftqJYi2XgA
         MHS/PhjOtp3qBOmQS4SlK0k9RlEYKFM8G6IFVRIu8hsNbXYVe/K73IamAgd8gLV7r4Zr
         ImNw==
X-Gm-Message-State: AKaTC02ozvIeqcSXfnxutxJi8X9LqByR8WY8oAWT+VqFBcRIaMLqiAeQmsf6huOSg3saMg==
X-Received: by 10.99.222.85 with SMTP id y21mr179632458pgi.119.1481659562809;
        Tue, 13 Dec 2016 12:06:02 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id c71sm82325141pga.22.2016.12.13.12.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2016 12:06:02 -0800 (PST)
Subject: Re: [RFC] MIPS: Add cacheinfo support
To:     Justin Chen <justinpopo6@gmail.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
References: <20161208011626.20885-1-justinpopo6@gmail.com>
 <5849EC43.2070802@imgtec.com>
 <CAJx26kW0e-HC0VUTObZ5Or+XjFvE9KmtOToKbFvKYvhE--Vw5A@mail.gmail.com>
 <584A0281.3040505@imgtec.com>
 <3004fca6-3688-65bb-7c86-248603482088@gmail.com>
 <584F0C71.5010004@imgtec.com>
 <6981ff1e-685e-2df7-4b6e-c67c3aa735e7@gmail.com>
 <584F3E9D.9030501@imgtec.com>
 <alpine.DEB.2.00.1612131101200.6743@tp.orcam.me.uk>
 <58504983.2050608@imgtec.com>
 <CAJx26kWV70vKE-2A_zStOF=L2=xVpuX-eNnHtnM=XWyKurfvBg@mail.gmail.com>
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justin.chen@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <31824f14-e8b0-2f14-2ade-1c30e6e3cce5@gmail.com>
Date:   Tue, 13 Dec 2016 12:05:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAJx26kWV70vKE-2A_zStOF=L2=xVpuX-eNnHtnM=XWyKurfvBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56037
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

On 12/13/2016 12:01 PM, Justin Chen wrote:
> On Tue, Dec 13, 2016 at 11:18 AM, Leonid Yegoshin
> <Leonid.Yegoshin@imgtec.com> wrote:
>> On 12/13/2016 03:09 AM, Maciej W. Rozycki wrote:
>>>
>>> On Tue, 13 Dec 2016, Leonid Yegoshin wrote:
>>>
>>>> Well, I prefer the collection of 3 flags:
>>>>
>>>> flush_required        - or flush to next level is required to force
>>>> coherency
>>>> between this level and next after update of this level
>>>> invalidate_required   - or invalidate is required to force coherency
>>>> between
>>>> this level and next after update of next level
>>>> coherent_to_level     - object is coherent with this level (only one
>>>> domain of
>>>> coherency on this level is assumed)
>>>
>>>   A "flush" has always been an ambiguous term -- meaning anything from
>>> "write-back", through "write-back+invalidate" to "invalidate".  What is
>>> "flush" is supposed to exactly mean here?  If specifically any of the two
>>> formers (the latter is obviously the other flag), then I suggest using the
>>> respective name, or otherwise if it is meant to be generic "do what is
>>> needed", then perhaps "synchronize" will work, like with the name of the
>>> SYNCI instruction?
>>>
>> Well, I am not expert in choosing names, you know. I just would like to make
>> a distinguishing between "transfer data from this level to next one" - any
>> way - writeback or write-back-invalidate, and "clear data in this level to
>> be pulled on demand from next level".
>>
>> This is an information purpose as Florian described, so details can be
>> skipped. The only useful info here - some efforts are needed after event
>> (see above) and that efforts are not cheap from performance point of view.
>>
>> If we put here details then it is a long way because we need a lot of
>> details, see my original post. However, I would like to differ "flush" and
>> "invalidate" because it is triggered by different kind of event (from
>> upstream or from downstream).
>>
>> - Leonid.
> I can add in the flags mentioned by Leonid. However, I would suggest
> these flags be added in as a separate patch series as it will require
> modifications to the cacheinfo code to propagate the information to
> the sysfs.
> 
> Would it be ok to accept this patch series as is while I work with the
> cacheinfo maintainers to include these new flags?

Seems entirely reasonable to me. You may want to make a new patch
submission without "RFC", just to make it clear that this is a patch
ready for review/acceptance.

Thanks!
-- 
Florian
