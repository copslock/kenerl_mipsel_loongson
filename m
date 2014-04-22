Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 00:06:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35674 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6834671AbaDVWGN6Jgah (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Apr 2014 00:06:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s3MM698b007505;
        Wed, 23 Apr 2014 00:06:09 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s3MM65Aa007504;
        Wed, 23 Apr 2014 00:06:05 +0200
Date:   Wed, 23 Apr 2014 00:06:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 4/6] ASoC: qi_lb60: Use devm_snd_soc_register_card()
Message-ID: <20140422220605.GA5334@linux-mips.org>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
 <1398199596-23649-4-git-send-email-lars@metafoo.de>
 <20140422205410.GI12304@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140422205410.GI12304@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39899
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

On Tue, Apr 22, 2014 at 09:54:10PM +0100, Mark Brown wrote:

> On Tue, Apr 22, 2014 at 10:46:34PM +0200, Lars-Peter Clausen wrote:
> > Makes the code a bit shorter and will also allow us to remove the drivers
> > remove() callback eventually.
> 
> Applied all the patches up to here, thanks.  Will wait for Ralf's review
> for the other two, they look good to me.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Really, the MIPS bits were trivial ...

  Ralf
