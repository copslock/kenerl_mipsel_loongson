Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 18:50:51 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:26116 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823081Ab3FZQuuGfVtk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Jun 2013 18:50:50 +0200
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account
 for PHYS_OFFSET"
Thread-Topic: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account
 for PHYS_OFFSET"
Thread-Index: AQHObcv38iGve3vzvUORHZK08vTPDplIk1UA//+Y6YyAAIBeAP//kjTX
Date:   Wed, 26 Jun 2013 16:50:03 +0000
Message-ID: <nh7ue18fnbn1tbs2wsphlis9.1372265400519@email.android.com>
References: <1371742590-10138-1-git-send-email-Steven.Hill@imgtec.com>
 <20130626145234.GB7171@linux-mips.org>
 <gjxqcs1k6ixh0k608l2d5c4p.1372261412004@email.android.com>,<20130626162302.GE7171@linux-mips.org>
In-Reply-To: <20130626162302.GE7171@linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2013_06_26_17_50_44
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

Ralf,

EVA has actually INCREASE in user address space - I right now run system with 2GB phys memory and 3GB of user virtual memory address space. Work in progress is to verify that GLIBC accepts addresses above 2GB.

Yes, it is all about increasing phys and user memory and avoiding 64bits. Many solutions dont justify 64bit chip (chip space increase, performance degradation and increase in DMA addresses for devices).

- Leonid.


Ralf Baechle <ralf@linux-mips.org> wrote:


On Wed, Jun 26, 2013 at 03:43:35PM +0000, Leonid Yegoshin wrote:

> This is a precursor for EVA specs implementation on Aptiv cores.
>
> EVA has different virtual address sets for kernel and user space and it can use memory on different physical address location. For exam, on Malta it can use a natural 0x80000000, one our customer put memory into 0x40000000 etc.

Hmm...  Any significant reduction below 2GB sounds like opening a can of
worms with address space layout assumption in some application code.

I guess they were desperately looking to increase kernel memory, highmem
didn't fit the bill nor going 64 bit so this was the solution?

  Ralf
