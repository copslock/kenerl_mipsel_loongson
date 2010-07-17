Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jul 2010 19:49:30 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:61515 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491203Ab0GQRt0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Jul 2010 19:49:26 +0200
Received: by wyb38 with SMTP id 38so1446582wyb.36
        for <linux-mips@linux-mips.org>; Sat, 17 Jul 2010 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=R7gemLKJFKQN9loheEruriXj5gOfoavNbXaXzQ30SlQ=;
        b=CTE3IlQTbn7hmdwMYzhIwng9c2itU948iQSSAOHd92qHbMiiggUPE2IwYABrUP6w+W
         F0odPST5RxbTdFfFo21YBLA6QZXkn5MonDlsogJ6vg1ncoeNs8LrLY3IOSxDnvZNrZfi
         R9Wy8/ODiecCpy6GfqX5a8Qbewaa0Omy4cfNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=DzEdjeFh5Nrk2LcULpQNMdfHmfExNASjqq9Wf4xbMrBMPZIaNhKvVbie1uyRHtnSEK
         DmM1R6jFMwfMCysFhLzyZlTTJ1BrQ0j/qMOqdwLa1bVZ6z1vXBDkHzIIansoTYJeSTe8
         GEr3dcfkuw43fdbT7ipmUw7SA6oUdJ+32knyk=
Received: by 10.227.22.33 with SMTP id l33mr2151739wbb.101.1279388961200;
        Sat, 17 Jul 2010 10:49:21 -0700 (PDT)
Received: from lenovo.localnet (florian.mimichou.net [88.178.11.95])
        by mx.google.com with ESMTPS id p45sm1344673weq.45.2010.07.17.10.49.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Jul 2010 10:49:19 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] mips/alchemy: define eth platform devices in the correct order
Date:   Sat, 17 Jul 2010 19:37:58 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.34-1-amd64; KDE/4.4.4; x86_64; ; )
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mips@linux-mips.org, Wolfgang Grandegger <wg@denx.de>
References: <1279377528-3190-1-git-send-email-wg@grandegger.com> <AANLkTikEjMarWjpMLQYCceRzmr7mL8RZp3-9MZ_tvKO8@mail.gmail.com> <4C41E5C0.9010006@grandegger.com>
In-Reply-To: <4C41E5C0.9010006@grandegger.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <201007171937.59573.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi 

Le Saturday 17 July 2010 19:17:52, Wolfgang Grandegger a écrit :
> On 07/17/2010 07:01 PM, Manuel Lauss wrote:
> > Servus Wolfgang,
> > 
> > On Sat, Jul 17, 2010 at 4:38 PM, Wolfgang Grandegger <wg@grandegger.com> 
wrote:
> >> From: Wolfgang Grandegger <wg@denx.de>
> >> 
> >> Currently, the eth devices are probed in the inverse order, first
> >> au1xxx_eth1_device and then au1xxx_eth0_device. On the GPR board,
> >> 
> >> this makes trouble:
> >>  # ifconfig|grep HWaddr
> >>  eth0      Link encap:Ethernet  HWaddr 00:50:C2:0C:30:01
> >>  eth1      Link encap:Ethernet  HWaddr 66:22:01:80:38:10
> >> 
> >> A bogous ethernet hwaddr is assigned to the first device and
> >> au1xxx_eth0_device is mapped to eth1, which even does not work

Most likely prom_get_ethernet_addr is failing for the first device because 
pdev->id == 1 that is why you get such an address, take a look at au1000-
eth.c.

> >> 
> >> properly. With this patch, the problems are gone:
> >>  # ifconfig|grep HWaddr
> >>  eth0      Link encap:Ethernet  HWaddr 66:22:11:32:38:10
> >>  eth1      Link encap:Ethernet  HWaddr 66:22:11:32:38:11
> > 
> > Interesting.  I don't disagree with the patch; what do you think about
> > passing MAC address via platform_data?   I don't particularly like
> > how the driver is trying to get a MAC address using the prom interface.

The patch is actually good, because there are no reasons to register the 
second MAC before the first one, sorry about that. However, the real fix also 
involves au1000-eth,c in au1000_probe(). We currently only handle the case 
where the pdev->id is 0, not 1. When pdev->id == 1 you end up defaulting to 
the default au1000-eth defined MAC address. So I would do it that way:

- make the board code get the ethernet MAC address for the given adapter
- pass it via platform_data
- au1000-eth checks for its validity or generates a random one

> 
> Well, I don't think it's a good idea. Each board should have a different
> mac address and it's nomally stored somewhere in the boards non-volatile
> storage during board bringup.
> 
> > I'll try to cook something up.
> 
> But not via platform data, please. Or have I missed something. With the
> flat device tree (as used for PowerPC) the situation is different
> because the boot-loader can fixup the MAC address before booting Linux.

MIPS has no mainlined support for DT yet, but still, you would have to cope 
with existing boards running YAMON as a bootloader, so using prom_getenv() is 
imho a good solution.
--
Florian
