Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 15:22:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4024 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028971AbcEKNWXfIGh2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 15:22:23 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 7F58E515CB9A8;
        Wed, 11 May 2016 14:22:14 +0100 (IST)
Received: from [10.20.78.170] (10.20.78.170) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Wed, 11 May 2016
 14:22:16 +0100
Date:   Wed, 11 May 2016 14:22:05 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>, <fengguang.wu@intel.com>,
        "stable # v4 . 4+" <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Allow R6 compact branch policy to be left
 unspecified
In-Reply-To: <20160511120544.GM16402@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1605111412420.6794@tp.orcam.me.uk>
References: <1461314611-15317-1-git-send-email-paul.burton@imgtec.com> <alpine.DEB.2.00.1604221648580.21846@tp.orcam.me.uk> <20160422173245.GC2467@jhogan-linux.le.imgtec.org> <20160511120544.GM16402@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.170]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Wed, 11 May 2016, Ralf Baechle wrote:

> I was wondering if we should simply probe for the availability of the
> GCC option and not use it, if using an older GCC, then change the
> help text for the option accordingly.  This approach would allow
> make randconfig or similar to work as expected with older compilers.

 Well, if the default is `optimal' anyway, then I think we can simply omit 
the option unless someone has requested an override.  In which case I 
think the compilation should fail if the option is not supported, under 
the principle of the least surprise -- if someone has requested a feature, 
then they ought to be informed that it is absent rather than silently 
fooled into thinking it has been enabled while in fact it has not.

 I agree probing for the presence of the option requested and then failing 
gracefully (e.g. "Toolchain feature FOO not available, please upgrade or 
reconfigure without BAR" or suchlike) is a better idea than just aborting 
midway through, and I think `randconfig' and similar validators should be 
prepared for it and handle gracefully as well (i.e. not a kernel bug).

 FWIW,

  Maciej
