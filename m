Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 13:10:36 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:34853 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492641Ab0FCLKc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 13:10:32 +0200
Received: by fxm15 with SMTP id 15so5540837fxm.36
        for <multiple recipients>; Thu, 03 Jun 2010 04:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=X+AlSkPMj6qz1FYei4JfrR8fQ3KLYIfryJlX70NV+n4=;
        b=tNpGBZG/q2URxiC3hH8ZNz2cuJyMBHWPLp5g1tItJiJsszt5s4dZWXyJHzv7Hkly2h
         UwDhGTgl5yO7VlvvRgxE4pLrHyGeUmyrj/ijpGil4Q9pFGPW2jEOx0KGz7OcZdSglwiT
         +zDD9kg47jiPgDyerVNv3WHeItYI+74tLAOFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Bw6ff015+hwRql+5DFnxKIa9se9Q85OxwQEuZh6CTMufpeR4scoKkCgsvBHe3mHt7e
         DdLLkl7NauCGcVAAIOfepwfHhYuc8rfKtSIcqmLj5g4G+GRN9dMwYskEbsIbRvv5WlZI
         NYz7YDsXhdVUMUssifJufza6CMY0xp/+4o+Lc=
MIME-Version: 1.0
Received: by 10.223.98.83 with SMTP id p19mr10082057fan.27.1275563426959; Thu, 
        03 Jun 2010 04:10:26 -0700 (PDT)
Received: by 10.223.104.209 with HTTP; Thu, 3 Jun 2010 04:10:26 -0700 (PDT)
In-Reply-To: <95654e45e2f02133c6334fb147d3e28ef94f2bb0.1275439768.git.wuzhangjin@gmail.com>
References: <95654e45e2f02133c6334fb147d3e28ef94f2bb0.1275439768.git.wuzhangjin@gmail.com>
Date:   Thu, 3 Jun 2010 14:10:26 +0300
Message-ID: <AANLkTikKBasnKuS2Ym6fS8Wr17obMnFWSmA2mJxDIrjU@mail.gmail.com>
Subject: Re: [PATCH -queue] MIPS: Move Loongson Makefile parts to their own 
        Platform file (cont.)
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2301

On Wed, Jun 2, 2010 at 11:53 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> Hi, Ralf
>
> I have fogotten to remove the -Werror in the Makefiles under loongson/

I'm just curious: why would anyone want to remove -Werror? It's very
useful in most cases, IMO.

Dmitri
