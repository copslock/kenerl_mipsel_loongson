Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2011 21:54:29 +0100 (CET)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:43683 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903762Ab1LUUyZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Dec 2011 21:54:25 +0100
Received: by lahc1 with SMTP id c1so6027608lah.36
        for <linux-mips@linux-mips.org>; Wed, 21 Dec 2011 12:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:date:in-reply-to:references
         :content-type:x-mailer:content-transfer-encoding:message-id
         :mime-version;
        bh=vvU7IdbwU18tlrQWMKIBXYChO5DWD4fsZfTH7ur7hdA=;
        b=pBSEgYM3JbbWJkpltHl1ER8ut6u1CkKCDgpMyCObnMU1V9O9RXDPS6rIb9aGUny6vI
         JsOGsCoKaAGsVVpHUOVzIEhb4ZS4UOMYJgCPnMJciPayC37QsyPoy/iWG0i1rTKG13EK
         SQYWDWZwNysFMfKmp+Yw2h5cvLUwUilzK2j/w=
Received: by 10.152.134.50 with SMTP id ph18mr7207784lab.1.1324500859973;
        Wed, 21 Dec 2011 12:54:19 -0800 (PST)
Received: from [192.168.255.2] (host-94-101-1-70.igua.fi. [94.101.1.70])
        by mx.google.com with ESMTPS id pi7sm5438310lab.5.2011.12.21.12.54.16
        (version=SSLv3 cipher=OTHER);
        Wed, 21 Dec 2011 12:54:18 -0800 (PST)
Subject: Re: [PATCH V2 2/5] MTD: bcm63xxpart: make sure CFE and NVRAM
 partitions are at least 64K
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>
Date:   Wed, 21 Dec 2011 22:54:13 +0200
In-Reply-To: <1324290964-14096-1-git-send-email-jonas.gorski@gmail.com>
References: <1324208821.17534.0.camel@sauron.fi.intel.com>
         <1324290964-14096-1-git-send-email-jonas.gorski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Content-Transfer-Encoding: 7bit
Message-ID: <1324500858.2110.1.camel@koala>
Mime-Version: 1.0
X-archive-position: 32151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17466

On Mon, 2011-12-19 at 11:36 +0100, Jonas Gorski wrote:
> The CFE boot loader on BCM63XX platforms assumes itself and the NVRAM
> partition to be 64 KiB (or erase block sized, if larger).
> Ensure this assumption is also met when creating the partitions to
> prevent accidential erasure of CFE or NVRAM.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Updated, thanks!
