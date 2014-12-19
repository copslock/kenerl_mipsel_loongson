Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 23:49:12 +0100 (CET)
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:59223 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009171AbaLSWtKOnzrH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 23:49:10 +0100
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7E8FA352130;
        Fri, 19 Dec 2014 22:49:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rail00_327c312fb645a
X-Filterd-Recvd-Size: 1686
Received: from joe-X200MA.home (pool-71-103-235-196.lsanca.fios.verizon.net [71.103.235.196])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Dec 2014 22:49:06 +0000 (UTC)
Message-ID: <1419029345.25129.16.camel@perches.com>
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
Date:   Fri, 19 Dec 2014 14:49:05 -0800
In-Reply-To: <yw1xy4q4exo9.fsf@unicorn.mansr.com>
References: <1418849927.28384.1.camel@perches.com>
         <alpine.DEB.2.11.1412190031530.17382@nanos>
         <1418951658.28384.20.camel@perches.com>
         <yw1x388ch0su.fsf@unicorn.mansr.com> <1418954914.25129.1.camel@perches.com>
         <yw1xy4q4exo9.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44849
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

On Fri, 2014-12-19 at 10:33 +0000, Måns Rullgård wrote:
> Joe Perches <joe@perches.com> writes:
> > The kernel/printk/early_printk() function seems
> > used only by arm/microblaze/tile/x86.
> 
> Rather than introduce more config complexity, you could try to remove
> the 7 remaining uses of early_printk().

That's the general idea actually.
Dunno if that's possible at one go though.

cheers, Joe
