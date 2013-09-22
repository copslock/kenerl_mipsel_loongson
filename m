Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Sep 2013 23:54:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36856 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab3IVVyyOb-nm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Sep 2013 23:54:54 +0200
Date:   Sun, 22 Sep 2013 22:54:54 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Joe Perches <joe@perches.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] framebuffer: Remove pmag-aa-fb
In-Reply-To: <CAMuHMdXCTo4keP6vcXzxS1OQcdPC48eMu3H=D7mW-bWgrSsN6w@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1309222244170.16797@linux-mips.org>
References: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>        <6f500d88eb23fd9a4cfc5583f5ca17bc5f58fe24.1379641901.git.joe@perches.com>        <CAMuHMdW6R5qTJ0uvsUUaYBZAqFcNshPsXeMbz5hwqq5UOkJr-g@mail.gmail.com>       
 <alpine.LFD.2.03.1309201907380.8379@linux-mips.org>        <1379702587.2301.12.camel@joe-AO722>        <alpine.LFD.2.03.1309201946430.8379@linux-mips.org> <CAMuHMdXCTo4keP6vcXzxS1OQcdPC48eMu3H=D7mW-bWgrSsN6w@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Sun, 22 Sep 2013, Geert Uytterhoeven wrote:

> >  Thanks, but the changes required are actually much more than that -- the
> > driver has never been converted to the modern TURBOchannel API.  I have
> > now dug out an old patch I was working on back in 2006 to convert this
> > driver as well as drivers/video/maxinefb.c.  I'll try to complete the two
> > drivers as soon as possible (unfortunately I can't test the latter at all;
> > it's for an onboard graphics adapter of another DECstation model),
> > although I now remember the main reason I didn't complete them back then
> > was they used an old internal API that was removed and no suitable
> > replacement provided.  I need to investigate again what that actually was
> > though (hw cursor probably).
> 
> pmag-aa-fb.c still has struct display_switch (for the old drawing API) and the
> old fb_ops (with get_var()/get_fix()), instead of the new fb_ops (rectangular
> drawing API and var/fix as member data).

 That I got covered already in the old patch, but there was something 
else.  Otherwise I would have pushed it along updates for pmag-ba-fb.c and 
pmagb-b-fb.c long ago.

  Maciej
