Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 11:02:11 +0200 (CEST)
Received: from merlin.infradead.org ([205.233.59.134]:54479 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903693Ab2FFJCB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 11:02:01 +0200
Received: from canuck.infradead.org ([2001:4978:20e::1])
        by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
        id 1ScC7b-0006JF-Kj; Wed, 06 Jun 2012 09:01:43 +0000
Received: from dhcp-089-099-019-018.chello.nl ([89.99.19.18] helo=twins)
        by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
        id 1ScC7a-00083k-MZ; Wed, 06 Jun 2012 09:01:43 +0000
Received: by twins (Postfix, from userid 1000)
        id 8D8C88028D56; Wed,  6 Jun 2012 11:01:35 +0200 (CEST)
Message-ID: <1338973295.2749.81.camel@twins>
Subject: Re: [RFC PATCH] sched/numa: do load balance between remote nodes
From:   Peter Zijlstra <a.p.zijlstra@chello.nl>
To:     Alex Shi <alex.shi@intel.com>
Cc:     anton@samba.org, benh@kernel.crashing.org, cmetcalf@tilera.com,
        dhowells@redhat.com, davem@davemloft.net, fenghua.yu@intel.com,
        hpa@zytor.com, ink@jurassic.park.msu.ru,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        mattst88@gmail.com, paulus@samba.org, lethal@linux-sh.org,
        ralf@linux-mips.org, rth@twiddle.net, sparclinux@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, sivanich@sgi.com,
        greg.pearson@hp.com, kamezawa.hiroyu@jp.fujitsu.com,
        bob.picco@oracle.com, chris.mason@oracle.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mingo@kernel.org, pjt@google.com, tglx@linutronix.de,
        seto.hidetoshi@jp.fujitsu.com, ak@linux.intel.com,
        arjan.van.de.ven@intel.com
Date:   Wed, 06 Jun 2012 11:01:35 +0200
In-Reply-To: <1338965571-9812-1-git-send-email-alex.shi@intel.com>
References: <1338965571-9812-1-git-send-email-alex.shi@intel.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-archive-position: 33563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.p.zijlstra@chello.nl
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 2012-06-06 at 14:52 +0800, Alex Shi wrote:
> -       if (sched_domains_numa_distance[level] > REMOTE_DISTANCE)
> +       if (sched_domains_numa_distance[level] > RECLAIM_DISTANCE) 

I actually considered this.. I just felt a little uneasy re-purposing
the RECLAIM_DISTANCE for this, but I guess its all the same anyway. Both
mean expensive-away-distance.

So I've taken this.

thanks!
