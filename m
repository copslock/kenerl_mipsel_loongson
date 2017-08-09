Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2017 12:46:44 +0200 (CEST)
Received: from mail-ua0-x241.google.com ([IPv6:2607:f8b0:400c:c08::241]:36972
        "EHLO mail-ua0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995200AbdHIKqhN9LNl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Aug 2017 12:46:37 +0200
Received: by mail-ua0-x241.google.com with SMTP id 80so3671228uas.4;
        Wed, 09 Aug 2017 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T64Zk3h/Jq42X2GmHrwtomLRCqrMjoY/2r4ZCJepjhw=;
        b=jx6xTcCT8uBNer/EXKWbMM0q275xhoHcsTWXy2iOxRJNZ2FukUo9R2zboEv5z4saKC
         FK/Wwnc3pymB/wNfUvH/0GEfK5zL5ReppJalPd7S7MZuS+IWzLDVKnGrWoX0FjkaGcPM
         n//es7ebPdqrc/HzKT8uCbxgYOlSdcF+JV7F6OxKw6PYaidWwfUw4ocxF70ciGivQ4/m
         CKRLozrBPFaXPE+QAisxlbUylE5NHmR+jyE1ZczHEhiFe+PVfoYj3vXj4l6sicdB2tQK
         WH3YVFuWfM3jurlFVpW+21arUL3+t5JCeEhK6oblpbmOQVe3X2niVN4YntOyIMJXrKQT
         HtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T64Zk3h/Jq42X2GmHrwtomLRCqrMjoY/2r4ZCJepjhw=;
        b=D4oBHTcmVU5aiIkoa4Tod/pTAfLBFy7p6+lTC1h8v4wAVIyu3e17OPxB3D1AeOFZ9J
         JS8ZW8VKbsCmIJMvQCU42AkQlqNLTYPYsl7SM9TBtS66ACJn/A7T/lfZ4oRn7oKE1K6x
         kA2KDcMX5kYX86ox8Endj8OA3Jk0Du+gv93V4mT6ktElEauu8HUkZMx0eGUr1iH/ZWig
         So4Nv5/iPElgZXZHd9lSBGiOu86Tktis7VEK3T/L3soZveCJnaHAjV4rmlziOHgN4pLp
         ISxu3D64MqhTYJ0RWWB3EJ1ylAN0ite4Ba/9hPVupuoKsnduoYQYy5ckQcBawJOFZOSc
         wt4A==
X-Gm-Message-State: AHYfb5hSwjL7CuHCoeu7CNBJE4G5NaeKTc0E8je+U3CJwpp7UqdECB8S
        3gaD19cAxJK7NPT7wgaQlc61B+YdsQ==
X-Received: by 10.176.74.133 with SMTP id s5mr5434676uae.172.1502275591373;
 Wed, 09 Aug 2017 03:46:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.169.5 with HTTP; Wed, 9 Aug 2017 03:45:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1708090349390.17596@tp.orcam.me.uk>
References: <20170731092151.116438-1-manuel.lauss@gmail.com> <alpine.DEB.2.00.1708090349390.17596@tp.orcam.me.uk>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 9 Aug 2017 12:45:50 +0200
Message-ID: <CAOLZvyEH_5kBGq2Yn9YmfbJghnPKtkpbh9Lpo7AbJxrmh=-6Qw@mail.gmail.com>
Subject: Re: [RFC PATCH] MIPS: math-emu: do not use bools for arithmetic
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Wed, Aug 9, 2017 at 10:14 AM, Maciej W. Rozycki <macro@imgtec.com> wrote:
> On Mon, 31 Jul 2017, Manuel Lauss wrote:
>
>> I'm unsure whether the patch is really correct, due to the unexpected
>> binary size reduction.  I do not have a hardfloat mips32 userland at hand
>> therefore I'd appreciate it if someone could test it!
>
>  What exactly are you unsure about?  Double operations using odd register
> indices in the 32-bit FPR mode are architecturally unpredictable.  Is this
> what concerns you?

I was not able to find a definition for get_fpr by grepping the tree
for it, so I wasn't
sure whether only the LSB or all mattered.

Manuel
