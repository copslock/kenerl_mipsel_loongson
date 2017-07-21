Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 12:52:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40315 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990557AbdGUKwGiXDCn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2017 12:52:06 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 622A8417B4F5F;
        Fri, 21 Jul 2017 11:51:56 +0100 (IST)
Received: from BADAG03.ba.imgtec.org (10.20.40.115) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 21 Jul
 2017 11:51:59 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 badag03.ba.imgtec.org ([fe80::5efe:10.20.40.115%12]) with mapi id
 14.03.0266.001; Fri, 21 Jul 2017 03:51:55 -0700
From:   Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Lingfeng Yang <lfy@google.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        "Henrik Rydberg" <rydberg@bitmath.org>,
        James Hogan <James.Hogan@imgtec.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>
Subject: RE: [PATCH v2 5/7] input: goldfish: Fix multitouch event handling
Thread-Topic: [PATCH v2 5/7] input: goldfish: Fix multitouch event handling
Thread-Index: AQHS8Cc4mBKVBGESdkKoWcpJyrfvrqI8qHWAgCGT8yA=
Date:   Fri, 21 Jul 2017 10:51:54 +0000
Message-ID: <EF5FA6C3467F85449672C3E735957B85015D9BC7B2@BADAG02.ba.imgtec.org>
References: <1498665399-29007-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1498665399-29007-6-git-send-email-aleksandar.markovic@rt-rk.com>,<20170629185835.GB38388@dtor-ws>
In-Reply-To: <20170629185835.GB38388@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Aleksandar.Markovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@imgtec.com
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

Hello, Dmitry,

Thanks for your valuable review - and sorry for my late response.

For this patch, I am just the submitter, and I would ask Lingfang to
make some additional comments/clarifications regarding architecture of
user-kernel protocols for relevant drivers, and also regarding similar
issues that you brought up.

However, please see my notes (from the point of view of user of this
driver) below, perhaps they can clear some doubts regarding this patch.

> ________________________________________
> From: Dmitry Torokhov [dmitry.torokhov@gmail.com]
> Sent: Thursday, June 29, 2017 11:58 AM
> To: Aleksandar Markovic
> Cc: linux-mips@linux-mips.org; Lingfeng Yang; Miodrag Dinic; Goran Ferenc; Aleksandar Markovic; Douglas Leung; Henrik Rydberg; James Hogan; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Paul Burton; Petar Jovanovic; Raghu Gandham
> Subject: Re: [PATCH v2 5/7] input: goldfish: Fix multitouch event handling
> 
> On Wed, Jun 28, 2017 at 05:56:29PM +0200, Aleksandar Markovic wrote:
> > From: Lingfeng Yang <lfy@google.com>
> >
> > Register Goldfish Events device properly as a multitouch device,
> > and send SYN_REPORT event in appropriate cases only.
> >
> > If SYN_REPORT is sent on every single multitouch event, it breaks
> > the multitouch. The multitouch becomes janky and having to click
> > 2-3 times to do stuff (plus randomly activating notification bars
> > when not clicking).
> 
> This sounds like a deficiency in protocol handling in userspace. Given
> that input core can suppress duplicate events userpsace mught very well
> only see one ABS_X followed by SYN_REPORT if Y coordinate did not change
> or was suppressed by jitter detection.
> 

I can't comment on protocols - I have to deffer these questions to
Lingfeng,

My experiences during integration of Android emulator for Mips
related to this driver is as follows: Without this patch, UI
interaction (even non-multitouch) is so erratic that I would think
majority of users would deem emulator UI non-usable. So, the problem
is severe. With this patch, however, UI is nice and dendy - and,
more than this, we did accross-the-board UI regression tests of 
this path (via CTS), and did not find any regression at all.


> > If these SYN_REPORT events are supressed,
> > multitouch will work fine, plus the events will have a protocol
> > that looks nice.
> >
> > In addition, Goldfish Events device needs to be registerd as a
> > multitouch device by issuing input_mt_init_slots. Otherwise,
> > input_handle_abs_event in drivers/input/input.c will silently drop
> > all ABS_MT_SLOT events, casusing touches with more than one finger
> > not to work properly.
> >
> > Signed-off-by: Lingfeng Yang <lfy@google.com>
> > Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> > Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> > ---
> >  drivers/input/keyboard/goldfish_events.c | 33 +++++++++++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
> > index f6e643b..6e0b8bb 100644
> > --- a/drivers/input/keyboard/goldfish_events.c
> > +++ b/drivers/input/keyboard/goldfish_events.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/types.h>
> >  #include <linux/input.h>
> > +#include <linux/input/mt.h>
> >  #include <linux/kernel.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> > @@ -24,6 +25,8 @@
> >  #include <linux/io.h>
> >  #include <linux/acpi.h>
> >
> > +#define GOLDFISH_MAX_FINGERS 5
> > +
> >  enum {
> >       REG_READ        = 0x00,
> >       REG_SET_PAGE    = 0x00,
> > @@ -52,7 +55,22 @@ static irqreturn_t events_interrupt(int irq, void *dev_id)
> >       value = __raw_readl(edev->addr + REG_READ);
> >
> >       input_event(edev->input, type, code, value);
> > -     input_sync(edev->input);
> > +
> > +     /*
> > +      * Send an extra (EV_SYN, SYN_REPORT, 0x0) event if a key
> > +      * was pressed. Some keyboard device drivers may only send
> > +      * the EV_KEY event and not EV_SYN.
> 
> Can they be fixed?
> 
> > +      *
> > +      * Note that sending an extra SYN_REPORT is not necessary
> > +      * nor correct protocol with other devices such as
> > +      * touchscreens, which will send their own SYN_REPORT's
> > +      * when sufficient event information has been collected
> > +      * (e.g., for touchscreens, when pressure and X/Y coordinates
> > +      * have been received). Hence, we will only send this extra
> > +      * SYN_REPORT if type == EV_KEY.
> > +      */
> > +     if (type == EV_KEY)
> > +             input_sync(edev->input);
> 
> Ideally we would not be sending synthetic EV_SYN at all...
> 

My understanding is that this patch aims to minimize synthetic EV_SYNs.
It would've been great if it had eliminated them all, but such
requirement seems to require significant work in multiple drivers.
All that taken into account, this patch looks to me like a good step in
the right direction, and I am asking for its acceptance in its current
form.

> >       return IRQ_HANDLED;
> >  }
> >
> > @@ -155,6 +173,19 @@ static int events_probe(struct platform_device *pdev)
> >       input_dev->name = edev->name;
> >       input_dev->id.bustype = BUS_HOST;
> >
> > +     /*
> > +      * Set the Goldfish Device to be multitouch.
> > +      *
> > +      * In the Ranchu kernel, there is multitouch-specific code
> > +      * for handling ABS_MT_SLOT events (see
> > +      * drivers/input/input.c:input_handle_abs_event).
> > +      * If we do not issue input_mt_init_slots, the kernel will
> > +      * filter out needed ABS_MT_SLOT events when we touch the
> > +      * screen in more than one place, preventing multitouch with
> > +      * more than one finger from working.
> > +      */
> > +     input_mt_init_slots(input_dev, GOLDFISH_MAX_FINGERS, 0);
> 
> This needs error handling. Also, can the backend communicate number of
> slots so the userspace has better idea about the capabilities of the
> device?
> 

