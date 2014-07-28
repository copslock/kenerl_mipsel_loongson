Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 01:46:53 +0200 (CEST)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:41980 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860177AbaG1X3il8ba2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 01:29:38 +0200
Received: by mail-oi0-f52.google.com with SMTP id h136so6731420oig.11
        for <linux-mips@linux-mips.org>; Mon, 28 Jul 2014 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=u4eJl+L+lo+gtCTcQEIqgkA/4jNDLQWGL/rVVaZu+mw=;
        b=X0jcAqhlSVl4bumv5H0Gkoy4AomayVc+keqvCU/ZABce6dXlOyVLUztKGsURkPOi4v
         H0lAUMWI8wz7VUPFliJWb7rWbaQXD92a6V5d0NRF0XOcIv5TTfmLAlwCWX5tHySLEOL2
         7eb6ejRoXrusMCpaDfOOCZIQ2GRZZhkwRwa3bxhgKWZ7mMtx9e3SdAxX5y/rBJVg7Bfa
         phal5mRCI0s8kLLyS+MRAk7+rAqjkM7XDWPlfkBkIMoiBdl2aEOipg5m68uXG1qy1oq8
         StESTR6PFKJTU1OO3MMOa8+tVLG1TfU0phJIsnMXllODW4QeqioCn6bOwLIAOl1Hhpan
         kezw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=u4eJl+L+lo+gtCTcQEIqgkA/4jNDLQWGL/rVVaZu+mw=;
        b=bNAIusI2QFldro4Vb+7twCFnwpPeyqImTGO9MEz1Qe/IDg3XFMsrWBkYBnUAk8WP65
         lAr0eP+JCvDZmWbPNkyO7lCAzz84kFeDoLklTpS+CiKynD/goVOVF2DGuTCuukLmbn/A
         A0eVapTO+enqJrlg+niwchT7qMPXBz06fhXVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=u4eJl+L+lo+gtCTcQEIqgkA/4jNDLQWGL/rVVaZu+mw=;
        b=dWoGdZVC6QioJCGyAiokNuPQv3bw6BTrSRcGM6xxqDXmpthFLwVnMm2uIRM9fsGQUd
         xuUZSB4xmqPsb25nYjPYVVnfov84E/QZMIjLJ9/MrGrHxdSTzDn0HNShr+6FB3eIyKUn
         99nBd36HntemqceyR9dRjjf/Qh+wjdAXYD46+Bz/hqBE9/6OncGQjrSbAOwP4l1K0mXQ
         kT2mHZGukfi6jDah3YFkkpjX+VdJR35MZD0VOMnZVnk35qMQVxMr+ESP7ya64zjuVN9N
         jHtUPL/GKt2H28BbdCdWmsNptOWwE6rNe4NlyAk+NEoNM48AxR7TH229JuCSOgUTDXCW
         Ewiw==
X-Gm-Message-State: ALoCoQlXL0Z+8uXHj/SjD4e2zycabFWCkUalnwK5AMtt208hM42iWrbHljxS9H+6YsNuxKsN4RXV
MIME-Version: 1.0
X-Received: by 10.182.3.100 with SMTP id b4mr36848404obb.79.1406590171913;
 Mon, 28 Jul 2014 16:29:31 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Mon, 28 Jul 2014 16:29:31 -0700 (PDT)
In-Reply-To: <53D68F91.4000106@zytor.com>
References: <cover.1405992946.git.luto@amacapital.net>
        <CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com>
        <CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>
        <53D68F91.4000106@zytor.com>
Date:   Mon, 28 Jul 2014 16:29:31 -0700
X-Google-Sender-Auth: XiJtTw83h0hS56GiBImAI2p2mao
Message-ID: <CAGXu5jKJOrtjY9JsCBUvUbj_y4Hv+AeMEmGwWZZ18FmiZmAbbQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Two-phase seccomp and x86 tracing changes
From:   Kees Cook <keescook@chromium.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Will Drewry <wad@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexei Starovoitov <ast@plumgrid.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41731
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

On Mon, Jul 28, 2014 at 10:59 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 07/23/2014 12:20 PM, Andy Lutomirski wrote:
>>
>> It looks like patches 1-4 have landed here:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>
>> hpa, what's the route forward for the x86 part?
>>
>
> I guess I should discuss this with Kees to figure out what makes most
> sense.  In the meantime, could you address Oleg's question?

Since the x86 parts depend on the seccomp parts, I'm happy if you
carry them instead of having them land from my tree. Otherwise I'm
open to how to coordinate timing.

-Kees

>
>         -hpa
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Kees Cook
Chrome OS Security
