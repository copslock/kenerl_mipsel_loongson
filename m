Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 22:19:06 +0100 (CET)
Received: from mail-ee0-f45.google.com ([74.125.83.45]:47958 "EHLO
        mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833263Ab3A1VTFguocC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jan 2013 22:19:05 +0100
Received: by mail-ee0-f45.google.com with SMTP id b57so1516571eek.18
        for <multiple recipients>; Mon, 28 Jan 2013 13:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:organization
         :user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type;
        bh=Zv0/kz0UU0b2zfpQoIgq5br3HZBKVjzFcnAHuoc3CBk=;
        b=uxqVuWKfo5eU0f7MOzA1LI/WegNHlXwKF9YUmsq3jnWCEhutWkgvo9MeO1thxS17Yj
         UHnWsWiGR2SRnz1ebqAEkVwVMWOzZ66i0Y1rAb/6/tc5DBN+qx1ujeebqmj7Ahh64aSe
         W+plnOGKBKUvEgh/N26Lg8++JdCTgvPbBUFVbUD+I7e1MxYnrrwruGYuwLXr5BpkQcQq
         Nu1YXkD/d1og6a5YVoJ0RoACXu7uUousl5+qjrwiry2/S8yXjA8VcwHolG5KUdKdU4rU
         vkOO4FmbQDXCIYssg0NZkifPLXq3gCMaqSSvHLArdjQKDbu5J9l1jsrNV6waFEnUpoAf
         Mh9A==
X-Received: by 10.14.204.198 with SMTP id h46mr56014998eeo.1.1359407940144;
        Mon, 28 Jan 2013 13:19:00 -0800 (PST)
Received: from bender.localnet ([2a01:e35:2f70:4010:9560:cb03:7239:2d07])
        by mx.google.com with ESMTPS id b2sm17555261eep.9.2013.01.28.13.18.58
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 13:18:59 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org, balbi@ti.com
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cernekee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org
Subject: Re: [PATCH 03/13] MIPS: BCM63XX: move code touching the USB private register
Date:   Mon, 28 Jan 2013 22:17:15 +0100
Message-ID: <2622165.icySTsWGzL@bender>
Organization: OpenWrt
User-Agent: KMail/4.9.4 (Linux/3.5.0-22-generic; KDE/4.9.4; x86_64; ; )
In-Reply-To: <20130128204114.GA5509@arwen.pp.htv.fi>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org> <1359399991-2236-4-git-send-email-florian@openwrt.org> <20130128204114.GA5509@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 35603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

On Monday 28 January 2013 22:41:14 Felipe Balbi wrote:
> Hi,
> 
> On Mon, Jan 28, 2013 at 08:06:21PM +0100, Florian Fainelli wrote:
> > diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63xx_udc.c
> > index ad17533..af450c4 100644
> > --- a/drivers/usb/gadget/bcm63xx_udc.c
> > +++ b/drivers/usb/gadget/bcm63xx_udc.c
> > @@ -41,6 +41,7 @@
> >  #include <bcm63xx_dev_usb_usbd.h>
> >  #include <bcm63xx_io.h>
> >  #include <bcm63xx_regs.h>
> > +#include <bcm63xx_usb_priv.h>
> 
> actually, I want to see this arch dependency vanish. The whole
> "phy_mode" stuff should be a PHY driver, care to implement this properly
> using the PHY layer ?

Ok, but then I won't be able to use the generic OHCI and EHCI platform drivers
because they are not yet aware of clocks, PHY slave device etc... For now I
would like to stick with that since this is also very BCM63xx centric.

Would that be ok with you?
-- 
Florian
