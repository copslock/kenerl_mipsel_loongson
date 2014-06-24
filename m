Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 21:35:09 +0200 (CEST)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:64801 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842554AbaFXTfEn6poD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 21:35:04 +0200
Received: by mail-lb0-f170.google.com with SMTP id 10so1129601lbg.29
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 12:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=U0TeMLfMCAG5Wfz7VwlaRqfTmPQJGkMOJjsBNLSdlbs=;
        b=KmY5Qy4/+HqxfgykLBkSiIao7tkQmg1yiaVh2cctaWtBgG1zga53ZcMH3LgQDx8AkR
         40AYQjxIcKnVF60B4dYNmunY++aYr+L/yb/VIggOEDFzmkOflG4fdDmHJrrBvxcJlJQg
         mhuVde6IwbNBdqqE34i1FRb7GCo+0Kd6pF3c3/EOGgXT/TUzpf8Ss/66eC5kzhreT3fr
         HZ6DbOZmLcudgutwpTCiBGW5uQorzIlBkohMvCDl4sK5beSZkO+Fs72fZdPQ1Bh3JAOR
         Wd8YzIPdl9c4ELklywReqPFod8ldtJPF27HMUP3irmcxBYcgotffhi343TzFQHEbIc3z
         fJ7w==
X-Gm-Message-State: ALoCoQlTmj9hNgzYjhAlyMrc8fhQNKYHtA1ZFBlcJKHruefzjc59JvnSiNFINBYjVPxbNcMyQ1s7
X-Received: by 10.112.134.194 with SMTP id pm2mr2006834lbb.22.1403638496249;
 Tue, 24 Jun 2014 12:34:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Tue, 24 Jun 2014 12:34:36 -0700 (PDT)
In-Reply-To: <20140624193055.GA4482@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-5-git-send-email-keescook@chromium.org> <20140624191815.GA3623@redhat.com>
 <CALCETrVgpP=zOtiQafVgcic2T95TdEM5DTvHYXWTbcZ14xBqHQ@mail.gmail.com> <20140624193055.GA4482@redhat.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 24 Jun 2014 12:34:36 -0700
Message-ID: <CALCETrU9x05ADgz9JToiw_BuCPz1h0xmOh=1R3eojL9far1aEA@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] seccomp: move no_new_privs into seccomp
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40768
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

On Tue, Jun 24, 2014 at 12:30 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/24, Andy Lutomirski wrote:
>>
>> On Tue, Jun 24, 2014 at 12:18 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>> >>
>> >> -struct seccomp { };
>> >> +struct seccomp {
>> >> +     unsigned long flags;
>> >> +};
>> >
>> > A bit messy ;)
>> >
>> > I am wondering if we can simply do
>> >
>> >         static inline bool current_no_new_privs(void)
>> >         {
>> >                 if (current->no_new_privs)
>> >                         return true;
>> >
>> >         #ifdef CONFIG_SECCOMP
>> >                 if (test_thread_flag(TIF_SECCOMP))
>> >                         return true;
>> >         #endif
>>
>> Nope -- privileged users can enable seccomp w/o nnp.
>
> Indeed, I am stupid.
>
> Still it would be nice to cleanup this somehow. The new member is only
> used as a previous ->no_new_privs, just it is long to allow the concurent
> set/get. Logically it doesn't even belong to seccomp{}.

We could add an unsigned long atomic flags field to task_struct.

Grr.  Why isn't there an unsigned *int* atomic bitmask type?  Even u64
would be better.  unsigned long is useless.

>
> Oleg.
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
