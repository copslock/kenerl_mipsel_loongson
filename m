Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 15:40:11 +0200 (CEST)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:44285 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012026AbaJUNkJyZB80 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 15:40:09 +0200
Received: by mail-wg0-f48.google.com with SMTP id k14so1398374wgh.19
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=n1d4dz20ToIr/rCWhdxx3TgLXQoqjbA++/DfLEacKtg=;
        b=UKxP/CcLtK8di/0wdzd4Ib6YHqm0TSHcWY7Pj+e+HOee5DyujWutmGspBT6oYyp9nK
         LHDJ91sv2TGMGwxLIwRXqxV0cCGasgijdx+TDSdQYoCOGZpUqs0tdV3+GAxjgqWOIs22
         Tefnmrn8n+qJ14MNrwSJ2IV76NimHI87uXPZLCZT0dUv2STPJOA/jLU+KGfM7FMjIb6m
         qRGyQHx3kMNBIHeypMApmxTB/HYJIQJQFcXOKt84nXJ9PEXjJZJuCzTJ4gjySAm4rYEO
         BMgxCtujMFiV2EHAJaIKAOgPO9JHLImI8AvBJk1iTvt0Mf763RVMkCM0QbgHmTNkEqYw
         /m5g==
X-Received: by 10.180.36.48 with SMTP id n16mr29717681wij.6.1413898804229;
        Tue, 21 Oct 2014 06:40:04 -0700 (PDT)
Received: from netboy (197.56.253.84.static.wline.lns.sme.cust.swisscom.ch. [84.253.56.197])
        by mx.google.com with ESMTPSA id ny6sm13132834wic.22.2014.10.21.06.40.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 06:40:03 -0700 (PDT)
Date:   Tue, 21 Oct 2014 15:39:59 +0200
From:   Richard Cochran <richardcochran@gmail.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, Jonathan Corbet <corbet@lwn.net>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Foley <pefoley2@pefoley.com>
Subject: Re: [PATCH] Documentation: ptp: Fix build failure on MIPS cross
 builds
Message-ID: <20141021133959.GC16479@netboy>
References: <1413794538-28465-1-git-send-email-markos.chandras@imgtec.com>
 <20141021110724.GA16479@netboy>
 <54464D6A.5000501@imgtec.com>
 <20141021125240.GB16479@netboy>
 <544659B1.6070509@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544659B1.6070509@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <richardcochran@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43425
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

On Tue, Oct 21, 2014 at 02:03:45PM +0100, Markos Chandras wrote:
> 
> Hmm I can't see this testptp.mk file in the mainline. What tree are you
> referring to?

Sorry, I have net-next open in front of me. The same guy who added
the buggy Makefile deleted my working makefile...

Thanks,
Richard
