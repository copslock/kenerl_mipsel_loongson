Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 16:13:02 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52725 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825821Ab3F0ONBmOWlK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 16:13:01 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5RECxce014990;
        Thu, 27 Jun 2013 16:12:59 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5RECxE5014989;
        Thu, 27 Jun 2013 16:12:59 +0200
Date:   Thu, 27 Jun 2013 16:12:59 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH V2 2/2] MIPS: BCM63XX: Enable second core SMP on BCM6328
 if available
Message-ID: <20130627141259.GC10727@linux-mips.org>
References: <1371548072-6247-1-git-send-email-jogo@openwrt.org>
 <1371548072-6247-3-git-send-email-jogo@openwrt.org>
 <20130627140533.GB10727@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130627140533.GB10727@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Jun 27, 2013 at 04:05:33PM +0200, Ralf Baechle wrote:

> > BCM6328 has a OTP which tells us if the second core is available.
> 
> Patch doesn't apply on top of my latest tree (more exactly, commit
> 426fe4812d09283a53b8294ae38c5a239eeee8ef) any more.  Can you respin?

Seems that was a patch ordering problem.  I can apply both patches of
this series if I drop https://patchwork.linux-mips.org/patch/5356/.

  Ralf
