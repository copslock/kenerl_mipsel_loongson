Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Apr 2017 15:13:46 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbdDSNNjNmXIu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Apr 2017 15:13:39 +0200
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A50198C;
        Wed, 19 Apr 2017 13:13:31 +0000 (UTC)
Date:   Wed, 19 Apr 2017 15:13:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 4.4 27/32] MIPS: Force o32 fp64 support on 32bit MIPS64r6
 kernels
Message-ID: <20170419131322.GB32643@kroah.com>
References: <20170410163839.055472822@linuxfoundation.org>
 <20170410163843.079809660@linuxfoundation.org>
 <alpine.LFD.2.20.1704150040420.29296@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1704150040420.29296@eddie.linux-mips.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57731
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

On Sat, Apr 15, 2017 at 12:45:42AM +0100, Maciej W. Rozycki wrote:
> On Mon, 10 Apr 2017, Greg Kroah-Hartman wrote:
> 
> > Force o32 fp64 support in this case by also selecting
> > MIPS_O32_FP64_SUPPORT from CPU_MIPS64_R6 if 32BIT.
> [...]
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -1412,7 +1412,7 @@ config CPU_MIPS32_R6
> >  	select CPU_SUPPORTS_MSA
> >  	select GENERIC_CSUM
> >  	select HAVE_KVM
> > -	select MIPS_O32_FP64_SUPPORT
> > +	select MIPS_O32_FP64_SUPPORT if 32BIT
> >  	help
> >  	  Choose this option to build a kernel for release 6 or later of the
> >  	  MIPS32 architecture.  New MIPS processors, starting with the Warrior
> 
>  Has the patch been misapplied?  Its description refers to CPU_MIPS64_R6, 
> however the hunk heading in the diff itself indicates CPU_MIPS32_R6.

Ugh, you are right, I think I had to apply this one by hand, and got it
really wrong.  I'll go fix it up now, many thanks for pointing it out.

greg k-h
