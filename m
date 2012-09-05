Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2012 01:30:35 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:42860 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903404Ab2IEXa3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2012 01:30:29 +0200
Received: by eaai12 with SMTP id i12so355130eaa.36
        for <multiple recipients>; Wed, 05 Sep 2012 16:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WzschZMRJzE+KaP51EZSOHk6yptNVSVM/LYEEmupikc=;
        b=qkQwFxdvGuE3nDpY1QjRa0K0yYIQwG1jj3WvmiGlTi2xNkUoxOgSd+pIJojT1DwoxI
         m4W/87R50sFjZfY9RiBdRmTbYlxZa/1Uu2urxJCmhA1LGoixUS4fXC/TfGFsKpDBdKX5
         3qULmYxmFz//Tdztr9KQefepITuYfNwFHYfst0Vtx53DKdINr0jrCPHh4xyf2FX0oRhG
         UedrBlrBa4D9Z8lrCrnVrP/MCds3Snjty2jRXA0RRjX9RNWcvf/eQo2kOeNnjgROuJyF
         B7dRhZBJoimaPpuCuv6zdnLD3dWIF5c3R8sHTF1FKP2Vxj0hS//x/o9gJV0wF2HFurNJ
         mKiQ==
MIME-Version: 1.0
Received: by 10.14.202.66 with SMTP id c42mr179156eeo.35.1346887824305; Wed,
 05 Sep 2012 16:30:24 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Wed, 5 Sep 2012 16:30:24 -0700 (PDT)
In-Reply-To: <5047C967.2010709@gmail.com>
References: <1346876878-25965-1-git-send-email-sjhill@mips.com>
        <1346876878-25965-2-git-send-email-sjhill@mips.com>
        <5047BAA0.1010602@gmail.com>
        <5047C967.2010709@gmail.com>
Date:   Wed, 5 Sep 2012 16:30:24 -0700
Message-ID: <CAJiQ=7AZDYFR4Dk=QvNxFCy-j2BGuxzZtfQa1WsJuH9gKX-EDA@mail.gmail.com>
Subject: Re: [PATCH 1/4] MIPS: Add base architecture support for RI and XI.
From:   Kevin Cernekee <cernekee@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Wed, Sep 5, 2012 at 2:51 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> Nobody in their right mind would implement only one of RI or XI.  So
> splitting this feature into two parts just adds complication with no
> benefit.  Unless you have evidence that there is actual silicon that only
> implements one of the two, there is no reason to split this, and to way to
> test it.
>
> You can just keep kernel_uses_smartmips_rixi, and the rest of the patch set
> is mostly unneeded.

Recent BMIPS4380/BMIPS5000 cores support the XI bit, and ignore the RI bit.

AFAICT it is safe to just use kernel_uses_smartmips_rixi=1 on these processors.
