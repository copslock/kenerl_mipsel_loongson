Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2017 18:35:08 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37256 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993875AbdCTRfAyNmBJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Mar 2017 18:35:00 +0100
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 210FFB80;
        Mon, 20 Mar 2017 17:34:53 +0000 (UTC)
Date:   Mon, 20 Mar 2017 18:34:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 4.4 08/35] MIPS: Update lemote2f_defconfig for
 CPU_FREQ_STAT change
Message-ID: <20170320173432.GA20708@kroah.com>
References: <20170316142906.685052998@linuxfoundation.org>
 <20170316142907.261390617@linuxfoundation.org>
 <1489939579.2852.72.camel@decadent.org.uk>
 <20170320101530.GD14919@linux-mips.org>
 <20170320162957.GB23463@kroah.com>
 <20170320165049.GH14919@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320165049.GH14919@linux-mips.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57401
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

On Mon, Mar 20, 2017 at 05:50:49PM +0100, Ralf Baechle wrote:
> On Mon, Mar 20, 2017 at 05:29:57PM +0100, Greg Kroah-Hartman wrote:
> 
> > > I don't think so, I don't get warnings for "make ARCH=mips lemote2f_defconfig"
> > 
> > Ok, is it worth reverting as this is an issue on later kernels?
> 
> Same answer as for the other patch - I can't imagine it's going to cause
> any problems.

Thanks for the response, will leave these as-is.

greg k-h
