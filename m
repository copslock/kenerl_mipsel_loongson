Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 01:46:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50320 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6834875Ab3FZXqqVyB8C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 01:46:46 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5QNkdgW004437;
        Thu, 27 Jun 2013 01:46:39 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5QNkZwC004436;
        Thu, 27 Jun 2013 01:46:35 +0200
Date:   Thu, 27 Jun 2013 01:46:35 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>,
        "Steven J. Hill" <sjhill@mips.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <blogic@openwrt.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] MIPS: define cpu_has_mmips where appropriate
Message-ID: <20130626234635.GN7171@linux-mips.org>
References: <1369345335-28062-1-git-send-email-jogo@openwrt.org>
 <519F933A.6020407@gmail.com>
 <519FDF9A.6080204@gmail.com>
 <20130626232438.GM7171@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130626232438.GM7171@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37157
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

On Thu, Jun 27, 2013 at 01:24:38AM +0200, Ralf Baechle wrote:

> > >Acked-by: David Daney <david.daney@cavium.com>
> > 
> > I changed my mind:  NAK.
> > 
> > I will send a smaller, but equivalent patch.
> 
> Fair enough - until then I'm going to apply this patch.

Jonas pointed me at your other patch so I'm going to drop this one
again.

  Ralf
