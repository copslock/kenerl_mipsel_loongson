Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Oct 2010 18:59:19 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:45293 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491132Ab0JQQ7Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Oct 2010 18:59:16 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 7ABB112AF9C;
        Sun, 17 Oct 2010 18:59:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JbzjNApt7cMs; Sun, 17 Oct 2010 18:59:15 +0200 (CEST)
Received: from lenovo.localnet (gob75-6-82-236-225-16.fbx.proxad.net [82.236.225.16])
        by zmc.proxad.net (Postfix) with ESMTPSA id 1EF5C12AF99;
        Sun, 17 Oct 2010 18:59:15 +0200 (CEST)
From:   Florian Fainelli <ffainelli@freebox.fr>
Organization: Freebox
To:     Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 1/9] MIPS: Decouple BMIPS CPU support from bcm47xx/bcm63xx SoC code
Date:   Sun, 17 Oct 2010 18:59:43 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.36-rc6-amd64; KDE/4.4.5; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>, mbizon@freebox.fr,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
In-Reply-To: <17ebecce124618ddf83ec6fe8e526f93@localhost>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <201010171859.44942.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips

Hello Kevin,

Le Saturday 16 October 2010 23:22:30, Kevin Cernekee a écrit :
> BMIPS processor cores are used in 50+ different chipsets spread across
> 5+ product lines.  In many cases the chipsets do not share the same
> peripheral register layouts, the same register blocks, the same
> interrupt controllers, the same memory maps, or much of anything else.
> 
> But, across radically different SoCs that share nothing more than the
> same BMIPS CPU, a few things are still mostly constant:
> 
> SMP operations
> Access to performance counters
> DMA cache coherency quirks
> Cache and memory bus configuration
> 
> So, it makes sense to treat each BMIPS processor type as a generic
> "building block," rather than tying it to a specific SoC.  This makes it
> easier to support a large number of BMIPS-based chipsets without
> unnecessary duplication of code, and provides the infrastructure needed
> to support BMIPS-proprietary features.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

I boot tested all of your nine patches on a BCM6348 system without problems.

Tested-by: Florian Fainelli <ffainelli@freebox.fr>
--
Florian
