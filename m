Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Aug 2010 18:02:36 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:39425 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491820Ab0H1QCd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Aug 2010 18:02:33 +0200
Received: by wyb38 with SMTP id 38so3621973wyb.36
        for <linux-mips@linux-mips.org>; Sat, 28 Aug 2010 09:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=PJablISL68enrRs771C0QNZ9o7e+Ghu1wEcWabZYYYM=;
        b=h5fhXMQciPnirxEdB8VXC3W94kf1Tusy40RMStyHJeTxNsjAaVfA7Qj+bKyHtxOAtP
         7DXo0cY1Jm4v6isfhTewJZ7ENZ7zIiOhkyE3qQxkOR07dOJonbthDYOG4VTVRcqeTtSK
         lGepvdHLxYYZ4NF+TztGDjE9RanlL4BqrK4jc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=Jt7iYvDkzgn4UaSbhvufwCXSZPUWLL3W4yWna47NUgDfAn2B/EhkEy9wrAtosmcPBX
         Uphc7G114ayS7S9KLAuRuzn77PgRQnyxZWWF2wccZAqAGzcCcxPAXbPL/OJ0qhA9kLgm
         19e3rbMXFqfCK0Q7TvjEGHxXGYacRdCH0uyCs=
MIME-Version: 1.0
Received: by 10.227.72.149 with SMTP id m21mr2158447wbj.217.1283011333703;
 Sat, 28 Aug 2010 09:02:13 -0700 (PDT)
Received: by 10.216.166.69 with HTTP; Sat, 28 Aug 2010 09:02:13 -0700 (PDT)
In-Reply-To: <20100828071842.GB6957@capricorn-x61>
References: <20100828071842.GB6957@capricorn-x61>
Date:   Sun, 29 Aug 2010 00:02:13 +0800
Message-ID: <AANLkTimDt2pPxaiKP0WUyYgg3xmYSVsc8Cp2neNET_TA@mail.gmail.com>
Subject: Re: How is interrupt handling on MIPS SMP?
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Adam

On 8/28/10, Adam Jiang <jiang.adam@gmail.com> wrote:
> How dose interrupt be handled on SMP build on MIPS architecture? Does
> mips-linux support SMP?
>

$ grep SYS_SUPPORTS_SMP -ur arch/mips/Kconfig | egrep -v "config|depend" | wc -l
6

You can get more information from the book "See MIPS Run Linux" version 2.

Regards,
Wu Zhangjin
