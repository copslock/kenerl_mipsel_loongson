Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 22:29:01 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:3651 "EHLO
        ste-ftg-msa2.bahnhof.se" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991743AbdJFU2x2jfHL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 22:28:53 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTP id E87D53F5E1;
        Fri,  6 Oct 2017 22:28:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-ftg-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6rChu_-u1Hzr; Fri,  6 Oct 2017 22:28:47 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTPA id EB32A3F5CA;
        Fri,  6 Oct 2017 22:28:41 +0200 (CEST)
Date:   Fri, 6 Oct 2017 22:28:39 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20171006202838.GA26707@localhost.localdomain>
References: <20170911151737.GA2265@localhost.localdomain>
 <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
 <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170920140715.GA9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201604400.16752@tp.orcam.me.uk>
 <20170922163753.GA2415@localhost.localdomain>
 <alpine.DEB.2.00.1709300024350.12020@tp.orcam.me.uk>
 <20170930182608.GB7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301929060.12020@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709301929060.12020@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

>  Anyway, as noted above that shouldn't cause a problem with user software 
> and I think that any corruption you can see comes from elsewhere.  You'll 
> have to paper this $ra non-sign-extension issue over somehow to proceed 
> though.

I've extended do_IRQ with a register check under the condition that
user_mode(get_irq_regs()) is true, with the following sample results
where registers $2-$25 are printed if they are not sign-extended
properly (there is a certain amount of randomness to this):

    $10 : 00005f6362696c5f
    epc = 0fb6db00 in ld.so.1[fb60000+19000]

     $8 : ffffff7272655f5f
     $9 : ffffff7272655f5f
    $10 : 7066732e6362696c
    epc = 0fb759a0 in ld.so.1[fb60000+19000]

    $10 : 7274735f65646f6d
    $12 : ffff000000000000
    $13 : 0000ffffffffffff
    $14 : 000000ffffffffff
    epc = 0fb6d03c in ld.so.1[fb60000+19000]

    $10 : ffff732e6362696c
    epc = 0fb6cfe8 in ld.so.1[fb60000+19000]

     $8 : 000000ff00000000
    epc = 77e29fe4 in libc.so.6[77dc0000+12e000]

     $9 : 7fb71f357fb71f40
    epc = 0041cc60 in busybox[400000+3d000]

    $10 : 0000ffffff6f6c63
    epc = 0fb6d060 in ld.so.1[fb60000+19000]

    $10 : 00ffffffff657365
    epc = 0fb6d03c in ld.so.1[fb60000+19000]

    $12 : ffff000000000000
    $13 : 0000ffffffffffff
    epc = 0fb6d03c in ld.so.1[fb60000+19000]

     $8 : 4700302e325f4342
     $9 : 4700302e325f4342
    $10 : 0000ff6e6769735f
    $14 : 00ff000000000000
    epc = 0fb75a6c in ld.so.1[fb60000+19000]

    $10 : 635f6362696c5f5f
    $12 : ffff000000000000
    $13 : 0000ffffffffffff
    epc = 0fb6d608 in ld.so.1[fb60000+19000]

I'm not yet sure this approach is completely correct, because there are
quite a few macros and other things to set this up, and I'm assuming all
these registers are saved for IRQs by SAVE_ALL. The regs variable is
64-bits unsigned long long and save/restore is SD/LD in relevant places.

It would be interesting to somehow single-step through BusyBox and for
every hardware instruction validate registers to find the first occurrence
where sign-extension breaks.

What about making the R5900 a 64-bit kernel only if it would turn out that
the 32-bit sign-extension logic is not completely reliable?

Fredrik
