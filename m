Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 20:14:11 +0200 (CEST)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:61284 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861350AbaGRSOGq7Xdp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 20:14:06 +0200
Received: by mail-oa0-f53.google.com with SMTP id j17so3850631oag.12
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bBJ+vU4nV99JUHTovCdJ6W5qesSF5QdblH81IliY7H8=;
        b=knwE0aLIVomw71V+DuIkXpsiWqctDA5R8viSH5hCEw797vKMGw1l8rgSwQS8rjUr/U
         EwSuCDh6+MiGze6tBq8by35rTBHyeI5psj01VwRu0bFw1ACoJd6AvhzlK/qkzwS0Meaw
         y5mqudl1GL40ihwgnG86QEgnW+RpXIDuPELiSuV1avSbo2lUC/nHkhDGSEmUgtvEgI/s
         0bVtr37+qAiQwHpO2sGCk3ofgrb9iBHKvaPN7iR8Cy7mnqVoUtMC+xWXD6mnjZ7lKGxi
         8NH+QSp4Y8fXb0LXHyNHi//Z3a4lR611hLrgetSNCkPr1v0fiUcpgOULxwFH1+YJzmOm
         x6yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bBJ+vU4nV99JUHTovCdJ6W5qesSF5QdblH81IliY7H8=;
        b=ewu5haeLfZtEZ7rAPRtBG+zNRnC2Zqk1t6Yqn+RBArcua+2Sslu0I0pxQUJQxL/ldE
         folOuaJ8enP4U0Dr4V8NNueusurF80pl0sJ8GFYH7QXnUhaaIs66C7l4VDv4PeeoY+SA
         9AldX/pSeivHX63+T/fA6ia3uvqnGFaId7r0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bBJ+vU4nV99JUHTovCdJ6W5qesSF5QdblH81IliY7H8=;
        b=daGiP6bQEdEpPy6dXJfmqWE+fq26MsCQbRa6ChzmdxkXDmnOLthdDP9ogi7xowmtPx
         iBaKoNxDRK9k3zrLGte1yZ97GD2alX9YDMtosjlh5cSKv15ppAqr+xdOTeDdsiWvI8am
         2pAsG1PEF/OTOyrJDpzk5afitoxoTxCQOINEk7Iks5ysOp4cfGgukSRzYaHQg0IWSNi3
         9ryJYM3k7f/rLrMkiAokxZVOpkeo5ai3lzV1f0gCnx9gQwgHwsBhcjSK29ANEtZT61ma
         twPUJtvphO1v/ppuBaCJMqt/zRNAMjBenEAmixo1uei/Wsr4kyNzMcLHbJUi1wXFd3ok
         mDQA==
X-Gm-Message-State: ALoCoQl6T3uRW50VDtauAFVzwjINNR1cGO0uKdUpCc3UDo2H70Ab+mV2MkyKRKR+lAlVJbeUvanA
MIME-Version: 1.0
X-Received: by 10.60.80.229 with SMTP id u5mr9485819oex.62.1405707239894; Fri,
 18 Jul 2014 11:13:59 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Fri, 18 Jul 2014 11:13:59 -0700 (PDT)
In-Reply-To: <CALCETrUv3G+C3PTOD1FJGOG8AQCA30hNkUiusCnQDGq6Kt_Feg@mail.gmail.com>
References: <1405620518-18495-1-git-send-email-keescook@chromium.org>
        <alpine.LRH.2.11.1407181325200.15709@namei.org>
        <CALCETrUv3G+C3PTOD1FJGOG8AQCA30hNkUiusCnQDGq6Kt_Feg@mail.gmail.com>
Date:   Fri, 18 Jul 2014 11:13:59 -0700
X-Google-Sender-Auth: xxAQnTZ2fv-l92gae79uUzqDbDk
Message-ID: <CAGXu5jL9wQ4ZJ1kDRx_Y_cyGQEjO_Ugmcc--Q71x32_x1q9ScA@mail.gmail.com>
Subject: Re: [PATCH v12 11/11] seccomp: add thread sync ability
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     James Morris <jmorris@namei.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Drysdale <drysdale@google.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41327
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

On Fri, Jul 18, 2014 at 10:17 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Thu, Jul 17, 2014 at 8:26 PM, James Morris <jmorris@namei.org> wrote:
>> On Thu, 17 Jul 2014, Kees Cook wrote:
>>
>>> Twelfth time's the charm! :)
>>
>> Btw, there doesn't seem to be an official seccomp maintainer.  Kees, would
>> you like to volunteer for this?  If so, send in a patch for MAINTAINERS,
>> and set up a git tree for me to pull from.

Sure thing, I'll get this set up now. I wonder if I should include the
glob "arch/*/kernel/ptrace.c" in the MAINTAINERS entry. :P

> *snicker* :)
>
> Kees, if you take on this awesome responsibility, should I send you a
> rebased version of the fastpath stuff?  If so, I think that the
> arch-neutral part should go in through your shiny new tree (once it's
> reviewed to your satisfaction), and I'll ask hpa to pick up the x86
> part.

Yeah, that sounds perfect.

> I'd volunteer to be a "R:eviewer", but I don't think that the R tag
> has made it into MAINTAINERS yet.

I'd love to have you listed. :)

-Kees

-- 
Kees Cook
Chrome OS Security
