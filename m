Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2017 08:50:50 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:47074 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbdLFHumewh1o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2017 08:50:42 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id E3E0820C12; Wed,  6 Dec 2017 08:50:34 +0100 (CET)
Received: from windsurf.lan (LStLambert-657-1-97-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id B1F64203E2;
        Wed,  6 Dec 2017 08:50:34 +0100 (CET)
Date:   Wed, 6 Dec 2017 08:50:34 +0100
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "Waldemar Brodkorb" <wbx@openadk.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20171206085034.3869dc9d@windsurf.lan>
In-Reply-To: <20171205234923.GK27409@jhogan-linux.mipstec.com>
References: <20170803225547.6caa602b@windsurf.lan>
        <20171203105631.5232445a@windsurf.lan>
        <20171205234923.GK27409@jhogan-linux.mipstec.com>
Organization: Free Electrons
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61317
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

On Tue, 5 Dec 2017 23:49:24 +0000, James Hogan wrote:

> > I'm still facing this problem. There was a lengthy thread about it back
> > in August when I reported the problem, but then it calmed down, with no
> > real solution proposed.
> > 
> > Are there plans to fix this at some point?  
> 
> I recently fixed a similar issue in 64r6[el]_defconfig, but its not the
> same as it applies to all gcc versions on mips64r6. Given Ralf appears
> to be busy I'll take a look.

Thanks a lot. If you need some help to reproduce the problem, let me
know, I can provide simple instructions to produce it.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
