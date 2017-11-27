Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 16:06:44 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdK0PGfiDa7B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Nov 2017 16:06:35 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 77C00B9E;
        Mon, 27 Nov 2017 15:06:22 +0000 (UTC)
Date:   Mon, 27 Nov 2017 16:06:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     James Hogan <james.hogan@mips.com>
Cc:     john@phrozen.org, ralf@linux-mips.org, stable@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: WTF: patch "[PATCH] MIPS: pci: Remove KERN_WARN instance inside
 the mt7620 driver" was seriously submitted to be applied to the 4.9-stable
 tree?
Message-ID: <20171127150627.GC31337@kroah.com>
References: <1511786146225230@kroah.com>
 <20171127124036.GA11276@jhogan-linux.mipstec.com>
 <20171127125649.GA13615@kroah.com>
 <20171127141300.GB11276@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171127141300.GB11276@jhogan-linux.mipstec.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Mon, Nov 27, 2017 at 02:13:00PM +0000, James Hogan wrote:
> On Mon, Nov 27, 2017 at 01:56:49PM +0100, Greg KH wrote:
> > On Mon, Nov 27, 2017 at 12:40:36PM +0000, James Hogan wrote:
> > > Hi Greg,
> > > 
> > > On Mon, Nov 27, 2017 at 01:35:46PM +0100, gregkh@linuxfoundation.org wrote:
> > > > The patch below was submitted to be applied to the 4.9-stable tree.
> > > > 
> > > > I fail to see how this patch meets the stable kernel rules as found at
> > > > Documentation/process/stable-kernel-rules.rst.
> > > > 
> > > > I could be totally wrong, and if so, please respond to 
> > > > <stable@vger.kernel.org> and let me know why this patch should be
> > > > applied.  Otherwise, it is now dropped from my patch queues, never to be
> > > > seen again.
> > > 
> > > I should have adjusted the commit message. KERN_WARN doesn't exist so it
> > > actually fixes a build error as well as switching to pr_warn().
> > 
> > What build error?  I have not heard of this breaking the build on 4.9
> > for the past year, is it in some config that no one uses?  :)
> 
> The LEDE project has been carrying the patch [1] since February when
> they added 4.9 support (their 4.4 support had a slightly earlier version
> of the driver added with just a plain printk, no KERN_WARN).
> 
> They have both CONFIG_SOC_MT7620 and CONFIG_PCI=y in their ralink mt7620
> config [2], and they are keeping up to date with stable releases [3], so
> I have no doubt they would appreciate having the patch applied to
> upstream stable to reduce their delta.
> 
> The only defconfigs in mainline which enable this platform
> (CONFIG_SOC_MT7620) are omega2p_defconfig and vocore2_defconfig, which
> were added in August by Harvey to help widen our internal continuous
> build & boot test coverage. Neither defconfig enables CONFIG_PCI yet
> which is required to see the build failure below, but regardless it is a
> valid configuration which LEDE is actively using.
> 
> arch/mips/pci/pci-mt7620.c: In function ‘wait_pciephy_busy’:
> arch/mips/pci/pci-mt7620.c:123:11: error: ‘KERN_WARN’ undeclared (first use in this function)
>     printk(KERN_WARN "PCIE-PHY retry failed.\n");
>            ^~~~~~~~~
> 
> John: I'm not familiar with the hardware, but would it be appropriate to
> add CONFIG_PCI=y to either of those 2 defconfigs (omega2p_defconfig and
> vocore2_defconfig) so this driver gets some upstream build[/boot]
> testing?
> 
> Anyway, hopefully that helps allay stable backport concerns.

Yes, thanks, that explains it a lot better, now queued up.

greg k-h
