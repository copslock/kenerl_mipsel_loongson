Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2013 23:12:25 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:37829 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816288Ab3I1VMXF1uOu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Sep 2013 23:12:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 68CB919BDB6;
        Sun, 29 Sep 2013 00:12:19 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 4RXEBU0FUVHD; Sun, 29 Sep 2013 00:12:14 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id 773B95BC009;
        Sun, 29 Sep 2013 00:12:13 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sun, 29 Sep 2013 00:12:12 +0300
Date:   Sun, 29 Sep 2013 00:12:12 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Richard Weinberger <richard@nod.at>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/2] staging: octeon-ethernet: don't assume that CPU 0 is
 special
Message-ID: <20130928211212.GC4572@blackmetal.musicnaut.iki.fi>
References: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
 <52473ECF.8080503@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52473ECF.8080503@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Sat, Sep 28, 2013 at 10:40:47PM +0200, Richard Weinberger wrote:
> Am 28.09.2013 21:50, schrieb Aaro Koskinen:
> > Currently the driver assumes that CPU 0 is handling all the hard IRQs.
> > This is wrong in Linux SMP systems where user is allowed to assign to
> > hardware IRQs to any CPU. The driver will stop working if user sets
> > smp_affinity so that interrupts end up being handled by other than CPU
> > 0. The patch fixes that.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> >  drivers/staging/octeon/ethernet-rx.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
> > index e14a1bb..de831c1 100644
> > --- a/drivers/staging/octeon/ethernet-rx.c
> > +++ b/drivers/staging/octeon/ethernet-rx.c
> > @@ -80,6 +80,8 @@ struct cvm_oct_core_state {
> >  
> >  static struct cvm_oct_core_state core_state __cacheline_aligned_in_smp;
> >  
> > +static int cvm_irq_cpu = -1;
> 
> Why are you introducing a new global variable here?
> Can't you pass cvm_irq_cpu as argument to cvm_oct_enable_napi()?

This information needs to be accessed in cvm_oct_no_more_work().
Maybe I'm missing something obvious, but I don't get how the argument
could be accessed in or passed to napi poll routine which is calling
cvm_oct_no_more_work()?

A.
