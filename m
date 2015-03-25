Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 17:33:38 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52257 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009770AbbCYQdhCBoY7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Mar 2015 17:33:37 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2PGXb2Z010012;
        Wed, 25 Mar 2015 17:33:37 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2PGXaC3010011;
        Wed, 25 Mar 2015 17:33:36 +0100
Date:   Wed, 25 Mar 2015 17:33:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] ath79: Increase max memory limit to 256MByte
Message-ID: <20150325163336.GA9705@linux-mips.org>
References: <1418904340-13464-1-git-send-email-helmut.schaa@googlemail.com>
 <CAGXE3d-xHPfQMq3h=V1TTm1UUc0qq7Hm373c4CdDRCR1Z77zuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXE3d-xHPfQMq3h=V1TTm1UUc0qq7Hm373c4CdDRCR1Z77zuw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46523
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

On Wed, Jan 28, 2015 at 04:39:33PM +0100, Helmut Schaa wrote:

> On Thu, Dec 18, 2014 at 1:05 PM, Helmut Schaa
> <helmut.schaa@googlemail.com> wrote:
> > At least QCA955x can handle up to 256MBytes.
> >
> > Signed-off-by: Helmut Schaa <helmut.schaa@googlemail.com>
> > ---
> >
> > Only tested on QCA955x, not sure if this would affect older SoCs in some way.
> 
> Any objections to this? In the meantime I was able to test on AR9344
> as well (with 128MByte of RAM).

The holdup has rather been that none of the folks who normally handle ath79
has commented.  The patch is looking ok - but I can't test it.  Patch applied.

Thanks,

  Ralf
