Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 02:14:26 +0100 (CET)
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:50615 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008199AbaLSBOXbQWUj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 02:14:23 +0100
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C538123412;
        Fri, 19 Dec 2014 01:14:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: car45_6014dc6a95041
X-Filterd-Recvd-Size: 1938
Received: from joe-X200MA.home (pool-71-103-235-196.lsanca.fios.verizon.net [71.103.235.196])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Dec 2014 01:14:20 +0000 (UTC)
Message-ID: <1418951658.28384.20.camel@perches.com>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k,
 mips)
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Date:   Thu, 18 Dec 2014 17:14:18 -0800
In-Reply-To: <alpine.DEB.2.11.1412190031530.17382@nanos>
References: <1418849927.28384.1.camel@perches.com>
         <alpine.DEB.2.11.1412190031530.17382@nanos>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Fri, 2014-12-19 at 00:33 +0100, Thomas Gleixner wrote:
> On Wed, 17 Dec 2014, Joe Perches wrote:
> > It seems like early_printk can be configured into
> > a few architectures but also appear not to be used.
> > 
> > $ git grep -w "early_printk"
> ...
> > These seem to the only uses:
> ... 
> > So blackfin, m68k, and mips seems to have it possible to enable,
> > but also don't appear at first glance to use it,
> 
> Hint: CONFIG_EARLY_PRINTK covers far more than early_printk()

I know this.

Note also I didn't specify CONFIG_EARLY_PRINTK,
just early_printk.
 
> > Is early_printk really used by these architectures?
> > Should it be removed?
> 
> Sure, if you have a good reason to remove working functionality.

Unused.

Ideally, all direct early_printk() uses would go away.
This would just be a starting point to minimize code.
