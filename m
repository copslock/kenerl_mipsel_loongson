Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 20:45:33 +0200 (CEST)
Received: from mail-ob0-f175.google.com ([209.85.214.175]:43339 "EHLO
        mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860046AbaF0Sp3k4FDx convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jun 2014 20:45:29 +0200
Received: by mail-ob0-f175.google.com with SMTP id wm4so6070270obc.6
        for <linux-mips@linux-mips.org>; Fri, 27 Jun 2014 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=3P09+TtHyb9MDetCx+TCyh3w/w1Wo9MkGlneGr0Rzbc=;
        b=MQ+5sCqpBzDibZQVV5W3wH/b8i61B/Zib7oaGwTJyJ5ynhfnp9m9A3zx4di58eR/sA
         d+c+pLIetpFC0p/Fzi3mUqeSEzzbGFd5ZVyvt+4uxzDEgKvECWNDREAtbT3xg+ciT8Pz
         kvkQol5ZBG2djOIvFasoqsAPXaPBO+X5DZT3fhUxTfjG831sghHOLg/DjBstpNa+bqtI
         LwN6gQjM//BoCE40Xm3+m3l2VWtdtfpZyuBBQ6NrVNlXSB1aKUw5QZ1kjdLCfWT0aoNS
         6fXMc6KSuo9/GskxSdtY8teSuS8BJb5wJOqChFxl6PIQ0Gua49dumQVzLKzhE96JtJPv
         pgRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=3P09+TtHyb9MDetCx+TCyh3w/w1Wo9MkGlneGr0Rzbc=;
        b=KHUZvUi9r6cqUJwLkgnq1lrzEjZFAX7XrbazADixvZGY+ODPeqKFEEIcyOuHXL6aD+
         0gbi+CgkHp1GgDyHfo0EZtnrUWVB7dvPBzgqln3vKhjZFhcB7OaaiIy4lVG1YK220nOS
         TYJulU+JpV46YVrGw3a57twl3BYOLMhtOZEIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3P09+TtHyb9MDetCx+TCyh3w/w1Wo9MkGlneGr0Rzbc=;
        b=KkDANReYrt5dkFAJr9tpAJDkuZZw0x1jYI3EK0vXFdpiTIy5WUIE/CLaK2Rfzay3iZ
         UaP/nrV03u+hpSX8PHVqmQkdRoOem8s5G1ndIHFQQnMnJ0UfoaMHILZT7sFa0k67uJ0c
         VMQwLGvSJ19S5DYdNrUDKX/v7ffkuJvfh90dq20sqZ2UTVmXiDwgY2FU9NEWMn1NqV6I
         R3BcPyFm5Uyi9oHmFSwGjIQJ2BBhp0nEqghGZ/k162J+rinPBD11e2Z4lmSB078a0z03
         aX6Ee+C1qlcjIUXj46jIBMvFxa4uN1+RDuCnbfGHwp/5rT0bOPIAtXnIxXLkNCBfOUA1
         jm2w==
X-Gm-Message-State: ALoCoQm4TN5D1uqpFSEYC+avkrWdi8d8mu5QNqwZiqpj4AgsVMT4Ua1uRlT6duc/Y1fRFGhiNTp7
MIME-Version: 1.0
X-Received: by 10.60.120.98 with SMTP id lb2mr25210918oeb.52.1403894723360;
 Fri, 27 Jun 2014 11:45:23 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Fri, 27 Jun 2014 11:45:23 -0700 (PDT)
In-Reply-To: <20140626123710.GA16204@google.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
        <1403560693-21809-3-git-send-email-keescook@chromium.org>
        <20140626123710.GA16204@google.com>
Date:   Fri, 27 Jun 2014 11:45:23 -0700
X-Google-Sender-Auth: 7zWe2MZOonWy0O3lzzu2P7_-VEQ
Message-ID: <CAGXu5j+CxPPj2m+mgAR99O9PmDF0Pg4vKEXqN6SOdawQ7X_q8g@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] seccomp: split filter prep from check and apply
From:   Kees Cook <keescook@chromium.org>
To:     David Drysdale <drysdale@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40872
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

On Thu, Jun 26, 2014 at 5:37 AM, David Drysdale <drysdale@google.com> wrote:
> On Mon, Jun 23, 2014 at 02:58:06PM -0700, Kees Cook wrote:
>> In preparation for adding seccomp locking, move filter creation away
>> from where it is checked and applied. This will allow for locking where
>> no memory allocation is happening. The validation, filter attachment,
>> and seccomp mode setting can all happen under the future locks.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  kernel/seccomp.c |   97 +++++++++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 67 insertions(+), 30 deletions(-)
>>
>> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> index afb916c7e890..edc8c79ed16d 100644
>> --- a/kernel/seccomp.c
>> +++ b/kernel/seccomp.c
>> @@ -515,6 +551,7 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
>>       current->seccomp.mode = seccomp_mode;
>>       set_thread_flag(TIF_SECCOMP);
>>  out:
>> +     seccomp_filter_free(prepared);
>>       return ret;
>>  }
>
> I think this needs to be inside #ifdef CONFIG_SECCOMP_FILTER to match
> the definition of seccomp_filter_free:
>
> ../kernel/seccomp.c:554:2: error: implicit declaration of function ‘seccomp_filter_free’ [-Werror=implicit-function-declaration]

Thanks for catching that! I've ended up rearranging the patch series
so the prepare/attach split happens after I've split the set_mode
functions now, so I've managed to avoid this condition now. :)

-Kees

-- 
Kees Cook
Chrome OS Security
