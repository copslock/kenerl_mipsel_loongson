Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 16:14:52 +0100 (CET)
Received: from iolanthe.rowland.org ([192.131.102.54]:34165 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S27006967AbaKZPOuclR6e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 16:14:50 +0100
Received: (qmail 1377 invoked by uid 2102); 26 Nov 2014 10:14:48 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Nov 2014 10:14:48 -0500
Date:   Wed, 26 Nov 2014 10:14:48 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kevin Cernekee <cernekee@gmail.com>
cc:     sre@kernel.org, <dbaryshkov@gmail.com>, <dwmw2@infradead.org>,
        <arnd@arndb.de>, <linux@prisktech.co.nz>,
        <gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
        <grant.likely@linaro.org>, <robh+dt@kernel.org>,
        <computersforpeace@gmail.com>, <marc.ceeeee@gmail.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 9/9] usb: {ohci,ehci}-platform: Use new OF big-endian
 helper function
In-Reply-To: <1416962994-27095-10-git-send-email-cernekee@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1411261013340.1322-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+54715d4c@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
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

On Tue, 25 Nov 2014, Kevin Cernekee wrote:

> This handles the existing "big-endian" case, and in addition, it also does
> the right thing when "native-endian" is specified.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt | 2 ++
>  Documentation/devicetree/bindings/usb/usb-ohci.txt | 2 ++
>  drivers/usb/host/ehci-platform.c                   | 2 +-
>  drivers/usb/host/ohci-platform.c                   | 2 +-
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 43c1a4e..9505c31 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -12,6 +12,8 @@ Optional properties:
>   - big-endian-regs : boolean, set this for hcds with big-endian registers
>   - big-endian-desc : boolean, set this for hcds with big-endian descriptors
>   - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
> + - native-endian : boolean, enables big-endian-regs + big-endian-desc
> +   iff the kernel was compiled for big endian

Is this really a property of the hardware?  It appears to depend on the 
kernel configuration.  As such, is it appropriate for DT?

Alan Stern
