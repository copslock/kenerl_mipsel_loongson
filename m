Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 10:05:20 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48300 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010792AbbBBJFSMqAS3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 10:05:18 +0100
Received: by mail-pa0-f46.google.com with SMTP id lj1so79889642pab.5;
        Mon, 02 Feb 2015 01:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZBHsHdyQLisLeEwaMGT6MPZjzikDzkN2plEVZmiDWz0=;
        b=RgNfKa3x2Su/Smj74zktv0osj7yPqRY4TapY5PB1sWBoUaQElZoMKX9FjO1n0pgBhA
         ush6xB974UN+bEWPmgeRYPFBhS0YWKzWACWFSyU1/NBup11c12uP2x04QOPnhNIcvKu3
         NOOouY7Eg1DkwwetbL3Dzv8IPr1D35VmNj1f53WKxbe/48F0Gn2ovBhdqBZu4p8lnPbg
         nk+hGRCpSXG2ADLY8J2Y57ufGqSooCrMwH8gxthsoMDHVSKS5LmAr/E9YdBm3G8iDtcL
         VTZaQ+5JdvmI47AWsMQl7UyYPakcnCFyyGx/7MQa1ai2brGHUojfaDCRxPNLqvMP+EwS
         v/eA==
X-Received: by 10.67.7.225 with SMTP id df1mr28444147pad.48.1422867912137;
        Mon, 02 Feb 2015 01:05:12 -0800 (PST)
Received: from norris-Latitude-E6410 (cpe-45-48-59-37.socal.res.rr.com. [45.48.59.37])
        by mx.google.com with ESMTPSA id r14sm17425912pdi.67.2015.02.02.01.05.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Feb 2015 01:05:11 -0800 (PST)
Date:   Mon, 2 Feb 2015 01:05:08 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: jz4740: Convert to GPIO descriptor API
Message-ID: <20150202090508.GF3523@norris-Latitude-E6410>
References: <1417549706-28420-1-git-send-email-lars@metafoo.de>
 <20141215154408.GD9382@linux-mips.org>
 <20150109200535.GV9759@ld-irv-0074>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150109200535.GV9759@ld-irv-0074>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Fri, Jan 09, 2015 at 12:05:35PM -0800, Brian Norris wrote:
> On Mon, Dec 15, 2014 at 04:44:08PM +0100, Ralf Baechle wrote:
> > On Tue, Dec 02, 2014 at 08:48:26PM +0100, Lars-Peter Clausen wrote:
> > 
> > > Use the GPIO descriptor API instead of the deprecated legacy GPIO API to
> > > manage the busy GPIO.
> > > 
> > > The patch updates both the jz4740 nand driver and the only user of the driver
> > > the qi-lb60 board driver.
> > > 
> > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > ---
> > > This patch should preferably be merged through the MTD tree with Ralf's ack for
> > > the MIPS bits.
> > 
> > Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
> For MTD stuff:
> 
> Acked-by: Brian Norris <computersforpeace@gmail.com>
> 
> > Though in my experience MIPS-specific patches to non-arch/mips code receive
> > best testing in the MIPS tree.
> 
> I don't mind this going in the MIPS tree. I doubt this driver will get
> much other activity in MTD soon, and you're likely quite right about
> MIPS testing.
> 
> Let me know if you'd like to take it. If I don't hear back in a week or
> two, I'll take it via MTD.

OK, applied to l2-mtd.git.

Brian
