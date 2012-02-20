Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2012 20:07:52 +0100 (CET)
Received: from forward10.mail.yandex.net ([77.88.61.49]:47681 "EHLO
        forward10.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903565Ab2BTTHp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2012 20:07:45 +0100
Received: from smtp8.mail.yandex.net (smtp8.mail.yandex.net [77.88.61.54])
        by forward10.mail.yandex.net (Yandex) with ESMTP id DD4C11020EE9;
        Mon, 20 Feb 2012 23:07:23 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1329764843; bh=U/R5XbpG3r+JHUnzPXx1zuYexHX9mG3NbKVCkQ9QlHA=;
        h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type:
         Content-Transfer-Encoding;
        b=Fjrdp05POiwf1MESqOjeGN9bx0BTp/IG0GYy1vNirih1AY37mz9pygDhVrocN6JxW
         vu74CkpAaqJheetD+fkN/dH7IA310J/xEwKSPSuZObXvWqWptCWTxjnaZJebFLwjK+
         CPSj82lV90+Swl+ms65doxoG76F2PQSrqxfPKcF8=
Received: from smtp8.mail.yandex.net (localhost [127.0.0.1])
        by smtp8.mail.yandex.net (Yandex) with ESMTP id B7E3B1B604C7;
        Mon, 20 Feb 2012 23:07:23 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1329764843; bh=U/R5XbpG3r+JHUnzPXx1zuYexHX9mG3NbKVCkQ9QlHA=;
        h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type:
         Content-Transfer-Encoding;
        b=Fjrdp05POiwf1MESqOjeGN9bx0BTp/IG0GYy1vNirih1AY37mz9pygDhVrocN6JxW
         vu74CkpAaqJheetD+fkN/dH7IA310J/xEwKSPSuZObXvWqWptCWTxjnaZJebFLwjK+
         CPSj82lV90+Swl+ms65doxoG76F2PQSrqxfPKcF8=
Received: from unknown (unknown [94.242.50.174])
        by smtp8.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 7Neq0pmo-7NeqalPf;
        Mon, 20 Feb 2012 23:07:23 +0400
X-Yandex-Spam: 1
Message-ID: <4F429B4C.9070600@yandex.ru>
Date:   Mon, 20 Feb 2012 23:13:16 +0400
From:   Nikolai Zhubr <n-a-zhubr@yandex.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
MIME-Version: 1.0
To:     OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        linux-mips@linux-mips.org
Subject: kexec on mips
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n-a-zhubr@yandex.ru
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello all,

I'm running both openwrt and debian on a mips-based wndr3800 netgear 
router/ap and I'm using kexec to arrange kind of dual-boot in a safe and 
comfortable manner.

Now, I've found that the following is critical for kexec to actually work:
--- arch/mips/kernel/machine_kexec.c.orig       2012-02-08 
01:58:13.000000000 +0300
+++ arch/mips/kernel/machine_kexec.c    2012-02-20 22:19:11.000000000 +0300
@@ -52,7 +52,7 @@
         reboot_code_buffer =
           (unsigned long)page_address(image->control_code_page);

-       kexec_start_address = image->start;
+       kexec_start_address = (unsigned long) phys_to_virt(image->start);
         kexec_indirection_page =
                 (unsigned long) phys_to_virt(image->head & PAGE_MASK);

I've found that in openwrt repository this change was present (among 
others) in a big patchset targeted for kernel 2.6.30 and now it is still 
present as a small separate patch for 2.6.38 
(target/linux/generic/patches-2.6.38/303-mips_fix_kexec.patch) and maybe 
others. Meanwhile, the latest _stable_ openwrt for the moment (backfire 
10.03.1) was released with kernel 2.6.32 without this patch so I had to 
dig through some forums to find the reason of kexec not working 
out-of-the-box. I've just now checked and the latest kernel.org's stable 
kernel (3.2.6) does not seem to include this either. Ok, since I know 
the secret already I'll fix it for myself anytime, but maybe some kind 
soul could just submit this _one_ line upstream? I'd say this feature is 
really handy in some cases.

Thank you.

(Please CC me, I'm not subscribed to linux-mips)

Nikolai
