Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2008 19:06:07 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56482 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S21405742AbYJMSGF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Oct 2008 19:06:05 +0100
Date:	Mon, 13 Oct 2008 19:06:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	weiwei wang <veivei.vang@gmail.com>,
	Mark Mason <mason@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [Fwd: [bug report] 0xffffffffc0000000 can't be used on
 bcm1250]
In-Reply-To: <20081013162906.GB7144@linux-mips.org>
Message-ID: <alpine.LFD.1.10.0810131842430.9667@ftp.linux-mips.org>
References: <48EC9894.4080201@gmail.com> <20081008115001.GA21596@linux-mips.org> <48ED5BA5.4070301@gmail.com> <20081009131554.GB22796@linux-mips.org> <48EEBFE8.1000501@gmail.com> <alpine.LFD.1.10.0810101138180.19747@ftp.linux-mips.org> <48F2BC15.70408@gmail.com>
 <alpine.LFD.1.10.0810131508390.9667@ftp.linux-mips.org> <20081013162906.GB7144@linux-mips.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 13 Oct 2008, Ralf Baechle wrote:

> > +static void __cpuinit build_bcm1250_m3_war(u32 **p, struct uasm_reloc **r)
> > +{
> > +	uasm_i_dmfc0(p, K0, C0_BADVADDR);
> > +	uasm_i_dmfc0(p, K1, C0_ENTRYHI);
> > +	uasm_i_xor(p, K0, K0, K1);
> > +	uasm_i_dsll(p, K1, K0, 24);
> > +	uasm_i_dsrl32(p, K1, K1, (24 + PAGE_SHIFT + 1) - 32);
> > +	uasm_i_dsrl32(p, K0, K0, 30);
> > +	uasm_i_or(p, K0, K0, K1);
> > +	uasm_il_bnez(p, r, K0, label_leave);
> 
> The workaround is beginning to be relativly expensive.  We're investing 8
> instructions extra only to verify that the content of c0_entryhi is
> correct.  I haven't tried yet but me seems by avoiding the use of c0_context
> entirely relying only on badvaddr we may be able to get away cheaper.

 Well, this is broken silicon, so we could well declare it unsupported.  
Workarounds should be as cheap maintenance-wise as possible.  The run-time 
hit is secondary.  Owing to how these bit fields are laid out I don't 
think we can get anywhere below the present instruction count with the 
current approach.

 In this case using BadVAddr might be possible, but it'd have to be masked 
as appropriate and possibly additionally transformed in some way and we 
are short on registers (k0 and k1 only), so that may be tough and prove no 
cheaper.  Feel free to try though.  At least with the synthesiser we can 
keep code for all the other good hardware intact.

 However as not all BCM1250 hardware suffers from this problem we should 
be more finegrained wrt choosing at the run time whether the workaround 
should be enabled or not in the first place and I'll see if I can find 
some time to address this.  It's been on my todo list for a while now, so 
perhaps it's time to tick it off.

> Btw, adding linux-mips to the cc list.  This really should be public.

 Of course -- I haven't noticed the list was omitted. :(

  Maciej
