Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jun 2010 02:58:53 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:35577 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491897Ab0FOA6t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jun 2010 02:58:49 +0200
Received: by iwn3 with SMTP id 3so192886iwn.36
        for <linux-mips@linux-mips.org>; Mon, 14 Jun 2010 17:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=QfMIHybHwk8M0gVYvfjdbndsMIelHx16LKJ/b/f/Vjo=;
        b=jjP7/Pbv5YT0oE5m6oOcGNVNruPkfACjUqhnJQk1iMUyZGdrDeBFVNKGe37HWaRrV0
         vMrLFZffzpvgnsmp/BYNL5IZfrixGEZoqVgS/i9IukMEMrKTHIwKcDH8FHSFZortnFMg
         AWQ6pQ0f+jpc5uuf6XrMZwrumA8YLAOAI0jlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Kl7Z7+qWdPUavB+9k09cx6il1KNPfwFCVoLYpOlvzOTaZpOQCz/NWlnRveGlPG484w
         930vG5ouofD4ewixAmEOBbHaoNgzkNIkoH7qPw6j9DaDXQ7D2NIQuypo1fH6lByYxNQU
         f70WLOnlnqZE+CEScauCp3OwXUcwuB+Rki+Us=
MIME-Version: 1.0
Received: by 10.42.8.72 with SMTP id h8mr2231563ich.17.1276563527583; Mon, 14 
        Jun 2010 17:58:47 -0700 (PDT)
Received: by 10.42.3.196 with HTTP; Mon, 14 Jun 2010 17:58:47 -0700 (PDT)
In-Reply-To: <AANLkTikmXmu9uhxnk2OXuCICMpe-hdUJHaB-okhkNf3t@mail.gmail.com>
References: <AANLkTikmXmu9uhxnk2OXuCICMpe-hdUJHaB-okhkNf3t@mail.gmail.com>
Date:   Tue, 15 Jun 2010 08:58:47 +0800
Message-ID: <AANLkTinUV5r8tgVxMiercS4NivtCVNa0vTObQtF8SROm@mail.gmail.com>
Subject: Re: Do I Need to enable or set l2 cache in mips for linux work
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9944

CONFIG_MIPS_CPU_SCACHE is the one you need to set.

You may try the Perf tool located at tools/perf. For how to build the tool
and patch the kernel, please refer to:

http://www.linux-mips.org/archives/linux-mips/2010-06/msg00143.html

BTW, raw events are suggested for your L2$ profiling.


Deng-Cheng


2010/6/13 loody <miloody@gmail.com>:
> Dear all:
> My cpu is 24ke and are there any l2 cache configs I have to take care
> of, such linux can take advantage of it.
> BTW, will I can find any tool or test program for measuring the
> performance of l2 cache under linux?
> Appreciate your help,
> miloody
>
>
