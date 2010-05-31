Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 17:34:04 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:38709 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492177Ab0EaPeA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 May 2010 17:34:00 +0200
Received: by gwj18 with SMTP id 18so2882958gwj.36
        for <multiple recipients>; Mon, 31 May 2010 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=l3yFg/cxGWHZELcThCZ4OkwAecOmQnrtU2NRaHVfctg=;
        b=LMGOj4z2lKB6I+9PG1hRH+nOHw/jG73gca51G9RX8u5f5anC7w6Fwxdw5X3hatUzf2
         hoR74AO18+3flAzfpcCcg/oNmGpoyc3ZiZYFN3+f8DHdpcvFvW7S3JNQyEOLJdBMsz9b
         /beW6Jy87t5SPm0C3nZTceRXDlFocTkfUgY6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IWFUuFXn5H5mKLhO1Kf8xPlXHfB+GwsRpCeb5pJg7A6GgFhJDu9XcHW6Eo7zTWpn4S
         k97BMpqHuhfPpnuH5yI3CjiWv86DeexsbWbJwoekuf6bRl1MDxtBjW0+PJMYPSFFZvIw
         QIZYZT5gQPkbTXE6WCBt8nB+Fw615/njMkmiU=
MIME-Version: 1.0
Received: by 10.231.176.16 with SMTP id bc16mr6029046ibb.4.1275320027521; Mon, 
        31 May 2010 08:33:47 -0700 (PDT)
Received: by 10.231.183.68 with HTTP; Mon, 31 May 2010 08:33:47 -0700 (PDT)
In-Reply-To: <20100530141939.GA22153@merkur.ravnborg.org>
References: <20100530141939.GA22153@merkur.ravnborg.org>
Date:   Mon, 31 May 2010 17:33:47 +0200
Message-ID: <AANLkTilwqYZc9-vtHsdBg1JwIOiYEPBtuRG-Rqg6nxNC@mail.gmail.com>
Subject: Re: [PATCH 0/6] mips: diverse Makefile updates
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Sam, Ralf,

On Sun, May 30, 2010 at 4:19 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> This patchset does the following:
> - introduce arch/mips/Kbuild
> - use -Werror on all core-y files of the mips kernel
> - introduce a distributed way to specify platform definitions
> - refactor a few Makefiles
> - clean up cleaning


I took the patches from mips-queue and did my usual build:

$ make ARCH=mips CROSS_COMPILE=mipsel-softfloat-linux-gnu-
O=/home/mano/db120 /kernel/kbuild-db1200 menuconfig
/mnt/data/_home/mano/db1200/kernel/linux-2.6.git/arch/mips/Makefile:212:
arch/mips/Kbuild.platforms: No such file or directory
make[1]: *** No rule to make target `arch/mips/Kbuild.platforms'.  Stop.
make: *** [sub-make] Error 2

Any ideas?


> Ralf asked in private mail if I could try to implement
> a working varient of a suggestion I made some time ago.
> The idea was to move platform specific definitions to
> dedicated platfrom files.
>
> This is implmented in the third patch.

I'll implement this for Alchemy shortly.


Thanks!
      Manuel Lauss
