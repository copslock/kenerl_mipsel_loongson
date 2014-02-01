Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Feb 2014 17:16:27 +0100 (CET)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:36120 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824814AbaBAQQZme0h4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Feb 2014 17:16:25 +0100
Received: by mail-pb0-f41.google.com with SMTP id up15so5570347pbc.0
        for <linux-mips@linux-mips.org>; Sat, 01 Feb 2014 08:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=y6RhKiBLuzQfB2NeIJkCKbLRoMPBjqY6KnrTxWoTtkg=;
        b=ihC9F4wHipT2tMlwX4adglwGa7EeXDm/VlDpTli+4OXARIcZLvLcklit4zzC7NbCap
         eJHX3Zep7gKSWUJ390AT/DQzLX6BaaqSiyA01ycDK3je9ENSj8fSuRFCXmWF/76ZTmv2
         eVnCZW+YlZrpa0ab63Cou8y9jvVSRkyLvmI9moxdH2slG/I47L1hkyVTQcqVahB2OWJn
         oDHZbenBl9Q+MfYkuY+31vjerCwPWl4OYD7qS9dIPXNniG6ccnNPkQ7f7QKYXu37bkoJ
         q8MZ0g6wMjJwr6oS21wJRthx2ckVyjoKHu3SdUIWErP+VBGL3RAKo52Sdf/4NlT41tNH
         J8MA==
X-Received: by 10.66.142.170 with SMTP id rx10mr27520561pab.117.1391271378596;
 Sat, 01 Feb 2014 08:16:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.70.24.34 with HTTP; Sat, 1 Feb 2014 08:15:58 -0800 (PST)
From:   Tom Li <biergaizi2009@gmail.com>
Date:   Sun, 2 Feb 2014 00:15:58 +0800
Message-ID: <CAB6YEzX0_EupSDn=HQP_cPSBO6JG6bpZnRcguZpcUJAHNdNzhg@mail.gmail.com>
Subject: Regression since 3.8: a DMA cache change break rtl8187 USB wireless
 on Loongson
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <biergaizi2009@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: biergaizi2009@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

According to Bug #54391[0], the rtl8187 USB wireless card on
YeeLoong 8089D laptop / Loongson platform is broken since Linux 3.8.0.

The driver cause a kernel panic when receiving frames.
Many users' on Loongson-dev mailing confirmed the issue is 100% reproduced.

After a git bisect, I confirmed
a16dad7763420a3b46cff1e703a9070827796cfc (MIPS: Fix potencial corruption)
Caused the issue. After reverted the commit, the wireless is working again
even in the latest 3.12 kernel.

But rtl8187 driver doesn't use DMA directly.

After discuss with Stanislaw Gruszka, it maybe caused by:

- USB host controller driver misusing the DMA API
- A Loongson hardware-related issue, some alignment instructions
should be added back

YeeLoong 8089D uses a AMD CS5536 controller

> 00:0e.4 USB controller: Advanced Micro Devices, Inc. [AMD] CS5536 [Geode companion] OHC (rev 02)
> 00:0e.5 USB controller: Advanced Micro Devices, Inc. [AMD] CS5536 [Geode companion] EHC (rev 02)

And they use PCI abstraction provide by ohci-pci and ehci-pci.


More information is avaliable here:

[0]: https://bugzilla.kernel.org/show_bug.cgi?id=54391

Thanks,

Tom Li.
