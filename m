Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 08:07:04 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:46788 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbdFFGGzeoAdJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 08:06:55 +0200
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 862928EE;
        Tue,  6 Jun 2017 06:06:48 +0000 (UTC)
Date:   Tue, 6 Jun 2017 08:06:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH 5/9] MIPS: Rename `sigill_r6' to `sigill_r2r6' in
 `__compute_return_epc_for_insn'
Message-ID: <20170606060643.GA25486@kroah.com>
References: <alpine.DEB.2.00.1706040314270.10864@tp.orcam.me.uk>
 <alpine.DEB.2.00.1706051739400.21750@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1706051739400.21750@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58253
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

On Tue, Jun 06, 2017 at 12:17:53AM +0100, Maciej W. Rozycki wrote:
> Cc: stable@vger.kernel.org # 3.19+
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> ---
>  Not a fix by itself, but needed for the next 2 changes.

And why isn't that info in the changelog text?  I know I will not take
patches without any changelog text, I don't know of other maintainers
are more "lax" about that :)

thanks,

greg k-h
