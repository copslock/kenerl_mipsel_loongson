Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jul 2010 19:01:20 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:35686 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491203Ab0GQRBQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Jul 2010 19:01:16 +0200
Received: by iwn40 with SMTP id 40so3905963iwn.36
        for <linux-mips@linux-mips.org>; Sat, 17 Jul 2010 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Eq6uCSry74u4+0f5zd9nSbUac1FMA27ksMpPPNr/FDg=;
        b=PW/C1xv6fqgy5QeBL5B8fNXYGFb79SF64h4/OFFo1Ee0r0NMYZ8wHd6W47fmksQoAl
         D+ylnkAOPElQFehs6pZJ3jhLwNGGZaHnKSybJZ6uvK33LoYXtZtCY5ouf1ZrmaWZAHye
         hba/prgW33S6V9eXR6LNoze+K7A5RB4jV3DX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MtvUgG5aOZos5oby6l5CKV7hUTG6zNEBdjVMWYSi8m1Qtb0Vsp1j1YZDgF/wzEUbt2
         lyBE1KrpHGImqI6gTYpCCvJ7gA+ZrhDGAFmqeQORADj7UZie99I8cX2GeMHLZmbHfqaX
         00Yp9eYAlGAqsa6COEcZz4aRfEtgmLtasuyJY=
MIME-Version: 1.0
Received: by 10.231.144.75 with SMTP id y11mr2759518ibu.15.1279386074529; Sat, 
        17 Jul 2010 10:01:14 -0700 (PDT)
Received: by 10.231.144.137 with HTTP; Sat, 17 Jul 2010 10:01:14 -0700 (PDT)
In-Reply-To: <1279377528-3190-1-git-send-email-wg@grandegger.com>
References: <1279377528-3190-1-git-send-email-wg@grandegger.com>
Date:   Sat, 17 Jul 2010 19:01:14 +0200
Message-ID: <AANLkTikEjMarWjpMLQYCceRzmr7mL8RZp3-9MZ_tvKO8@mail.gmail.com>
Subject: Re: [PATCH] mips/alchemy: define eth platform devices in the correct 
        order
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-mips@linux-mips.org, Wolfgang Grandegger <wg@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Servus Wolfgang,

On Sat, Jul 17, 2010 at 4:38 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> From: Wolfgang Grandegger <wg@denx.de>
>
> Currently, the eth devices are probed in the inverse order, first
> au1xxx_eth1_device and then au1xxx_eth0_device. On the GPR board,
> this makes trouble:
>
>  # ifconfig|grep HWaddr
>  eth0      Link encap:Ethernet  HWaddr 00:50:C2:0C:30:01
>  eth1      Link encap:Ethernet  HWaddr 66:22:01:80:38:10
>
> A bogous ethernet hwaddr is assigned to the first device and
> au1xxx_eth0_device is mapped to eth1, which even does not work
> properly. With this patch, the problems are gone:
>
>  # ifconfig|grep HWaddr
>  eth0      Link encap:Ethernet  HWaddr 66:22:11:32:38:10
>  eth1      Link encap:Ethernet  HWaddr 66:22:11:32:38:11

Interesting.  I don't disagree with the patch; what do you think about
passing MAC address via platform_data?   I don't particularly like
how the driver is trying to get a MAC address using the prom interface.

I'll try to cook something up.

Manuel
