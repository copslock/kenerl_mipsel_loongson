Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2012 22:04:48 +0100 (CET)
Received: from mail-qa0-f42.google.com ([209.85.216.42]:34729 "EHLO
        mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab2K2VErnxYn7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Nov 2012 22:04:47 +0100
Received: by mail-qa0-f42.google.com with SMTP id hg5so690544qab.15
        for <multiple recipients>; Thu, 29 Nov 2012 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=cb9rkGeGOByJYpkiyq8zf0yeahjiKqgkgOzVRy7ot2A=;
        b=PuWSLwLwtw30zjpEt52P8NmbbBXHt8BnV9mliZx38m/yx4ZK2WPGCtrApbb2TIzQUp
         rD5g5mkgIZicak5SRS5IDyemN7Plu+nE++ES1Bzyrp4xHljSwvwhSJsxTgDGwTeV3Qch
         1JRL4tymYRGvZxF07dqPdCiWpqd4r1/6Fhe5IgAiAUiBRgMvLh8p3/p+pjNIFsoSJ7L8
         vqjo3BqA52bL8NbJdAHD9l+wznedx+VV01891rfVPg/OWnNcL+iLEffOGoTa42z1hA/4
         9QiX2hAwsnAegnDSIqmaXtctQk0NNH1KO0faYB/6i+9fmgv3uEdCPJReGpc06f8i8MtM
         gt5g==
MIME-Version: 1.0
Received: by 10.49.133.68 with SMTP id pa4mr20898793qeb.50.1354223081214; Thu,
 29 Nov 2012 13:04:41 -0800 (PST)
Received: by 10.49.117.161 with HTTP; Thu, 29 Nov 2012 13:04:40 -0800 (PST)
Date:   Thu, 29 Nov 2012 16:04:40 -0500
Message-ID: <CAOGqxeUOrVFoqsmUV19h5tXsD6pw5creXP9aN1C-V7K3WL2EXA@mail.gmail.com>
Subject: MIPS Function Tracer question
From:   Alan Cooper <alcooperx@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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

I've been doing some testing of the MIPS Function Tracer functionality
on the 3.3 kernel. I was surprised to find that the option to generate
frame pointers was required for tracing. When I don't enable
FRAME_POINTER along with FUNCTION_TRACER, the kernel hangs on boot. I
also noticed that a checkin to the 3.4 kernel
(b732d439cb43336cd6d7e804ecb2c81193ef63b0) no longer forces on
FRAME_POINTER when FUNCTION_TRACER is selected. I was wondering how it
works in 3.4 and beyond, so I built a Malta kernel from the latest
MIPS tree with FUNCTION_TRACING enabled and tested it with QEMU. The
kernel hung the same way. I can think of 2 reasons for this:
1. Function tracing is broken for MIPS in 3.4 and beyond.
2. The 4.5.3 GNU C compiler I'm using is generating different code for
function tracing.
I was wondering if anyone has MIPS function tracing working in 3.4 or later?

I did figure out why it's hanging and I have some changes that will
allow the function tracer to run without frame pointers, but before I
proceed I want to rule out compiler differences.

Thanks
