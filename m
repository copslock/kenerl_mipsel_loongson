Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 19:27:17 +0200 (CEST)
Received: from mail-oa0-f48.google.com ([209.85.219.48]:38249 "EHLO
        mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817913AbaF0R1MSSbIF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2014 19:27:12 +0200
Received: by mail-oa0-f48.google.com with SMTP id m1so5967602oag.35
        for <linux-mips@linux-mips.org>; Fri, 27 Jun 2014 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ynkRZlD3Y2aL0rX/aKuN1Q9uJPiWrW1RfmRe4ZP+utg=;
        b=Z1gEEX+C+4H3O9deMwuxdTeCZgcrQHkUMGnAuc6OUgD+gwcJqlAsFkb3WQyE+rXAE2
         Jj6kf1RtrgKTs38MH145RMmAZSKw/HXRAGxH8Eouy2DFQ+9ev5WPluTJUc2dsFvuG/5s
         lf1NUxMPI5fxXdOT9jNgynjuD4bCu5ctu4rAHwpFrFF354bcIX72DiMB08/m0zelTKS6
         uPwJKLRJUPXzOvURjMBpr4VHqh4/4gomfv+OdezFbKNgXOBuhRIDuw4+AF51MJZhQ/Mf
         uDIvgaWpe9tkOSsRqXkjO6DizNXAGC0vuC+9Rm9Ksehf6D6oSyYyr2Q/iGb5D16Lbn2U
         tpjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ynkRZlD3Y2aL0rX/aKuN1Q9uJPiWrW1RfmRe4ZP+utg=;
        b=Yu5ovKrs9luf4a8Gx8l7SkCbnUvVMosrvWJTvn0A5xjGlEx0QGLl0jbJwZ3PMS1zPM
         2jgtkFbobsyyJJfdGsTsoDFSqhvsDNStRSf1/gozwj+QqtDXnilRCaHlOrFMYIAlsTNL
         LBbqp/XKady7LVuHiXcrDwumjb3MgozFBotoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ynkRZlD3Y2aL0rX/aKuN1Q9uJPiWrW1RfmRe4ZP+utg=;
        b=VYEFc/P7oSkpCQ+TL/U1LLXO1ttZQwlTWbjlAdT2R2SmAa1KLQdI15bhaYlIq5vyS1
         IE1aNaWnmX1NEap958rjv13eN7oRl1Wy2Deakvog0nRLly7GLx75kZ32ipocz4oNOOAD
         xjV9lHKzutGu8pSlpFLbME4GaEagOWkX0FWGl+enf1J4fx/c99sWtcdx7Uzp4ZwtiqJX
         TUsZs965aImWFTAYssT0AajcDLLZYN0f9haV7dBv7mDH0523I3nsbG1nx6asb3ZydNjF
         aVTchkeXamwNTnHD8nhCmluCpfC36POYaKc5pkZPnIQ3jGDt3F/iUlrF77gLiOehpRRr
         UHBg==
X-Gm-Message-State: ALoCoQk3C1rZj4Z4JrcwUD/81UfRbuLh6h6vJAFcRxV9AVG7K67WBlLwncNNKwM1SIidm+jKR2Vw
MIME-Version: 1.0
X-Received: by 10.182.65.167 with SMTP id y7mr25111208obs.29.1403890025762;
 Fri, 27 Jun 2014 10:27:05 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Fri, 27 Jun 2014 10:27:05 -0700 (PDT)
In-Reply-To: <20140625180705.GB18185@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <1403642893-23107-4-git-send-email-keescook@chromium.org>
        <20140625180705.GB18185@redhat.com>
Date:   Fri, 27 Jun 2014 10:27:05 -0700
X-Google-Sender-Auth: 1BbBV6EEfSsvkxRb2BCJ4_fZvH4
Message-ID: <CAGXu5j+97V=8H-ft0Rmn8PPR7X=m_L5vLzgneUvbv920+8Yc2w@mail.gmail.com>
Subject: Re: [PATCH v8 3/9] seccomp: introduce writer locking
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
X-archive-position: 40869
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

On Wed, Jun 25, 2014 at 11:07 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/24, Kees Cook wrote:
>>
>> +static void copy_seccomp(struct task_struct *p)
>> +{
>> +#ifdef CONFIG_SECCOMP
>> +     /*
>> +      * Must be called with sighand->lock held, which is common to
>> +      * all threads in the group. Regardless, nothing special is
>> +      * needed for the child since it is not yet in the tasklist.
>> +      */
>> +     BUG_ON(!spin_is_locked(&current->sighand->siglock));
>> +
>> +     get_seccomp_filter(current);
>> +     p->seccomp = current->seccomp;
>> +
>> +     if (p->seccomp.mode != SECCOMP_MODE_DISABLED)
>> +             set_tsk_thread_flag(p, TIF_SECCOMP);
>> +#endif
>> +}
>
> Wait. But what about no_new_privs? We should copy it as well...
>
> Perhaps this helper should be updated a bit and moved into seccomp.c so
> that seccomp_sync_threads() could use it too.

Ah! Yes. I had been thinking it had been copied during the task_struct
duplication, but that would have been before holding sighand->lock, so
it needs explicit recopying. Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
