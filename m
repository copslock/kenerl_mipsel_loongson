Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 17:10:50 +0200 (CEST)
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57803 "EHLO
        mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859626AbaFYPKr53mRx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 17:10:47 +0200
Received: by mail-ob0-f174.google.com with SMTP id va2so2218721obc.5
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Y36nyxpFk+lXWY7Uz0mqdzdbbKZvtf0lRJsaPziS3k8=;
        b=BeoA7OAlj90TLoCTQWcO7or2C1/1whmktz2t1DaZ4w4ydManYncXvoJ/Z4lHoCKGHa
         4r00N8A5QbiXw0olXq78Jr6B0vZTcOx5ML5Tuvc6WS6wQlrw1/PWxWTEoSOqqA+Yp3kP
         ZTbf1NmYmXdQBxirp9G1agGBjV/RIhf8+DmJQykwSy3CMsEZ56lNjC46qQu/tt9kB5HA
         e+IUAUWtgEMgrnXBXiOpi5z2SPoFJG05XixMxxTHOYi75A273wt9+HI7w8gLcWrl5/Dq
         1QAxHU6h7CzEvw0kqLUbbz61COce537DgLTX7H5f7URP8lsAvW86cFfOqmmLVlwQedc4
         yuwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Y36nyxpFk+lXWY7Uz0mqdzdbbKZvtf0lRJsaPziS3k8=;
        b=dyj1FOWt2zOyjNq37YtsBXmCpo/QTp+hGqcFINJqXQEuNHlArlUJBlmgEO6YgcQLnP
         QYuEWRI6iRxHyELoAjbSd12joEJJ6iY9Qp7ik21V30YzcMY///ar3ZLRejjVOM7uSlUE
         QtVaAMn/8t6kxKRQoNiVlW8NPSGWtHPca/a5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Y36nyxpFk+lXWY7Uz0mqdzdbbKZvtf0lRJsaPziS3k8=;
        b=eHsq4kuOeDV4eCv17P+WX4ix8DRDZy6G1s9tCCT+DZJ3Uapb5NNZCUYD7O6zhApZiy
         vWuVOJMwyBCL3FH3I/8DIcyU/b3VGJ8SEDABMdJ67H9IRdygCavyfQRBnEXvGQ1LmLp3
         cSgGdkoqULO6Aeg+D1qnkyavQm/D8WcShVr8o5lZlIkmvwALxQPaFk/+rPl9/i51XZ74
         Ljr+7TQM5wYiJRJ35H+CdxejigQUzbjEAYg6w9YgtH7ho1dJMeZ46O6+rPLBZ3io6fLm
         8MGoqvSZoj34xhzFt/SRnSwChta9ArFEoRGo0syw9Arr2bn0kr+sP/pAmIIgn8f0vpjx
         wcgw==
X-Gm-Message-State: ALoCoQmlPCOJ0AJGKyOvoAp2P/JvmUsvQXmrmJW3yQ5404Uq44beQ4eBaLdzP7akMnLemHz1jNqs
MIME-Version: 1.0
X-Received: by 10.182.213.100 with SMTP id nr4mr8702872obc.39.1403709041910;
 Wed, 25 Jun 2014 08:10:41 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 25 Jun 2014 08:10:41 -0700 (PDT)
In-Reply-To: <20140625140440.6870eac1@alan.etchedpixels.co.uk>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <20140624205615.GW5412@outflux.net>
        <20140625140440.6870eac1@alan.etchedpixels.co.uk>
Date:   Wed, 25 Jun 2014 08:10:41 -0700
X-Google-Sender-Auth: bCbTkPScOTHELah4xx8OXxxVzrQ
Message-ID: <CAGXu5j+99NOtJq2-TWYm8mwNw1ki0y3rRH21wX66MVM8=jz1bQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] man-pages: seccomp.2: document syscall
From:   Kees Cook <keescook@chromium.org>
To:     One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Wed, Jun 25, 2014 at 6:04 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
> On Tue, 24 Jun 2014 13:56:15 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> Combines documentation from prctl, in-kernel seccomp_filter.txt and
>> dropper.c, along with details specific to the new syscall.
>
> What is the license on the example ? Probably you want to propogate the
> minimal form of the text in seccomp/dropper into the document example to
> avoid confusion ?

What is the license of the other code examples in man-pages?

-Kees

-- 
Kees Cook
Chrome OS Security
