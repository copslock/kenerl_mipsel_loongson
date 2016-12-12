Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2016 22:58:05 +0100 (CET)
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34275 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993040AbcLLV5wUBlQj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Dec 2016 22:57:52 +0100
Received: by mail-pg0-f66.google.com with SMTP id e9so2191601pgc.1
        for <linux-mips@linux-mips.org>; Mon, 12 Dec 2016 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Vsav0fBU1a0RxY2+kFyVoZUhFv1AihTqepRs3rYbQd0=;
        b=Y84WfQ4JJS8NeWxQksWUltLcLfls/QlhHN7E1hThIkHTZ0AajhtwqcE4Znf6NraEgR
         M4SwJAz2Dq5tzui0DFzkcscCA+yT3T9v6JpTQKkrhRmCJdQUE7SWLszM1U5OCBy9MD1F
         aPsioLJagKbl76FpqYoSEAKYhkThmxbyZnSwvqM1QJFjYBUirPQjX9/JXvA/zK8IX+PJ
         N/cvImjP9Ng2UC3ejBJoJsA9q3jGakYYuEa3CIQH2CHvrKAOGb/2OuzmRcykjQGBVImu
         MqZFHgZ2Ck6/Dt5/EeUP7REbrRVhj5ee/nhNN044+ll+BU9V8ZfvwGEMKrhT3kESAZkb
         K9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Vsav0fBU1a0RxY2+kFyVoZUhFv1AihTqepRs3rYbQd0=;
        b=ialZQY9ftPtedG309d1ZDOUFPlqVqSvLeRNGTuKFxpI1nk46QIo8/vr6T/G6yPk+0P
         vk/h7808uhq5ZzSEGT0QpDaYHayAel0WViHbm7EjPNZM9kVi8PA5ppOpIhpJccK1/EBZ
         5RUnsO+zmTc2PHUzf155NXdNlJxrkiZcUSIyMfOYA6RNBIRYIENx31EZOgvQDlmIsqZC
         szgrcnCr8FqPhpLzLQQGqivjPt2VVBO5H9dzxaA0pZJhbJQ1fue8rqLtUfnsZoy0bbve
         QY6evbKJzAyYAa1XRlx25WKTTMiiFVMNty3E+EiCAhICz3YrCz9PReq6ueAmuo+aMykm
         DhHg==
X-Gm-Message-State: AKaTC03atDZCVgwzvetzS1GkTu1ymj28rUKSos+UC1rXwkrcukMh7RNf59u8nOY8K+vPfg==
X-Received: by 10.84.218.76 with SMTP id f12mr41468352plm.141.1481579866393;
        Mon, 12 Dec 2016 13:57:46 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id s65sm78165910pgb.25.2016.12.12.13.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 13:57:45 -0800 (PST)
Subject: Re: [RFC] MIPS: Add cacheinfo support
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Justin Chen <justinpopo6@gmail.com>
References: <20161208011626.20885-1-justinpopo6@gmail.com>
 <5849EC43.2070802@imgtec.com>
 <CAJx26kW0e-HC0VUTObZ5Or+XjFvE9KmtOToKbFvKYvhE--Vw5A@mail.gmail.com>
 <584A0281.3040505@imgtec.com>
 <3004fca6-3688-65bb-7c86-248603482088@gmail.com>
 <584F0C71.5010004@imgtec.com>
Cc:     linux-mips@linux-mips.org, bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justin.chen@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6981ff1e-685e-2df7-4b6e-c67c3aa735e7@gmail.com>
Date:   Mon, 12 Dec 2016 13:57:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <584F0C71.5010004@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56016
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

On 12/12/2016 12:45 PM, Leonid Yegoshin wrote:
> On 12/12/2016 10:24 AM, Florian Fainelli wrote:
>>
>> What Justin's patch is about is not so much about providing hints to
>> user-space to bypass the kernel's own management of caches, (even though
>> that has been used as an argument by the original introduction of
>> cacheinfo), but more to provide some information to user-space about the
>> cache topology and hierarchy.
> 
> I missed that, if it is for information purpose only, then it is OK.
> 
>>
>> Even though this is limited information this is still helpful to
>> applications like lshw and others out there.
>>
>> What would be needed from your perspective to get cacheinfo added to
>> MIPS, shall we go back and address your initial comment about all the
>> little details about coherency, snooping and re-filling strategy?
> 
> It depends. Initially, I thought Justin wants to replace
> arch/mips/mm/c-XXX.c with some universal approach and listed the missed
> stuff for that (I actually missed some more points in that list).
> 
> But for information purpose I don't have any more addition to Justin's
> patch... may be the coherency status, it has impact on performance:
> coherency of L1D->L2, L2->memory and L1I->L1D/L2.

OK, how would you want that to be represented? Should we try to "link"
with the leaf we are coherent with? For instance, if the L1D cache is
coherent with the L2, we have something like this:

# Assuming this is L1D cache:
/sys/devices/system/cpu/cpu0/cache/index0
ls -1
coherency_line_size
level
number_of_sets
physical_line_partition
power/
shared_cpu_list
shared_cpu_map
size
type
uevent
ways_of_associativity

We add a new symbolic link, e.g:

coherent_with -> ../index1

that indicates that this cache is coherent with the cache pointed at by
directory index1.

Thanks!
-- 
Florian
