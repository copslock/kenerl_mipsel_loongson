Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 19:00:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49010 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6831903Ab3FZRAginOF9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 19:00:36 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5QH0YhH016646;
        Wed, 26 Jun 2013 19:00:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5QH0Xwr016645;
        Wed, 26 Jun 2013 19:00:33 +0200
Date:   Wed, 26 Jun 2013 19:00:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tony Wu <tung7970@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add missing cpu_has_mips_1 guardian
Message-ID: <20130626170033.GG7171@linux-mips.org>
References: <20130621110301.GA23195@hades.local>
 <20130626143115.GA7171@linux-mips.org>
 <20130626151854.GC7171@linux-mips.org>
 <CAMuHMdWVTu2fzfOuxwsuvP9COKvuhMA+aNaWVESQZhBh9um9bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWVTu2fzfOuxwsuvP9COKvuhMA+aNaWVESQZhBh9um9bA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37144
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

On Wed, Jun 26, 2013 at 06:07:22PM +0200, Geert Uytterhoeven wrote:

> On Wed, Jun 26, 2013 at 5:18 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > If it's running Linus, that is.
> 
> Hmm, didn't know Linus is MIPS-based...

Neither does he!

> > Little complication: traps.c: was using a test for a pure MIPS I ISA as
> 
> Stray colon right after "traps.c".

Fixed, thanks,

  Ralf
