Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2016 18:40:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39672 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27031859AbcETQkNIWL1d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 May 2016 18:40:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4KGeAJE007337;
        Fri, 20 May 2016 18:40:10 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4KGe865007336;
        Fri, 20 May 2016 18:40:08 +0200
Date:   Fri, 20 May 2016 18:40:08 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>, Paul.Burton@imgtec.com
Subject: Re: [PATCH]: ELF/MIPS build fix
Message-ID: <20160520164008.GC13016@linux-mips.org>
References: <20160520141705.GA1913@linux-mips.org>
 <alpine.LFD.2.20.1605201735220.17173@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1605201735220.17173@eddie.linux-mips.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, May 20, 2016 at 05:37:17PM +0100, Maciej W. Rozycki wrote:

> > CONFIG_MIPS32_N32=y but CONFIG_BINFMT_ELF disabled results in the following
> > linker errors:
> 
>  Is this for a configuration with native (n64) ELF disabled, but one or 
> more compat ELF formats (o32, n32) enabled?  An interesting use case then.

Yes.  Fairly sensible for one of those systems where we only support 64 bit
kernels but don't need a 64 bit userland.

  Ralf
