Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 14:12:44 +0200 (CEST)
Received: from mail-wg0-f54.google.com ([74.125.82.54]:34465 "EHLO
        mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006986AbbFBMMm45J74 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 14:12:42 +0200
Received: by wgv5 with SMTP id 5so138336359wgv.1;
        Tue, 02 Jun 2015 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OlOgj7oLhI54w8l2hUol8L1nFuCE5TPmmSlfp0UGWdI=;
        b=sLBb6KO7eOlpjKtbiz2uOcrr4NM6RttQ7pUU1S7rutA6dqKn17c5PviVIWUDgoFYOf
         IBQqFxHqaAxLGhkuypJT1w/EqBRmFZSqOvrgEttEC/iAlgN8jhrf4NERMY15M0vnRusL
         c5pJyM4irOOtn541GUbhu10EaHYsH3Hpc3fvTIgIAh7glUuj9xPIt4sxjsmRZaMKM1xc
         O6dnU14XQcbABC9uwrUF1nAYbLWQovglb4VnnW4h7zzy7VpV6oNb4kR+RzyaLNveIEAX
         0N3lMbpUBNLH8QLdid5czULmOpvMUyZNdRQeSxyO7xv7/3JcrnoUqIiBFVRCWaYepj0J
         chyw==
X-Received: by 10.180.39.203 with SMTP id r11mr30018349wik.47.1433247153550;
        Tue, 02 Jun 2015 05:12:33 -0700 (PDT)
Received: from macpro.local ([2a02:a03f:8ec:bb00:51d0:57cb:b42d:bceb])
        by mx.google.com with ESMTPSA id j7sm26535374wjz.11.2015.06.02.05.12.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2015 05:12:32 -0700 (PDT)
Date:   Tue, 2 Jun 2015 14:12:29 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, benh@kernel.crashing.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, markos.chandras@imgtec.com,
        macro@linux-mips.org, Steven.Hill@imgtec.com,
        alexander.h.duyck@redhat.com, davem@davemloft.net
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
Message-ID: <20150602121227.GA1474@macpro.local>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
 <20150602000934.6668.43645.stgit@ubuntu-yegoshin>
 <20150602100835.GG24014@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150602100835.GG24014@NP-P-BURTON>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <luc.vanoostenryck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luc.vanoostenryck@gmail.com
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

On Tue, Jun 02, 2015 at 11:08:35AM +0100, Paul Burton wrote:
> Hi Leonid,
> 

<snip>

> > +
> > +	  If that instructions are not implemented in processor then it is
> > +	  converted to generic "SYNC 0".
> 
> I think this would read better as something like:
> 
>   If a processor does not implement the lightweight sync operations then
>   the architecture requires that they interpret the corresponding sync
>   instructions as the typical heavyweight "sync 0". Therefore this
>   should be safe to enable on all CPUs implementing release 2 or
>   later of the MIPS architecture.
> 

Is it really the case for release 2?

I'm asking because recently I needed to do something similar and I couldn't
find this garantee in the revision 2.00 of the manual.
May it's just poorly formulated but here is what I find in it:
- "The stype values 1-31 are reserved for future extensions to the architecture."
  (ok)
- "A value of zero will always be defined such that it performs all defined
   synchronization operations." (ok)
- "Non-zero values may be defined to remove some synchronization operations."
  (ok, certainly if we understand the word "weaker" instead of "remove")
- "As such, software should never use a non-zero value of the stype field, as
  this may inadvertently cause future failures if non-zero values remove
  synchronization operations." (Mmmm, ok but ...)
Nowhere is there something close to what is found in the revision 5.0 or later:
  "If an implementation does not use one of these non-zero values to define a
   different synchronization behavior, then that non-zero value of stype must
   act the same as stype zero completion barrier."

The wording may have changed since revision 2.8 but I don't have access to the
corresponding manual.


Luc Van Oostenryck
