Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Apr 2015 20:26:23 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37710 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010024AbbDCS0VHMr7u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Apr 2015 20:26:21 +0200
Received: from localhost (gob75-2-82-67-192-59.fbx.proxad.net [82.67.192.59])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4B316B04;
        Fri,  3 Apr 2015 18:26:14 +0000 (UTC)
Date:   Fri, 3 Apr 2015 20:25:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/6] ASoC: jz4740: Remove Makefile entry for removed file
Message-ID: <20150403182540.GA12460@kroah.com>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
 <5515363F.1050209@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5515363F.1050209@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Fri, Mar 27, 2015 at 10:51:43AM +0000, Markos Chandras wrote:
> On 04/22/2014 09:46 PM, Lars-Peter Clausen wrote:
> > Commit 0406a40a0 ("ASoC: jz4740: Use the generic dmaengine PCM driver")
> > jz4740-pcm.c file, but neglected to remove the Makefile entries.
> > 
> > Fixes: 0406a40a0 ("ASoC: jz4740: Use the generic dmaengine PCM driver")
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Reported-by: Ralf Baechle <ralf@linux-mips.org>
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> >  sound/soc/jz4740/Makefile | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/sound/soc/jz4740/Makefile b/sound/soc/jz4740/Makefile
> > index be873c1..d32c540 100644
> > --- a/sound/soc/jz4740/Makefile
> > +++ b/sound/soc/jz4740/Makefile
> > @@ -1,10 +1,8 @@
> >  #
> >  # Jz4740 Platform Support
> >  #
> > -snd-soc-jz4740-objs := jz4740-pcm.o
> >  snd-soc-jz4740-i2s-objs := jz4740-i2s.o
> >  
> > -obj-$(CONFIG_SND_JZ4740_SOC) += snd-soc-jz4740.o
> >  obj-$(CONFIG_SND_JZ4740_SOC_I2S) += snd-soc-jz4740-i2s.o
> >  
> >  # Jz4740 Machine Support
> > 
> Hi,
> 
> This patch (eebdec044e82) is present in 3.15-rc1 but the build failure
> that was introduced by 0406a40a0 ("ASoC: jz4740: Use the generic
> dmaengine PCM driver") is present in 3.14-rc1 so 3.14 is still broken.
> 
> Greg, would it be possible to cherry pick eebdec044e82 ("ASoC: jz4740:
> Remove Makefile entry for removed file") to 3.14 stable branch? It seems
> to apply without conflicts.

Now applied, thanks.

greg k-h
