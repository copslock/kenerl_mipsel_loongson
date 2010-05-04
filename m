Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 14:43:51 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:46994 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492575Ab0EDMns (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 14:43:48 +0200
Received: by qyk30 with SMTP id 30so5338515qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 05:43:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.251.72 with SMTP id mr8mr2998272qcb.30.1272977021001; Tue, 
        04 May 2010 05:43:41 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 05:43:40 -0700 (PDT)
In-Reply-To: <m34oinx60z.fsf@anduin.mandriva.com>
References: <z2l180e2c241005040254y895e5456sf37194c97f3f739f@mail.gmail.com>
         <m34oinx60z.fsf@anduin.mandriva.com>
Date:   Tue, 4 May 2010 20:43:40 +0800
Message-ID: <z2o180e2c241005040543vc1f06c47m4ed020293c04dbee@mail.gmail.com>
Subject: Re: [PATCH 0/12] add basic gdium support
From:   yajin <yajinzhou@vm-kernel.org>
To:     Arnaud Patard <apatard@mandriva.com>
Cc:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Hi,

I am not sending of MY patches, but the patches based on the previous
work of many other people, of course including yours. I have mailed
you several days ago about what I am currently doing AND told you my
repository URL on repo.or.cz AND suggested about cooperation AND
suggested we can share the same repository. So it is not fair for you
to say that.

> - no respect of patch authorship
What do you mean? I remained all the copyright information of original
author and NOT adding anything else.

>
> The gpio patch is even a dup of a patch I sent last week...
Sorry for this. I use the wrong repository. Just as wu said, I should
use linux-queue.git, not the linux-mips.

> What's the aim here ? Sending your patches before mines to annoy me ?
Hey, guy. Take it easy. I am sending the patches here because I have
got them work and want to be reviewed by both the linux-loongson and
linux-mips maillist. I do not intend to annoy anyone.

Again, I suggest we can share the same repository, either yours or
mine on repo.or.cz.

yajin

http://vm-kernel.org



2010/5/4 Arnaud Patard <apatard@mandriva.com>:
> yajin <yajinzhou@vm-kernel.org> writes:
>
> Hi,
>
>> Gdium is a netbook based on loongson2f CPU and sm502 SOC. It does NOT
>> have a south bridge. The sm502 SOC is used for LCD controller and
>> audio output. This series of patches are adding gdium support to
>> ralf's linux-mips repository.
>
> what's wrong with you ? I told you I was going to send patches and now
> you're sending yours (judging by a quick look) which:
> - are incomplete and/or broken
> - no respect of patch authorship
>
> The gpio patch is even a dup of a patch I sent last week...
>
> What's the aim here ? Sending your patches before mines to annoy me ?
>
>
> Arnaud
>
