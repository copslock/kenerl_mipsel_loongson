Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 22:40:45 +0100 (CET)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:49964 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903702Ab1LQVkm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Dec 2011 22:40:42 +0100
Received: by lahc1 with SMTP id c1so2850098lah.36
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 13:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:date:in-reply-to:references
         :content-type:x-mailer:content-transfer-encoding:message-id
         :mime-version;
        bh=P4cVmkVA/23wvCvcMiAhHWzqraEdkYx3VDBQvJR0MTw=;
        b=LbRHFAXkqo1dLCuILeA7D7AJlyHg9tFf122hU5erJ4QdZoZM2MBpQqVyxiKP9bNP/s
         9d1cDhFUnQ39Ly0swlVYamx0BarkatE2iP0eZD/2Ra8llU9gFuTQSbMAQYdD3od7s17w
         IE2uo12BUoFgP+UG8G3PbtTqI9nfbGZWVSUcQ=
Received: by 10.152.113.101 with SMTP id ix5mr3481350lab.16.1324158036583;
        Sat, 17 Dec 2011 13:40:36 -0800 (PST)
Received: from [192.168.255.2] (host-94-101-1-70.igua.fi. [94.101.1.70])
        by mx.google.com with ESMTPS id on4sm413177lab.7.2011.12.17.13.40.32
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 13:40:35 -0800 (PST)
Subject: Re: [PATCH 0/5] MTD: bcm63xxpart: improve robustness
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>
Date:   Sat, 17 Dec 2011 23:40:30 +0200
In-Reply-To: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Content-Transfer-Encoding: 7bit
Message-ID: <1324158035.2240.5.camel@koala>
Mime-Version: 1.0
X-archive-position: 32126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14230

On Sat, 2011-12-17 at 13:58 +0100, Jonas Gorski wrote:
> This patchset aims at improving the robustness of the CFE detection and
> image tag validation and parsing.
> 
> The image tag parsing improvement is especially useful when booting a
> ramdisk image through tftp, since there is no guarantee that the image
> on the flash is valid at this point.
> 
> As usual this patchset should got through the MTD tree and is based on
> the l2-mtd-2.6 git.

Looks good except of the "explain 64KiB" nit-pick. Pushing to
l2-mtd-2.6.git, but I'll take the improved version of patch 2.

Artem.
