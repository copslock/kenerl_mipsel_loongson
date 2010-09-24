Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2010 13:29:26 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491012Ab0IXL3W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Sep 2010 13:29:22 +0200
Date:   Fri, 24 Sep 2010 12:29:21 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Which Linux driver (source code) is used for tty0 (console) on
 MALTA?
Message-ID: <20100924112921.GA17964@linux-mips.org>
References: <AEA634773855ED4CAD999FBB1A66D07601113E58@CORPEXCH1.na.ads.idt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D07601113E58@CORPEXCH1.na.ads.idt.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19201

On Wed, Sep 22, 2010 at 11:49:25AM -0700, Ardelean, Andrei wrote:

> I am using MALTA and my goal is to port MIPS Linux on a new platform.
> Which driver (source code) is used for tty0 (console)? I see the support
> for "early console" but I think that this is not the real Linux driver
> used after boot stage.

Correct.  Early console uses an extremly simple driver which in general
is separate from the full blown driver that takes over later.

> More general, how to find which code source is used for an embedded
> driver (part of the Kernel at compiling time) for each h/w resource.
> MIPS Linux distribution comes with a lot of drivers but I have
> difficulties to figure out which one is used for MALTA. Is it a files
> where all those are registered?

For any modern style driver that information is available through sysfs.
For example on this laptop here:

# cd /sys/devices/platform/serial8250
# ls -l
total 0
lrwxrwxrwx. 1 root root    0 Sep 24 12:20 driver -> ../../../bus/platform/drivers/serial8250
-r--r--r--. 1 root root 4096 Sep 24 12:20 modalias
drwxr-xr-x. 2 root root    0 Sep 24 12:20 power
lrwxrwxrwx. 1 root root    0 Sep 24 12:20 subsystem -> ../../../bus/platform
drwxr-xr-x. 5 root root    0 Sep 24 12:20 tty
-rw-r--r--. 1 root root 4096 Sep 24 12:20 uevent
#

So you see the driver being used is the 8250 driver.  Similar you can
find the driver for a PCI device in /sys/devices/pci* etc.

  Ralf
