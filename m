Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2012 11:43:19 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:33810 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903451Ab2GLJnN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2012 11:43:13 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 753C89BA80B;
        Thu, 12 Jul 2012 11:43:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3cVkBtxKVNKX; Thu, 12 Jul 2012 11:43:12 +0200 (CEST)
Received: from lenovo.localnet (alphacore.org [94.143.118.29])
        by zmc.proxad.net (Postfix) with ESMTPSA id 74A629BA528;
        Thu, 12 Jul 2012 11:43:12 +0200 (CEST)
From:   Florian Fainelli <ffainelli@freebox.fr>
Organization: Freebox
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/7] Prerequisites for BCM63XX UDC driver
Date:   Thu, 12 Jul 2012 11:43:07 +0200
User-Agent: KMail/1.13.7 (Linux/3.4-trunk-amd64; KDE/4.8.4; x86_64; ; )
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, ralf@linux-mips.org,
        mbizon@freebox.fr
References: <0f67eabbb0d5c59add27e42a08b94944@localhost> <CAJiQ=7Dxp8StP6Wj-EFAgWpLHxRrs616089BpKRSbPq4kWszag@mail.gmail.com> <CAOiHx==+Z+GL6r8dDWVSrtUHMYXNsK3GWktq=1RLN0VjkQcL1Q@mail.gmail.com>
In-Reply-To: <CAOiHx==+Z+GL6r8dDWVSrtUHMYXNsK3GWktq=1RLN0VjkQcL1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201207121143.08293.ffainelli@freebox.fr>
X-archive-position: 33891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Le jeudi 12 juillet 2012 10:57:58, Jonas Gorski a écrit :
> On 9 July 2012 04:58, Kevin Cernekee <cernekee@gmail.com> wrote:
> > On Fri, Jun 22, 2012 at 10:14 PM, Kevin Cernekee <cernekee@gmail.com> 
wrote:
> >> These patches are intended to lay the groundwork for a new USB Device
> >> Controller (gadget UDC) driver.
> > 
> > I have posted "V2" for 4 of the 7 patches.  New bundle is here:
> > 
> > http://patchwork.linux-mips.org/bundle/cernekee/bcm63xx-udc-prereq-v2/
> 
> These look good to me, and I have no further objections.

Me neither, they look good.
-- 
Florian
