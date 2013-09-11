Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2013 17:59:19 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47343 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822304Ab3IKP7LMkbCz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Sep 2013 17:59:11 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D541CA9A;
        Wed, 11 Sep 2013 15:59:02 +0000 (UTC)
Date:   Wed, 11 Sep 2013 08:59:02 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH] MIPS: kernel: vpe: Make vpe_attrs an array of pointers.
Message-ID: <20130911155902.GB24542@kroah.com>
References: <1378901872-20683-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1378901872-20683-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37786
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

On Wed, Sep 11, 2013 at 01:17:52PM +0100, Markos Chandras wrote:
> Commit 567b21e973ccf5b0d13776e408d7c67099749eb8
> "mips: convert vpe_class to use dev_groups"
> 
> broke the build on MIPS since vpe_attrs should be an array
> of 'struct device_attribute' pointers.
> 
> Fixes the following build problem:
> arch/mips/kernel/vpe.c:1372:2: error: missing braces around initializer
> [-Werror=missing-braces]
> arch/mips/kernel/vpe.c:1372:2: error: (near initialization for 'vpe_attrs[0]')
> [-Werror=missing-braces]
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: John Crispin <blogic@openwrt.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/kernel/vpe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ugh, sorry about that, I thought I cross-built this, testing it out, but
it looks like I didn't.  I'll queue this up after 3.12-rc1 is out,
thanks for sending it.

greg k-h
