Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 20:19:39 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:35132 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491145Ab0EaSTf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 May 2010 20:19:35 +0200
Received: by iwn40 with SMTP id 40so531885iwn.36
        for <multiple recipients>; Mon, 31 May 2010 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=o1OoMIdtXjcYlsh96jfhjJcy3Wq6uMj9wXQ3YYhHIws=;
        b=EYB9Lu5nLeEISoS4SuW7vV4cOr/YaXYcfgQd5Flgk8Er1UZEULXc7qHWmRnHQYak5T
         Ia4cfLjFpDsxAP25ABUY2BDLEGhxzoP0RZon/se7Ch55kbF4L46zYuwKyQyGQRlSHubA
         eREOr2y5A/Zv85Azgu1UAFqGTyb1tuRky9iEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KO96dhWB0KtoRzwedd5tQzjy92R1tGkYaPBQoYmprR9CuNTAL9LAu3qP07q2TSuyZs
         q6K8NJjaD/NEa/1lzlMnOfwePyvLqE+AZbN4mrMxpoVV6UbeuJ1V/iNrRIxEPM2KhFN/
         ROLn34aOP27zrmgL5pWOgXzHK3ZVEt4Jpl2Wg=
MIME-Version: 1.0
Received: by 10.231.120.95 with SMTP id c31mr6242587ibr.95.1275329974013; Mon, 
        31 May 2010 11:19:34 -0700 (PDT)
Received: by 10.231.183.68 with HTTP; Mon, 31 May 2010 11:19:33 -0700 (PDT)
In-Reply-To: <20100531180321.GA27518@merkur.ravnborg.org>
References: <20100530141939.GA22153@merkur.ravnborg.org>
        <AANLkTilwqYZc9-vtHsdBg1JwIOiYEPBtuRG-Rqg6nxNC@mail.gmail.com>
        <20100531180321.GA27518@merkur.ravnborg.org>
Date:   Mon, 31 May 2010 20:19:33 +0200
Message-ID: <AANLkTimRi4FOtJA8xKfD78dBK4rWfFawOsZkACZfhe4g@mail.gmail.com>
Subject: Re: [PATCH] mips: fix build with O=...
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Sam,

Thanks a lot.

> Hi Manuel.
> Thanks for testing and reporting so quick.
> The following fixed it for me - I tried only the ar7 platfrom.
> And do not hesitate to ask if you hit troubles converting your
> platform.

I just moved stuff from main Makefile to Platform, so far it seems
to work for 2


> Note: On top of my tree since git did not see the
> git tree posted by Ralf as a git tree?!?

git://git.linux-mips.org/pub/scm/linux-queue.git works

Manuel
