Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 22:34:14 +0100 (CET)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:58066 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903702Ab1LQVeL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Dec 2011 22:34:11 +0100
Received: by lahc1 with SMTP id c1so2848566lah.36
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 13:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:date:in-reply-to:references
         :content-type:x-mailer:content-transfer-encoding:message-id
         :mime-version;
        bh=a9k7O5a7YT2N4ciHkWrtUzDK/JcFBYQHMdCvWw3Bqqs=;
        b=PT0RJ792wUfkrhfKfczxRbBGOYv3V+wfVJNaFgOC9TSQCzDrMMW8R9ModfkP6vXmWX
         DEhzFG7Emb2xCkpCumxOJbqrfG018KyBf2ivAXGS9CCtaR48QbGVAtPzkol/X6/ZENhx
         5iDTZXIr4vJvnYAF96CPOqEVKeYN0fuDbTBRw=
Received: by 10.152.108.239 with SMTP id hn15mr11955236lab.44.1324157645099;
        Sat, 17 Dec 2011 13:34:05 -0800 (PST)
Received: from [192.168.255.2] (host-94-101-1-70.igua.fi. [94.101.1.70])
        by mx.google.com with ESMTPS id ng10sm12198526lab.13.2011.12.17.13.34.01
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 13:34:04 -0800 (PST)
Subject: Re: [PATCH 2/5] MTD: bcm63xxpart: make sure CFE and NVRAM
 partitions are at least 64K
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>
Date:   Sat, 17 Dec 2011 23:33:58 +0200
In-Reply-To: <1324126698-9919-3-git-send-email-jonas.gorski@gmail.com>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
         <1324126698-9919-3-git-send-email-jonas.gorski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Content-Transfer-Encoding: 7bit
Message-ID: <1324157643.2240.2.camel@koala>
Mime-Version: 1.0
X-archive-position: 32125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14225

On Sat, 2011-12-17 at 13:58 +0100, Jonas Gorski wrote:
> The CFE and NVRAM are always at least 64K big, so make sure their
> partitions are never smaller than this in case the flash has smaller
> erase sectors.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Not that I have any knowledge about BCM platform, but still, I think
it is good idea to explain why these partitions have to be at least
64KiB. Could you please do this, just for the sake of having good
commit messages?

Artem.
