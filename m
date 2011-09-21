Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2011 22:09:34 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:43655 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491885Ab1IUUJ0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Sep 2011 22:09:26 +0200
Received: by qyl16 with SMTP id 16so4591992qyl.15
        for <multiple recipients>; Wed, 21 Sep 2011 13:09:20 -0700 (PDT)
Received: by 10.52.65.42 with SMTP id u10mr1093781vds.267.1316635760064; Wed,
 21 Sep 2011 13:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.101.232 with HTTP; Wed, 21 Sep 2011 13:08:59 -0700 (PDT)
In-Reply-To: <20110914150452.GA12638@linux-mips.org>
References: <20110908220559.GA3040@maxin> <20110914150452.GA12638@linux-mips.org>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Wed, 21 Sep 2011 14:08:59 -0600
X-Google-Sender-Auth: E7i5-atD7WEYz250_aoL6nYCs7g
Message-ID: <CACxGe6ufZkVvTS-A8j1khkapaMN_3LuztRPSfHmeKqU7saJzWA@mail.gmail.com>
Subject: Re: [PATCH] mips: mm: tlbex.c: Fix compiler warnings
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Maxin B. John" <maxin.john@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11940

On Wed, Sep 14, 2011 at 9:04 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Sep 09, 2011 at 01:06:00AM +0300, Maxin B. John wrote:
>
>>  CC      arch/mips/mm/tlbex.o
>> cc1: warnings being treated as errors
>> arch/mips/mm/tlbex.c: In function 'build_r3000_tlb_modify_handler':
>> arch/mips/mm/tlbex.c:1769: error: 'wr.r1' is used uninitialized in this function
>> arch/mips/mm/tlbex.c:1769: error: 'wr.r2' is used uninitialized in this function
>> arch/mips/mm/tlbex.c:1769: error: 'wr.r3' is used uninitialized in this function
>> make[2]: *** [arch/mips/mm/tlbex.o] Error 1
>> make[1]: *** [arch/mips/mm] Error 2
>> make: *** [arch/mips] Error 2
>
> This was fixed by 949cb4ca0aa53e97ea5f524536593ad2d2946b73.  The real
> fix to not pass the wr members to build_pte_modifiable() because they
> just are not needed.

Which tree is this fix getting merged via?  Will it be in v3.1?

g.
