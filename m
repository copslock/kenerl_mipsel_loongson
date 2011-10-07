Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2011 19:33:45 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:49364 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491196Ab1JGRdl convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Oct 2011 19:33:41 +0200
Received: by ggnm2 with SMTP id m2so3668305ggn.36
        for <multiple recipients>; Fri, 07 Oct 2011 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3B8gzzWBzAn9Y8casjElE9Yi6hjuEPdN16InymItd6Q=;
        b=Gfyink+bvuBl2vVlr0XZ4gK+OkeZHnZaJnbnFKx7B8kGXWgvyKFg4xR3Z6zKZeFx4y
         DzUsoH/9POxWMjWJZkDIg7uQVPsYJZsIdojWJhAu7a1itAd8ZlEe0x6CJKw38B8Cr7zH
         URrXTmSw3MxfwCttfxAb4zwzw9wzUFyFhwgCM=
Received: by 10.236.131.82 with SMTP id l58mr11811310yhi.90.1318008815745;
 Fri, 07 Oct 2011 10:33:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.105.169 with HTTP; Fri, 7 Oct 2011 10:33:15 -0700 (PDT)
In-Reply-To: <20111007163330.GA26918@linux-mips.org>
References: <1317908261-25608-1-git-send-email-manuel.lauss@googlemail.com> <20111007163330.GA26918@linux-mips.org>
From:   Manuel Lauss <manuel.lauss@googlemail.com>
Date:   Fri, 7 Oct 2011 19:33:15 +0200
Message-ID: <CAOLZvyGhA5VChtZKsCyNFhBWHbCvYX-uqXu7baswjMkFwA8d9w@mail.gmail.com>
Subject: Re: [PATCH V2] MIPS: Alchemy: redo PCI as platform driver
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4889

On Fri, Oct 7, 2011 at 6:33 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Oct 06, 2011 at 03:37:41PM +0200, Manuel Lauss wrote:
>
>> V2: changed PM to use syscore_ops instead of the platform_driver PM callbacks.
>>     syscore_ops are called much earlier during the resume process which
>>     makes restoring the wired entry much more straightforward.
>
> Shouldn't the handling of wired entries rather be done in
> arch/mips/power/cpu.c?

It should, but save_processor_state() is only called during hibernation,
and I am not qualified enough (yet) to implement it.

Manuel
