Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2016 18:37:20 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27031847AbcETQhRic0hd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2016 18:37:17 +0200
Date:   Fri, 20 May 2016 17:37:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>, Paul.Burton@imgtec.com
Subject: Re: [PATCH]: ELF/MIPS build fix
In-Reply-To: <20160520141705.GA1913@linux-mips.org>
Message-ID: <alpine.LFD.2.20.1605201735220.17173@eddie.linux-mips.org>
References: <20160520141705.GA1913@linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 20 May 2016, Ralf Baechle wrote:

> CONFIG_MIPS32_N32=y but CONFIG_BINFMT_ELF disabled results in the following
> linker errors:

 Is this for a configuration with native (n64) ELF disabled, but one or 
more compat ELF formats (o32, n32) enabled?  An interesting use case then.

  Maciej
