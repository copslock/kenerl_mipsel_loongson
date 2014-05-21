Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 23:07:55 +0200 (CEST)
Received: from mail-vc0-f175.google.com ([209.85.220.175]:40882 "EHLO
        mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854846AbaEUVHvm3CuU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 23:07:51 +0200
Received: by mail-vc0-f175.google.com with SMTP id hu19so3257096vcb.6
        for <linux-mips@linux-mips.org>; Wed, 21 May 2014 14:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=gdsl8C2kGSwK75DokddKZHUdw+Y0Hrw6oKDDVtgE95o=;
        b=H2ucAXCLH3UNi9wacFygYShqp8o4533H1nOFRnDQUaW/8P4h6QFV6nh03B1sZyoWei
         zdwinZ8Fc80VKcAs0wVQIqzmdBXGzU8qhNUb9l25dorgjQ6JBqLtdsYM3abO12bt4Dbb
         CyYpyvsDY7egU+v4/gJ89ktA7HxSxpUMzQiulASXRG5c+nkj/T7Mhn2LaTfgRYjriFt+
         BXAgpOuetHRlK9xo1OpmtO4EHVDvSB0s7TnMKT/eSnenqxLczRga3Hox0b6tGVkvyMn2
         qXpx6QsK44UUxnHf4WTCz/VwYM1W/O+Wt1Au+7ouLyJZbw7LQFLJT/hGpyCRSWXl5Znr
         Gicw==
X-Gm-Message-State: ALoCoQkw2n5lv+jUD5IAPPiEW3+pLo36vp+6t9E50RRYQEUIRqbRzjg/l619gdBew79/eZrosldI
X-Received: by 10.58.201.5 with SMTP id jw5mr44042609vec.6.1400706465661; Wed,
 21 May 2014 14:07:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.58.246.39 with HTTP; Wed, 21 May 2014 14:07:24 -0700 (PDT)
In-Reply-To: <1683789.b73kOmCp2z@sifl>
References: <1397550996-14805-1-git-send-email-markos.chandras@imgtec.com>
 <1398177636-10442-1-git-send-email-markos.chandras@imgtec.com>
 <2398159.J868kTHAKn@sifl> <1683789.b73kOmCp2z@sifl>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 21 May 2014 14:07:24 -0700
Message-ID: <CALCETrW7qsVmTGSfw8rjpUAUjigK=Qyi8P2LSb_BOmwfRkc+xg@mail.gmail.com>
Subject: Re: [PATCH 3.15] MIPS: Add new AUDIT_ARCH token for the N32 ABI on MIPS64
To:     Paul Moore <pmoore@redhat.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Wed, May 21, 2014 at 1:59 PM, Paul Moore <pmoore@redhat.com> wrote:
> On Monday, May 12, 2014 02:53:05 PM Paul Moore wrote:
>> On Tuesday, April 22, 2014 03:40:36 PM Markos Chandras wrote:
>> > A MIPS64 kernel may support ELF files for all 3 MIPS ABIs
>> > (O32, N32, N64). Furthermore, the AUDIT_ARCH_MIPS{,EL}64 token
>> > does not provide enough information about the ABI for the 64-bit
>> > process. As a result of which, userland needs to use complex
>> > seccomp filters to decide whether a syscall belongs to the o32 or n32
>> > or n64 ABI. Therefore, a new arch token for MIPS64/n32 is added so it
>> > can be used by seccomp to explicitely set syscall filters for this ABI.
>> >
>> > Link: http://sourceforge.net/p/libseccomp/mailman/message/32239040/
>> > Cc: Andy Lutomirski <luto@amacapital.net>
>> > Cc: Eric Paris <eparis@redhat.com>
>> > Cc: Paul Moore <pmoore@redhat.com>
>> > Cc: Ralf Baechle <ralf@linux-mips.org>
>> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> > ---
>> > Ralf, can we please have this in 3.15 (Assuming it's ACK'd)?
>> >
>> > Thanks a lot!
>> > ---
>> >
>> >  arch/mips/include/asm/syscall.h |  2 ++
>> >  include/uapi/linux/audit.h      | 12 ++++++++++++
>> >  2 files changed, 14 insertions(+)
>>
>> [NOTE: Adding lkml to the To line to hopefully spur discussion/acceptance as
>> this *really* should be in 3.15]
>>
>> I'm re-replying to this patch and adding lkml to the To line because I
>> believe it is very important we get this patch into 3.15.  For those who
>> don't follow the MIPS architecture very closely, the upcoming 3.15 is the
>> first release to include support for seccomp filters, the latest generation
>> of syscall filtering which used a BPF based filter language.  For reason
>> that are easy to understand, the syscall filters are ABI specific (e.g.
>> syscall tables, word length, endianness) and those generating syscall
>> filters in userspace (e.g. libseccomp) need to take great care to ensure
>> that the generated filters take the ABI into account and fail safely in the
>> case where a different ABI is used (e.g. x86, x86_64, x32).
>>
>> The patch below corrects, what is IMHO, an omission in the original MIPS
>> seccomp filter patch, allowing userspace to easily separate MIPS and MIPS64.
>> Without this patch we will be forced to handle MIPS/MIPS64 like we handle
>> x86_64/x32 which is a royal pain and not something I want to have deal with
>> again.
>>
>> Further, while I don't want to speak for the audit folks, it is my
>> understanding that they want this patch for similar reasons.
>>
>> Please merge this patch for 3.15 or at least provide some feedback as to why
>> this isn't a viable solution for upstream.  Once 3.15 ships, fixing this
>> will require breaking the MIPS ABI which isn't something any of us want.
>>
>> Thanks,
>> -Paul
>
> *Bump*
>
> I don't know what else needs to be done to get some action on this and we're
> running out of time for 3.15.

Reply to Linus' next -rc email.

--Andy
