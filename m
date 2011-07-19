Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2011 07:35:16 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:50896 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490984Ab1GSFfG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jul 2011 07:35:06 +0200
Received: by qyk7 with SMTP id 7so2185597qyk.15
        for <multiple recipients>; Mon, 18 Jul 2011 22:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gOtOjJE1F5JmkhBGiWm6ftmeOKqiwCMnAaGGC9nV7Ek=;
        b=mRKY3BeOwm8PMrtotbw4tEvZRMKXsKAnZA0unN5RSKTT85UTwFr5qtKXfDBa9MXW2+
         7+gZbT2YSmOPOCkaD2bopS3XUvOy3Oo9WSpmKV0QBAlUySbOwOX/oNkVPXl6DsH/3oPV
         D8ljEY6fPmHifLLOYY8Yo2r9To+JZBo0MXdpE=
MIME-Version: 1.0
Received: by 10.229.2.89 with SMTP id 25mr5500677qci.39.1311053700421; Mon, 18
 Jul 2011 22:35:00 -0700 (PDT)
Received: by 10.229.46.135 with HTTP; Mon, 18 Jul 2011 22:35:00 -0700 (PDT)
In-Reply-To: <201107162350.51025.rjw@sisk.pl>
References: <201107162350.51025.rjw@sisk.pl>
Date:   Tue, 19 Jul 2011 14:35:00 +0900
Message-ID: <CACBHAewP5twv0X=SOJw+Yb0HVvr7binRQ+VknSzh6=dVBPw_ww@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS build fix related to power management for 3.0
From:   Yuasa Yoichi <tripeaks@gmail.com>
To:     "Rafael J. Wysocki" <rjw@sisk.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tripeaks@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12948

Hi,

2011/7/17 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi Linus,
>
> Please pull a MIPS build fix related to PM for 3.0 from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes
>
> It fixes a build regression resulting from a missing conversion from using
> a sysdev to using syscore_ops for PM/shutdown in the MIPS tree.

It has already been fixed in MIPS tree.

Yoichi
