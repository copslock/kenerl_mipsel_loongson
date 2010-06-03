Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 14:50:19 +0200 (CEST)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:45624 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492656Ab0FCMuP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 14:50:15 +0200
Received: by wwi17 with SMTP id 17so41158wwi.36
        for <multiple recipients>; Thu, 03 Jun 2010 05:50:10 -0700 (PDT)
Received: by 10.227.134.20 with SMTP id h20mr9231375wbt.47.1275569410054;
        Thu, 03 Jun 2010 05:50:10 -0700 (PDT)
Received: from [192.168.1.6] (host81-136-218-57.in-addr.btopenworld.com [81.136.218.57])
        by mx.google.com with ESMTPS id l46sm6270wed.22.2010.06.03.05.50.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 05:50:08 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC][PATCH 20/26] alsa: ASoC: Add JZ4740 codec
 driver
From:   Liam Girdwood <lrg@slimlogic.co.uk>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1275568334.3593.92.camel@odin>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
         <1275505950-17334-4-git-send-email-lars@metafoo.de>
         <1275568334.3593.92.camel@odin>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 03 Jun 2010 13:50:08 +0100
Message-ID: <1275569408.3593.107.camel@odin>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 27048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lrg@slimlogic.co.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2364

On Thu, 2010-06-03 at 13:32 +0100, Liam Girdwood wrote:
> On Wed, 2010-06-02 at 21:12 +0200, Lars-Peter Clausen wrote:
> > This patch adds support for the JZ4740 internal codec.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> > Cc: alsa-devel@alsa-project.org
> > ---
> >  sound/soc/codecs/Kconfig        |    4 +
> >  sound/soc/codecs/Makefile       |    2 +
> >  sound/soc/codecs/jz4740-codec.c |  502 +++++++++++++++++++++++++++++++++++++++
> >  sound/soc/codecs/jz4740-codec.h |   20 ++
> >  4 files changed, 528 insertions(+), 0 deletions(-)
> >  create mode 100644 sound/soc/codecs/jz4740-codec.c
> >  create mode 100644 sound/soc/codecs/jz4740-codec.h
> 
> no need for code in file name here.

My bad typing - I mean codec.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
