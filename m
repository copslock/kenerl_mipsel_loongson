Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Dec 2017 10:56:55 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:36566 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990437AbdLCJ4s6DVYC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Dec 2017 10:56:48 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 7622420732; Sun,  3 Dec 2017 10:56:41 +0100 (CET)
Received: from windsurf.lan (LFbn-TOU-1-149-75.w86-201.abo.wanadoo.fr [86.201.231.75])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 430C920374;
        Sun,  3 Dec 2017 10:56:31 +0100 (CET)
Date:   Sun, 3 Dec 2017 10:56:31 +0100
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Waldemar Brodkorb <wbx@openadk.org>,
        James Hogan <james.hogan@mips.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20171203105631.5232445a@windsurf.lan>
In-Reply-To: <20170803225547.6caa602b@windsurf.lan>
References: <20170803225547.6caa602b@windsurf.lan>
Organization: Free Electrons
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Hello,

+James Hogan in Cc.

On Thu, 3 Aug 2017 22:55:47 +0200, Thomas Petazzoni wrote:

> When trying to build the current Linux master with a gcc 7.x toolchain
> for mips64r6-n32, I'm getting the following build failure:
> 
> crypto/scompress.o: In function `.L31':
> scompress.c:(.text+0x2a0): undefined reference to `__multi3'
> drivers/base/component.o: In function `.L97':
> component.c:(.text+0x4a4): undefined reference to `__multi3'
> drivers/base/component.o: In function `component_master_add_with_match':
> component.c:(.text+0x8c4): undefined reference to `__multi3'
> net/core/ethtool.o: In function `ethtool_set_per_queue_coalesce':
> ethtool.c:(.text+0x1ab0): undefined reference to `__multi3'
> Makefile:1000: recipe for target 'vmlinux' failed
> make[2]: *** [vmlinux] Error 1

I'm still facing this problem. There was a lengthy thread about it back
in August when I reported the problem, but then it calmed down, with no
real solution proposed.

Are there plans to fix this at some point?

Thanks a lot,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
