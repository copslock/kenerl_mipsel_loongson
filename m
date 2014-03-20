Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2014 12:06:50 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:37357 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821117AbaCTLGqY0Z7w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Mar 2014 12:06:46 +0100
Received: from [95.69.23.227] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1WQao7-0000Qx-Hz; Thu, 20 Mar 2014 11:06:43 +0000
Date:   Thu, 20 Mar 2014 11:06:38 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <luis.henriques@canonical.com>
To:     Qais Yousef <Qais.Yousef@imgtec.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Ralf Baechle (ralf@linux-mips.org)" <ralf@linux-mips.org>
Subject: Re: [PATCH v2] mips/include/asm/mipsregs.h: include linux/types.h
Message-ID: <20140320110638.GC3709@hercules>
References: <1386582585-20867-1-git-send-email-qais.yousef@imgtec.com>
 <392C4BDEFF12D14FA57A3F30B283D7D14152C8@LEMAIL01.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <392C4BDEFF12D14FA57A3F30B283D7D14152C8@LEMAIL01.le.imgtec.org>
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

On Fri, Mar 14, 2014 at 12:08:13PM +0000, Qais Yousef wrote:
> Can we include this patch in the next 3.10 and forward stable releases please?
> 
> It's already in Linus' tree under commit id: 87c99203fea897fbdd84b681ad9fced2517dcf98
> 
> Thanks,
> Qais

Thank you, I'm queuing it for the 3.11 kernel.

Cheers,
--
Luís

> > -----Original Message-----
> > From: Qais Yousef
> > Sent: 09 December 2013 09:50
> > To: linux-mips@linux-mips.org
> > Cc: Qais Yousef
> > Subject: [PATCH v2] mips/include/asm/mipsregs.h: include linux/types.h
> > 
> > The file uses u16 type but doesn't include its definition explicitly
> > 
> > I was getting this error when including this header in my driver:
> > 
> >   arch/mips/include/asm/mipsregs.h:644:33: error: unknown type name ‘u16’
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> > Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
> > ---
> > changes since v1:
> > 	- include linux/types.h instead of s/u16/unsigned short/
> > 	- amend commit message accordingly
> > 
> >  arch/mips/include/asm/mipsregs.h |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/mips/include/asm/mipsregs.h
> > b/arch/mips/include/asm/mipsregs.h
> > index e033141..86479bb 100644
> > --- a/arch/mips/include/asm/mipsregs.h
> > +++ b/arch/mips/include/asm/mipsregs.h
> > @@ -14,6 +14,7 @@
> >  #define _ASM_MIPSREGS_H
> > 
> >  #include <linux/linkage.h>
> > +#include <linux/types.h>
> >  #include <asm/hazards.h>
> >  #include <asm/war.h>
> > 
> > --
> > 1.7.1
> 
