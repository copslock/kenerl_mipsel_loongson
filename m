Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jun 2015 21:14:13 +0200 (CEST)
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49474 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008475AbbFSTOLiNfeM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jun 2015 21:14:11 +0200
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id D158720BBC
        for <linux-mips@linux-mips.org>; Fri, 19 Jun 2015 15:14:10 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 19 Jun 2015 15:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=w/sLWpHHnwonu+K2X3wkAiNjOEI=; b=GKjsP
        bj4rNEP9ThfquAIeKvK6v/6H0i5m7KBqVbrimweqBD0WPp6XUFxqdoqWmH1o/ssR
        26aSY6E3pYSfTmIFM2IZKODQePRP/+mm/eMn1jOpEqLoj9SwsBzEgNMzO1nvHxJY
        Ttkwy/n3x0LRD+SetbJQWSGahzeQNc51TmDqcU=
X-Sasl-enc: n25h3DsDNCQGswlw1utJ/w3ZXp8k+oGrT3X/22bqvx0a 1434741250
Received: from localhost (unknown [50.170.35.168])
        by mail.messagingengine.com (Postfix) with ESMTPA id 661A8C0028A;
        Fri, 19 Jun 2015 15:14:10 -0400 (EDT)
Date:   Fri, 19 Jun 2015 12:14:09 -0700
From:   Greg KH <greg@kroah.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     stable <stable@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: KVM: do not sign extend on unsigned MMIO load
Message-ID: <20150619191409.GA12700@kroah.com>
References: <1431002870-30098-1-git-send-email-hofrat@osadl.org>
 <554CC530.20906@imgtec.com>
 <5575536E.8080608@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5575536E.8080608@imgtec.com>
User-Agent: Mutt/1.5.23+89 (0255b37be491) (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Mon, Jun 08, 2015 at 09:33:50AM +0100, James Hogan wrote:
> Hi stable folk,
> 
> On 08/05/15 15:16, James Hogan wrote:
> > On 07/05/15 13:47, Nicholas Mc Guire wrote:
> >> Fix possible unintended sign extension in unsigned MMIO loads by casting
> >> to uint16_t in the case of mmio_needed != 2.
> >>
> >> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > 
> > Looks good to me. I wrote an MMIO test to reproduce the issue, and this
> > fixes it.
> > 
> > Reviewed-by: James Hogan <james.hogan@imgtec.com>
> > Tested-by: James Hogan <james.hogan@imgtec.com>
> > 
> > It looks suitable for stable too (3.10+).
> 
> This has reached mainline, commit ed9244e6c534612d2b5ae47feab2f55a0d4b4ced
> 
> Please could it be added to stable (3.10+).

It does not apply to 3.10 or 3.14-stable, so please provide a backport
if you want it there.

thanks,

greg k-h
