Return-Path: <SRS0=1Pqs=Q6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED32C43381
	for <linux-mips@archiver.kernel.org>; Sat, 23 Feb 2019 06:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1141D206B6
	for <linux-mips@archiver.kernel.org>; Sat, 23 Feb 2019 06:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="eOYYsGSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfBWGIy (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:08:54 -0500
Received: from forward104p.mail.yandex.net ([77.88.28.107]:54702 "EHLO
        forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfBWGIy (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Sat, 23 Feb 2019 01:08:54 -0500
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id 133BE4B00CD9;
        Sat, 23 Feb 2019 09:08:50 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id APlZ5bXQJC-8nammqo5;
        Sat, 23 Feb 2019 09:08:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1550902130;
        bh=GHjJ2Pbn/7g8fBPFRHJihS61HAZ/WtEN0/SCWMMVD0g=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=eOYYsGSiCXUGov9WcBxkksenTmHs8Y270TsGlH4r5YwLjtHoQ8edahmopWrLdbjrR
         7q5cAd9tWsAxR1TiSOv/zPHSWk4jSmPUMtOEiwNXoH4IMGe8eA7Pkf/Q16zNFjkN8u
         enD2uCyzfpUUQirpAg4muVA427S4sRJvXnqn73EQ=
Authentication-Results: mxback15j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id nn9kF2icp7-8gWigNSC;
        Sat, 23 Feb 2019 09:08:46 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: CS5536 Spurious Interrupt Problem on Loongson2
To:     Tom Li <tomli@tomli.me>, Alexandre Oliva <lxoliva@fsfla.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     James Hogan <jhogan@kernel.org>, Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org
References: <ora7in8tfs.fsf@lxoliva.fsfla.org>
 <20190223015650.GA8616@localhost.localdomain>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <e57f51ad-4065-b652-ef0e-d93b084d938f@flygoat.com>
Date:   Sat, 23 Feb 2019 14:08:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190223015650.GA8616@localhost.localdomain>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


ÔÚ 2019/2/23 9:56, Tom Li Ð´µÀ:
> On Fri, Feb 22, 2019 at 09:43:43PM +0200, Aaro Koskinen wrote:
>> Mini-PC does not have any EC. PMON is:
>> Version: PMON2000 2.1 (Bonito) #121: Mon Jan  5 14:19:11 CST 2009.

Check "env" variables in PMON shell. There night be some information 
such as version or build date.

> On Fri, Feb 22, 2019 at 05:22:15PM -0300, Alexandre Oliva wrote:
>> I don't have the PMON or EC versions in /proc/cmdline.  machtype is the same.
>> 'vers' in the pmon text prompt responds: PMON2000 2.1 (Bonito) #291
> Okay, so the problem is presented on both Yeeloong laptops and MiniPCs, and
> it seems both you are running some old PMON versions. The new PMON should
> report the PMON and/or EC versions versions in /proc/cmdline.
>
> The version I'm using is
>> PMON: PMON2000 2.1 (Bonito) #7: 2010-08-31 01:26:26 (LM8089-1.4.9a)
> I'll attempt to reproduce and investigate the problem after finishing the
> initial pushes of Yeeloong platform drivers.
>
> However, there are some difficulties.
>
> * I don't have the MiniPC. Loongson 2F hardware is now completely unsupported,
> and almost impossible to purchase one.

I have a Lemote Fuloong mini-pc, I can help with testing if you need.

The latest PMON of MiniPC is 
https://mirrors.ustc.edu.cn/loongson/install/pmon-LM60xx-1.3.6a.bin

Tested on my Fuloong 6003.

>
> * Early PMON source was not released under a version-control system, and now it's
> difficult to find both the source code and the binary for those earlier versions.

https://github.com/kisom/pmon

That's the earliest PMON source I can find.

>
> * PMON upgrading is notoriously unreliable, unless the binary image is completely
> tested by someone with the identical setup, the result is likely a bricked machine.
> I don't recommend you to upgrade the firmware, unless you've got the on-field support
> of hardware hackers with soldering equipment and a EEPROM programmer.
PMON is stored on a LPC Bus flash, for most models, the chip is placed 
on a solt so we can replace it easily. Purchase some extra chip should 
be enough.
>
> I'll try asking online if anyone still has the old hardware lying around, and
> check the corpse of those dead and buried threads posted on the Chinese fourm
> ten years ago, to see if there's still some binary images.

You can call Liu Shiwei <liushiwei@gmail.com> for help, he is familiar 
with these old Loongson-2F hardware.

>
> Thanks,
> Tom Li

-- 
--
Jiaxun Yang

