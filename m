Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Oct 2017 18:33:59 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:19969 "EHLO
        ste-ftg-msa2.bahnhof.se" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990408AbdJBQdwneNm0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Oct 2017 18:33:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTP id AAD973F43F;
        Mon,  2 Oct 2017 18:33:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-ftg-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G-n9BfRAwJlJ; Mon,  2 Oct 2017 18:33:45 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTPA id 862E03F41B;
        Mon,  2 Oct 2017 18:33:41 +0200 (CEST)
Date:   Mon, 2 Oct 2017 18:33:39 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20171002163339.GA2171@localhost.localdomain>
References: <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170918192428.GA391@localhost.localdomain>
 <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk>
 <20170920145440.GB9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60217
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

>  In any case you'll have to find a MIPS I or MIPS II distribution, like an 
> older version of Debian.

I will see what I can find. I currently have Black Rhino based on Debian
and tailored for the R5900, as you verified.

>  The three-argument MUL is a part of the base MIPS32 architecture BTW, 
> originating from the IDT R4650 and the NEC Vr5500 processors.  It has 
> nothing to do with the DSP ASE (though it may have been claimed originally 
> to be a DSP enhancement).

Ah, I was referring to a press release that appears to be written by
MIPS Technologies (linked from Wikipedia):

    In addition, DSP enhancements such as multiply (MUL) and multiply and
    add (MADD) instructions have been standardized and added to the new
    architectures. While these instructions have been available as
    licensee-specific extensions in the past, this is the first time that
    they have been available as a standard part of the MIPS(R) architecture.

https://www.thefreelibrary.com/MIPS+Technologies,+Inc.+Enhances+Architecture+to+Support+Growing+Need...-a054531136

> > For this reason the R5900 patch modifies the __{save,restore}_dsp macros,
> > mips_dsp_state::dspcontrol, DSP_INIT, sigcontext32::sc_dsp, etc. I've seen
> > the cpu_has_dsp macro too, but haven't looked at the details of this yet.
> 
>  Given that the R5900 does not expand DSP support anyhow that sounds 
> suspicious to me.

Yes, I agree.

Fredrik
