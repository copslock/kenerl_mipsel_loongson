Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2014 20:15:38 +0200 (CEST)
Received: from mail-vc0-f182.google.com ([209.85.220.182]:63781 "EHLO
        mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862847AbaGURfBjvxgV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Jul 2014 19:35:01 +0200
Received: by mail-vc0-f182.google.com with SMTP id hy4so13102735vcb.27
        for <multiple recipients>; Mon, 21 Jul 2014 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GNal6CKaqfsYE+z/l+16F6rs49dle79FkwjxWoQQDo0=;
        b=nbtBDFyFai8po5+HZu7RZx82aZyI6prSHhlNBlByN+Y1A5EGCz9KVZOlYNwPXkSJ+j
         yDVuxSX54B+KZbpP0ze1+n/gznhUyNunW6kpWW4jJUWhS3e0W5ohqxFqV+ybuvRWkHeP
         oWT+eHfcwAX5TC24nByxhKchaY+lP6Al3ZX6oX/kay1C6/V9trY7ABjYKzaCTpEaXJlZ
         GNL8C5qGr/9qSwscdYD8L418IoI7PIViVKtNtdizRTAT+debszNnNByFD/2cz7A/KiuQ
         sEsI3rvUbUrNc5KeqxO5hG7oW9hKLpEOrpV8jPNoRuG764ZYv5meN4stVaIqfGVCdr1h
         qpuQ==
MIME-Version: 1.0
X-Received: by 10.220.174.137 with SMTP id t9mr31780312vcz.12.1405964095157;
 Mon, 21 Jul 2014 10:34:55 -0700 (PDT)
Received: by 10.221.53.5 with HTTP; Mon, 21 Jul 2014 10:34:55 -0700 (PDT)
In-Reply-To: <20140721081931.GC30558@pburton-laptop>
References: <1405746604-7737-1-git-send-email-xerofoify@gmail.com>
        <1405771556.18077.5.camel@x220>
        <CAPDOMVgQ-F9Y4AoNfFW-vN0YP10kwYL-GCwkpnXj+zg_UMJ4jw@mail.gmail.com>
        <20140721081931.GC30558@pburton-laptop>
Date:   Mon, 21 Jul 2014 13:34:55 -0400
Message-ID: <CAPDOMVgnonw5+ZB6GjRUSVex6_EdXC-ZL-L_YUCSaZ=M5UHQiw@mail.gmail.com>
Subject: Re: [PATCH] mips: Remove uneeded line in cmp_smp_finish
From:   Nick Krause <xerofoify@gmail.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Paul Bolle <pebolle@tiscali.nl>, ralf@linux-mips.org,
        Leonid.Yegoshin@imgtec.com, markos.chandras@imgtec.com,
        Steven.Hill@imgtec.com, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

On Mon, Jul 21, 2014 at 4:19 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> On Sat, Jul 19, 2014 at 05:33:16PM -0400, Nick Krause wrote:
>> On Sat, Jul 19, 2014 at 8:05 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
>> > On Sat, 2014-07-19 at 01:10 -0400, Nicholas Krause wrote:
>> >> This patch removes a unneeded line from this file as stated by the
>> >> fix me in this file.
>> >>
>> >> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>> >> ---
>> >>  arch/mips/kernel/smp-cmp.c | 2 --
>> >>  1 file changed, 2 deletions(-)
>> >>
>> >> diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
>> >> index fc8a515..61bfa20 100644
>> >> --- a/arch/mips/kernel/smp-cmp.c
>> >> +++ b/arch/mips/kernel/smp-cmp.c
>> >> @@ -60,8 +60,6 @@ static void cmp_smp_finish(void)
>> >>  {
>> >>       pr_debug("SMPCMP: CPU%d: %s\n", smp_processor_id(), __func__);
>> >>
>> >> -     /* CDFIXME: remove this? */
>> >> -     write_c0_compare(read_c0_count() + (8 * mips_hpt_frequency / HZ));
>> >
>> > That comment ends in a question mark. I wonder why...
>> >
>> >>  #ifdef CONFIG_MIPS_MT_FPAFF
>> >>       /* If we have an FPU, enroll ourselves in the FPU-full mask */
>> >
>> >
>> > Paul Bolle
>> >
>> If we need it then can I remove the FIx me comment.
>> Cheers Nick
>
> That depends: have you verified that we do need it?
>
> I wouldn't feel comfortable with removing either line without someone
> first explaining why it isn't necessary and testing the result on a
> number of different systems, with varying combinations of csrc-r4k &
> cevt-r4k.
>
> I absolutely agree that removing unnecessary code or outdated comments
> are both good things, but let's be sure they're unnecessary or outdated
> first. Your patch does not make me confident that you've checked either
> of those.
>
> Thanks,
>     Paul


I don't have this hardware , however if we can find people to test
this it would be great.
Cheers Nick
