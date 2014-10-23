Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2014 01:54:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49937 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009481AbaJWXySE61Pd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Oct 2014 01:54:18 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9NNsHKh012271;
        Fri, 24 Oct 2014 01:54:17 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9NNsG8b012270;
        Fri, 24 Oct 2014 01:54:16 +0200
Date:   Fri, 24 Oct 2014 01:54:16 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] MIPS: sead3: Only build the led driver if LEDS_CLASS
 is enabled
Message-ID: <20141023235416.GA7529@linux-mips.org>
References: <1412847261-7930-1-git-send-email-markos.chandras@imgtec.com>
 <1412847261-7930-4-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412847261-7930-4-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Oct 09, 2014 at 10:34:21AM +0100, Markos Chandras wrote:

> leds-sead3.c:(.text+0x7dc): undefined reference to `led_classdev_unregister'
> leds-sead3.c:(.text+0x7e8): undefined reference to `led_classdev_unregister'
> 
> Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

Hmm...  I think there's a whole lot more broken.  Let's start with the
Makefile:

-obj-y				+= leds-sead3.o sead3-leds.o

Very creative filenames.  No way to know in what way foo-bar and bar-foo
are different.  But let's take a look at sead3-leds:

[...]
module_init(led_init);

MODULE_AUTHOR("Chris Dearman <chris@mips.com>");
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("LED probe driver for SEAD-3");

But although you were trying to make this a module, this better shouldn't
be one, the devices should always be registered if they're there, driver
enabled or not.

Anyway this should probably become a device_initcall() and all the
module bits should go.

And now let's take a look at sead3-led..  oh wait, that's leds-sead3 -
did I bitch about the filename before?  That's a complete device driver
and it blows up primarily because it lives in a directory where it
shouldn't be at all.

  Ralf
