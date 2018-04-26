Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2018 08:55:43 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57206 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990410AbeDZGzgg8HRh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Apr 2018 08:55:36 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 64320407;
        Thu, 26 Apr 2018 06:55:29 +0000 (UTC)
Date:   Thu, 26 Apr 2018 08:55:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     alexander.levin@microsoft.com, linux-mips@linux-mips.org,
        matt.redfearn@mips.com, paul.burton@mips.com, ralf@linux-mips.org,
        stable-commits@vger.kernel.org
Subject: Re: Patch "MIPS: generic: Fix machine compatible matching" has been
 added to the 4.14-stable tree
Message-ID: <20180426065521.GA14025@kroah.com>
References: <1524582066147140@kroah.com>
 <20180425220221.GB25917@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425220221.GB25917@saruman>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63792
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

On Wed, Apr 25, 2018 at 11:02:21PM +0100, James Hogan wrote:
> On Tue, Apr 24, 2018 at 05:01:06PM +0200, gregkh@linuxfoundation.org wrote:
> > We now have a platform (Ranchu) in the "generic" platform which matches
> 
> The reason I didn't tag stable was because Ranchu was added in 4.16 ...
> 
> >  	if (!mach->matches)
> >  		return NULL;
> 
> ... so mach->matches will always be NULL before 4.16 ...
> 
> >  
> > -	for (match = mach->matches; match->compatible; match++) {
> > +	for (match = mach->matches; match->compatible[0]; match++) {
> 
> ... so this can't get hit.
> 
> Feel free to drop, otherwise it does no harm, its dead code.

Now dropped, thanks for letting me know.

greg k-h
