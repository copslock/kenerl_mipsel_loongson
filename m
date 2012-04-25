Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2012 15:58:32 +0200 (CEST)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:40109 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903678Ab2DYN6S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2012 15:58:18 +0200
Received: by vcbf13 with SMTP id f13so78107vcb.36
        for <multiple recipients>; Wed, 25 Apr 2012 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SojX2MbYNFrs9B99UP91BGZ/MCX+eqYl25lQZvIGxm0=;
        b=i09sMBi1ePgPhQdx/8tFfDa0490aZuVsQ6FcAoSVSTwx0G5HdNG0YWImSxBIi3kTHC
         JGyViwzMKJkIGABX7gxDbNO1U2TrDPd3B02vZhk0KcLyH3gnpSylvpgIBVDWaoqj63Ta
         yt1s7g2nNdag67sKinbUlvC+7mfjNxmQU3gbbdT04yUqXTvYspIf9Uk9vIjjrvOhkbAG
         A7orKk7QN9zy8OUAQm8HfjIeL1M8rfqmyk4z5vZCxikxBn2HK3wQGTiYN5kd6S9sL4AJ
         BbJ9r3lkolW3vyXqRp4uwVAzY51avfh/58V5v9B8j6iagfMa4mgBXklIIKeM6VK8R/p9
         q9Lg==
MIME-Version: 1.0
Received: by 10.220.10.19 with SMTP id n19mr2684059vcn.36.1335362292025; Wed,
 25 Apr 2012 06:58:12 -0700 (PDT)
Received: by 10.220.118.131 with HTTP; Wed, 25 Apr 2012 06:58:11 -0700 (PDT)
In-Reply-To: <4F9736C9.8020003@gmail.com>
References: <CAJd=RBAXc+QSX+xnJ2W9vVwK64Etrzrr=iBqPkJXNvYgwujQ_Q@mail.gmail.com>
        <4F9736C9.8020003@gmail.com>
Date:   Wed, 25 Apr 2012 21:58:11 +0800
Message-ID: <CAJd=RBBcWKQC+YoCrpvPJ78jZoytj=t6oeybdR=t_r_DCfGhLQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: Add support for transparent huge page
From:   Hillf Danton <dhillf@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Apr 25, 2012 at 7:27 AM, David Daney <ddaney.cavm@gmail.com> wrote:
>
> I'm not sure where that copyright came from.
>
You ported hugetlb to MIPS, and I C hello to the author that way:)
