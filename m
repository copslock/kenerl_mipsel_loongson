Return-Path: <SRS0=1Pqs=Q6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396D7C43381
	for <linux-mips@archiver.kernel.org>; Sat, 23 Feb 2019 01:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31D12077B
	for <linux-mips@archiver.kernel.org>; Sat, 23 Feb 2019 01:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="i1iFQtN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfBWB5D (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:57:03 -0500
Received: from tomli.me ([153.92.126.73]:38372 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBWB5D (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 22 Feb 2019 20:57:03 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 8afa3a1b;
        Sat, 23 Feb 2019 01:57:00 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:3d30:359c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 23 Feb 2019 01:57:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=yZ4NcNqFPTLdiHYo2oEJdYRZoejinIuV9KRikLNJSco=; b=i1iFQtN4plosB0gxqp4qGFl53eDfUAsH5yRrXBaeAUnO4L8vuOrzgeufaI/8hFItWlDHDRO8iem1jSgwIAMCtGDEfP8zaSYS0XbOCqvLLEMUIB8++meeHtUtl6K2dc+XsWGuP/T4zKUtyK3BXll5M1Dvr4GjN1/5UoTF3a/xZU6NEO7auUdBqGbIj7gK1Ulfv6g9PwIUMwi289RoVbesfUnlPTCxStDEg3Ct1KECxeXg1Yzn08En01d9pZXKf9XB2vPN3rPNM6j8oL10sSr3itn0yN5Q1VevLe3kpzEdQK3cZtJK+ynihewsfs62tUTWysWENWl5Zx9JJoVBuwA2cA==
Date:   Sat, 23 Feb 2019 09:56:51 +0800
From:   Tom Li <tomli@tomli.me>
To:     Alexandre Oliva <lxoliva@fsfla.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        Tom Li <tomli@tomli.me>
Subject: Re: CS5536 Spurious Interrupt Problem on Loongson2
Message-ID: <20190223015650.GA8616@localhost.localdomain>
References: <ora7in8tfs.fsf@lxoliva.fsfla.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ora7in8tfs.fsf@lxoliva.fsfla.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Feb 22, 2019 at 09:43:43PM +0200, Aaro Koskinen wrote:
> Mini-PC does not have any EC. PMON is:
> Version: PMON2000 2.1 (Bonito) #121: Mon Jan  5 14:19:11 CST 2009.

On Fri, Feb 22, 2019 at 05:22:15PM -0300, Alexandre Oliva wrote:
> I don't have the PMON or EC versions in /proc/cmdline.  machtype is the same.
> 'vers' in the pmon text prompt responds: PMON2000 2.1 (Bonito) #291

Okay, so the problem is presented on both Yeeloong laptops and MiniPCs, and
it seems both you are running some old PMON versions. The new PMON should
report the PMON and/or EC versions versions in /proc/cmdline. 

The version I'm using is
> PMON: PMON2000 2.1 (Bonito) #7: 2010-08-31 01:26:26 (LM8089-1.4.9a)

I'll attempt to reproduce and investigate the problem after finishing the
initial pushes of Yeeloong platform drivers.

However, there are some difficulties.

* I don't have the MiniPC. Loongson 2F hardware is now completely unsupported,
and almost impossible to purchase one.

* Early PMON source was not released under a version-control system, and now it's
difficult to find both the source code and the binary for those earlier versions.

* PMON upgrading is notoriously unreliable, unless the binary image is completely
tested by someone with the identical setup, the result is likely a bricked machine.
I don't recommend you to upgrade the firmware, unless you've got the on-field support
of hardware hackers with soldering equipment and a EEPROM programmer.

I'll try asking online if anyone still has the old hardware lying around, and
check the corpse of those dead and buried threads posted on the Chinese fourm
ten years ago, to see if there's still some binary images.

Thanks,
Tom Li
