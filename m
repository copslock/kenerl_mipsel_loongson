Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2018 17:16:14 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:44900 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990864AbeB0QQIKXzNC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Feb 2018 17:16:08 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CC21D20881; Tue, 27 Feb 2018 17:15:59 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 81146207C1;
        Tue, 27 Feb 2018 17:15:49 +0100 (CET)
Date:   Tue, 27 Feb 2018 17:15:50 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] MIPS: defconfigs: add a defconfig for Microsemi
 SoCs
Message-ID: <20180227161550.GC15333@piout.net>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-8-alexandre.belloni@free-electrons.com>
 <20180214170342.GF3986@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214170342.GF3986@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

On 14/02/2018 at 17:03:43 +0000, James Hogan wrote:
> On Tue, Jan 16, 2018 at 11:12:39AM +0100, Alexandre Belloni wrote:
> > +# CONFIG_EARLY_PRINTK is not set
> 
> Only Loongson1b/1c explicitly disable early printk. Do you disable it
> for a particular reason?
> 

Well, it is so late that it is not really useful and I don't find that
particularly interesting to have it on by default.

But I don't have a strong opinion, I certainly can let it enabled.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
