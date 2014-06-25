Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 20:31:57 +0200 (CEST)
Received: from mail-oa0-f44.google.com ([209.85.219.44]:40761 "EHLO
        mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859933AbaFYSbzM0vS7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 20:31:55 +0200
Received: by mail-oa0-f44.google.com with SMTP id i7so2591956oag.3
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xxOyiLu8lA3jP6sdCx23/Je+Kh1wn2HoIsTfNI1NLuE=;
        b=oWxLaYGhVd6yUBOlg6Rj6T33WYlKOa4pCjHppBkBk4flILAAF6PIydD12UKBTveWiw
         +bMo4NKtqCz+n8/ApR29VvzflorZbMZnUv/O6cl8AWw+lnTLTdugThykKp5rZDjLiEgU
         QhmY96FsbqHd8gEexfYmlR7qNuuC8vBJZJ89QP6YFjt+qY475tvRrvZy4gtstMSYDMeZ
         l7npnadkydY0/f4EaiTwt/YlQTutAyVGzlcWfUIf2NJ5K9KDml8e9hTr5nzlKMe7BTnj
         gxkWZj89XlzSjCvomhlZkvymf6GAVKKBgoqlrbKGx+WMKrZfhKSwUBWk6J6N0cEZX/pj
         6X4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xxOyiLu8lA3jP6sdCx23/Je+Kh1wn2HoIsTfNI1NLuE=;
        b=IiJWHYoo/8f1FfcaTvONzDWzHYB5MucZyy+dIzpg78GqJKsN4utS/orpZ+mEB6w+js
         iwyq7an5hArKXlYgaeZMvemkYvsev2mgNJGZTJ2ISNEJqdnF+OAUPE/qK/aN6cgDJ+8n
         rGADkRKbrYmtVoaBHpxbAzL/sVOMcv3uV44Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xxOyiLu8lA3jP6sdCx23/Je+Kh1wn2HoIsTfNI1NLuE=;
        b=CGNEtrX/1M7tzI8Tlg+bt8bzjKnXZt3fAjTqml6UhOQos1jX0w4NPPcE9rE20bY2bz
         3PJAp7Ohyl22WpMOmgYqB+IyShfYQki2HReChMqnoZSVtIwhJq5GtmeTzXrCEtU5EM9A
         jL5EBYQkaA7aCxUawoi1720txFNQlu2sa/HupIGz+Bv6FfXIiyf9SEYl3/Nw6hKgEXc8
         8rLrmLUe3iy6Br2xAugYw/uUlx0cNlYIUphiEioUfmnfFMKazx/rtxg+mq7RzCORgbPw
         nwThddvrTHJ2gE1Ynj9GdDBQUQ7TZp/VieZQx5PRJUPVsmcTTX3zBKvi4agVvGRB1yQq
         VYnQ==
X-Gm-Message-State: ALoCoQlQCo0Rj+IwCPcNrMBnzbpmMrkrjenZ4hY+4o+3psQresvEHEC1Bsx+nBL9ApVQRTQ0zT28
MIME-Version: 1.0
X-Received: by 10.182.81.99 with SMTP id z3mr4566558obx.79.1403721109111; Wed,
 25 Jun 2014 11:31:49 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 25 Jun 2014 11:31:48 -0700 (PDT)
In-Reply-To: <20140625182012.GA19437@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <1403642893-23107-10-git-send-email-keescook@chromium.org>
        <20140625142121.GD7892@redhat.com>
        <CAGXu5jJtLrjbobZC1FD4WV-Jm2p7cRGa1aSPK-d_isnfCZAHdA@mail.gmail.com>
        <20140625165209.GA14720@redhat.com>
        <CAGXu5jLHDew1fifGY_mWgwcH7evm0T8rqSnBrw4XpoAXGK+t-Q@mail.gmail.com>
        <20140625172410.GA17133@redhat.com>
        <CAGXu5jKkLS3++_dtWHnjWudVvaSR9DRwjNG3q00SmSy6XoCMaw@mail.gmail.com>
        <20140625182012.GA19437@redhat.com>
Date:   Wed, 25 Jun 2014 11:31:48 -0700
X-Google-Sender-Auth: aGErAidmIooTIFiXMdWJrG37Qhc
Message-ID: <CAGXu5jLh-a2x0N+kHW7qbZSW0gOPs8v05EzBFkMYQwhft8o2aA@mail.gmail.com>
Subject: Re: [PATCH v8 9/9] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
From:   Kees Cook <keescook@chromium.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>, linux-mips@linux-mips.org,
        Will Drewry <wad@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        Julien Tinnes <jln@chromium.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Drysdale <drysdale@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexei Starovoitov <ast@plumgrid.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40835
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

On Wed, Jun 25, 2014 at 11:20 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/25, Kees Cook wrote:
>>
>> On Wed, Jun 25, 2014 at 10:24 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> >
>> > However, do_execve() takes cred_guard_mutex at the start in prepare_bprm_creds()
>> > and drops it in install_exec_creds(), so it should solve the problem?
>>
>> I can't tell yet. I'm still trying to understand the order of
>> operations here. It looks like de_thread() takes the sighand lock.
>> do_execve_common does:
>>
>> prepare_bprm_creds (takes cred_guard_mutex)
>> check_unsafe_exec (checks nnp to set LSM_UNSAFE_NO_NEW_PRIVS)
>> prepare_binprm (handles suid escalation, checks nnp separately)
>>     security_bprm_set_creds (checks LSM_UNSAFE_NO_NEW_PRIVS)
>> exec_binprm
>>     load_elf_binary
>>         flush_old_exec
>>             de_thread (takes and releases sighand->lock)
>>         install_exec_creds (releases cred_guard_mutex)
>
> Yes, and note that when cred_guard_mutex is dropped all other threads
> are already killed,
>
>> I don't see a way to use cred_guard_mutex during tsync (which holds
>> sighand->lock) without dead-locking. What were you considering here?
>
> Just take/drop current->signal->cred_guard_mutex along with ->siglock
> in seccomp_set_mode_filter() ? Unconditionally on depending on
> SECCOMP_FILTER_FLAG_TSYNC.

Yeah, this looks good. *whew* Testing it now, so far so good.

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
