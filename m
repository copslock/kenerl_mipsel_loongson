Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 11:48:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46724 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011397AbcBCKsx3o8dO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 11:48:53 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 0CB189E1615F9;
        Wed,  3 Feb 2016 10:48:46 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 10:48:47 +0000
Received: from localhost (10.100.200.105) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 10:48:46 +0000
Date:   Wed, 3 Feb 2016 10:48:46 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Andrey Konovalov" <adech.fo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/5] MIPS: Support R_MIPS_PC16 rel-style reloc
Message-ID: <20160203104846.GA9208@NP-P-BURTON>
References: <1454471085-20963-1-git-send-email-paul.burton@imgtec.com>
 <1454471085-20963-5-git-send-email-paul.burton@imgtec.com>
 <56B1D5B5.6050208@cogentembedded.com>
 <20160203103255.GA21157@NP-P-BURTON>
 <56B1D810.4040606@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <56B1D810.4040606@cogentembedded.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.105]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Wed, Feb 03, 2016 at 01:36:00PM +0300, Sergei Shtylyov wrote:
> On 2/3/2016 1:32 PM, Paul Burton wrote:
> 
> >>>MIPS32 code uses rel-style relocs, and MIPS32r6 modules may include the
> >>>R_MIPS_PC16 relocation. We thus need to support R_MIPS_PC16 rel-style
> >>>relocations in order to load MIPS32r6 kernel modules. This patch adds
> >>>such support, which is similar to the rela-style R_MIPS_PC16 support but
> >>
> >>     R_MIPS_LO16, you mean?
> >
> >Hi Sergei,
> >
> >No, I mean it's similar to the R_MIPS_PC16 code in module-rela.c. That
> >is, its rela-style equivalent (rather than rel-style as here).
> 
>    But you're *adding* R_MIPS_PC16, no?

Yup, this patch is adding R_MIPS_PC16 to module.c & it's similar to
R_MIPS_PC16 in module-rela.c.

(Incidentally I think we could tidy up the duplication between the two
files, but that can come later...)

Thanks,
    Paul
