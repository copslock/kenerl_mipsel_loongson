Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 23:33:23 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007512AbbBZWdVltdn3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 23:33:21 +0100
Date:   Thu, 26 Feb 2015 22:33:21 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
cc:     dwalker@fifo99.com, linux-mips@linux-mips.org
Subject: Re: octeon disable SWIOTLB
In-Reply-To: <54EDF39A.1080002@caviumnetworks.com>
Message-ID: <alpine.LFD.2.11.1502262227300.17311@eddie.linux-mips.org>
References: <20150225144128.GB27513@fifo99.com> <54EDF39A.1080002@caviumnetworks.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46010
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

On Wed, 25 Feb 2015, David Daney wrote:

> > Back in 2010 you made CONFIG_SWIOTLB mandatory (commit b93b2a). This
> > prevents the Continuous
> > memory allocation from being enabled. Would you be willing to accept a patch
> > which allows
> > this option to be disabled if CONFIG_EXPERT is set?
> 
> Ralf has the final say, so it really is not up to me.
> 
> That said, any patch that improves the flexibility of the kernel without
> adversely effecting reliability and correctness would be welcome.

 So how's DMA to/from 64-bit memory supposed to be handled then for 32-bit 
PCI option cards that don't support DAC by systems that use continuous 
memory allocation (whatever that is)?  Is that a bug in continuous memory 
allocation support?

  Maciej
