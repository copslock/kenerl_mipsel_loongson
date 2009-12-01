Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 00:05:20 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:35280 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493350AbZLAXFP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 00:05:15 +0100
Received: by ewy23 with SMTP id 23so2951100ewy.24
        for <multiple recipients>; Tue, 01 Dec 2009 15:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=7LlNs2nqT4RE1ESpQ8iuYDgr+4QM6+Bb9ftDmpGnwk8=;
        b=L6ccUC+EFj91K57gUfSplyKFwzHKTxNPpL2OXcHqfIE/1T3Dn7ryVYojWxYXcVXp9f
         tTupMkK98kv+rd+IbttkFif2hh4mMqn+3ftve0fZnPBeaZe5DUTZVV8ON0YSrmOmTUpc
         Cv0YTpEiC2APTSBi453VafQd7mxhttnPbNspY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=P7hLvXT6+YEG465KNRlFPnKq+EOo4jIQV76wnaetu/tzwANEa4rLB0nHRI+AyG9eyi
         G8uj6jjlzbF6pQURgvUlu4IBBmPCQfnbRRm+oQWFAktQK6zyy5g3OWySP6LfyBfZM81j
         d15FwnF8vkTrUjrXUXFSLW7ggWlCk7lwesWdo=
Received: by 10.213.103.9 with SMTP id i9mr6845747ebo.16.1259708709359;
        Tue, 01 Dec 2009 15:05:09 -0800 (PST)
Received: from lenovo.localnet (florian.mimichou.net [88.178.11.95])
        by mx.google.com with ESMTPS id 13sm371667ewy.5.2009.12.01.15.05.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 15:05:07 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     Hector Martin <hector@marcansoft.com>
Subject: Re: BCM63xx merge progress
Date:   Wed, 2 Dec 2009 00:05:06 +0100
User-Agent: KMail/1.12.1 (Linux/2.6.30-2-686; KDE/4.3.2; i686; ; )
Cc:     Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
References: <4B15974E.1060505@marcansoft.com>
In-Reply-To: <4B15974E.1060505@marcansoft.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200912020005.07407.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello Hector,

Le mardi 1 décembre 2009 23:23:10, Hector Martin a écrit :
> Hello, Maxime and Florian,
> 
> I saw that partial BCM63xx support has been merged into mainline. As I
> am interested in developing a driver for this platform, I would like to
> inquire as to the state of the remaining bits to merge. As it stands
> now, the code merged into mainline is rather broken and incomplete.
> 
> I'll be happy to grab the code myself and get the patches in proper
> merging order for mainline if nobody else is working / has time for it
> at the moment, so I'm asking first.

Everything that Maxime sent is, or will be merged either in 2.6.32 or in 
2.6.33, that includes:
- arch/mips/bcm63xx (will be in 2.6.32)
- USB driver bits (2.6.33)
- Ethernet MAC driver bits (2.6.32)
- Ethernet PHY driver bits (2.6.32)
- UART driver (2.6.32)
- PCMCIA support (2.6.32)

> 
> I have a BCM63xx router and will be testing whatever I work on, both
> compiling and running. My current reference is the OpenWRT patchset,
> which is against an older kernel but seems to be working pretty well on
> the actual hardware. I've also seen the linux-bcm63xx.git tree. Between
> these I should be able to put together a decent set of commits that
> cleanly apply onto current mainline.

We maintain a couple of different patches for OpenWrt, specifically the mtd 
partition parser since we provide images, so the box should boot from Flash. 
That driver is not in a mergable state at the moment. There is also a embryon 
of a SPI driver and a watchdog driver, which I will probably submit once 
cleaned up.

> 
> Please let me know what your thoughts are, and whether I should proceed
> and work on this myself or whether you have other plans.
> 

My plans are currently to maintain the bcm63xx board code and drivers in a 
working state for the community, probably not much.
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
