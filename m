Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 19:05:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36936 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903621Ab2HURFE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Aug 2012 19:05:04 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7LH4xq7021520;
        Tue, 21 Aug 2012 19:04:59 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7LH4vlp021519;
        Tue, 21 Aug 2012 19:04:57 +0200
Date:   Tue, 21 Aug 2012 19:04:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Daney <ddaney.cavm@gmail.com>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120821170456.GA18994@linux-mips.org>
References: <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
 <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
 <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
 <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
 <20120820053036.GA23166@kroah.com>
 <CAMuHMdWfhATFQrP-ZiMi6Ub3ZbOgUhe7S_fVUzc7zOwDxRNsyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWfhATFQrP-ZiMi6Ub3ZbOgUhe7S_fVUzc7zOwDxRNsyw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34304
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Aug 21, 2012 at 04:32:45PM +0200, Geert Uytterhoeven wrote:

> Anyone who disables CONFIG_HOTPLUG in his defconfig files?
> 
> $ git grep CONFIG_HOTPLUG arch/*/*config
> arch/frv/defconfig:# CONFIG_HOTPLUG is not set
> arch/h8300/defconfig:# CONFIG_HOTPLUG is not set
> arch/um/defconfig:CONFIG_HOTPLUG=y
> $
> 
> Yep, (at least --- not all defconfigs are up-to-date) frv and h8300.

Since we started stripping all the defconfigs down grepping through
arch/*/configs/ doesn't yield much useful information anymore :-(

There are currently 8 MIPS default configurations that dondo not enable
CONFIG_HOTPLUG.  I didn't check other architectures.

  Ralf
