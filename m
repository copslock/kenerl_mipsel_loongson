Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 20:01:01 +0200 (CEST)
Received: from mail-ob0-f180.google.com ([209.85.214.180]:40929 "EHLO
        mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859932AbaFYSA5xisGN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 20:00:57 +0200
Received: by mail-ob0-f180.google.com with SMTP id vb8so2547052obc.11
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=43RNnLHgc+B2/JxI1B1RNawefVRPfBJQIQ2WK/1stZE=;
        b=Lt03DObQpMMYjbdxZypGEQCqaRJu45rERS/hWfo/zbgbn8T63tN4aU2hsGBhg7/UL2
         zk/xU/6MNRIf2aQhoTEg/GZeW/4FhKjlE5rGmSUF4AcwZ4VnI4Ft+ldcLntgNchCjvLD
         rPEA10hsrW/2lXPHM2uWkYjsyNeTIBRdp1V6MArWUpwqJ49/rU1x2CX58McYJ342Ajji
         2Jej5Y5qbbXSycU58kZVnY+anh0sIs28CmJXmYueivDq7Xorbz70wKm1u7W0elfLM5zU
         vIKsB0o/+PruKvSqxoqO3Z+4aQobG/4F8guD47BXiCTN18oQe3q6zRb5PmE9boCazjaE
         E6FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=43RNnLHgc+B2/JxI1B1RNawefVRPfBJQIQ2WK/1stZE=;
        b=FzFgQbpvPJQV6oib803VI6+HTxyfvoKE0fjD4+/cyBHLwGaKIIeMo8dfj09F4D5cYK
         /HSu58tls/8rpS7obdqsR6UuzZNXmn2hb8F75Fg13YfbkPwOYD7Ue6/0QzpFfCTxZnRy
         fhyUlWcgfXA9cH3Fpcvhhnh9u/SoJe6ZMhm44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=43RNnLHgc+B2/JxI1B1RNawefVRPfBJQIQ2WK/1stZE=;
        b=TX3StQtbLdhW53ZhXpSeSsjw89HX9/2VZPgiJyhwj1BmG9sFCuqIqxuZDJZDVNZWMt
         Sh483hFbxyp0JTVBqs+4O3aVzG+DTdnD71QRDJkQbvrIajvG84PPoSF/07LLPhAroQw5
         MM6wljmQasYcx3stBQ6N6pTO7ggBJG30vxw+HZJYtgM+NAUUnLwdxMmrgFddg9zak2Dt
         s9nScQ+acL1SGaJLoa6qnOMxmR/kBsbpCqhoDRvZK2BCUNJYDiipJjZExcT8moukUaOX
         cOhOX0IGIc2JYIs+Wo0TCvo1r+YAy45trvyFD3bJn4UzOi0G1lMQ50CQj2evVioAcZWI
         L9RA==
X-Gm-Message-State: ALoCoQkVx+wK6AzXc4dfut/Gj32k8lEhe2RDkL7bVzTL78WGKp7abXvBwgJGVr7nP2oAgS836Td5
MIME-Version: 1.0
X-Received: by 10.182.81.99 with SMTP id z3mr4375158obx.79.1403719251729; Wed,
 25 Jun 2014 11:00:51 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 25 Jun 2014 11:00:51 -0700 (PDT)
In-Reply-To: <20140625175136.GA18185@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <1403642893-23107-6-git-send-email-keescook@chromium.org>
        <20140625135121.GB7892@redhat.com>
        <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
        <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
        <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
        <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
        <20140625173245.GA17695@redhat.com>
        <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
        <20140625175136.GA18185@redhat.com>
Date:   Wed, 25 Jun 2014 11:00:51 -0700
X-Google-Sender-Auth: OqbIQ1uTXUI-aEPiNFDo8JxIExk
Message-ID: <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
From:   Kees Cook <keescook@chromium.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
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
X-archive-position: 40828
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

On Wed, Jun 25, 2014 at 10:51 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/25, Andy Lutomirski wrote:
>>
>> On Wed, Jun 25, 2014 at 10:32 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> > On 06/25, Andy Lutomirski wrote:
>> >>
>> >> Write the filter, then smp_mb (or maybe a weaker barrier is okay),
>> >> then set the bit.
>> >
>> > Yes, exactly, this is what I meant. Plas rmb() in __secure_computing().
>> >
>> > But I still can't understand the rest of your discussion about the
>> > ordering we need ;)
>>
>> Let me try again from scratch.
>>
>> Currently there are three relevant variables: TIF_SECCOMP,
>> seccomp.mode, and seccomp.filter.  __secure_computing needs
>> seccomp.mode and seccomp.filter to be in sync, and it wants (but
>> doesn't really need) TIF_SECCOMP to be in sync as well.
>>
>> My suggestion is to rearrange it a bit.  Move mode into seccomp.filter
>> (so that filter == NULL implies no seccomp) and don't check

This would require that we reimplement mode 1 seccomp via mode 2
filters. Which isn't too hard, but may add complexity.

>> TIF_SECCOMP in secure_computing.  Then turning on seccomp is entirely
>> atomic except for the fact that the seccomp hooks won't be called if
>> filter != NULL but !TIF_SECCOMP.  This removes all ordering
>> requirements.
>
> Ah, got it, thanks. Perhaps I missed somehing, but to me this looks like
> unnecessary complication at first glance.
>
> We alredy have TIF_SECCOMP, we need it anyway, and we should only care
> about the case when this bit is actually set, so that we can race with
> the 1st call of __secure_computing().
>
> Otherwise we are fine: we can miss the new filter anyway, ->mode can't
> be changed it is already nonzero.
>
>> Alternatively, __secure_computing could still BUG_ON(!seccomp.filter).
>> In that case, filter needs to be set before TIF_SECCOMP is set, but
>> that's straightforward.
>
> Yep. And this is how seccomp_assign_mode() already works? It is called
> after we change ->filter chain, it changes ->mode before set(TIF_SECCOMP)
> just it lacks a barrier.

Right, I think the best solution is to add the barrier. I was
concerned that adding the read barrier in secure_computing would have
a performance impact, though.


-- 
Kees Cook
Chrome OS Security
