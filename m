Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 21:00:42 +0200 (CEST)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:58876 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491065Ab1FLTAh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 21:00:37 +0200
Received: by wwi18 with SMTP id 18so2043367wwi.0
        for <multiple recipients>; Sun, 12 Jun 2011 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=L8s88egjbnhn3SkPLUf3vlEd5+dT1yNS4bEJu/nz9Hc=;
        b=T8bzlqIPgElLKM8xC2jBFfvQLqSTGR61jMJ6uUy/YnN8HdRnW0H+tA8aAswFHfDx9D
         6YGYLMNHE7goWZ3CmvbkJgHWUH9ebPj9NTUveSLs0ssdNS0U/jCAL7V45KoPTRSdFlWZ
         V5UipILfP4BndfarV4xM4jjwRPXkbykmbSnvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=OSgZKAsE/dF74/WeEWXuWKZpGOfWxhWd+h5oJalNULGKv1bO+0mnVuzGuhSt3pCo/v
         74lIK3u+82Hr5mMhN/s9lmzW3i+7CGjLBcolMTWXSLQbw6b8Mn79XwJzBlZNJ6dU5R3d
         YMtc7WhtAJLRsvWkPTdFND+KDIxDXsxdjEQlY=
Received: by 10.216.253.215 with SMTP id f65mr4242268wes.14.1307905232161;
        Sun, 12 Jun 2011 12:00:32 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id g2sm2500598weg.14.2011.06.12.12.00.30
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 12:00:30 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] MIPS: ar7: use linux/time.h instead of asm/time.h
Date:   Sun, 12 Jun 2011 21:00:29 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Cc:     ralf@linux-mips.org
References: <1307905041-18391-1-git-send-email-florian@openwrt.org> <1307905041-18391-5-git-send-email-florian@openwrt.org>
In-Reply-To: <1307905041-18391-5-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106122100.29385.florian@openwrt.org>
X-archive-position: 30361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10222

On Sunday 12 June 2011 20:57:21 Florian Fainelli wrote:
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/ar7/time.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

And this one too is causing a build failure, sorry about that.
-- 
Florian
