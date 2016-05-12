Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 09:21:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43202 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27029211AbcELHVa41unN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2016 09:21:30 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4C7LSWg006307;
        Thu, 12 May 2016 09:21:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4C7LRV2006306;
        Thu, 12 May 2016 09:21:27 +0200
Date:   Thu, 12 May 2016 09:21:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>, linux-mips@linux-mips.org,
        matt.redfearn@imgtec.com
Subject: Re: [PATCH] MIPS: tools: Ignore relocation tool
Message-ID: <20160512072127.GQ16402@linux-mips.org>
References: <1462994177-6460-1-git-send-email-f.fainelli@gmail.com>
 <alpine.DEB.2.00.1605120218540.6794@tp.orcam.me.uk>
 <57340ADB.5040508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57340ADB.5040508@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53391
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

On Wed, May 11, 2016 at 09:47:23PM -0700, Florian Fainelli wrote:

> Le 11/05/2016 18:32, Maciej W. Rozycki a écrit :
> > On Wed, 11 May 2016, Florian Fainelli wrote:
> > 
> >> Add a .gitignore ignoring arch/mips/boot/tools/relocs.
> > 
> >  It's also left behind after `make distclean' so looks like it's missing a 
> > clean-up rule or one hasn't been properly wired.
> 
> Whoops did not notice that, I will send a follow-up patch for that too,
> thanks!

Somehow that also popped up on my radar only a day or two ago.  It seems
the tools/ directory isn't wired up like other dirs and thus make clean
etc. never get executed on it.

  Ralf
