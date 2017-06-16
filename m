Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 03:57:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6132 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994800AbdFPB5I7hv30 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 03:57:08 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BFC4492AF32F;
        Fri, 16 Jun 2017 02:57:00 +0100 (IST)
Received: from [10.20.78.209] (10.20.78.209) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 16 Jun 2017
 02:57:01 +0100
Date:   Fri, 16 Jun 2017 02:56:51 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <linux-mips@linux-mips.org>, <msalter@redhat.com>,
        <dmitry.torokhov@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Make individual platforms select
 ARCH_MIGHT_HAVE_PC_SERIO
In-Reply-To: <20170605171033.15008-1-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.00.1706160249370.23046@tp.orcam.me.uk>
References: <20170605171033.15008-1-f.fainelli@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.209]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Mon, 5 Jun 2017, Florian Fainelli wrote:

> Out of the many MIPS platforms only 3 appear to be actually using an
> I8042 keyboard controller: SGI, JAZZ and LOOGSON64, remove
> ARCH_MIGHT_HAVE_PC_SERIO from the top-level MIPS Kconfig symbol and move
> it down to those platforms that need it.

 How did you determine that?  Malta for one not only has an SMSC FDC37M817 
Super I/O Controller featuring an 8042-compatible core, but actual PS/2 
keyboard and mouse connectors as well.

  Maciej
