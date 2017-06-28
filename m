Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 18:28:16 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992675AbdF1Q2FC2PpS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jun 2017 18:28:05 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D5755728;
        Wed, 28 Jun 2017 16:27:57 +0000 (UTC)
Date:   Wed, 28 Jun 2017 18:27:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 10/10] MIPS: generic: Add optional support for Android
 kernel
Message-ID: <20170628162756.GA16759@kroah.com>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1498664922-28493-11-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498664922-28493-11-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58884
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

On Wed, Jun 28, 2017 at 05:47:03PM +0200, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
> 
> This commit adds new android.config configuration file including
> the most common prerequisites for running Android operating system.
> 
> The selected set of platform independent configuration parameters
> have been taken from the official Android kernel repo:
> https://android.googlesource.com/kernel/common/+
> /android-4.4/android/configs/android-base.cfg
> 
> android.config will be merged with the selected generic kernel
> configuration only if explicitly specified through environment
> variable OS=android.
> 
> Example:
> make ARCH=mips 64r6el_defconfig BOARDS="list of boards" OS=android
> 
> android.config file should be occasionally revisited and updated
> with latest requirements from Google.
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  MAINTAINERS                              |   1 +
>  arch/mips/Makefile                       |   8 +-
>  arch/mips/configs/generic/android.config | 173 +++++++++++++++++++++++++++++++

Why is this a MIPS config file?  What about the "generic" android
configs we already have?  Shouldn't they work just as well here?

And finally, does this config file fragment pass the latest tests that
Google has for kernel config requirements?

thanks,

greg k-h
