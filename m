Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2013 03:31:29 +0100 (CET)
Received: from mail-la0-f54.google.com ([209.85.215.54]:65192 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825700Ab3ALCb1yNJZt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2013 03:31:27 +0100
Received: by mail-la0-f54.google.com with SMTP id fp12so2303909lab.41
        for <multiple recipients>; Fri, 11 Jan 2013 18:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GQsymRpZylKC4vcpvkPD8m+B7LUjxy2QcpyyFDnAsjU=;
        b=V/VBNxfOC/MjFhrd1OfAG8dPxXSsbFqJY6mVXFyToivfM5rb27M8uM3iGKWW/T/xI7
         HxqXIpf7YNycArKLZhMucbHyoNlAZJCxBQMIYoqWDCJlmBKaCOgjAKS6Wpn+0zckcWyR
         Bdm6aDvrOy7I0xZC+fZ8CEYhSXapBpOe+K2OdSqvSBsqbvbexOJ08ST3zTw9MxbVBnWJ
         OJRaVe3aMYsUHVCbYv9qvqBeMeKeULScSlHbGoEgvQySvxlYpO53Gh1rDtwR+JPoGLF8
         yYJzx6gf0Hx/NC9Ck89yRrgjbsYoara+gEaGl/0cbDncZ5P+Nd062B8Zi914fz4EbZbr
         Phpw==
MIME-Version: 1.0
Received: by 10.112.46.70 with SMTP id t6mr32401632lbm.107.1357957881993; Fri,
 11 Jan 2013 18:31:21 -0800 (PST)
Received: by 10.112.114.37 with HTTP; Fri, 11 Jan 2013 18:31:21 -0800 (PST)
In-Reply-To: <1357941325-25718-1-git-send-email-sjhill@mips.com>
References: <1357941325-25718-1-git-send-email-sjhill@mips.com>
Date:   Fri, 11 Jan 2013 20:31:21 -0600
Message-ID: <CACoURw4tUZPwDccE5-84OcvpUQtag5_Wy03oKmjzagS5So+67w@mail.gmail.com>
Subject: Re: [PATCH v3] MIPS: Add option to disable software I/O coherency.
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35405
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

On Fri, Jan 11, 2013 at 3:55 PM, Steven J. Hill <sjhill@mips.com> wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Some MIPS controllers have hardware I/O coherency. This patch
> detects those and turns off software coherency. A new kernel
> command line option also allows the user to manually turn
> software coherency on or off.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  arch/mips/include/asm/mach-generic/dma-coherence.h |    5 +-
>  arch/mips/mm/c-r4k.c                               |   34 +++++++---
>  arch/mips/mm/dma-default.c                         |    6 +-
>  arch/mips/mti-malta/malta-setup.c                  |   71 ++++++++++++++++++++
>  4 files changed, 105 insertions(+), 11 deletions(-)

Tested successfully on my RM7035C-based system that has
CONFIG_DMA_NONCOHERENT set.  My system works fine with this
patch applied.

Tested-by: Shane McDonald <mcdonald.shane@gmail.com>
