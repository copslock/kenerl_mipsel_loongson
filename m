Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 14:09:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50625 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825727Ab3IRMJULE8os (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Sep 2013 14:09:20 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8IC9G8M027659;
        Wed, 18 Sep 2013 14:09:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8IC9Ein027658;
        Wed, 18 Sep 2013 14:09:14 +0200
Date:   Wed, 18 Sep 2013 14:09:14 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: BCM47XX: add board detection
Message-ID: <20130918120914.GM22468@linux-mips.org>
References: <1379503798-9014-1-git-send-email-hauke@hauke-m.de>
 <CAMuHMdU8V=96fEb9Vrpb2+TEWiD5L2Gh+3xzY9SBDotP2NaQ=g@mail.gmail.com>
 <52399641.4090901@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52399641.4090901@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37852
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

On Wed, Sep 18, 2013 at 02:02:09PM +0200, Hauke Mehrtens wrote:

> On 09/18/2013 01:41 PM, Geert Uytterhoeven wrote:
> > On Wed, Sep 18, 2013 at 1:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> >> Detect on which board this code is running based on some nvram
> >> settings. This is needed to start board specific workarounds and
> >> configure the leds and buttons which are on different gpios on every board.
> >>
> >> This patches add some boards we have seen, but there are many more.
> > 
> > Can you please make the board database __initconst, and only retain in memory
> > a copy of the detected board info?
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> I will change this in a next version of this patch.

I've already queued the first version of the patch so an incremental
patch would be handy.

Thanks,

  Ralf
