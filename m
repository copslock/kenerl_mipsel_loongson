Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2014 10:15:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51646 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010257AbaJXIPLcHO19 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Oct 2014 10:15:11 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9O8FALK020074;
        Fri, 24 Oct 2014 10:15:10 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9O8F9YO020073;
        Fri, 24 Oct 2014 10:15:09 +0200
Date:   Fri, 24 Oct 2014 10:15:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>,
        Chris Dearman <chris.dearman@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: sead3: Build the I2C related devices if
 CONFIG_I2C is enabled
Message-ID: <20141024081509.GA12641@linux-mips.org>
References: <1412847261-7930-1-git-send-email-markos.chandras@imgtec.com>
 <1412847261-7930-3-git-send-email-markos.chandras@imgtec.com>
 <20141023181925.GA6719@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141023181925.GA6719@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43550
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

On Thu, Oct 23, 2014 at 08:19:26PM +0200, Ralf Baechle wrote:

> > There is no point building the drivers for the i2c related devices if
> > CONFIG_I2C is not enabled.
> > 
> > This also fixes a randconfig problem:
> > 
> > arch/mips/mti-sead3/sead3-pic32-i2c-drv.c: In function 'i2c_platform_probe':
> > arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:345:2: error: implicit declaration of
> > function 'i2c_add_numbered_adapter' [-Werror=implicit-function-declaration]
> >   ret = i2c_add_numbered_adapter(&priv->adap);
> >     ^
> > arch/mips/mti-sead3/sead3-pic32-i2c-drv.c: In function
> > 'i2c_platform_remove':
> > arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:361:2: error: implicit declaration
> > of function 'i2c_del_adapter' [-Werror=implicit-function-declaration]
> > i2c_del_adapter(&priv->adap);
> 
> The platform devices should always be registered.
> 
> And why on earth is there an I2C drivers in arch?  That should rather
> go to drivers/i2c/busses/.

It's even worse.  arch/mips/mti-sead3/sead3-pic32-i2c-drv.c registers a
driver - but nothing registers a platform device for it.  And nobody's
apparently missing a functioning driver.  Nuke?

  Ralf
