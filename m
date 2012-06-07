Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 02:35:35 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:53197 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903717Ab2FGAfa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Jun 2012 02:35:30 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 06 Jun 2012 17:35:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="scan'208";a="175750030"
Received: from debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2012 17:35:17 -0700
Message-ID: <4FCFF6D8.70507@intel.com>
Date:   Thu, 07 Jun 2012 08:33:28 +0800
From:   Alex Shi <alex.shi@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111229 Thunderbird/9.0
MIME-Version: 1.0
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
CC:     anton@samba.org, benh@kernel.crashing.org, cmetcalf@tilera.com,
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
Subject: Re: [RFC PATCH] sched/numa: do load balance between remote nodes
References: <1338965571-9812-1-git-send-email-alex.shi@intel.com> <1338973295.2749.81.camel@twins>
In-Reply-To: <1338973295.2749.81.camel@twins>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.shi@intel.com
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

On 06/06/2012 05:01 PM, Peter Zijlstra wrote:

> On Wed, 2012-06-06 at 14:52 +0800, Alex Shi wrote:
>> -       if (sched_domains_numa_distance[level] > REMOTE_DISTANCE)
>> +       if (sched_domains_numa_distance[level] > RECLAIM_DISTANCE) 
> 
> I actually considered this.. I just felt a little uneasy re-purposing
> the RECLAIM_DISTANCE for this, but I guess its all the same anyway. Both
> mean expensive-away-distance.
> 


I understand you, the BIOS guys don't have a good alignment with us on
this.

> So I've taken this.
> 
> thanks!
