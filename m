Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jul 2010 20:09:04 +0200 (CEST)
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:42016 "EHLO
        mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491161Ab0G2SJA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jul 2010 20:09:00 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAG5fUUzZiBZX/2dsb2JhbACgCXLAYA2FKwQ
Received: from 87.22-136-217.adsl-dyn.isp.belgacom.be (HELO infomag) ([217.136.22.87])
  by relay.skynet.be with ESMTP; 29 Jul 2010 20:08:55 +0200
Received: from wim by infomag with local (Exim 4.69)
        (envelope-from <wim@infomag.iguana.be>)
        id 1OeXXK-0005jr-MO; Thu, 29 Jul 2010 20:08:54 +0200
Date:   Thu, 29 Jul 2010 20:08:54 +0200
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        wim@iguana.be, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@misterjones.org>,
        Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 7/7] watchdog: Add watchdog driver for OCTEON SOCs.
Message-ID: <20100729180854.GE30740@infomag.iguana.be>
References: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com> <1279935707-3997-8-git-send-email-ddaney@caviumnetworks.com> <20100724030754.GG7217@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100724030754.GG7217@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Will review tomorrow, but if OK then it can indeed go via MIPS tree.

Kind regards,
Wim.

> On Fri, Jul 23, 2010 at 06:41:47PM -0700, David Daney wrote:
> 
> Wim, ok to merge this one through the MIPS tree?
> 
>   Ralf
