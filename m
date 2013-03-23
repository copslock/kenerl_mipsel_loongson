Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 14:39:48 +0100 (CET)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:47899 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827575Ab3CWNjrosjzt convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 14:39:47 +0100
Received: by mail-wg0-f45.google.com with SMTP id dq12so63702wgb.24
        for <linux-mips@linux-mips.org>; Sat, 23 Mar 2013 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=D20KaMfTKgEXKkou8N5Zm5TYIhWFfc0n/LSisfyexfs=;
        b=U0I9GEQV1cnfLj/P+KJETEEj22GpnatQ4HfklndoJogohCEVnvE9DA9g/ldy85i9dX
         a0BrtntqbZTU4Z0eahbMdKnYKsFpQ9Sa5LMZVsjcQScH0t6kze46b4W2ytdWjKQzOqAR
         sznAMFratZzdNkLWL/tG54vAQyjTOPwwcmrOLn1a51qyGGMfIdncKzEopj1/+ormJA6N
         vIA0pYBn2ptcGg3+ROOiE/DHQFmhu91s+FQY1GRHXiSfN3rSzsftmKP251UCLq2UTb98
         78BG/ptCGnUtwTnq9UmxwLldiBJ7aqTM6R9euA47z33KErdsPOT7tQ6hffBg95ZUHQgV
         FGgw==
X-Received: by 10.194.170.165 with SMTP id an5mr8707153wjc.41.1364045982466;
        Sat, 23 Mar 2013 06:39:42 -0700 (PDT)
Received: from lenovo.localnet ([2a01:e35:2f70:4010:21d:7dff:fe45:5399])
        by mx.google.com with ESMTPS id bj9sm16765650wib.4.2013.03.23.06.39.40
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Mar 2013 06:39:41 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH 0/3] fix NVRAM partition size if larger than expected
Date:   Sat, 23 Mar 2013 14:39:38 +0100
User-Agent: KMail/1.13.7 (Linux/3.7-trunk-amd64; KDE/4.8.4; x86_64; ; )
Cc:     linux-mtd@lists.infradead.org,
        Artem Bityutskiy <dedekind1@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
References: <1364044070-10486-1-git-send-email-jogo@openwrt.org>
In-Reply-To: <1364044070-10486-1-git-send-email-jogo@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201303231439.39168.florian@openwrt.org>
X-archive-position: 35950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Le samedi 23 mars 2013 14:07:46, Jonas Gorski a écrit :
> Some device vendors use a larger nvram size than expected. While Broadcom
> has defined it as 64K max, devices with 128K have been seen in the wild.
> Luckily they properly set the nvram's PSI size to the correct value, so
> we can use that to size the nvram partion.
> 
> Yes it's a bit confusing as there are two nvrams, one with a fixed layout
> with in the bootloader, with the size information about the other.
> 
> Since 2 of 3 patches are for the mtd tree, this patchset should go there
> (but it applies to both l2-mtd and mips-next fine).

Besides the minor nitpicks from patch 2, this serie looks good:

Acked-by: Florian Fainelli <florian@openwrt.org>

Thanks!
-- 
Florian
