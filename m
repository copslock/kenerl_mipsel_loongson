Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 19:55:48 +0200 (CEST)
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52273 "EHLO
        mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859957AbaGKRzn2p6je (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 19:55:43 +0200
Received: by mail-oa0-f46.google.com with SMTP id m1so1595850oag.33
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GhXWItfPQY4SY+4f8DHYKWPFFZWAdkDKupYHz2Rs/1Q=;
        b=arfMxo6rh13eElgbRZmCRPoSv/9euEVbIXS8oz+Cj0Ujmj0gTW2QR+EjIxK/RlGy+d
         Hf8W3zfQ8tUbFcgyKkasL+OQFL3w5bptCmYoQEWZqPGMiS9SjL5YyUnsu382XdW5ewLx
         btNg/SKhJOhtvm3n3qf76kdyw1wuHEYS+lk5wISPkDfV/ZTsM+VpA+y7NhIRPPxR2/Yz
         PF1uykiX+9bLUUY3Khqvc92ASj5KCSxUcJPJ9CNUgqZlOW7PRZANvh8UniQZAu0JtO+H
         djVeXcTwM8vihSkqPEOwcYIERdHQ09EuEdz3y6dP06pQZuctaCQQXSHZOOnVbUkWcJnw
         uEUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GhXWItfPQY4SY+4f8DHYKWPFFZWAdkDKupYHz2Rs/1Q=;
        b=Dl5lGrOiDHNgmwtsWdNo+8jEzF1ULHAMX5bDxbPIWigl+tC1oN+MfaaUMXI0qHHk7R
         disrIzQzRml1AWsE21wrWCtmhg+wQLb64KwM6Bkwzs23DnVbaz7wwaBBabhkEaun0P9A
         Z+H8LVQLoEyWMo50CEwiUmPh0FSGSvh8HfzaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GhXWItfPQY4SY+4f8DHYKWPFFZWAdkDKupYHz2Rs/1Q=;
        b=jOjwmL3YacSTnZG5dBTOQoA+YalHtytuWkaFBAqnBSSroT4jPtyBgW/bhvx9elfYIs
         JPmlOHt4YHkPKexZ45Votkkk7i2u6w9kNOpQMVWPqTqt4Zs8uzRn51JZ5jMCzl8VEQXs
         xVGsMuOgyUTuKdjF51pgKrkZUE2S0LxNKzf3GHctt/P5EveyplaVX5JRtVO5tmYHjt4j
         OQqGiRoHY6gmQ2Cq0TXkJqw22Aa+FSUToJoUSTubAjhcttENKoar+o9Qz+lOyquw75hC
         klNPAs+V6FxKU8xLzgIOrDpZfJnqDmi48XYw1913j8ejFHN4WU4PBIxM07uAfVMyFRjI
         12gQ==
X-Gm-Message-State: ALoCoQn5RgWU0Wp+e4ruCc7j899vA904WlrqjoBOZ1Di/dZJqG3oY9WGj4HJgb5lE4lsBuhYX/2b
MIME-Version: 1.0
X-Received: by 10.60.80.229 with SMTP id u5mr596067oex.62.1405101333392; Fri,
 11 Jul 2014 10:55:33 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Fri, 11 Jul 2014 10:55:33 -0700 (PDT)
In-Reply-To: <20140711164931.GA18473@redhat.com>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
        <20140711164931.GA18473@redhat.com>
Date:   Fri, 11 Jul 2014 10:55:33 -0700
X-Google-Sender-Auth: SJfBkqeY5Uc35Qre_3PWDuD0oM4
Message-ID: <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
Subject: Re: [PATCH v10 0/11] seccomp: add thread sync ability
From:   Kees Cook <keescook@chromium.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
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
X-archive-position: 41151
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

On Fri, Jul 11, 2014 at 9:49 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 07/10, Kees Cook wrote:
>>
>> This adds the ability for threads to request seccomp filter
>> synchronization across their thread group (at filter attach time).
>> For example, for Chrome to make sure graphic driver threads are fully
>> confined after seccomp filters have been attached.
>>
>> To support this, locking on seccomp changes via thread-group-shared
>> sighand lock is introduced, along with refactoring of no_new_privs. Races
>> with thread creation are handled via delayed duplication of the seccomp
>> task struct field and cred_guard_mutex.
>>
>> This includes a new syscall (instead of adding a new prctl option),
>> as suggested by Andy Lutomirski and Michael Kerrisk.
>
> I do not not see any problems in this version,

Awesome! Thank you for all the reviews. :) If Andy and Michael are
happy with this too, I think this is in good shape. \o/

-Kees

>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>



-- 
Kees Cook
Chrome OS Security
