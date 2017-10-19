Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 11:36:44 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:49592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990414AbdJSJghjJBpN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 11:36:37 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7DFEE8EE;
        Thu, 19 Oct 2017 09:36:30 +0000 (UTC)
Date:   Thu, 19 Oct 2017 11:36:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: Re: [PATCH 4.4 36/50] MIPS: IRQ Stack: Unwind IRQ stack onto task
 stack
Message-ID: <20171019093638.GD20059@kroah.com>
References: <20171006083705.157012217@linuxfoundation.org>
 <20171006083711.033827562@linuxfoundation.org>
 <1508189305.22379.54.camel@codethink.co.uk>
 <599a61c7-b25c-47a7-7664-443666d2d8bd@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <599a61c7-b25c-47a7-7664-443666d2d8bd@mips.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60461
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

On Tue, Oct 17, 2017 at 08:18:23AM +0100, Matt Redfearn wrote:
> 
> 
> On 16/10/17 22:28, Ben Hutchings wrote:
> > On Fri, 2017-10-06 at 10:53 +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Matt Redfearn <matt.redfearn@imgtec.com>
> > > 
> > > 
> > > [ Upstream commit db8466c581cca1a08b505f1319c3ecd246f16fa8 ]
> > [...]
> > 
> > There was a follow-up to this which I suspect is also needed on the 4.4
> > and 4.9 branches: commit 5fdc66e04620 ("MIPS: Fix minimum alignment
> > requirement of IRQ stack").
> > 
> > Ben.
> > 
> Hi Ben,
> 
> Yes you are correct, I missed tagging that one for stable. Please apply it.

Thanks for letting me know, now queued up.

greg k-h
