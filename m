Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 18:56:10 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007065AbaKYR4EtVtrz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 18:56:04 +0100
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 56CA3BFA;
        Tue, 25 Nov 2014 17:55:57 +0000 (UTC)
Date:   Tue, 25 Nov 2014 09:38:59 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Grant Likely <grant.likely@linaro.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>, jslaby@suse.cz,
        robh@kernel.org, arnd@arndb.de, f.fainelli@gmail.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO
 accesses via DT
Message-ID: <20141125173859.GA27287@kroah.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <20141125151018.359EAC44343@trevor.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141125151018.359EAC44343@trevor.secretlab.ca>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44446
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

On Tue, Nov 25, 2014 at 03:10:18PM +0000, Grant Likely wrote:
> On Mon, 24 Nov 2014 15:36:15 -0800
> , Kevin Cernekee <cernekee@gmail.com>
>  wrote:
> > My last submission attempted to work around serial driver coexistence
> > problems on multiplatform kernels.  Since there are still questions
> > surrounding the best way to solve that problem, this patch series
> > will focus on the narrower topic of big endian MMIO support on serial.
> > 
> > 
> > V2->V3:
> > 
> >  - Document the new DT properties.
> > 
> >  - Add libfdt-based wrapper, to complement the "struct device_node" based
> >    version.
> > 
> >  - Restructure early_init_dt_scan_chosen_serial() changes to use a
> >    temporary variable, so it is easy to add more of_setup_earlycon()
> >    properties later.
> > 
> >  - Make of_serial and serial8250 honor the new "big-endian" property.
> > 
> > 
> > This series applies cleanly to:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux.git devicetree/next-overlay
> > 
> > but was tested on the mips-for-linux-next branch because my BE platform
> > isn't supported in mainline yet.
> 
> For the whole series:
> Acked-by: Grant Likely <grant.likely@linaro.org>
> 
> Greg, which tree do you want to merge this through? My DT tree, or the
> tty tree?

I can take these through my tty tree, thanks.

greg k-h
