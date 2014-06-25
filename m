Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 16:44:32 +0200 (CEST)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:62915 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816417AbaFYOoWSA2g0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 16:44:22 +0200
Received: by mail-oa0-f53.google.com with SMTP id l6so2252134oag.12
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=d43c9ia4W4ibB4JXNGaNqBdNylfjX3ysbsOgdxFdABQ=;
        b=pSR8s9nSTMeCY9F0OMYJdEYif0/yXCCV5+NiA/h0yR8/ZJKUtIWldrS+1P5tL5Uxul
         TqSdu6PyLebwqai41geFrbx6s7SyWtIb03SrCNLsNPb/4SD/yIj/R13Fl4rDANHFbgdJ
         NeKAA8R+ZWzfW/agrJ/ciQSkegpmDNwx+hlk6cYEw55ZNmhEWIGpe4HOekmA+a/YJ3Wt
         LY4Joh3g1aYtlFsnZs/V3vHy31iiYIGqi5bQITVtokBnnsoDDXU/e95pfy59fj6aIklc
         3vPmUigJY/K06oy76LWF956od0EW1mio5qDOL6+zzhttDlG5FBM22ZSGF8rzWUqMa86R
         q5Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=d43c9ia4W4ibB4JXNGaNqBdNylfjX3ysbsOgdxFdABQ=;
        b=fMzddH57Z/xmEibz7xXs7FF6S6wSVYYC7fcXbomx9TZ+MKKNQLVr/N8N+g8c4XIPrN
         D4NQimXx0KwHMMY1AgFJ9gqtG7jXHZb2HwirLxFB+dqB7GLT7Rgt+djhKJtseC7FqJs4
         Mi0hg9PyQeW4HEDRwyyIuBlKCVLscpQkfKBWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=d43c9ia4W4ibB4JXNGaNqBdNylfjX3ysbsOgdxFdABQ=;
        b=QBFgPA6/y1GOoY0DxwVaZtQkjEtXocmgkznH+tBG5BRQePYc/6hspIKetVzc4QPun5
         Uj2Tl+l0Z6SocRVeZSONSwSvn3f/qi9PIvZpryHbvInBn3Hnt18p9Szu7KEnkQ1itRkl
         b+90o6yeUa3q8RGXxxhyn5RTbTYQ+qRa7nlepltK4fDO+zd6fpw2FRd4XVGYBnb15e2j
         bzsCtagM2rZ9WWguq55t8jP9d3WcJm9tLYCwnwvh+WzcZwzHunr3eu7wcjWfOpFilorv
         K4Fm5BaXL+3B5L4BA6IC68CD0SssQgDOFBHdN3MNZVVD2vNNRF506ofba8WGnMOYVqa5
         MGPg==
X-Gm-Message-State: ALoCoQl4AIGvKKduaxByFfvy6E9Ixwm8P3DwRNtuyqVRA5m3rFw1LR7DhhBuQAoHT3q5T7yLTgMc
MIME-Version: 1.0
X-Received: by 10.60.143.37 with SMTP id sb5mr8481969oeb.38.1403707455342;
 Wed, 25 Jun 2014 07:44:15 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 25 Jun 2014 07:44:15 -0700 (PDT)
In-Reply-To: <20140625134354.GA7892@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <1403642893-23107-5-git-send-email-keescook@chromium.org>
        <20140625134354.GA7892@redhat.com>
Date:   Wed, 25 Jun 2014 07:44:15 -0700
X-Google-Sender-Auth: 0nCLCSOhkNigsvazxcb0T8pkDus
Message-ID: <CAGXu5j+yutPBpEq3qiVwAMT6q0y36bwM2ksBvj-=6AqkWAgaGQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] sched: move no_new_privs into new atomic flags
From:   Kees Cook <keescook@chromium.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Wed, Jun 25, 2014 at 6:43 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/24, Kees Cook wrote:
>>
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1307,8 +1307,7 @@ struct task_struct {
>>                                * execve */
>>       unsigned in_iowait:1;
>>
>> -     /* task may not gain privileges */
>> -     unsigned no_new_privs:1;
>> +     unsigned long atomic_flags; /* Flags needing atomic access. */
>>
>>       /* Revert to default priority/policy when forking */
>>       unsigned sched_reset_on_fork:1;
>
> Agreed, personally I like it more than seccomp->flags.
>
> But probably it would be better to place the new member before/after
> other bitfields to save the space?

Sure, I'll move it down. (Though I thought the compiler was smarter about that.)

-Kees

-- 
Kees Cook
Chrome OS Security
