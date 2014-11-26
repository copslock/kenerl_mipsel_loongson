Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 17:24:29 +0100 (CET)
Received: from iolanthe.rowland.org ([192.131.102.54]:34338 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S27007210AbaKZQY12rQYV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 17:24:27 +0100
Received: (qmail 2367 invoked by uid 2102); 26 Nov 2014 11:24:25 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Nov 2014 11:24:25 -0500
Date:   Wed, 26 Nov 2014 11:24:25 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kevin Cernekee <cernekee@gmail.com>
cc:     sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux@prisktech.co.nz>,
        Greg KH <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Grant Likely <grant.likely@linaro.org>, <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marc C <marc.ceeeee@gmail.com>, <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 9/9] usb: {ohci,ehci}-platform: Use new OF big-endian
 helper function
In-Reply-To: <CAJiQ=7CuLA2vDpnkDysBU100R0uuUidB_ua3sZdV74vNPjV76w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1411261120300.1322-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+54715d4c@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44473
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

On Wed, 26 Nov 2014, Kevin Cernekee wrote:

> On Wed, Nov 26, 2014 at 7:14 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >> index 43c1a4e..9505c31 100644
> >> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >> @@ -12,6 +12,8 @@ Optional properties:
> >>   - big-endian-regs : boolean, set this for hcds with big-endian registers
> >>   - big-endian-desc : boolean, set this for hcds with big-endian descriptors
> >>   - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
> >> + - native-endian : boolean, enables big-endian-regs + big-endian-desc
> >> +   iff the kernel was compiled for big endian
> >
> > Is this really a property of the hardware?  It appears to depend on the
> > kernel configuration.  As such, is it appropriate for DT?
> 
> Yes, the peripheral registers automatically adjust their endianness to
> match the CPU.  So if the CPU is running an LE kernel, the peripheral
> needs to be accessed in LE mode; if the CPU is running a BE kernel,
> the peripheral needs to be accessed in BE mode.

Okay, then:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

But you might want to update the description slightly to say:

 - native-endian : boolean, enables big-endian-regs + big-endian-desc
   iff the CPU is running in big-endian mode

It's a very minor distinction, since you can't run a kernel that was 
compiled for little endian if the CPU is running in big-endian mode, 
but this makes it clear that you're talking about the hardware rather 
than the software.

Alan Stern
