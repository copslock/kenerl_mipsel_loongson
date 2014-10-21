Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 20:28:09 +0200 (CEST)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42100 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012075AbaJUS2IN1FI8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 20:28:08 +0200
Received: by mail-wi0-f178.google.com with SMTP id r20so2703153wiv.5
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lYJy8knP4wur4AU1RVhHIHI21CU4NebbQuasv7uXIR8=;
        b=ZsBuYgUgLRQgUujvKfkshQFT8BNbzkbLbNIgaZN7vAl8ejUClD8IvwWiHmEiyD/xOk
         G9SxJ8IZQnQ8lg3ztEfalhzSZUy1TkQ/QmqODQ7Ps/UArG7ETRmLRkxD76yOIUJJ1Fy+
         e4LdvjboBLsUD151G5vwZD+R6oUAgwhT3FGNZYEDS2EqcmMP13tV9RikHQZfDnGOgiiD
         8MRF4H4pOpo4lCx8tMPQU9BlsQC9n2Tydx8NC1hDmXFS/X9BEr3RaivAepAf2WGD2qNY
         JndOVgd46Fg803iKt+LcQuhcrfrR0PMPNtfvCgkSCsAMiUst3YgyXvdRoDAunjKlz4JT
         xGwQ==
X-Received: by 10.180.91.19 with SMTP id ca19mr32068338wib.29.1413916082134;
        Tue, 21 Oct 2014 11:28:02 -0700 (PDT)
Received: from localhost.localdomain (194-166-229-1.adsl.highway.telekom.at. [194.166.229.1])
        by mx.google.com with ESMTPSA id lp8sm13910498wic.17.2014.10.21.11.28.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 11:28:01 -0700 (PDT)
Date:   Tue, 21 Oct 2014 20:27:57 +0200
From:   Richard Cochran <richardcochran@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     David Miller <davem@davemloft.net>, markos.chandras@imgtec.com,
        linux-mips@linux-mips.org, corbet@lwn.net, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
Subject: Re: [PATCH] Documentation: ptp: Fix build failure on MIPS cross
 builds
Message-ID: <20141021182757.GA3960@localhost.localdomain>
References: <1413794538-28465-1-git-send-email-markos.chandras@imgtec.com>
 <20141021110724.GA16479@netboy>
 <20141021.123544.9516812519754063.davem@davemloft.net>
 <544690CB.4030307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544690CB.4030307@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <richardcochran@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43428
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

(adding Makefile author Peter Foley onto CC)

On Tue, Oct 21, 2014 at 09:58:51AM -0700, David Daney wrote:
> On 10/21/2014 09:35 AM, David Miller wrote:
> >From: Richard Cochran <richardcochran@gmail.com>
> >Date: Tue, 21 Oct 2014 13:07:25 +0200
> >
> >>On Mon, Oct 20, 2014 at 09:42:18AM +0100, Markos Chandras wrote:
> >>>diff --git a/Documentation/ptp/Makefile b/Documentation/ptp/Makefile
> >>>index 293d6c09a11f..397c1cd2eda7 100644
> >>>--- a/Documentation/ptp/Makefile
> >>>+++ b/Documentation/ptp/Makefile
> >>>@@ -1,5 +1,15 @@
> >>>  # List of programs to build
> >>>+ifndef CROSS_COMPILE
> >>>  hostprogs-y := testptp
> >>>+else
> >>>+# MIPS system calls are defined based on the -mabi that is passed
> >>>+# to the toolchain which may or may not be a valid option
> >>>+# for the host toolchain. So disable testptp if target architecture
> >>>+# is MIPS but the host isn't.
> >>>+ifndef CONFIG_MIPS
> >>>+hostprogs-y := testptp
> >>>+endif
> >>>+endif
> >>
> >>It seems like a shame to simply give up and not compile this at all.
> >>Is there no way to correctly cross compile this for MIPS?
> >
> >Yeah seriously, we should try to make this work instead of throwing our
> >hands in the air.
> >
> 
> We cross compile things successfully all the time for all the
> various MIPS ABIs.
> 
> It is a simple matter of having the Makefile setup for cross compiling.
> 
> What I don't understand is why we are using hostprogs in this
> Makefile.  Isn't this a program that would run on the target, not
> the build host?

Yes.

Peter, could you please fix it?

Thanks,
Richard
