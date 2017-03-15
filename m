Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 10:52:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57310 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990514AbdCOJwUzrBAG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 10:52:20 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2F9PbDt008691;
        Wed, 15 Mar 2017 10:25:37 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2F9PamM008690;
        Wed, 15 Mar 2017 10:25:36 +0100
Date:   Wed, 15 Mar 2017 10:25:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Matt Turner <mattst88@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-nfs@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: NFS corruption, fixed by echo 1 > /proc/sys/vm/drop_caches --
 next debugging steps?
Message-ID: <20170315092536.GC22089@linux-mips.org>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
 <20170313094757.GI2878@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313094757.GI2878@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57287
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

On Mon, Mar 13, 2017 at 09:47:57AM +0000, James Hogan wrote:

> > 
> > Note that the corruption is different across reboots, both in the size
> > of the corruption and the location. I saw 1900~ and 1400~ byte
> > sequences corrupted on separate occasions, which don't correspond to
> > the system's 16kB page size.
> > 
> > I've tested kernels from v3.19 to 4.11-rc1+ (master branch from
> > today). All exhibit this behavior with differing frequencies. Earlier
> > kernels seem to reproduce the issue less often, while more recent
> > kernels reliably exhibit the problem every boot.
> > 
> > How can I further debug this?
> 
> It smells a bit like a DMA / caching issue.
> 
> Can you provide a full kernel log. That might provide some information
> about caching that might be relevant (e.g. does dcache have aliases?).

The architecture of the BCM1250 SOC used for the BCM91250 boards are
fully coherent, S-cache and D-cache are physically indexed and tagged.
Only the VIVT (plus the usual ASID tagging) I-cache leaves space for
software to screw up cache management but that shouldn't matter for this
case, so I suggest to start looking into this from the NFS side.

  Ralf
