Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 17:43:47 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:12877 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823098Ab3FZPnoC2aSI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Jun 2013 17:43:44 +0200
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account
 for PHYS_OFFSET"
Thread-Topic: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account
 for PHYS_OFFSET"
Thread-Index: AQHObcv38iGve3vzvUORHZK08vTPDplIk1UA//+Y6Yw=
Date:   Wed, 26 Jun 2013 15:43:35 +0000
Message-ID: <gjxqcs1k6ixh0k608l2d5c4p.1372261412004@email.android.com>
References: <1371742590-10138-1-git-send-email-Steven.Hill@imgtec.com>,<20130626145234.GB7171@linux-mips.org>
In-Reply-To: <20130626145234.GB7171@linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2013_06_26_16_43_38
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37137
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

This is a precursor for EVA specs implementation on Aptiv cores.

EVA has different virtual address sets for kernel and user space and it can use memory on different physical address location. For exam, on Malta it can use a natural 0x80000000, one our customer put memory into 0x40000000 etc.

- Leonid.


Ralf Baechle <ralf@linux-mips.org> wrote:


On Thu, Jun 20, 2013 at 10:36:30AM -0500, Steven J. Hill wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> This reverts commit 3f4579252aa166641861a64f1c2883365ca126c2. It is
> invalid because the macros CAC_ADDR and UNCAC_ADDR have a kernel
> virtual address as an argument and also returns a kernel virtual
> address. Using and physical address PHYS_OFFSET is blatantly wrong
> for a macro common to multiple platforms.

While the patch itself is looking sane at a glance, I'm wondering if this
is fixing any actual bug or is just the result of a code review?

  Ralf
