Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 21:01:29 +0100 (CET)
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35580 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992992AbcLMUBWdV2ID (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Dec 2016 21:01:22 +0100
Received: by mail-yb0-f193.google.com with SMTP id d59so2767942ybi.2
        for <linux-mips@linux-mips.org>; Tue, 13 Dec 2016 12:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5q2UpgRnSGA3KVdZEE1qWw6jciaRsEThRGZJ2QDEvIY=;
        b=oNoyLCSM9FofEsDhCkt83oj0DDqF58Sd3QiGVtf8nDM/n1M7NmIQyclDASiVR1kyhh
         KJidNlwWYQ7h3t0C4MTFV/FDODNcKsYm5UV58s6qXXuAXE9tW1um7lQ8xDyWzmtwYQ6O
         2By0yZB+v+JcDADvTPY3Ds94iQfjPxkGBMGlFr2zpvmdLY4PwcgtN96SOSaI9P1pXDrG
         QY4ekCvy97Qo/Zeg9j1rXE+i4a/YYGwJEBeg+46IbT0o0AiEPmTsVLzRcfJfDDxvSWhP
         DSv0zBbj/Yr7X9YqW+YunF8KtNYnaFqa7zl25KiidsvWO/TYuWSy/UtngIYAJHqaEk5g
         +Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5q2UpgRnSGA3KVdZEE1qWw6jciaRsEThRGZJ2QDEvIY=;
        b=FtoxqOZqePA11od06YxVJtj6uEBUwPa+0hHGIo53UVCLuRNQoYYA7TxPD9ppGi8u1Q
         uxaTmrv8qPUbILzHvB2Yiob4wStUHQ8h26+1iL0uFj2XAucKTLdBZrPc5ES0cMmsJ9sl
         Y6HY6+lLXa4rzaM8thF66zCfJ9S9HkSywY1ybzSsnus2C83vUHG96MERR/Ih8neb4JM0
         iBUIFMu8XvzTi/xsgge/EEkCXl88dvcQ13XYHAOrQxKPT3uXbxrHNB/QatjSV4ibofwF
         I6qx+V/BMh4OokuEqX1kZpDz9i6oOXyHzs+ToTJ4Svfr7lZ74Sd5WeC8lmFfJh8gTjs7
         voAA==
X-Gm-Message-State: AKaTC02IIt8Gs0o3TAuX21/1tflfY3zNh6xNo7jbuTwC6dWCr+orZ1FOhMGwD8Ao63eeP1eRV+9YDQqRz8RO5A==
X-Received: by 10.37.163.33 with SMTP id d30mr48706724ybi.54.1481659274007;
 Tue, 13 Dec 2016 12:01:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.55.141 with HTTP; Tue, 13 Dec 2016 12:01:13 -0800 (PST)
In-Reply-To: <58504983.2050608@imgtec.com>
References: <20161208011626.20885-1-justinpopo6@gmail.com> <5849EC43.2070802@imgtec.com>
 <CAJx26kW0e-HC0VUTObZ5Or+XjFvE9KmtOToKbFvKYvhE--Vw5A@mail.gmail.com>
 <584A0281.3040505@imgtec.com> <3004fca6-3688-65bb-7c86-248603482088@gmail.com>
 <584F0C71.5010004@imgtec.com> <6981ff1e-685e-2df7-4b6e-c67c3aa735e7@gmail.com>
 <584F3E9D.9030501@imgtec.com> <alpine.DEB.2.00.1612131101200.6743@tp.orcam.me.uk>
 <58504983.2050608@imgtec.com>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Tue, 13 Dec 2016 12:01:13 -0800
Message-ID: <CAJx26kWV70vKE-2A_zStOF=L2=xVpuX-eNnHtnM=XWyKurfvBg@mail.gmail.com>
Subject: Re: [RFC] MIPS: Add cacheinfo support
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <justinpopo6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinpopo6@gmail.com
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

On Tue, Dec 13, 2016 at 11:18 AM, Leonid Yegoshin
<Leonid.Yegoshin@imgtec.com> wrote:
> On 12/13/2016 03:09 AM, Maciej W. Rozycki wrote:
>>
>> On Tue, 13 Dec 2016, Leonid Yegoshin wrote:
>>
>>> Well, I prefer the collection of 3 flags:
>>>
>>> flush_required        - or flush to next level is required to force
>>> coherency
>>> between this level and next after update of this level
>>> invalidate_required   - or invalidate is required to force coherency
>>> between
>>> this level and next after update of next level
>>> coherent_to_level     - object is coherent with this level (only one
>>> domain of
>>> coherency on this level is assumed)
>>
>>   A "flush" has always been an ambiguous term -- meaning anything from
>> "write-back", through "write-back+invalidate" to "invalidate".  What is
>> "flush" is supposed to exactly mean here?  If specifically any of the two
>> formers (the latter is obviously the other flag), then I suggest using the
>> respective name, or otherwise if it is meant to be generic "do what is
>> needed", then perhaps "synchronize" will work, like with the name of the
>> SYNCI instruction?
>>
> Well, I am not expert in choosing names, you know. I just would like to make
> a distinguishing between "transfer data from this level to next one" - any
> way - writeback or write-back-invalidate, and "clear data in this level to
> be pulled on demand from next level".
>
> This is an information purpose as Florian described, so details can be
> skipped. The only useful info here - some efforts are needed after event
> (see above) and that efforts are not cheap from performance point of view.
>
> If we put here details then it is a long way because we need a lot of
> details, see my original post. However, I would like to differ "flush" and
> "invalidate" because it is triggered by different kind of event (from
> upstream or from downstream).
>
> - Leonid.
I can add in the flags mentioned by Leonid. However, I would suggest
these flags be added in as a separate patch series as it will require
modifications to the cacheinfo code to propagate the information to
the sysfs.

Would it be ok to accept this patch series as is while I work with the
cacheinfo maintainers to include these new flags?

-Justin
