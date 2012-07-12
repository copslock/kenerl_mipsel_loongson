Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 01:53:13 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:56941 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903849Ab2GLXxI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2012 01:53:08 +0200
Received: by yenr9 with SMTP id r9so3305178yen.36
        for <linux-mips@linux-mips.org>; Thu, 12 Jul 2012 16:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PNrp57piZKjv1LuTOp16EqSw/5JGtlptl7VLa13/3hA=;
        b=kyY99pAK/NXZoeADpNnnMmDt73DjzSSU619CMBO7bt782CI3xarAFZM3OJ1Ekb2bzt
         EB+g1cgpDwUOfCe8RsrAdSZ+kGEBWSBwxM7+rxk/5JNuPeVxJdahx+/wQ0tjPquNHmhk
         8gq2agddtfMz4fzQeuBIakDdmM/BbSHPqcLNsztiHmyUuibXYxaOEA0FgSjWdGKJhr5Y
         uh6zTD6wrPi+LInYfZQ0vzO4lAkCFNcBZI0quLHCXkl8jAIFA5DVZTCOYWY0DsETx44U
         uwmVWgn1xp+9hs2S6nOWwoLhmvApQnSJHmJkmiwMUgzAUbYh7BrpJ8PB+nyVIGh6ayqD
         LGmw==
Received: by 10.66.79.8 with SMTP id f8mr274629pax.81.1342137182002; Thu, 12
 Jul 2012 16:53:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.138.233 with HTTP; Thu, 12 Jul 2012 16:52:41 -0700 (PDT)
In-Reply-To: <20120705160222.GJ25225@inbox.lv>
References: <20120705160222.GJ25225@inbox.lv>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 12 Jul 2012 16:52:41 -0700
Message-ID: <CAEdQ38EOyU0WFKosbYmZ5Sa88KByRYeX_PyzzOPbvH+h33Ypdw@mail.gmail.com>
Subject: Re: Please recommend distro for Lemote Fuloong
To:     Code Blue <codeblue@inbox.lv>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Thu, Jul 5, 2012 at 9:02 AM, Code Blue <codeblue@inbox.lv> wrote:
> Hi,
>
> I just received a Lemote Fuloong Mini and I installed OpenBSD on it. I would
> like to dual boot Linux but I am having a hard time finding the right distro.
>
> I know Lemote and MIPS people are doing a lot of work and submitting patches
> to the Linux kernel and binutils and I am sure many other areas. Can anyone
> please recommend a Linux distro that will come with (or can install) a
> recent kernel so I can take advantage of all this hard work people are
> doing? Of course I will need a tarball or USB installer since the Fuloong
> doesn't have an optical drive. Thank you.
>
> --
>                        _
> ASCII ribbon campaign ( ) Please follow up to the mailing list
>  against HTML e-mail   X
>    and proprietary    / \          Mutt.org
>      attachments            Code Blue or Go Home!
>

Gentoo.

Join the #gentoo-mips IRC channel and ping 'blueness' since he's built
some very nice install stages and netboot images.

Also, we provide multilib installations with o32, n32, and n64 base
libraries (n32 is default).
