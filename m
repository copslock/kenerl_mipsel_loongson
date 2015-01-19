Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 10:16:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56596 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011771AbbASJQGZUc0X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 10:16:06 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0D9E0B6249063;
        Mon, 19 Jan 2015 09:15:58 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 19 Jan 2015 09:16:00 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 19 Jan
 2015 09:15:58 +0000
Message-ID: <54BCCB4E.5070005@imgtec.com>
Date:   Mon, 19 Jan 2015 09:15:58 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>
CC:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: 3.18+: soft-float userland unusable due to .MIPS.abiflags patch
References: <CAOLZvyFP6FX3ydFdU7fmDd7GCnBCAPyLnxkmyjYknXP8Wui0kg@mail.gmail.com> <CAOLZvyGBOqCARmLx+rQ1CEgFw2TZBYYauGOiD9tF31MFsB-peQ@mail.gmail.com> <6D39441BF12EF246A7ABCE6654B0235320FA97DF@LEMAIL01.le.imgtec.org> <CAOLZvyGUGr3ubbzNjoFLCEDk29Fbn4qjoT6xmT=F1OZ4L-YhMA@mail.gmail.com> <CAOLZvyE7nk4r+gcYTkdbfeDWh6c75RRhijuh-XY=AK98LF81LA@mail.gmail.com> <6D39441BF12EF246A7ABCE6654B0235320FA9A04@LEMAIL01.le.imgtec.org> <20150117163832.GA12420@fuloong-minipc.musicnaut.iki.fi> <6D39441BF12EF246A7ABCE6654B0235320FAA1B6@LEMAIL01.le.imgtec.org> <CAOLZvyEvXuTYhCgO6=XZCUv5_apqVaz44WswPesSSS3fvoALaw@mail.gmail.com> <20150119053647.GV28594@NP-P-BURTON>
In-Reply-To: <20150119053647.GV28594@NP-P-BURTON>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 01/19/2015 05:36 AM, Paul Burton wrote:
> On Sun, Jan 18, 2015 at 11:35:31AM +0100, Manuel Lauss wrote:
>> On Sat, Jan 17, 2015 at 8:00 PM, Matthew Fortune
>> <Matthew.Fortune@imgtec.com> wrote:
>>> Aaro Koskinen <aaro.koskinen@iki.fi> writes:
>>>> On Fri, Jan 16, 2015 at 08:36:12PM +0000, Matthew Fortune wrote:
>>>>> You are right that it is the .MIPS.abiflags patch that is causing your
>>>>> trouble. For a long time I had to put a restriction in the ABI plan
>>>>> that soft-float binaries without an ABIFLAGS pheader could not be
>>>>> linked against soft-float binaries with an ABIFLAGS pheader. We have
>>>>> since found a way to relax that restriction without reducing the
>>>>> effectiveness of the new compatibility checks. I would need to check
>>>>> the code in the kernel but I suspect that is the issue. Markos has
>>>>> done a significant update to this piece of code which he posted
>>>>> earlier today. That updated version should allow the combination of
>>>>> soft-float without ABIFLAGS and soft-float with ABIFLAGS.
>>>>
>>>> Are you referring to the series with 70 patches? I think a fix that
>>>> passes stable kernel rules is needed.
>>>
>>> Yes it was just one patch though for this issue:
>>> [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall ABI and FPU
>>> mode checks
>>>
>>> I wasn't trying to suggest how to fix the existing code just explaining
>>> how it came to be and what has been done about it for next release.
>>> (I'm not a kernel developer I'm just interested as I did most of the
>>> design work for the new ABI extensions.)
>>>
>>> I guess there are three options:
>>> a) revert the patch - That would remove the new ABI safety measures from
>>>    3.19 which is a shame given it has MSA support in it (I think anyway).
>>>    equally given that the new prctl FPU mode options did not make 3.19
>>>    then I suppose it doesn't lose too much either as the two features
>>>    go hand in hand to some extent.
>>
>> I favor this one.  I don't know how many systems with MSA are in the wild,
>> and if there are any, I'm sure they're using some mti/imgtec-supplied kernel
>> anyway.  Another thing I noticed last time is that companies shipping MIPS
>> products rarely upgrade their toolchains, so I'm sure the ABI safety measures
>> can wait for another release, but then function with all configurations
>> in the wild.
>>
>> Manuel
> 
> An alternative would be the patch I just submitted, which makes the mode
> checks conditional upon CONFIG_MIPS_O32_FP64_SUPPORT:
> 
>   http://marc.info/?l=linux-mips&m=142164553017027&w=2
> 
> Assuming this fixes your problem, and I believe it should, it would
> avoid the churn of reverting the patch & readding the modified logic
> again later.
> 
> Thanks,
>     Paul
> 
There is also this patch from James for 3.19 final

http://patchwork.linux-mips.org/patch/8932/

so with these two patches we should be good for 3.19.

-- 
markos
