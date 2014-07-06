Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jul 2014 09:06:17 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:22922 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816022AbaGFHGOJzHOM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Jul 2014 09:06:14 +0200
X-IronPort-AV: E=Sophos;i="5.01,610,1400050800"; 
   d="scan'208";a="38141337"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw1-out.broadcom.com with ESMTP; 06 Jul 2014 00:32:48 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Sun, 6 Jul 2014 00:06:05 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Sun, 6 Jul 2014 00:06:05 -0700
Received: from jayachandranc.netlogicmicro.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 4BEED9FA00;    Sun,  6 Jul 2014 00:06:02 -0700 (PDT)
Date:   Sun, 6 Jul 2014 12:38:15 +0530
From:   Jayachandran C. <jchandra@broadcom.com>
To:     Nick Krause <xerofoify@gmail.com>
CC:     Randy Dunlap <rdunlap@infradead.org>, <ralf@linux-mips.org>,
        <blogic@openwrt.org>, <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mips: Add #ifdef in file bridge.h
Message-ID: <20140706070814.GA8511@jayachandranc.netlogicmicro.com>
References: <1404528619-3715-1-git-send-email-xerofoify@gmail.com>
 <53B80EFC.6020504@infradead.org>
 <CAPDOMVid83VWT4n93MjvxoWdcq2KPYren0o5ubGi+9HHY6a7EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDOMVid83VWT4n93MjvxoWdcq2KPYren0o5ubGi+9HHY6a7EQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On Sun, Jul 06, 2014 at 01:58:43AM -0400, Nick Krause wrote:
> No I didn't I finally learned how to cross compile the kernel it's not
> hard just have to find the docs for it :).
> Cheers Nick

There is already an ifdef in the right place in the file. There is not need
to move it here as these macros are safe for assembly.

The FIXME comment was a note to verfiy the Flash BAR address taken from the
manual. Ideally, this has to be removed after checking it on hardware. Thanks
for pointing this out.

But the patch is incorrect and can be dropped.

> On Sat, Jul 5, 2014 at 10:43 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 07/04/2014 07:50 PM, Nicholas Krause wrote:
> >> This patch addes a #ifdef __ASSEMBLY__ in order to check if this part
> >> of the file is configured to fix this #ifdef block in bridge.h for mips.
> >>
> >> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> >> ---
> >>  arch/mips/include/asm/netlogic/xlp-hal/bridge.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
> >> index 3067f98..4f315c3 100644
> >> --- a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
> >> +++ b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
> >> @@ -143,7 +143,7 @@
> >>  #define BRIDGE_GIO_WEIGHT            0x2cb
> >>  #define BRIDGE_FLASH_WEIGHT          0x2cc
> >>
> >> -/* FIXME verify */
> >> +#ifdef __ASSEMBLY__
> >>  #define BRIDGE_9XX_FLASH_BAR(i)              (0x11 + (i))
> >>  #define BRIDGE_9XX_FLASH_BAR_LIMIT(i)        (0x15 + (i))
> >>
> >>
> >
> > Hi,
> >
> > Where is the corresponding #endif ?
> > The #endif at line 185 goes with the #ifndef __ASSEMBLY__ at line 176.
> >
> > I think that this patch will cause a build error (or at least a warning).
> > Did you test it?
> >

JC.
