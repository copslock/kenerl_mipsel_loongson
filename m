Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 17:15:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21128 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012294AbcBCQP2ZBbvQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 17:15:28 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id A510640DB7FF6;
        Wed,  3 Feb 2016 16:15:18 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 16:15:21 +0000
Received: from localhost (10.100.200.164) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 16:15:20 +0000
Date:   Wed, 3 Feb 2016 16:15:17 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>,
        Andrey Konovalov <adech.fo@gmail.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 1/5] MIPS: Bail on unsupported module relocs
Message-ID: <20160203161517.GE30470@NP-P-BURTON>
References: <1454471085-20963-1-git-send-email-paul.burton@imgtec.com>
 <1454471085-20963-2-git-send-email-paul.burton@imgtec.com>
 <alpine.DEB.2.00.1602031139250.15885@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1602031139250.15885@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.164]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51698
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

On Wed, Feb 03, 2016 at 12:24:38PM +0000, Maciej W. Rozycki wrote:
> On Wed, 3 Feb 2016, Paul Burton wrote:
> 
> > --- a/arch/mips/kernel/module-rela.c
> > +++ b/arch/mips/kernel/module-rela.c
> > @@ -134,9 +135,21 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  			return -ENOENT;
> >  		}
> >  
> > -		v = sym->st_value + rel[i].r_addend;
> > +		type = ELF_MIPS_R_TYPE(rel[i]);
> > +
> > +		if (type < ARRAY_SIZE(reloc_handlers_rela))
> > +			handler = reloc_handlers_rela[type];
> > +		else
> > +			handler = NULL;
> >  
> > -		res = reloc_handlers_rela[ELF_MIPS_R_TYPE(rel[i])](me, location, v);
> > +		if (!handler) {
> > +			pr_warn("%s: Unknown relocation type %u\n",
> > +				me->name, type);
> > +			return -EINVAL;
> 
>  Hmm, this looks like a fatal error condition to me, the module won't 
> load.  Why `pr_warn' rather than `pr_err' then?  Likewise in the other 
> file.
> 
>   Maciej

Hi Maciej,

To me fatality implies death, and nothing dies here. The module isn't
loaded but that's done gracefully & is not likely due to an error in the
kernel - it's far more likely that the module isn't valid. So to me,
warning seems appropriate rather than implying an error in the kernel.

Having said that I think it's a non-issue & don't really care either
way, so if Ralf wants it to be pr_err fine.

Thanks,
    Paul
