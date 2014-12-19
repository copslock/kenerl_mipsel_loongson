Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 03:08:41 +0100 (CET)
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:60698 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008199AbaLSCIjnXcSa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 03:08:39 +0100
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0124B3520B6;
        Fri, 19 Dec 2014 02:08:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tramp89_8535f8aa9ea24
X-Filterd-Recvd-Size: 1714
Received: from joe-X200MA.home (pool-71-103-235-196.lsanca.fios.verizon.net [71.103.235.196])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Dec 2014 02:08:35 +0000 (UTC)
Message-ID: <1418954914.25129.1.camel@perches.com>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k,
 mips)
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Date:   Thu, 18 Dec 2014 18:08:34 -0800
In-Reply-To: <yw1x388ch0su.fsf@unicorn.mansr.com>
References: <1418849927.28384.1.camel@perches.com>
         <alpine.DEB.2.11.1412190031530.17382@nanos>
         <1418951658.28384.20.camel@perches.com>
         <yw1x388ch0su.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44825
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

On Fri, 2014-12-19 at 01:43 +0000, Måns Rullgård wrote:
> What exactly are you proposing to remove?

Optionally compile out
kernel/printk/printk.c:early_printk()
even if CONFIG_EARLY_PRINTK is enabled.

> I see no unused code related
> to early printk (in any variant) under arch/mips.

I think there could be yet another CONFIG option
to specifically enable the early_printk function
for the arches that use it.

The kernel/printk/early_printk() function seems
used only by arm/microblaze/tile/x86.
