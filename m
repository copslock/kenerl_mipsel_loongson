Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2015 04:23:02 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:4432 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006157AbbH0CXBCDuEC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Aug 2015 04:23:01 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP; 26 Aug 2015 19:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,420,1437462000"; 
   d="scan'208";a="791705010"
Received: from jliu23-mobl.ccr.corp.intel.com (HELO [10.238.130.203]) ([10.238.130.203])
  by orsmga002.jf.intel.com with ESMTP; 26 Aug 2015 19:22:50 -0700
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
To:     Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
 <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com>
 <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com>
 <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com>
 <alpine.DEB.2.11.1508261701430.15006@nanos> <55DDDE3C.8030609@imgtec.com>
 <alpine.DEB.2.11.1508262101450.15006@nanos>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
From:   Jiang Liu <jiang.liu@linux.intel.com>
Organization: Intel
Message-ID: <55DE7479.1010109@linux.intel.com>
Date:   Thu, 27 Aug 2015 10:22:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1508262101450.15006@nanos>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jiang.liu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.liu@linux.intel.com
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

On 2015/8/27 5:40, Thomas Gleixner wrote:
> But back to the IPIs. We need infrastructure and DT support to:
> 
> 1) reserve an IPI
> 
> 2) send an IPI
> 
> 3) request/free an IPI
> 
> #1 We have no infrastructure for that, but we definitely need one.
> 
>    We can look at the IPI as a single linux irq number which is
>    replicated on all cpu cores. The replication can happen in hardware
>    or by software, but that depends on the underlying root irq
>    controller. How that is implemented does not matter for the
>    reservation.
> 
>    The most flexible and platform independent solution would be to
>    describe the IPI space as a seperate irq domain. In most cases this
>    would be a hierarchical domain stacked on the root irq domain:
> 
>    [IPI-domain] --> [GIC-MIPS-domain]
> 
>    on x86 this would be:
> 
>    [IPI-domain] --> [vector-domain]
> 
>    That needs some change how the IPIs which are used by the kernel
>    (rescheduling, function call ..) are set up, but we get a proper
>    management and collision avoidance that way. Depending on the
>    platform we could actually remove the whole IPI compile time
>    reservation and hand out IPIs at boot time on demand and
>    dynamically.
Hi Thomas,
	Good point:) That will make the code more clear.
Thanks!
Gerry
