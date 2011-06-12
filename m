Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 21:00:11 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:33671 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491058Ab1FLTAG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 21:00:06 +0200
Received: by wwb17 with SMTP id 17so3532261wwb.24
        for <multiple recipients>; Sun, 12 Jun 2011 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=zaXZd9SDiGLGtob7WIi9M6TS55mphz5KsoY2ki3xwzU=;
        b=uqcB/1SOhC/yyOKs8ceI85xhNtnJLczCaOYPo9IdirW5eMNVH1UM1kIC3uCQ89dakG
         bU3UYAW6xeh3bLajL/30PTriDLbl/Zgb61KtbbM2k8UxXB4IcljnOotvcBAvVG+XvIQ6
         tOSM0tyx6KgOLf8lEGGwi/o8Wiq0qgiZUBAGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=xURVS0Lpcuid2SLZeOsoIaBT6xjonkaZItEapkRvfsYxe++nk17QjNb150+UL+QWSD
         tOLlJCEykPuGQHN94YMoKnP9AQPyuZTScZtW0AmQMoJajMC/49phYPbx8vCH9WELOvJy
         eD3VNniiYgAygzbvNzsMRbO/B90lWvnmJaC3E=
Received: by 10.227.91.81 with SMTP id l17mr4438294wbm.29.1307905201170;
        Sun, 12 Jun 2011 12:00:01 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id fl19sm3676630wbb.15.2011.06.12.11.59.59
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 12:00:00 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] MIPS: ar7: use linux/reboot.h instead of asm/reboot.h
Date:   Sun, 12 Jun 2011 20:59:57 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Cc:     ralf@linux-mips.org
References: <1307905041-18391-1-git-send-email-florian@openwrt.org> <1307905041-18391-4-git-send-email-florian@openwrt.org>
In-Reply-To: <1307905041-18391-4-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106122059.57909.florian@openwrt.org>
X-archive-position: 30360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10221

On Sunday 12 June 2011 20:57:20 Florian Fainelli wrote:
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/ar7/setup.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Ralf, please discard this one, it's causing a build failure.
-- 
Florian
