Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2012 17:45:00 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:58963 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903765Ab2FMPo4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jun 2012 17:44:56 +0200
Received: by yhjj52 with SMTP id j52so708851yhj.36
        for <multiple recipients>; Wed, 13 Jun 2012 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JJHKNhjjIrkG3SL7Z2zh/Zq3rWHwJyB1CiR/FCvXxkU=;
        b=Mu/XRgXamk1qDl3DvZKmgLO/M37TV8Pn6OUaZNKhvSAGKzn/K7Hml6P9oqQH1075Xh
         zqCAS8MfgMR1Tg77aXuGQC0GV/j/K/Ixj8OjdfAgUP1OMlsUmR1J9GlkVFiyyZhOTzYg
         EIPbUvmEGKjJBpixjXrfC79HeQLks6dIwdFpsgo3cY0wETKgtPxFIFsO4ZSNeL2Ht9Qu
         TUyMC8/hRN4AUlBLpb0b8aAW3pAlpNp99dZWDm53xjxSQCvz1y5COo6cZ6Zoku8s65Lw
         S23jzLEpfRrcDIfkiJSZS562HwwxdZMhKHnQfQzdxoyu2PchLAbjmiJMgJuZA6OFSjAB
         3KSA==
MIME-Version: 1.0
Received: by 10.50.169.33 with SMTP id ab1mr10982166igc.73.1339602289921; Wed,
 13 Jun 2012 08:44:49 -0700 (PDT)
Received: by 10.231.219.5 with HTTP; Wed, 13 Jun 2012 08:44:49 -0700 (PDT)
In-Reply-To: <CACoURw6oCNKHh7o9N_kE6uryfpu57sQqA-p2fq6hKnsikO5KgA@mail.gmail.com>
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
        <1337040290-16015-6-git-send-email-ddaney.cavm@gmail.com>
        <CACoURw4+N8Nk-N81kryXHOg9O_=ntvqv9prOLAZW6KKEYQ9v+A@mail.gmail.com>
        <4FD61B22.3040407@gmail.com>
        <4FD61F35.1080103@gmail.com>
        <CACoURw6oCNKHh7o9N_kE6uryfpu57sQqA-p2fq6hKnsikO5KgA@mail.gmail.com>
Date:   Wed, 13 Jun 2012 09:44:49 -0600
Message-ID: <CACoURw6S+Z9urgYQzqkTZ0WR4kcaxMnSLm=D6m_6pWJnvDtUpA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MIPS: Move cache setup to setup_arch().
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
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

On Mon, Jun 11, 2012 at 12:32 PM, Shane McDonald
<mcdonald.shane@gmail.com> wrote:
> There is a line:
>
> __setup("cca=", cca_setup);
>
> that seems to be used to call cca_setup().  I don't know how
> the __setup() works, so I'm a little lost on the solution myself.
>
> Note that, besides the cca_setup(), there is also a routine
> setcoherentio() that is defined the same way as cca_setup().
> I suspect that suffers from the same problem as cca_setup().

I've been doing a little learning on how the __setup() macro works.
A proposed solution I have is to change from using the __setup()
macro to using early_param() to mark the call to cca_setup().
Functions marked with __setup() are executed late in the boot
process, whereas those marked with early_param() occur
very early in the process.  I have tried this out,
and it solves my problem, but I'm looking for feedback on
whether this is the correct solution.

Unless I get any different feedback, I'll send out a patch with
my change later today.

Shane McDonald
