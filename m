Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 20:59:53 +0100 (CET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:52030 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012457AbcBOT7vpuT02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 20:59:51 +0100
Received: from darkstar.musicnaut.iki.fi (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id DA4EF1887C7;
        Mon, 15 Feb 2016 21:59:48 +0200 (EET)
Date:   Mon, 15 Feb 2016 21:59:48 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MIPS: DTS: cavium-octeon: provide model attribute
Message-ID: <20160215195948.GF1640@darkstar.musicnaut.iki.fi>
References: <1455513977-934-1-git-send-email-xypron.glpk@gmx.de>
 <56C1B3A0.4090301@cogentembedded.com>
 <56C21054.4070702@gmx.de>
 <20160215183838.GD1640@darkstar.musicnaut.iki.fi>
 <56C2253D.50101@gmx.de>
 <20160215194056.GE1640@darkstar.musicnaut.iki.fi>
 <56C22C18.5090608@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56C22C18.5090608@gmx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Mon, Feb 15, 2016 at 08:50:48PM +0100, Heinrich Schuchardt wrote:
> On 02/15/2016 08:40 PM, Aaro Koskinen wrote:
> > On Mon, Feb 15, 2016 at 08:21:33PM +0100, Heinrich Schuchardt wrote:
> >> flash-kernel has a database /usr/share/flash-kernel/db/all.db with
> >> entries like:
> >>
> >> Machine: LeMaker Banana Pi
> >> Kernel-Flavors: armmp armmp-lpae
> >> Boot-Script-Path: /boot/boot.scr
> >> DTB-Id: sun7i-a20-bananapi.dtb
> >> U-Boot-Script-Name: bootscr.sunxi
> >> Required-Packages: u-boot-tools
> >>
> >> Machine refers to the value of /proc/device-tree/model.
> >> DTB-Id is the dtb to be installed.
> >>
> >> So what flash-kernel does is:
> >> - look up value of /proc/device-tree/model
> >> - retrieve correlated dtb file name from database
> >> - install dtb with this name
> >> - create symbolic links for the dtb
> >>
> >> If multiple boards use the the same dtb that is fine with flash-kernel
> >> as long as the value of model is unique per dtb.
> > 
> > OCTEON does not work like this. The file you are modifying
> > (octeon_3xxx.dts) is compiled into the kernel, and there is no external
> > DTB file. So the model string will be always the same regardless on
> > which board you have booted the kernel.
> 
> you are right DTBs are built in for MIPS systems.
> 
> Still it would be useful to be able to use the same property 'model' to
> determine which u-boot script (boot.scr) to install.

But that cannot be solved by adding a static model string to
octeon_3xxx.dts, because different OCTEON boards need different u-boot
commands (some boot from flash, some from mmc, some from USB, etc.).

A.
