Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Sep 2010 15:28:16 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1490951Ab0ION2M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Sep 2010 15:28:12 +0200
Date:   Wed, 15 Sep 2010 15:28:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     wuzhangjin@gmail.com,
        Waldemar Brodkorb <mail@waldemar-brodkorb.de>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: zboot for brcm
Message-ID: <20100915132811.GA6704@linux-mips.org>
References: <20100609153831.GA27461@waldemar-brodkorb.de>
 <201006171438.15832.florian@openwrt.org>
 <1276781479.4271.8.camel@localhost>
 <201009121913.29339.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201009121913.29339.florian@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11783

On Sun, Sep 12, 2010 at 07:13:28PM +0200, Florian Fainelli wrote:

Be careful with the firmware.  On Sibyte systems Linux queries the firmware
for available memory ranges.  The memory ranges are based on the sizes of
the sizes of the ELF file as loaded.  That means after decompression it
is possible that the kernel will treat some memory as free even though it
it is actually used.  Due to various other circumstances this does not
actually hit all systems.

  Ralf
