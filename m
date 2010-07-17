Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jul 2010 19:17:50 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.10]:47485 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491917Ab0GQRRn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jul 2010 19:17:43 +0200
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 165B71C00253;
        Sat, 17 Jul 2010 19:17:41 +0200 (CEST)
X-Auth-Info: tusy0rIBelCfxRu0XjkkUK/TxnBZybvqTs7GfxArvDQ=
Received: from lancy.mylan.de (dslb-088-065-251-225.pools.arcor-ip.net [88.65.251.225])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id E4EF31C003E7;
        Sat, 17 Jul 2010 19:17:40 +0200 (CEST)
Message-ID: <4C41E5C0.9010006@grandegger.com>
Date:   Sat, 17 Jul 2010 19:17:52 +0200
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     linux-mips@linux-mips.org, Wolfgang Grandegger <wg@denx.de>
Subject: Re: [PATCH] mips/alchemy: define eth platform devices in the correct
        order
References: <1279377528-3190-1-git-send-email-wg@grandegger.com> <AANLkTikEjMarWjpMLQYCceRzmr7mL8RZp3-9MZ_tvKO8@mail.gmail.com>
In-Reply-To: <AANLkTikEjMarWjpMLQYCceRzmr7mL8RZp3-9MZ_tvKO8@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

On 07/17/2010 07:01 PM, Manuel Lauss wrote:
> Servus Wolfgang,
> 
> On Sat, Jul 17, 2010 at 4:38 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> From: Wolfgang Grandegger <wg@denx.de>
>>
>> Currently, the eth devices are probed in the inverse order, first
>> au1xxx_eth1_device and then au1xxx_eth0_device. On the GPR board,
>> this makes trouble:
>>
>>  # ifconfig|grep HWaddr
>>  eth0      Link encap:Ethernet  HWaddr 00:50:C2:0C:30:01
>>  eth1      Link encap:Ethernet  HWaddr 66:22:01:80:38:10
>>
>> A bogous ethernet hwaddr is assigned to the first device and
>> au1xxx_eth0_device is mapped to eth1, which even does not work
>> properly. With this patch, the problems are gone:
>>
>>  # ifconfig|grep HWaddr
>>  eth0      Link encap:Ethernet  HWaddr 66:22:11:32:38:10
>>  eth1      Link encap:Ethernet  HWaddr 66:22:11:32:38:11
> 
> Interesting.  I don't disagree with the patch; what do you think about
> passing MAC address via platform_data?   I don't particularly like
> how the driver is trying to get a MAC address using the prom interface.

Well, I don't think it's a good idea. Each board should have a different
mac address and it's nomally stored somewhere in the boards non-volatile
storage during board bringup.

> I'll try to cook something up.

But not via platform data, please. Or have I missed something. With the
flat device tree (as used for PowerPC) the situation is different
because the boot-loader can fixup the MAC address before booting Linux.

Wolfgang.
