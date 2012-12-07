Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 16:55:35 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43312 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824759Ab2LGPzd2BAkK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 16:55:33 +0100
Received: by mail-lb0-f177.google.com with SMTP id n10so484827lbo.36
        for <multiple recipients>; Fri, 07 Dec 2012 07:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A7kOjls63oS0doXNCWP7irJGK66TnEmdmIl3ThH4m/Q=;
        b=FqEwLGtsGDMND0chMy8zLeIGVTJVEmnRNj9xBZ6oGA2YSI918foJAD4o+l0/hqUBMF
         6Iz4JPeQ2Lps2GOR6//IEwPipX92Z0LJ90qaXE13VvstpX6HDUwgGMw1KupPWUCZMrhv
         wAs+42JWZt8bwG6A7wnt47vyGwKg0hz50rXHEPO4CQw1zEkOdnFq18glt6be/2Et4OT5
         eAmiqFGYYTJObpSXjJUbyEQzjTu8wZopEnX/sUAAqIhdXvn2gqL2DIht6qItrF19LwXE
         cmJpZNteoUbJ1s2dTW8lLU7YCJKdv+xT6IVI4dWtPZ0/J/ETWvcZMdkqc1TCllLezcKB
         PRBQ==
MIME-Version: 1.0
Received: by 10.152.105.68 with SMTP id gk4mr5751592lab.48.1354895727737; Fri,
 07 Dec 2012 07:55:27 -0800 (PST)
Received: by 10.112.114.37 with HTTP; Fri, 7 Dec 2012 07:55:27 -0800 (PST)
In-Reply-To: <1354857802-29348-1-git-send-email-sjhill@mips.com>
References: <1354857802-29348-1-git-send-email-sjhill@mips.com>
Date:   Fri, 7 Dec 2012 09:55:27 -0600
Message-ID: <CACoURw62dWy1g2hKLCLwQugtrxPDOAcMgCtHTQFYno8qTktLRw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add option to disable software I/O coherency.
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35248
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

On Thu, Dec 6, 2012 at 11:23 PM, Steven J. Hill <sjhill@mips.com> wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Some MIPS controllers have hardware I/O coherency. This patch
> detects those and turns off software coherency. A new kernel
> command line option also allows the user to manually turn
> software coherency on or off.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

This patch conflicts with commit b5b64f2ba4 "MIPS: Move processing of
coherency kernel parameters earlier" in the linux-next tree.

Shane McDonald
