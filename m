Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jul 2012 12:54:26 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:65136 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903536Ab2GGKyX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Jul 2012 12:54:23 +0200
Received: by wgbdr1 with SMTP id dr1so9194157wgb.24
        for <linux-mips@linux-mips.org>; Sat, 07 Jul 2012 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=6uraLCkiggtfykfJXki+ig7UJeR8qNIKKAeguw6iaUw=;
        b=dA9Wt44Gd0fEqrzICG+Rlfm0f4NylLaqrv39hJNEzxYPIwX1TZBIqDmGEetOfz+kxP
         lRcx36HJlJiLHUOgsKwMdU6qWIAZCKRbqxKVxbR1NUq69xpYYY4Dvk2B9KnVYobYUQzx
         WYdJ1qIsnMOmSWLZkg5dIGS8iSVAxPjq7CWhPzhr0jEbYMDWu4WBGDb4QKpjPKZy0mSo
         KK3ZqguhzqaJL7f5wydRIryAYObl3h1bFjyHIQ1jg1uMu69L2s/FAex1DBzdWge0U0Mg
         g0E8aXejqzYA3Ano1PEaf3Lei/2JqieoL0COmCmCVWDd5+VYLTmR8hsmjyYJhXdAaV9b
         ReoQ==
MIME-Version: 1.0
Received: by 10.180.20.239 with SMTP id q15mr14661517wie.13.1341658458076;
 Sat, 07 Jul 2012 03:54:18 -0700 (PDT)
Received: by 10.194.59.106 with HTTP; Sat, 7 Jul 2012 03:54:18 -0700 (PDT)
In-Reply-To: <CANudz+soE9jkRERLbMLJYnYR5GXpkkt2owhQSDxXSMCVY7uF2Q@mail.gmail.com>
References: <CANudz+soE9jkRERLbMLJYnYR5GXpkkt2owhQSDxXSMCVY7uF2Q@mail.gmail.com>
Date:   Sat, 7 Jul 2012 12:54:18 +0200
X-Google-Sender-Auth: b9vIbuaWiO44RtCaQPsvbL0SbkM
Message-ID: <CAC157GDYoX7zSthHzBNNHU+0tKnXVK4mpNSh4KWULKMQToy3fA@mail.gmail.com>
Subject: Re: some question about struct ktermios
From:   Philipp Ittershagen <p.ittershagen@googlemail.com>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Kernel Newbies <kernelnewbies@nl.linux.org>,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p.ittershagen@googlemail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Jul 7, 2012 at 12:46 PM, loody <miloody@gmail.com> wrote:
> Dear all
> "struct ktermios" is the struct used for terminal.
> Why the header file is put at arch/mips/include/asm/termbits.h
> Doesn't it should located at kernel/include?


That is the architecture-specific definition. The generic definition
can be found at

include/asm-generic/termbits.h


Greetings,

  Philipp
