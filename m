Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 21:08:25 +0100 (CET)
Received: from iolanthe.rowland.org ([192.131.102.54]:41874 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S6833254Ab3A1UIYZcxGj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jan 2013 21:08:24 +0100
Received: (qmail 2975 invoked by uid 2102); 28 Jan 2013 15:08:21 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jan 2013 15:08:21 -0500
Date:   Mon, 28 Jan 2013 15:08:21 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Florian Fainelli <florian@openwrt.org>
cc:     linux-mips@linux-mips.org, <ralf@linux-mips.org>,
        <jogo@openwrt.org>, <mbizon@freebox.fr>, <cenerkee@gmail.com>,
        <linux-usb@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <blogic@openwrt.org>
Subject: Re: [PATCH 11/13] USB: EHCI: add ignore_oc flag to disable overcurrent
 checking
In-Reply-To: <1359399991-2236-12-git-send-email-florian@openwrt.org>
Message-ID: <Pine.LNX.4.44L0.1301281500530.1997-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 35599
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 28 Jan 2013, Florian Fainelli wrote:

> This patch adds an ignore_oc flag which can be set by EHCI controller
> not supporting or wanting to disable overcurrent checking. The EHCI
> platform data in include/linux/usb/ehci_pdriver.h is also augmented to
> take advantage of this new flag.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  drivers/usb/host/ehci-hcd.c      |    2 +-
>  drivers/usb/host/ehci-hub.c      |    4 ++--
>  drivers/usb/host/ehci.h          |    1 +
>  include/linux/usb/ehci_pdriver.h |    1 +
>  4 files changed, 5 insertions(+), 3 deletions(-)

You forgot to add

	ehci->ignore_oc = pdata->ignore_oc;

to ehci_platform_reset().  This makes me wonder: Either the patches 
were not tested very well or else the new ignore_oc stuff isn't needed.

> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index c97503b..bd435ac 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -634,7 +634,7 @@ static int ehci_run (struct usb_hcd *hcd)
>  		"USB %x.%x started, EHCI %x.%02x%s\n",
>  		((ehci->sbrn & 0xf0)>>4), (ehci->sbrn & 0x0f),
>  		temp >> 8, temp & 0xff,
> -		ignore_oc ? ", overcurrent ignored" : "");
> +		(ignore_oc || ehci->ignore_oc) ? ", overcurrent ignored" : "");

You could simplify the code here and other places if you add

	ehci->ignore_oc ||= ignore_oc;

to ehci_init().  Then you wouldn't need to test ignore_oc all the time.

Alan Stern
