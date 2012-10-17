Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2012 17:03:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52750 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823083Ab2JQPDXLSbwO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Oct 2012 17:03:23 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9HF3KSO007601;
        Wed, 17 Oct 2012 17:03:20 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9HF3J7S007593;
        Wed, 17 Oct 2012 17:03:19 +0200
Date:   Wed, 17 Oct 2012 17:03:19 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Antony Pavlov <antonynpavlov@gmail.com>, linux-mips@linux-mips.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] MIPS: JZ4740: add missing header file to serial.h
Message-ID: <20121017150319.GB7047@linux-mips.org>
References: <1350337127-11315-1-git-send-email-antonynpavlov@gmail.com>
 <1350337127-11315-2-git-send-email-antonynpavlov@gmail.com>
 <CAMuHMdUf-UBNE+2DxvOo5Cc5+FbzQzvCMBJN2epBesmn0dnoAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUf-UBNE+2DxvOo5Cc5+FbzQzvCMBJN2epBesmn0dnoAQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34714
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Oct 16, 2012 at 10:19:33AM +0200, Geert Uytterhoeven wrote:

> On Mon, Oct 15, 2012 at 11:38 PM, Antony Pavlov <antonynpavlov@gmail.com> wrote:
> > The 'uart_port' struct is used in the declaration of
> > the jz4740_serial_out() function.
> 
> It only needs a forward declaration, as it just references the pointer type.
> 
> > This commit adds the missing header file containing
> > declaration of the 'uart_port' struct.
> >
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > ---
> >  arch/mips/jz4740/serial.h |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/mips/jz4740/serial.h b/arch/mips/jz4740/serial.h
> > index aa5a939..dfc155c 100644
> > --- a/arch/mips/jz4740/serial.h
> > +++ b/arch/mips/jz4740/serial.h
> > @@ -16,6 +16,8 @@
> >  #ifndef __MIPS_JZ4740_SERIAL_H__
> >  #define __MIPS_JZ4740_SERIAL_H__
> >
> > +#include <linux/serial_core.h>
> > +
> 
> I.e. you can just use instead:
> 
>     struct uart_port;
> 
> >  void jz4740_serial_out(struct uart_port *p, int offset, int value);
> >
> >  #endif

Serial_core.h drags in eerythign and the kitchen sink so I really prefer
the forward declaration.

  Ralf
