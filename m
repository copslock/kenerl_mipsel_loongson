Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 16:09:49 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014653AbbCZPJ3UMJpI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 16:09:29 +0100
Received: from localhost (samsung-greg.rsr.lip6.fr [132.227.76.96])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D2A00B12;
        Thu, 26 Mar 2015 15:09:23 +0000 (UTC)
Date:   Thu, 26 Mar 2015 16:09:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH 9/9] ttyFDC: Implement KGDB IO operations.
Message-ID: <20150326150920.GC21726@kroah.com>
References: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
 <1422530054-7976-10-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1422530054-7976-10-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46551
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

On Thu, Jan 29, 2015 at 11:14:14AM +0000, James Hogan wrote:
> Implement KGDB IO operations for MIPS Fast Debug Channel (FDC). This can
> be enabled via Kconfig, which also allows the channel number to be
> chosen.
> 
> The magic sysrq hack is implemented in the TTY driver, detecting just ^C
> for the KGDB channel, and ^O followed by a letter for the FDC console
> channel.
> 
> The KGDB operations are reasonably efficient thanks to the flush
> callback, with a 4 byte buffer being used in both directions to allow up
> to 4 bytes to be encoded per FDC word. Reading of data for KGDB will
> discard any data received on other channels, which clearly isn't ideal,
> but given that there is a single FIFO shared between channels we can't
> do much better.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: linux-mips@linux-mips.org
> Cc: kgdb-bugreport@lists.sourceforge.net

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
