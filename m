Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 16:02:30 +0100 (CET)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:41938 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491093Ab1AXPC1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 16:02:27 +0100
Received: by qyk27 with SMTP id 27so4895388qyk.15
        for <linux-mips@linux-mips.org>; Mon, 24 Jan 2011 07:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=24BGB7okXoztZ/16iBczokaHSIUkk22ltoK+GdaC0zY=;
        b=HCR1FWSAaVduWPShZTbmxJ8opInYYcVNJblFoY2XiKa5KAOcdQxKOQfgccZO/hxSza
         M60L+223eRaKgVNADhSU3ZtGf7OSNPObcM4YjtPobrtZXrTcsQo4VmOxWDTcgSDnlzVv
         LbnvwKqJVrdRAFvJ2RjL23LDmb1Z7xfUrUgMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vTDt8drVgFYRXvBo4ZhOmsKGRbwUJsqS5XcdXrxm/6p25l+mGwj7QKlmfjkKgPUfKJ
         BW3ij2dpRxyL4YhYlR58uOT4vsrpObMFdi3SZE+KHb5fAxMhJD9Qu7Jru4eo+MjXmmxf
         awNlq6nZLUZDkguDvXk6KeV3HHXHPmNzsisN8=
MIME-Version: 1.0
Received: by 10.229.81.138 with SMTP id x10mr3888267qck.20.1295881340745; Mon,
 24 Jan 2011 07:02:20 -0800 (PST)
Received: by 10.229.45.13 with HTTP; Mon, 24 Jan 2011 07:02:20 -0800 (PST)
Date:   Mon, 24 Jan 2011 20:32:20 +0530
Message-ID: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com>
Subject: page size change on MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     linux-mips@linux-mips.org, kernelnewbies@nl.linux.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi All,


we are using mips32r2  so I want to know which all pages size it can support?
When I modify arch/mips/Kconfig.  it boot sucessfully on 16KB page
size. but hang/not boot crash when change page size to 8KB,32KB and 64
KB.

We are using 2.6.30 kernel.

At Page Size 8KB and 32KB  it hang in unpack_to_rootfs() function of
init/initramfs.c

64KB it hangs when execute init  Kernel panic - not syncing: Attempted
to kill init!

config PAGE_SIZE_4KB
        bool "4kB"
        help
         This option select the standard 4kB Linux page size.  On some
         R3000-family processors this is the only available page size.  Using
         4kB page size will minimize memory consumption and is therefore
         recommended for low memory systems.

config PAGE_SIZE_8KB
        bool "8kB"
       depends on (EXPERIMENTAL && CPU_R8000) || CPU_CAVIUM_OCTEON
        help
          Using 8kB page size will result in higher performance kernel at
          the price of higher memory consumption.  This option is available
          only on R8000 and cnMIPS processors.  Note that you will need a
          suitable Linux distribution to support this.

config PAGE_SIZE_16KB
        bool "16kB"
       depends on !CPU_R3000 && !CPU_TX39XX
        help
          Using 16kB page size will result in higher performance kernel at
          the price of higher memory consumption.  This option is available on
          all non-R3000 family processors.  Note that you will need a suitable
          Linux distribution to support this.

config PAGE_SIZE_32KB
        bool "32kB"
        help
          Using 32kB page size will result in higher performance kernel at
          the price of higher memory consumption.  This option is available
          only on cnMIPS cores.  Note that you will need a suitable Linux
          distribution to support this.

config PAGE_SIZE_64KB
        bool "64kB"
       depends on EXPERIMENTAL && !CPU_R3000 && !CPU_TX39XX
        help
          Using 64kB page size will result in higher performance kernel at
          the price of higher memory consumption.  This option is available on
          all non-R3000 family processor.  Not that at the time of this
          writing this option is still high experimental.
