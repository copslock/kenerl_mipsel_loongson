Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 12:34:04 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:43440 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbdAFLd5ZCDlE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 12:33:57 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 10B2A20790; Fri,  6 Jan 2017 12:33:54 +0100 (CET)
Received: from bbrezillon (LFbn-1-2159-240.w90-76.abo.wanadoo.fr [90.76.216.240])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 6AD2F20770;
        Fri,  6 Jan 2017 12:30:57 +0100 (CET)
Date:   Fri, 6 Jan 2017 12:30:53 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     "Anurag Raghavan (RBEI/ETW11)" <Raghavan.Anurag@in.bosch.com>
Cc:     Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "coreteam@netfilter.org" <coreteam@netfilter.org>,
        "fcoe-devel@open-fcoe.org" <fcoe-devel@open-fcoe.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "uclinux-h8-devel@lists.sourceforge.jp" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mmarek@suse.com" <mmarek@suse.com>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: ubi_io_read: error -74 (ECC error)
Message-ID: <20170106123053.4a5ffabc@bbrezillon>
In-Reply-To: <38f0cfac3dbe4ea89da84c7fbf667833@SGPMBX1023.APAC.bosch.com>
References: <38f0cfac3dbe4ea89da84c7fbf667833@SGPMBX1023.APAC.bosch.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

Hi Raghavan,

On Fri, 6 Jan 2017 10:07:29 +0000
"Anurag Raghavan (RBEI/ETW11)" <Raghavan.Anurag@in.bosch.com> wrote:

> Hi All,
> 
> My appdata partition could not be mounted or where the partition was not able to be used. Anyone can help me to find out the root cause of this. What are the possibilities of this ubifs corruption. Any patched are available to fix this issue.

Can you please stop sending over and over the same message in the hope
that someone will magically solve the problem for you. Pinging
maintainers is accepted but not 3 times in 2 days.

> 
> I am using the kernel version-30.3.5

It's not even a valid kernel version (probably a kerne, and we'll need a
lot more than the 10 lines of log you provided to help you debug your
driver, like the boot logs, a reference to the kernel sources you're
using, after how much time this problem occurred...

> Any kernel patches are available to solve this issue...??

What's your NAND controller? It seems related to a NAND driver issue.

Regards,

Boris

> 
> Error logs:
> 
> [    1.797141] UBI error: ubi_io_read: error -74 (ECC error) while reading 253952 bytes from PEB 445:8192, read 253952 bytes
> [    1.808274] UBIFS error (pid 491): ubifs_scan: corrupt empty space at LEB 489:233760
> [    1.816037] UBIFS error (pid 491): ubifs_scanned_corruption: corruption at LEB 489:233760
> [    1.828660] UBIFS error (pid 491): ubifs_scan: LEB 489 scanning failed
> [    1.835215] UBIFS warning (pid 491): ubifs_ro_mode: switched to read-only mode, error -117
> [    1.843502] UBIFS error (pid 491): make_reservation: cannot reserve 58 bytes in jhead 2, error -117
> [    1.852569] UBIFS error (pid 491): do_writepage: cannot write page 0 of inode 76584, error -117
> dpkg: error: unable to sync new file '/var/lib/dpkg/arch-new': Structure needs cleaning
> 
> Best regards
> 
> Raghavan Anurag
> RBEI/ETW1  
> 
> Tel. +91(422)667-4001 | Mobil 9986968950
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
