Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2015 18:10:35 +0200 (CEST)
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:40686 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006567AbbEUQKeQxAWv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2015 18:10:34 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 866CA23416;
        Thu, 21 May 2015 16:10:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pen34_5c043a3d91350
X-Filterd-Recvd-Size: 2307
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 May 2015 16:10:32 +0000 (UTC)
Message-ID: <1432224631.20840.45.camel@perches.com>
Subject: Re: [PATCH] mips: irq: Use DECLARE_BITMAP
From:   Joe Perches <joe@perches.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        John Crispin <blogic@openwrt.org>
Date:   Thu, 21 May 2015 09:10:31 -0700
In-Reply-To: <20150521131429.GA8177@linux-mips.org>
References: <1432125894.2870.284.camel@perches.com>
         <20150521131429.GA8177@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Thu, 2015-05-21 at 15:14 +0200, Ralf Baechle wrote:
> On Wed, May 20, 2015 at 05:44:54AM -0700, Joe Perches wrote:
> 
> > Use the generic mechanism to declare a bitmap instead of unsigned long.
> > 
> > This could fix an overwrite defect of whatever follows irq_map.
> > 
> > Not all "#define NR_IRQS <value>" are a multiple of BITS_PER_LONG so
> > using DECLARE_BITMAP allocates the proper number of longs required
> > for the possible bits.
> > 
> > For instance:
> > 
> > arch/mips/include/asm/mach-ath79/irq.h:#define NR_IRQS                  51
> > arch/mips/include/asm/mach-db1x00/irq.h:#define NR_IRQS 152
> > arch/mips/include/asm/mach-lantiq/falcon/irq.h:#define NR_IRQS 328
> 
> This only matters to user of the allocate_irqno() API and there is only
> on such platform, the IP27 which fortunately uses a NR_IRQS value that
> is a multiple of 64, so no impact.
> 
> Thanks anyway!

I think you should apply it anyway as it's an
error-prone style.

There are 3 mechanisms used today in the kernel
to declare bitmap arrays.

	DECLARE_BITMAP(array, size)
	unsigned long array[BITS_TO_LONGS(size)]
	unsigned long array[size/BITS_PER_LONG]

The first 2 are fine, the last has this defect
possible whenever size % BITS_PER_LONG != 0.

The series I sent converts all the uses of the
the possibly defective style.

cheers, Joe
