Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2014 11:25:22 +0200 (CEST)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:59187 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860067AbaGJJZS7cMeJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Jul 2014 11:25:18 +0200
Received: by mail-oa0-f53.google.com with SMTP id l6so9262407oag.26
        for <linux-mips@linux-mips.org>; Thu, 10 Jul 2014 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VBjhpgHN56I1SCqygdImtyp1IV5MHA8SA/N11dclpbA=;
        b=ReD9w+FJrJ16Ta+CAldITgFEC+LnPzDPoVwePrHWyQDODRlxNdo5v6ALRErp43u+Li
         ugNdvbN8H/t1snv9RMCYmXr5l9pDbwTHrdfjFCWdrA7JEiD3jecsi6sGFkR+Yso+O0Zn
         /lqAUMXKjSrdq73I/VOVIknXXCJYtaI5sdkAZDKfESLtupfYP83+BfXN7GMt7vsdJfmd
         HDQtyNSOXlVcdQ0BfK2HU2LX2y87XY4FudDQyfiPY0bqdByu4kHoDIy+TNDWTWJqqwqS
         L1Ot/eb5wy1RwvIyDy8itIT7YCwhvfz2zYoD9B5VOxdGkDPmH0S9FBqTnBOH9fxlMBVa
         BCJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VBjhpgHN56I1SCqygdImtyp1IV5MHA8SA/N11dclpbA=;
        b=OSzkCWsYHHjbajEorRlXl0cYrihlciKNygBKt57rjDsI87MwvM8duayTVNIrHAyWgF
         N8uPb+hzAvJO6vqnw5tMJ4KmHnsW+IAt/BIHM9dl+ilyf9Sgha6cfPe8yyFvfcygTYrA
         lIJgGmlIlNWPi0HtS4f9a6YEnJIySlJTedjpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VBjhpgHN56I1SCqygdImtyp1IV5MHA8SA/N11dclpbA=;
        b=Y0MFCA294EQ8YXF4I2TX2vO+v5iOyzVMkfEjLdcia6YiR2Pe6z6q1ZM9H5XTrNH9Lq
         kZ9qQsWFTaoL9eo3WMHQeOKtF/Q/55PZCd4QU6Ri/eIbobZLdR4r4IUL8zoOw/GOporq
         gU1Ace9jKJfb/JWXuuuapsnhEqTSMLBB10kPdB3nU++/qw6XJ4HxY41JoJaOizgl2K25
         GHdZUz1M/AT1c8kdbe0XBshabSKildiwDwPXuQCymAcCzopbVrdr+P4eIuCyC0rHGPKO
         Y2vZrBZ7kfaOtaWLdKWnGZZ5Mda966HHENR66fSeTpiiqPylWtKwwxaXNILFv9Fcglkc
         J7Tg==
X-Gm-Message-State: ALoCoQnMPAkxmX54Bznz7hSyhw7398HXWhy8JqWRYmZRAIR5ShLxrFdDpna8W1ZLprNNXp+1wmiT
MIME-Version: 1.0
X-Received: by 10.182.65.167 with SMTP id y7mr53425118obs.29.1404984312732;
 Thu, 10 Jul 2014 02:25:12 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Thu, 10 Jul 2014 02:25:12 -0700 (PDT)
In-Reply-To: <20140709185549.GB4866@redhat.com>
References: <1403911380-27787-1-git-send-email-keescook@chromium.org>
        <1403911380-27787-10-git-send-email-keescook@chromium.org>
        <20140709184215.GA4866@redhat.com>
        <20140709185549.GB4866@redhat.com>
Date:   Thu, 10 Jul 2014 02:25:12 -0700
X-Google-Sender-Auth: sQAH1XjXNSSrDt6A530PBSvtI74
Message-ID: <CAGXu5jL6q1d16uA1Yu+QO4eV7zWwcWEWgkZrwmsfymbMvEr6+Q@mail.gmail.com>
Subject: Re: [PATCH v9 09/11] seccomp: introduce writer locking
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
X-archive-position: 41109
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

On Wed, Jul 9, 2014 at 11:55 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 07/09, Oleg Nesterov wrote:
>>
>> On 06/27, Kees Cook wrote:
>> >
>> >  static u32 seccomp_run_filters(int syscall)
>> >  {
>> > -   struct seccomp_filter *f;
>> > +   struct seccomp_filter *f = ACCESS_ONCE(current->seccomp.filter);
>>
>> I am not sure...
>>
>> This is fine if this ->filter is the 1st (and only) one, in this case
>> we can rely on rmb() in the caller.
>>
>> But the new filter can be installed at any moment. Say, right after that
>> rmb() although this doesn't matter. Either we need smp_read_barrier_depends()
>> after that, or smp_load_acquire() like the previous version did?
>
> Wait... and it seems that seccomp_sync_threads() needs smp_store_release()
> when it sets thread->filter = current->filter by the same reason?
>
> OTOH. smp_store_release() in seccomp_attach_filter() can die, "current"
> doesn't need a barrier to serialize with itself.

I have lost track of what you're suggesting to change. :)

Since rmb() happens before run_filters, isn't the ACCESS_ONCE
sufficient? We only care that TIF_SECCOMP, mode, and some filter is
valid. In a tsync thread race, it's okay to use not use the deepest
filter node in the list, it just needs A filter.

-Kees

-- 
Kees Cook
Chrome OS Security
