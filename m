Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 13:16:06 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011991AbbD1LQEJlZbO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 13:16:04 +0200
Received: from localhost (samsung-greg.rsr.lip6.fr [132.227.76.96])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 64F3226;
        Tue, 28 Apr 2015 11:15:58 +0000 (UTC)
Date:   Tue, 28 Apr 2015 13:15:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Jiri Slaby <jslaby@suse.cz>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] ttyFDC: Fix to use native endian MMIO reads
Message-ID: <20150428111556.GA16174@kroah.com>
References: <1430215050-4995-1-git-send-email-james.hogan@imgtec.com>
 <1430215050-4995-3-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430215050-4995-3-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47129
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

On Tue, Apr 28, 2015 at 10:57:30AM +0100, James Hogan wrote:
> The MIPS Common Device Memory Map (CDMM) is internal to the core and has
> native endianness. There is therefore no need to byte swap the accesses
> on big endian targets, so convert the Fast Debug Channel (FDC) TTY
> driver to use __raw_readl()/__raw_writel() rather than
> ioread32()/iowrite32().
> 
> Fixes: 4cebec609aea ("TTY: Add MIPS EJTAG Fast Debug Channel TTY driver")
> Fixes: c2d7ef51d731 ("ttyFDC: Implement KGDB IO operations.")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-mips@linux-mips.org
> ---
>  drivers/tty/mips_ejtag_fdc.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
