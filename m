Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2012 03:30:31 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:33183 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903534Ab2HVBaY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Aug 2012 03:30:24 +0200
Received: by eekc13 with SMTP id c13so110548eek.36
        for <multiple recipients>; Tue, 21 Aug 2012 18:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZWS5x8HmP44Qv0LOZB1OQVrByPCHjdoWjHjy/6md9tY=;
        b=dU+Em8PbWvb8MxSbjWp4fGK651WzbHoLZmDADBshm9V/gF/X3V/0CmB3lRcnt2lVNb
         ZU0czD3lYu3/TWqfS6ihnNnKGbpqAPlt02Yp6oQvT26tME8DJACV8Z/bfj9eV8WqKWQB
         AcBAu/2nfUhKJL0NHoYCXpjAmwuqE2J1Ax69es0Cc4UaAIRSM+HWc5oQoxPLx9JGUWYc
         Wf2OpLXgo8APDcwuls9r8tpotSJqqLZ730LzOqLeb/okrl/CjsWCmsE7N4FlMR3BVl2G
         QMjTpBmG+/m2m2q2v134RIZVMzZPW7fMDCVe35VPE7rbfObOtQpW9JwwWjShaNW16auc
         FQhQ==
MIME-Version: 1.0
Received: by 10.14.207.9 with SMTP id m9mr16029418eeo.5.1345599019341; Tue, 21
 Aug 2012 18:30:19 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Tue, 21 Aug 2012 18:30:19 -0700 (PDT)
In-Reply-To: <20120821211355.GB6307@breakpoint.cc>
References: <b3bb6f2afb3ed82fd1e64563c68fb8df@localhost>
        <20120821211355.GB6307@breakpoint.cc>
Date:   Tue, 21 Aug 2012 18:30:19 -0700
Message-ID: <CAJiQ=7AkGWF03wmW1FcALwE6_s5o7pDLt2wpH-W-ngG-_G+91g@mail.gmail.com>
Subject: Re: [PATCH V2] usb: gadget: bcm63xx UDC driver
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     balbi@ti.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Tue, Aug 21, 2012 at 2:13 PM, Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
> please drop the "force all gadget drivers to also be dynamically linked" part.
> We may want to change this one day :)

Done in V3

>> +     if (!pd->use_fullspeed && !use_fullspeed)
> so it is a good advice to have pd not set to NULL :)

In V3 the probe function will call dev_err() and exit, instead of
crashing.  I added a comment explaining why it's mandatory: the
hardware requires specifying which port is shared between the device
core + host core, and if we just "assume" the wrong value, the port
won't pass traffic and it won't be obvious why.

>> +static bool use_fullspeed;
>> +module_param(use_fullspeed, bool, S_IRUGO);
>> +MODULE_PARM_DESC(use_fullspeed, "true for fullspeed only");
>
> How important is this option? Maybe this should become a generic option?

In theory, the hardware core should always be able to support USB 2.0
without any problems, and bcm63xx_udc.c should always be used with
gadget drivers that can handle USB 2.0.

In practice, there are a number of boards floating around which are
only reliable at USB 1.1 speeds, either due to impedance problems or
noise.  These fall into two categories:

1) Boards that have their own board definition in board_bcm963xx.c,
and pass this ID to Linux - in this case use_fullspeed can be
specified right in the platform data.

2) Products that copied the generic board name from the reference
design.  In this case they'll need another way of overriding
use_fullspeed, because the reference board supports high speed.  Some
might just add "bcm63xx_udc.use_fullspeed=1" to CONFIG_CMDLINE.
Others have to detect the board revision through other means (such as
reading a GPIO) and then pass the appropriate option to insmod.

use_fullspeed=1 just tells the core not to negotiate USB 2.0 PHY
rates.  It should be roughly equivalent to plugging the device into a
full speed hub.
