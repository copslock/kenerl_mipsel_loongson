Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2016 18:10:03 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026689AbcDPQJ5jrTY3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Apr 2016 18:09:57 +0200
Received: from localhost (unknown [70.102.234.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5A61C67;
        Sat, 16 Apr 2016 16:09:50 +0000 (UTC)
Date:   Sat, 16 Apr 2016 09:09:50 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Joshua Henderson <joshua.henderson@microchip.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 10/14] serial: pic32_uart: Add PIC32 UART driver
Message-ID: <20160416160950.GD10824@kroah.com>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
 <1452734299-460-11-git-send-email-joshua.henderson@microchip.com>
 <CAPKp9uYOnhJhNq8YDVRMpLSmGa7yWsktYnhVsMdWLtH1Jru3bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPKp9uYOnhJhNq8YDVRMpLSmGa7yWsktYnhVsMdWLtH1Jru3bw@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53023
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

On Fri, Apr 15, 2016 at 06:28:32PM +0100, Sudeep Holla wrote:
> Hi Greg,
> 
> I just noticed this now. I am having similar issue with MPS2 UART driver
> posted @[1], hence I am asking here to get some clarification myself.
> Sorry for replying on very old thread.
> 
> On Thu, Jan 14, 2016 at 1:15 AM, Joshua Henderson
> <joshua.henderson@microchip.com> wrote:
> > From: Andrei Pistirica <andrei.pistirica@microchip.com>
> >
> > This adds UART and a serial console driver for Microchip PIC32 class
> > devices.
> >
> > Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> > Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> 
> [...]
> 
> > diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> > index 93ba148..9df0a98 100644
> > --- a/include/uapi/linux/serial_core.h
> > +++ b/include/uapi/linux/serial_core.h
> > @@ -261,4 +261,7 @@
> >  /* STM32 USART */
> >  #define PORT_STM32     113
> >
> > +/* Microchip PIC32 UART */
> > +#define PORT_PIC32     114
> 
> This was posted before v4.6-rc1 similar to MPS2 UART and has taken
> port# 114 for it. However MVEBU UART obtained 114 with v4.6-rc1
> And MPS2 UART was assigned 115 when it got revised/reposted.
> 
> I also see this patch in linux-next with 114 itself as its port number.
> So the allocation of port number needs to be resolved before it gets
> merged or it's OK to wait for v4.7-rc1 ?
> 
> If it's former, can PORT_PIC32 take 116 as the latest post of MPS2 assigned
> it 115 and I have pulled the same to take it via arm-soc.
> 
> I am fine with any solution, just want to be notified if I need to
> take any action.

Just do the merge so the numbers are allocated in sequence.

We really need to fix this up one of these days, there's no real need
for these numbers, and it's a pain in merging, as you have found out...

thanks,

greg k-h
