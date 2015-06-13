Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Jun 2015 20:38:22 +0200 (CEST)
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33565 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007395AbbFMSiU1phyi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Jun 2015 20:38:20 +0200
Received: by oiha141 with SMTP id a141so38149712oih.0;
        Sat, 13 Jun 2015 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9SZPrMRnxFWFfTy6rQDWKTSTdePi/4HbPdtU716PMR8=;
        b=BXWTNrJn6iG9M+P3K8Br1TNOtRqjcJ91sQyPatCpx94j04LZnk34C2B5+bE9b6DInK
         crXE5yjixHcKYdz5XPUhB9kRlrwWPNdPpHU9XPoH6qIv3kNdh99I66KjMR3HfFoQz/JS
         KTD/IXabfsE2JeFhsyYTBBfNTa2yGrD48+UO4fmMjwIbDs66irqOMI5k5KP6i8v0VJUm
         V4mWPCa5pMwC213sH+gPAwlfTftW4cMP2z3TvLEhCr+xm6YHY1Bz/hxtezqpvq69ovcH
         Tqf/MiK+GytQVa9lFI1XjkRkMpifoj/ct1olmmJdkF2UweS/3AFrhp3cGuiaP25rC2pf
         HbIw==
X-Received: by 10.202.84.136 with SMTP id i130mr16151616oib.114.1434220694528;
 Sat, 13 Jun 2015 11:38:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.72.15 with HTTP; Sat, 13 Jun 2015 11:37:33 -0700 (PDT)
In-Reply-To: <1429896460-15026-1-git-send-email-f.fainelli@gmail.com>
References: <1429896460-15026-1-git-send-email-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Sat, 13 Jun 2015 11:37:33 -0700
Message-ID: <CAGVrzcb7oMa97=w_jSDPga6yPV50f6-QEBUnX1fhMFdQqDv1xw@mail.gmail.com>
Subject: Re: [PATCH] gitignore: Add MIPS vmlinux.32 to the list
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michal Marek <mmarek@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2015-04-24 10:27 GMT-07:00 Florian Fainelli <f.fainelli@gmail.com>:
> MIPS64 kernels builds will produce a vmlinux.32 kernel image for
> compatibility, ignore them.

Ralf, Michal, which one of you should take this patch?

>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index acb6afe6b7a3..6c7ca7a2d52e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -43,6 +43,7 @@ Module.symvers
>  /TAGS
>  /linux
>  /vmlinux
> +/vmlinux.32
>  /vmlinux-gdb.py
>  /vmlinuz
>  /System.map
> --
> 2.1.0
>



-- 
Florian
