Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 16:09:32 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014643AbbCZPJSvIsDE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 16:09:18 +0100
Received: from localhost (samsung-greg.rsr.lip6.fr [132.227.76.96])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 53000B13;
        Thu, 26 Mar 2015 15:09:13 +0000 (UTC)
Date:   Thu, 26 Mar 2015 16:09:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 8/9] MIPS, ttyFDC: Add early FDC console support
Message-ID: <20150326150909.GB21726@kroah.com>
References: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
 <1422530054-7976-9-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1422530054-7976-9-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46550
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

On Thu, Jan 29, 2015 at 11:14:13AM +0000, James Hogan wrote:
> Add support for early console of MIPS Fast Debug Channel (FDC) on
> channel 1 with a call very early from the MIPS setup_arch().
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/include/asm/cdmm.h | 11 +++++++++++
>  arch/mips/kernel/setup.c     |  2 ++
>  drivers/tty/Kconfig          | 13 +++++++++++++
>  drivers/tty/mips_ejtag_fdc.c | 20 ++++++++++++++++++++
>  4 files changed, 46 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
