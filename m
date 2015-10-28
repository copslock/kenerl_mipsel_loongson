Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 19:57:55 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26752 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011420AbbJ1S5xvDhqj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2015 19:57:53 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 44C14DA2D7AFD;
        Wed, 28 Oct 2015 18:57:44 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Wed, 28 Oct
 2015 18:57:47 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 28 Oct
 2015 11:57:46 -0700
Message-ID: <56311AA9.6040101@imgtec.com>
Date:   Wed, 28 Oct 2015 11:57:45 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Alex Smith <alex@alex-smith.me.uk>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [v3, 3/3] MIPS: VDSO: Add implementations of gettimeofday() and
 clock_gettime()
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com>      <5629904A.2070400@imgtec.com>   <20151027144748.GA23785@linux-mips.org> <562FE29C.8040106@imgtec.com>   <562FE678.2030307@gmail.com>    <562FE96C.3070002@imgtec.com>   <562FF05A.508@gmail.com>        <562FF15A.1050507@imgtec.com>   <CAOFt0_AFnR0MF2e8rRXhz_wkiGbL2VTFy=AXpcmWTZ9_bYA=VQ@mail.gmail.com>    <56311231.10503@imgtec.com> <CAOFt0_C3QXKrZ-uta_RrR04hFMbQnNdfoJP7pZjoSSUftc7dCQ@mail.gmail.com>
In-Reply-To: <CAOFt0_C3QXKrZ-uta_RrR04hFMbQnNdfoJP7pZjoSSUftc7dCQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 10/28/2015 11:30 AM, Alex Smith wrote:
> On 28 October 2015 at 18:21, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> wrote:
>>
>>
>> 1) I don't see that in code - there is no check that kernel uses actually uses R4K clocksource as primary (A), and if kernel uses R4K count as a clocksource and later switches to some more precise clocksource then there is no change in VDSO gettimeofday handling (B).
> Incorrect. The vdso_clock_mode flag in arch_clocksource_data that I
> mentioned in my previous email is copied into the VDSO data page by
> update_vsyscall(), which is called when the clocksource changes.

OK, I see this, good.

>
>> 2) The fact that MIPS kernel as today uses CP0_COUNT in any core as the same clocksource is correct only until first power saving event with CPU clock disabled (skipping Octeon). After that it is an incorrect use without an accurate synchronization and that synchronization doesn't exist.
>>
>> And I remember that today kernel uses only CPU0 CP0_COUNT to update time... may be wrong, need to check, but that could be a good code.
>>
>>> Maybe I'm missing something but I don't see anything in the generic
>>> timekeeping code that handles the same clocksource being
>>> unsynchronised or running at a different rate on different CPUs.
>>
>> (I would like to skip here the generic timekeeping code capabilities, just to restrict a discussion to HW capabilities)
>>
>>> Given that, if you think there is an issue that prevents the VDSO from
>>> using it then that would surely affect the kernel as well and needs to
>>> be fixed separately?
>>>
>>> If it really is necessary to prevent the VDSO from using a certain
>>> clocksource even though the kernel is using it, it should be a simple
>>> matter of setting clocksource.archdata.vdso_clock_mode to
>>> VDSO_CLOCK_NONE. This is how this patch stops it using the CP0 count
>>> when RDHWR is broken.
>>
>> OK, just put kernel-build time check that it is not SMP without GIC clocksource or it is Octeon. It would be enough to stop a mess.
> If you feel it's necessary then please do.

Please resend a patch with this fix.

- Leonid.
