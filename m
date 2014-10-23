Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 20:19:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48625 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010103AbaJWST2ENEkv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Oct 2014 20:19:28 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9NIJQS2006746;
        Thu, 23 Oct 2014 20:19:26 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9NIJQae006745;
        Thu, 23 Oct 2014 20:19:26 +0200
Date:   Thu, 23 Oct 2014 20:19:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: sead3: Build the I2C related devices if
 CONFIG_I2C is enabled
Message-ID: <20141023181925.GA6719@linux-mips.org>
References: <1412847261-7930-1-git-send-email-markos.chandras@imgtec.com>
 <1412847261-7930-3-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412847261-7930-3-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43543
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

On Thu, Oct 09, 2014 at 10:34:20AM +0100, Markos Chandras wrote:

> There is no point building the drivers for the i2c related devices if
> CONFIG_I2C is not enabled.
> 
> This also fixes a randconfig problem:
> 
> arch/mips/mti-sead3/sead3-pic32-i2c-drv.c: In function 'i2c_platform_probe':
> arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:345:2: error: implicit declaration of
> function 'i2c_add_numbered_adapter' [-Werror=implicit-function-declaration]
>   ret = i2c_add_numbered_adapter(&priv->adap);
>     ^
> arch/mips/mti-sead3/sead3-pic32-i2c-drv.c: In function
> 'i2c_platform_remove':
> arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:361:2: error: implicit declaration
> of function 'i2c_del_adapter' [-Werror=implicit-function-declaration]
> i2c_del_adapter(&priv->adap);

The platform devices should always be registered.

And why on earth is there an I2C drivers in arch?  That should rather
go to drivers/i2c/busses/.

  Ralf
