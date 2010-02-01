Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 09:52:03 +0100 (CET)
Received: from mail-ew0-f209.google.com ([209.85.219.209]:42326 "EHLO
        mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491929Ab0BAIwA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 09:52:00 +0100
Received: by ewy1 with SMTP id 1so899799ewy.26
        for <linux-mips@linux-mips.org>; Mon, 01 Feb 2010 00:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=M0DqParK0kgfzBaPKu4J832ECEtSE9PCeCem025Ykuo=;
        b=FSSIOM+OdDde8Ru2UsoAKW0++xNHVU7cQq1V2bApoDp/Zv8B+O0H+mBu0wkEpjhstb
         xGtAcXWMTmGtQvG2O6bE3k1tbCD17Sa6ExVnsLbLEI0s1+rViVlYrQ+K4MHnN22KdkX0
         25Gz2K8OLam1gaMqxw9gunlfammLFlJgfX1uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=Vjut6yNUvlwEb6l42fMUmaive3JdeTcirz4yV1ifRi3fj7qxAi/5pBMNqpG5stwSxX
         1lmLXYEcKobkCGKucugF6dEZGlLvaWMMrpHiJAOhhQZlVxU5/1QoZeZ6j05ldrUEkyzM
         ZMJvFpgRvkW6ouDhlMJMHNzB4hizcQ8oiHbXs=
Received: by 10.213.109.205 with SMTP id k13mr1754126ebp.44.1265014314505;
        Mon, 01 Feb 2010 00:51:54 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 15sm3488593ewy.12.2010.02.01.00.51.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 00:51:53 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 0/3] AR7 cleanups and fixes
Date:   Mon, 1 Feb 2010 09:51:27 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-server; KDE/4.3.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org
References: <0p2h37-ch6.ln1@chipmunk.wormnet.eu>
In-Reply-To: <0p2h37-ch6.ln1@chipmunk.wormnet.eu>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201002010951.27270.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Alexander,

On Sunday 31 January 2010 20:37:36 Alexander Clouter wrote:
> A number of patches I have already run by Florian Fainelli and now that
> the GPIO[1] and CLK[2] patches are in, I can submit my generic AR7
> cleanup and fixup patches:
>  1. whitespace cleanups
>  2. fix usb slave mem range mistype
>  3. make ar7_register_devices much more durable
> 
> So these patches should apply to the linux-queue...hopefully.

Feel free to add my Acked-by, on those 3 patches once you addresses Wu's 
comments. Thank you.
-- 
Regards, Florian
