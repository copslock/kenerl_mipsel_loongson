Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2011 15:49:06 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:39500 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491876Ab1IUNtA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Sep 2011 15:49:00 +0200
Received: by wyi11 with SMTP id 11so258135wyi.36
        for <multiple recipients>; Wed, 21 Sep 2011 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=K5eSXn1MamefEWVUzkH/PM2GDjj7ujnMGo+gQK9L4ss=;
        b=j3MLyWeCSnjmHb8R0bMtUiw1f0K3nN4CcOAq/A/JZUsYwGJQiUn7J5UE8J15LJG08q
         thWUju9ZUxTWd8Q+ITLpq5JZuQXdQuDWjvFLGEsffgzipdiG5Nwh4GbOu40k9G+gUSwI
         ny3JkCXnFxNwAAIG3qEYc6ToBVHrP78CO+AzY=
Received: by 10.227.135.141 with SMTP id n13mr715124wbt.53.1316612934616;
        Wed, 21 Sep 2011 06:48:54 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net. [213.228.1.121])
        by mx.google.com with ESMTPS id l18sm3258085wbo.23.2011.09.21.06.48.52
        (version=SSLv3 cipher=OTHER);
        Wed, 21 Sep 2011 06:48:53 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     ralf@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS: introduce GENERIC_DUMP_TLB
Date:   Wed, 21 Sep 2011 15:48:28 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-11-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org
References: <1316612390-6367-1-git-send-email-florian@openwrt.org> <1316612390-6367-2-git-send-email-florian@openwrt.org>
In-Reply-To: <1316612390-6367-2-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201109211548.28440.florian@openwrt.org>
X-archive-position: 31123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11665

Ralf,

On Wednesday 21 September 2011 15:39:44 Florian Fainelli wrote:
> Allows us not to duplicate more lines in arch/mips/lib/Makefile.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

I did not meant to resend this 3-series patch with the BCM6345 5 patches, 
sorry for the noise.
-- 
Florian
