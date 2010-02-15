Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 18:34:16 +0100 (CET)
Received: from mail-fx0-f216.google.com ([209.85.220.216]:55668 "EHLO
        mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491954Ab0BOReL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Feb 2010 18:34:11 +0100
Received: by fxm8 with SMTP id 8so5242687fxm.26
        for <multiple recipients>; Mon, 15 Feb 2010 09:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/liblPNUalx04Eglgi9UWBM9Szw48iqZzQ3bC9PG9dg=;
        b=ENNYp3AgBWt8jDarELas5flTNz1xf3v2UuFFJ5NjnCpPunGST2kjUlB+g+sE0sYzUF
         Gt/0fK2Wq9ug+7L0T97Vnnjq1JeSLqP4iI4OqVlQN4BDIrFwjDGw9yQ2hdp0GtPwcvq3
         eXt85kuzbvzwN2ZdCbuQyzuOWHP+zPNhKFz54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QDsFF/YF6s7IBGln92Lp8osOF1dPWk7PfXGTQa8STTtlUPnjoA6CwgprcjSGi6O+31
         G0l0fT5lp5HxUjOg+Q6P8gy6DgObD+Ai+D01Z9Ph5ctonKV5GfQYBHO9gCFRRaillEGH
         F550by2QpcvAsXaJWuTmUBAd7WsKGwaHw3VgI=
MIME-Version: 1.0
Received: by 10.223.6.88 with SMTP id 24mr3553855fay.2.1266255244895; Mon, 15 
        Feb 2010 09:34:04 -0800 (PST)
In-Reply-To: <4B78AC97.8030404@gmail.com>
References: <4B733C71.8030304@caviumnetworks.com>
         <1265843569-5786-4-git-send-email-ddaney@caviumnetworks.com>
         <f861ec6f1002141216t233fde34t1586bcd50dc051b4@mail.gmail.com>
         <4B78A0C1.1070509@gmail.com> <4B78AC97.8030404@gmail.com>
Date:   Mon, 15 Feb 2010 18:34:04 +0100
Message-ID: <f861ec6f1002150934y57d57408pfe62aceca763fe10@mail.gmail.com>
Subject: Re: [PATCH 4/6] MIPS: Implement Read Inhibit/eXecute Inhibit
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     David Daney <david.s.daney@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi David,

On Mon, Feb 15, 2010 at 3:08 AM, David Daney <david.s.daney@gmail.com> wrote:
>> On 02/14/2010 12:16 PM, Manuel Lauss wrote:

>>> this patch breaks my Alchemy builds:

> Try the attached patch, it allows me to build an au1000 kernel. But since I
> don't have harware, I cannot test it.

Boots my userspace, thank you!


> I started with pb1500_defconfig, but had to disable au1000_eth.c:
>
> drivers/net/au1000_eth.c: In function ‘au1000_probe’:
> drivers/net/au1000_eth.c:1009: error: implicit declaration of function
> ‘DECLARE_MAC_BUF’
> drivers/net/au1000_eth.c:1009: error: ‘ethaddr’ undeclared (first use in
> this function)
> drivers/net/au1000_eth.c:1009: error: (Each undeclared identifier is
> reported only once
> drivers/net/au1000_eth.c:1009: error: for each function it appears in.)

I'll try to fix this; usually I only build db1200_defconfig.

Manuel
