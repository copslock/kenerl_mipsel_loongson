Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 14:05:22 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:59076 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491839Ab0CCNFR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 14:05:17 +0100
Received: by ewy23 with SMTP id 23so817987ewy.24
        for <linux-mips@linux-mips.org>; Wed, 03 Mar 2010 05:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=GO8laIMURquqoWTWYTvsWaGIGytqK2JxPTyUZ7gmqwo=;
        b=wvkhY3+ubCMuYF4alqbHwOjSihVxIV730lOK2BTbbtlmrpnqfmQaRn44T8dWEvItbv
         7B9Y/WUEhLEpepbB/A4IIWSEW/0JmxdskRcjsypGb7Mx9NNdQiZUNLFLtymt8AkCc/wK
         tropTKOJEw4t5XpU4mm85YG55okxFevxnev/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=ks4I7y6hzOCPK8towkV0WCciTpZ412wUQc0EUMMlEgsUt3fhUaCvfKxh0zbYEtQ0dJ
         o7pGVC/Ask3F5gPqOIL2M9pwCY20dTBU+YrJZ1Bw/gdQFsJsCf7rLQd6S5e+lRG5NVcA
         tvXHnrAuwdTgfj2gCye48ByxW80NKmRQnpnXg=
Received: by 10.213.96.198 with SMTP id i6mr5974126ebn.45.1267621511113;
        Wed, 03 Mar 2010 05:05:11 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 7sm16795662eyb.33.2010.03.03.05.05.09
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 05:05:10 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     "Dea_RU" <dryukovz@mail.ru>
Subject: Re: TI AR7 7200 - no boot
Date:   Wed, 3 Mar 2010 14:04:52 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-server; KDE/4.3.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org
References: <27766331.post@talk.nabble.com> <27766728.post@talk.nabble.com> <27767861.post@talk.nabble.com>
In-Reply-To: <27767861.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201003031404.53039.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

On Wednesday 03 March 2010 13:58:48 Dea_RU wrote:
> i adder printk(...) before all function in kernel init funktion
>  /init/main.c
> 
> log show last message before called fundtion  local_irq_enable().
> 
> If delete my debug printk-s kernel stop after first console output
> "Calibrating delay loop... "
> 
> I do not MIPS arch interput specific ..... Can be MIPS need init internel
> timer and link overflow flag to interput ??

All handlers are not correctly setup, so you should include this patch in your 
tree:

http://www.linux-mips.org/archives/linux-mips/2010-01/msg00019.html

> 
> 
> ------ log with added printk ----
> ......
> Memory: 13172k/16384k available (1314k kernel code, 3212k reserved, 411k
> data, 120k init, 0k highmem)
> early_irq_init
> NR_IRQS:256 <- kernel
> init_IRQ
> prio_tree_init
> init_timers
> hrtimers_init
> softirq_init
> timerkepping_init
> time init
> profile_init
> early_boot_irqs_on
> local_irq_enable <- last my debug printk message before call to
> local_irq_enable()
> -------------------------------
> 

-- 
Regards, Florian
