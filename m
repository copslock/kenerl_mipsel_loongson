Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Oct 2011 04:37:17 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:52922 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490964Ab1JOChM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Oct 2011 04:37:12 +0200
Received: by iarr31 with SMTP id r31so3933182iar.36
        for <linux-mips@linux-mips.org>; Fri, 14 Oct 2011 19:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=71IBgndisftPrNZ4bVQ02Qs1zKqsdl4OayAJZ4/BkQI=;
        b=nQn4a8sW4NlWTot1K5YHLGMWJqhMAcKXRlMlYYbhJhK19oGEbZnJ28miRPW0TXBmyd
         BFc2eNcaYZWVI/vx5IHfCOfcPbxJSEt3EIosVlE85vgfMbV+8G0tlAuIVmemKpbBxzVy
         TcqG8vgoE2mFH+rk2nREGld/GgZf3D+L309dE=
MIME-Version: 1.0
Received: by 10.231.68.136 with SMTP id v8mr3609625ibi.51.1318646226145; Fri,
 14 Oct 2011 19:37:06 -0700 (PDT)
Received: by 10.231.59.135 with HTTP; Fri, 14 Oct 2011 19:37:06 -0700 (PDT)
In-Reply-To: <20111012190659.GC15003@mails.so.argh.org>
References: <20111012190659.GC15003@mails.so.argh.org>
Date:   Sat, 15 Oct 2011 10:37:06 +0800
Message-ID: <CAD+V5YJwAxxK3eVuLtEt-cC=B1ucu-4Pb73eHe_=BFhrPLY2ug@mail.gmail.com>
Subject: Re: YeeLoong / hotkey driver
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Andreas Barth <aba@not.so.argh.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        debian-mips@lists.debian.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10929

On Thu, Oct 13, 2011 at 3:06 AM, Andreas Barth <aba@not.so.argh.org> wrote:
> Hi,
>
> there is currently a mail thread about the hotkeys not working with
> the default debian kernel. After a bit of search, I noticed the
> patches within
> http://www.linux-mips.org/archives/linux-mips/2009-11/msg00598.html
> however I didn't find a conclusion.
>
> Do you remember (or does anyone else) what happened to the patches or
> how we could get hotkey support into the default kernels? Thanks!

The latest version is here:

http://dev.lemote.com/cgit/linux-loongson-community.git/tree/drivers/platform/mips/yeeloong_laptop.c?h=linux-3.0-stable

It may be related to some other changes, please get more info from:

http://dev.lemote.com/cgit/linux-loongson-community.git/

or

http://dev.lemote.com/code/linux-loongson-community

Regards,
Wu Zhangjin

>
>
>
> Andi
>
