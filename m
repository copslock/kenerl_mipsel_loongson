Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 23:23:32 +0100 (CET)
Received: from marcansoft.com ([80.68.93.119]:41201 "EHLO smtp.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493429AbZLAWX3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 23:23:29 +0100
Received: from [192.168.3.171] (141.Red-80-39-252.dynamicIP.rima-tde.net [80.39.252.141])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.marcansoft.com (Postfix) with ESMTPSA id 0E12E1E806D;
        Tue,  1 Dec 2009 23:23:19 +0100 (CET)
Message-ID: <4B15974E.1060505@marcansoft.com>
Date:   Tue, 01 Dec 2009 23:23:10 +0100
From:   Hector Martin <hector@marcansoft.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20091005)
MIME-Version: 1.0
To:     Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: BCM63xx merge progress
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hector@marcansoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hector@marcansoft.com
Precedence: bulk
X-list: linux-mips

Hello, Maxime and Florian,

I saw that partial BCM63xx support has been merged into mainline. As I
am interested in developing a driver for this platform, I would like to
inquire as to the state of the remaining bits to merge. As it stands
now, the code merged into mainline is rather broken and incomplete.

I'll be happy to grab the code myself and get the patches in proper
merging order for mainline if nobody else is working / has time for it
at the moment, so I'm asking first.

I have a BCM63xx router and will be testing whatever I work on, both
compiling and running. My current reference is the OpenWRT patchset,
which is against an older kernel but seems to be working pretty well on
the actual hardware. I've also seen the linux-bcm63xx.git tree. Between
these I should be able to put together a decent set of commits that
cleanly apply onto current mainline.

Please let me know what your thoughts are, and whether I should proceed
and work on this myself or whether you have other plans.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
