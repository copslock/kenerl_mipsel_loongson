Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Nov 2014 05:30:23 +0100 (CET)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56104 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007304AbaKIEaWGzCFw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Nov 2014 05:30:22 +0100
Received: from pool-96-249-243-124.nrflva.fios.verizon.net ([96.249.243.124] helo=titan)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1XnK8k-000HCZ-2x; Sun, 09 Nov 2014 04:30:14 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id 426836155F7;
        Sat,  8 Nov 2014 23:30:10 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 96.249.243.124
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19/BuFEd1mK8bYlEiMADFzkURv07a2ayA4=
X-DKIM: OpenDKIM Filter v2.0.1 titan 426836155F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1415507410;
        bh=X2vzGKybZ2wtvhFihfT5rp+bM/O24RIqI5ABKgnyvIM=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=ZEamxgZ6wwsuD7MZeXk8XpoqgWKxntQfPfvIASqB05Evhr+uLCstc49gzIvptp5y8
         OF/bc+O3a3Zneewu+cHCWPQ/fXI5VfjzllRD1BGLol6exh0QI00B1ldlTyS3+P+VeS
         6ocMQd5hItrThQuyWbUalOlKiv52LSD32mSXmXG+cb7+mTHfIzgCgLGkWHH7xb589s
         NNELZAaLTCeQXWYsz9fkEQ37BTLPXhdXVZLz+NWYexsOfzWFJSusVaCyQdK3Z1mWVg
         rB2UC78x5oNbkG6dO+jNq+T2LPpR5wGPrdsNRqo/aaBrbciNClnmbp1W4LKPMxnR7M
         xRmqKTgfZuzqQ==
Date:   Sat, 8 Nov 2014 23:30:10 -0500
From:   Jason Cooper <jason@lakedaemon.net>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     tglx@linutronix.de, linux-sh@vger.kernel.org, arnd@arndb.de,
        f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH V4 00/14] genirq endian fixes; bcm7120/brcmstb IRQ
 updates
Message-ID: <20141109043010.GR3698@titan.lakedaemon.net>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
 <20141107122745.GJ3698@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141107122745.GJ3698@titan.lakedaemon.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

On Fri, Nov 07, 2014 at 07:27:45AM -0500, Jason Cooper wrote:
> Thomas,
> 
> On Thu, Nov 06, 2014 at 10:44:15PM -0800, Kevin Cernekee wrote:
> > V3->V4:
> > 
> >  - Fix buildbot bisectability warning on patch 02/14 (missing include)
> 
> Dammit.  :(  Even if I had created a topic branch for this series, I
> still would have put the genirq changes in /core, then based a brcm
> branch off of that.
> 
> I'm inclined to think I should just drop v3 and apply v4, as a revert
> commit wouldn't solve the bisectability issue.

Ok, no complaints, so it's done.

thx,

Jason.
