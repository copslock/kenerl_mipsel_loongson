Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 22:36:43 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59132 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868692Ab3JCUglTsLPH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Oct 2013 22:36:41 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5C013A9C;
        Thu,  3 Oct 2013 20:36:33 +0000 (UTC)
Date:   Thu, 3 Oct 2013 13:36:32 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>, richard@nod.at
Subject: Re: [PATCH 1/2] staging: octeon-ethernet: don't assume that CPU 0 is
 special
Message-ID: <20131003203632.GA7115@kroah.com>
References: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38191
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

On Sat, Sep 28, 2013 at 10:50:33PM +0300, Aaro Koskinen wrote:
> Currently the driver assumes that CPU 0 is handling all the hard IRQs.
> This is wrong in Linux SMP systems where user is allowed to assign to
> hardware IRQs to any CPU. The driver will stop working if user sets
> smp_affinity so that interrupts end up being handled by other than CPU
> 0. The patch fixes that.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/staging/octeon/ethernet-rx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Given the objections for this series, I've now dropped it from my queue.
If you want to resubmit it, please do so.

thanks,

greg k-h
