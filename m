Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 14:52:54 +0200 (CEST)
Received: from mail-wg0-f42.google.com ([74.125.82.42]:61967 "EHLO
        mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012026AbaJUMwxH3va- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 14:52:53 +0200
Received: by mail-wg0-f42.google.com with SMTP id z12so1276272wgg.13
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OD3LVrZXHZ+/r8iFkYcMZhhno2ETrs8ArfZ6uFWDCq0=;
        b=DomhvtdmTAy93KAkSL3bQhkJ/zJR1zHOs9gJ5OykX30e/4u7DChGFNyymzlIPXS2EE
         oBGQpWeqYiRrHjI8OD+Av2upv7JjM8fjNrKwPucyKoooOZPN/Nzi+Zd0OIoM0q2C03uv
         xuoM4728rpTUY0bUJkOQftQ7Tnd3T+rAb2zKLzrgDk0rX9XIrZSm8ff6+qIC6viWsvqT
         9Pn1GABiegMXoAuSOr0bkxcvhZNUy+koxfDtF2EkNSo4EFwFGxxfaAnTwaADwhej1FlC
         ESFEs9VHGhcPxCzIApY48EuP/rPXFqhJXTSTj7lrXiebCT6wMU95rIQ1auLBhCb/Qc1Z
         Bgkg==
X-Received: by 10.180.90.105 with SMTP id bv9mr29038000wib.53.1413895966486;
        Tue, 21 Oct 2014 05:52:46 -0700 (PDT)
Received: from netboy ([84.253.56.197])
        by mx.google.com with ESMTPSA id lm9sm15280500wjc.45.2014.10.21.05.52.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 05:52:45 -0700 (PDT)
Date:   Tue, 21 Oct 2014 14:52:40 +0200
From:   Richard Cochran <richardcochran@gmail.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, Jonathan Corbet <corbet@lwn.net>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Foley <pefoley2@pefoley.com>
Subject: Re: [PATCH] Documentation: ptp: Fix build failure on MIPS cross
 builds
Message-ID: <20141021125240.GB16479@netboy>
References: <1413794538-28465-1-git-send-email-markos.chandras@imgtec.com>
 <20141021110724.GA16479@netboy>
 <54464D6A.5000501@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54464D6A.5000501@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <richardcochran@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richardcochran@gmail.com
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

(adding Peter Foley to CC ...)

On Tue, Oct 21, 2014 at 01:11:22PM +0100, Markos Chandras wrote:
> On 10/21/2014 12:07 PM, Richard Cochran wrote:
> > On Mon, Oct 20, 2014 at 09:42:18AM +0100, Markos Chandras wrote:
> >> diff --git a/Documentation/ptp/Makefile b/Documentation/ptp/Makefile
> >> index 293d6c09a11f..397c1cd2eda7 100644
> >> --- a/Documentation/ptp/Makefile
> >> +++ b/Documentation/ptp/Makefile
> >> @@ -1,5 +1,15 @@
> >>  # List of programs to build
> >> +ifndef CROSS_COMPILE
> >>  hostprogs-y := testptp
> >> +else
> >> +# MIPS system calls are defined based on the -mabi that is passed
> >> +# to the toolchain which may or may not be a valid option
> >> +# for the host toolchain. So disable testptp if target architecture
> >> +# is MIPS but the host isn't.
> >> +ifndef CONFIG_MIPS
> >> +hostprogs-y := testptp
> >> +endif
> >> +endif
> > 
> > It seems like a shame to simply give up and not compile this at all.
> > Is there no way to correctly cross compile this for MIPS?
> > 
> > Thanks,
> > Richard
> > 
> 
> As far as I can see you don't cross-compile the file. You use the host
> toolchain.

Look at Documentation/ptp/testptp.mk. There I do use $CROSS_COMPILE.

> There is no clean way to build it for host if you have your
> kernel configured for MIPS. Perhaps maybe you could define
> __MIPS_SIM_{ABI64, ABI32, NABI32} in the gcc command line (-D...) but
> this is a bit ugly. Or maybe use the host headers instead of the ones in
> the kernel source.

Your patch is for the file, Documentation/ptp/Makefile. I did not
write that file. Maybe Peter knows how to fix it?

Thanks,
Richard
