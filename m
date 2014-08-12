Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2014 09:24:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60944 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6842536AbaHLHYBql80- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Aug 2014 09:24:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0627376EA7C63;
        Tue, 12 Aug 2014 08:23:53 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 12 Aug
 2014 08:23:54 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 12 Aug 2014 08:23:54 +0100
Received: from localhost (192.168.154.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 12 Aug
 2014 08:23:53 +0100
Date:   Tue, 12 Aug 2014 08:23:53 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/4] MIPS: cpu-probe: Set the write-combine CCA value on
 per core basis
Message-ID: <20140812072353.GC12230@mchandras-linux.le.imgtec.org>
References: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com>
 <1405677093-22591-4-git-send-email-markos.chandras@imgtec.com>
 <53E00F39.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <53E00F39.7@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi Florian,

On Mon, Aug 04, 2014 at 03:54:49PM -0700, Florian Fainelli wrote:
> Hi Markos,
> 
> On 07/18/2014 02:51 AM, Markos Chandras wrote:
> > Different cores use different CCA values to achieve write-combine
> > memory writes. For cores that do not support write-combine we
> > set the default value to CCA:2 (uncached, non-coherent) which is the
> > default value as set by the kernel.
> > 
> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> > ---
> [snip]
> 			break;
> > @@ -765,67 +767,83 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
> >  
> >  static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
> >  {
> > +	c->writecombine = _CACHE_UNCACHED_ACCELERATED;
> 
> Why do we set this writecombine setting by default, when later we are
> going to override writecombine on a per-cpu basic.
> 
> In the end, we have the following:
> 
> cpu_probe()
> 	c->writecombine = _CACHE_UNCACHED;
> 
> 	cpu_probe_mips()
> 		c->writecombine = _CACHE_UNCACHED_ACCELERATED:
> 		... per-cpu case ...
> 		c->writecombine = _CACHE_UNCACHED;
> 
> Can't we just eliminate the various assignments in cpu_probe_mips() and
> only override c->writecombine if _CACHE_UNCACHED is not suitable?
> 
The reason I did it like this, is that new cores (eg *Aptiv family) will use
_CACHE_UNCACHED_ACCELERATED and that's why it's the 'default' option for
the MIPS cores. _CACHE_UNCACHED is only suitable for old cores.
The way it is right now, allows us to not have to set this option whenever we
add support for a new core since it will inherit the default option.

-- 
markos