Error handling will be fixed. Detecting capabilities sounds like a
good idea, but how about leaving it for a future patch?

> > +
> >       events_import_bits(edev, input_dev->evbit, EV_SYN, EV_MAX);
> >       events_import_bits(edev, input_dev->keybit, EV_KEY, KEY_MAX);
> >       events_import_bits(edev, input_dev->relbit, EV_REL, REL_MAX);
> > --
> > 2.7.4
> >
> 
> Thanks.
> 
> --
> Dmitry

Also, at the end, I would like to point that this patch have already
been in Android kernel "common 4.4" repository for some longish time,
we picked it from there:

https://android.googlesource.com/kernel/common/+/8bf12bc1b78dac6cb4fb7e4fbc0920978d17f5ea

This means that this patch is tested fairly well by now.

Regards,

Aleksandar
From Matt.Redfearn@imgtec.com Fri Jul 21 16:05:32 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:05:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49998 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992466AbdGUOFbyyRXG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2017 16:05:31 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EFA6C1B037F65;
        Fri, 21 Jul 2017 15:05:21 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 21 Jul 2017 15:05:25 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
CC:     "Luis R . Rodriguez" <mcgrof@kernel.org>,
        <linux-mips@linux-mips.org>, Petr Mladek <pmladek@suse.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] exec: Avoid recursive modprobe for binary format handlers
Date:   Fri, 21 Jul 2017 15:05:20 +0100
Message-ID: <1500645920-28490-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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
Content-Length: 2564
Lines: 63

When the kernel does not have a binary format handler for an executable
it is attempting to load, when CONFIG_MODULES is enabled it will attempt
to load a module for that format. If the kernel does not have a binary
format handler for the modprobe executable, this will trigger another
module load. Previously this recursive module loading was caught and an
error message printed informing the user that the executable could not
be executed:

request_module: runaway loop modprobe binfmt-464c
Starting init:/sbin/init exists but couldn't execute it (error -8)

Commit 6d7964a722af ("kmod: throttle kmod thread limit") which was
merged in v4.13-rc1 broke this behaviour since the recursive modprobe is
no longer caught, it just ends up waiting indefinitely for the kmod_wq
wait queue. Hence the kernel appears to hang silently when starting
userspace.

This problem was observed when the binfmt handler for MIPS o32 binaries
is not built in to a 64bit kernel and the root filesystem is o32 ABI.

Catch this by adding a guard to search_binary_handler(). If there is no
binary format handler available to load an exectuable, and the
executable matches modprobe_path, i.e. the userspace helper that would
be executed to load a module, then do not attempt to load the module
since it will just end up here again when it fails to execute. This
actually improves the original behaviour since the "runaway loop"
warning is no longer printed, and we simply get:

Starting init:/sbin/init exists but couldn't execute it (error -8)

Fixes: 6d7964a722af ("kmod: throttle kmod thread limit")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

What we really need to detect is that exec'ing modprobe failed, but
currently it does not get as far as an actual error since it just ends
up stuck waiting for the modprobes to complete, which they never will.
Open to suggestions of a different / better way to fix this.

Thanks,
Matt

---
 fs/exec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 62175cbcc801..004bb50a01fe 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1644,6 +1644,9 @@ int search_binary_handler(struct linux_binprm *bprm)
 		if (printable(bprm->buf[0]) && printable(bprm->buf[1]) &&
 		    printable(bprm->buf[2]) && printable(bprm->buf[3]))
 			return retval;
+		/* Game over if we need to load a module to execute modprobe */
+		if (strcmp(bprm->filename, modprobe_path) == 0)
+			return retval;
 		if (request_module("binfmt-%04x", *(ushort *)(bprm->buf + 2)) < 0)
 			return retval;
 		need_retry = false;
-- 
2.7.4
