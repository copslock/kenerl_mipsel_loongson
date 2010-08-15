Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Aug 2010 05:20:28 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:48396 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491074Ab0HODUX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Aug 2010 05:20:23 +0200
Received: by qwe4 with SMTP id 4so4464927qwe.36
        for <linux-mips@linux-mips.org>; Sat, 14 Aug 2010 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=IVo5kWR7Sjaw3hrcu2Dh2/Kc4+vCz41EeB8q2rPxXKs=;
        b=FgbX+7F/uVNYWqOXNKL6tcia9qy+aM6bRuNggg90Bek38pPa/+Wq9/TBj0hTpEBfi9
         RlbCK4k8GQ4I97+1z5dVFB73bWRYabdl/NvOTbdsldr+lvQNsIw8xi2jj7GqmhELCSpy
         +nO92PkHjs/7enp6lXowUTlgBagWYin9CtLyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=rQjF/F0LkwSGBH230pIDrcx0xcOCPfwI10lzaFlIk6i8wvqGNev6JCMny5ARaUzif8
         e2X01amSBOGHZm/QhLeIikfbyUvqO8WyVDkDJf8By7576Jv/7WzNUl2KChnxXThIfo7U
         +1NAtoP7bNKA8obZKH0bmZX3iEXwJRZzyE1CI=
MIME-Version: 1.0
Received: by 10.224.36.209 with SMTP id u17mr2204288qad.328.1281838403265;
 Sat, 14 Aug 2010 19:13:23 -0700 (PDT)
Received: by 10.229.55.69 with HTTP; Sat, 14 Aug 2010 19:13:23 -0700 (PDT)
Date:   Sun, 15 Aug 2010 10:13:23 +0800
Message-ID: <AANLkTik5o+LsApwvkDTb7z+k=Ls60h9PJugrvM7ozO=p@mail.gmail.com>
Subject: Clock Source in hrtimer
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

I am planning to use  linux 2.6.24  with hrtimer enabled and with
CONFIG_NO_HZ  on mips xlr 732.


As we know, a   monotomic increasing Clock Source is required to
support hrtimer,  whose cycles could be retrieved  from
clocksource->read function.

However  on  xlr 732 ,there is only a 32 bits counter register, which
would overflow in 4s ( 2^32 / 1GHZ = 4).

How to solve this ?


Thanks in advance
