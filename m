Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2003 18:53:53 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:62868 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225518AbTIVRxu>; Mon, 22 Sep 2003 18:53:50 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA28761;
	Mon, 22 Sep 2003 19:53:46 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 22 Sep 2003 19:53:46 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] PMAG-AA Hardware cursor support
In-Reply-To: <20030921212313.GN13578@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030922194304.25762C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 21 Sep 2003, Thiemo Seufer wrote:

> @@ -37,8 +37,7 @@ static inline void bt455_read_cmap_entry
>  					 u8* red, u8* green, u8* blue)
>  {
>  	bt455_select_reg(regs, cr);
> -	
> -	mb();
> +	rmb();
>  	*red = regs->addr_cmap_data & 0x0f;
>  	rmb();
>  	*green = regs->addr_cmap_data & 0x0f;

 I do think it has to be an mb() as the first access is a write and the
second one is a read. 

 You may also consider using ISO C initializers for struct members -- I
can do the conversion myself, but since you are actively working on the
code right now, I guess it might give you an unnecessary burden of chasing
the changing master sources.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
