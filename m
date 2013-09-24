Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2013 11:11:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42832 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824799Ab3IXJLFepVOH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Sep 2013 11:11:05 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8O9B3Z2022436;
        Tue, 24 Sep 2013 11:11:03 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8O9B296022435;
        Tue, 24 Sep 2013 11:11:02 +0200
Date:   Tue, 24 Sep 2013 11:11:02 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Jonas Gorski <jogo@openwrt.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3] MIPS: Tell R4k SC and MC variations apart
Message-ID: <20130924091102.GB21257@linux-mips.org>
References: <alpine.LFD.2.03.1309222307440.16797@linux-mips.org>
 <CAOiHx==GRTP3FpSfPG9yUc50mZBvrzjnXnGMXA6A5WSBRXbp3g@mail.gmail.com>
 <alpine.LFD.2.03.1309231332500.16797@linux-mips.org>
 <CAOiHx==su=eew_rXG_EJcub71vpqJgOS7XL05OcgjVDyZ8-1_Q@mail.gmail.com>
 <alpine.LFD.2.03.1309231358090.16797@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309231358090.16797@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37934
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

On Mon, Sep 23, 2013 at 02:01:53PM +0100, Maciej W. Rozycki wrote:

> There is no reliable way to tell R4000/R4400 SC and MC variations apart,
> however simple heuristic should give good results.  Only the MC version
> supports coherent caching so we can rely on such a mode having been set
> for KSEG0 by the power-on firmware to reliably indicate an MC processor.
> SC processors reportedly hang on coherent cached memory accesses and Linux
> is linked to a cached load address so the firmware has to use the correct
> caching mode to download the kernel image in a cached mode successfully.
> 
> OTOH if the firmware chooses to use either the non-coherent cached or the
> uncached mode for KSEG0 on an MC processor, then the SC variant will be
> reported, just as we currently do, so no regression here.

Queued for 3.13.  Thanks,

  Ralf
