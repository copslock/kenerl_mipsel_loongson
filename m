Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 22:41:58 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990656AbeBOVluA06MO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Feb 2018 22:41:50 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6340BF09;
        Thu, 15 Feb 2018 21:41:42 +0000 (UTC)
Date:   Thu, 15 Feb 2018 22:41:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
Message-ID: <20180215214142.GA31227@kroah.com>
References: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
 <05aec8b194d01871c2e9f62ce38d68b56dff59ca.1517437177.git-series.jhogan@kernel.org>
 <20180215174203.GA21337@kroah.com>
 <20180215213847.GK3986@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215213847.GK3986@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62564
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

On Thu, Feb 15, 2018 at 09:38:48PM +0000, James Hogan wrote:
> On Thu, Feb 15, 2018 at 06:42:03PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Jan 31, 2018 at 10:24:45PM +0000, James Hogan wrote:
> > > Move the Kconfig symbols USB_UHCI_BIG_ENDIAN_MMIO and
> > > USB_UHCI_BIG_ENDIAN_DESC out of drivers/usb/host/Kconfig, which is
> > > conditional upon USB && USB_SUPPORT, so that it can be freely selected
> > > by platform Kconfig symbols in architecture code.
> > > 
> > > For example once the MIPS_GENERIC platform selects are fixed in the
> > > patch "MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN", the MIPS
> > > 32r6_defconfig warns like so:
> > > 
> > > warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies (USB_SUPPORT && USB)
> > > warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_DESC which has unmet direct dependencies (USB_SUPPORT && USB)
> > > 
> > > Signed-off-by: James Hogan <jhogan@kernel.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > Cc: linux-usb@vger.kernel.org
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks, I'll apply this as a MIPS fix for 4.16.
> 
> Okay to leave patch 2 for you to deal with Greg since it doesn't really
> directly affect MIPS nor is it important for 4.16?

Just take both of them and be done with it :)

thanks,

greg k-h
