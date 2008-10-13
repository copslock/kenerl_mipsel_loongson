Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2008 17:29:14 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:24715 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21394774AbYJMQ3L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Oct 2008 17:29:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9DGT65Z008875;
	Mon, 13 Oct 2008 17:29:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9DGT6Vi008873;
	Mon, 13 Oct 2008 17:29:06 +0100
Date:	Mon, 13 Oct 2008 17:29:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	weiwei wang <veivei.vang@gmail.com>, mason@broadcom.com,
	linux-mips@linux-mips.org
Subject: Re: [Fwd: [bug report] 0xffffffffc0000000 can't be used on bcm1250]
Message-ID: <20081013162906.GB7144@linux-mips.org>
References: <48EC9894.4080201@gmail.com> <20081008115001.GA21596@linux-mips.org> <48ED5BA5.4070301@gmail.com> <20081009131554.GB22796@linux-mips.org> <48EEBFE8.1000501@gmail.com> <alpine.LFD.1.10.0810101138180.19747@ftp.linux-mips.org> <48F2BC15.70408@gmail.com> <alpine.LFD.1.10.0810131508390.9667@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0810131508390.9667@ftp.linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 13, 2008 at 04:18:04PM +0100, Maciej W. Rozycki wrote:

>  /*
> + * To avoid the BCM1250 M3 erratum check whether EntryHi is consistent
> + * with BadVAddr and return for the exception to retrigger if not.
> + */
> +static void __cpuinit build_bcm1250_m3_war(u32 **p, struct uasm_reloc **r)
> +{
> +	uasm_i_dmfc0(p, K0, C0_BADVADDR);
> +	uasm_i_dmfc0(p, K1, C0_ENTRYHI);
> +	uasm_i_xor(p, K0, K0, K1);
> +	uasm_i_dsll(p, K1, K0, 24);
> +	uasm_i_dsrl32(p, K1, K1, (24 + PAGE_SHIFT + 1) - 32);
> +	uasm_i_dsrl32(p, K0, K0, 30);
> +	uasm_i_or(p, K0, K0, K1);
> +	uasm_il_bnez(p, r, K0, label_leave);

The workaround is beginning to be relativly expensive.  We're investing 8
instructions extra only to verify that the content of c0_entryhi is
correct.  I haven't tried yet but me seems by avoiding the use of c0_context
entirely relying only on badvaddr we may be able to get away cheaper.

Btw, adding linux-mips to the cc list.  This really should be public.

  Ralf
