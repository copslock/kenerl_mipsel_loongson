Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Sep 2004 13:06:54 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:1332
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225241AbUINMGs>; Tue, 14 Sep 2004 13:06:48 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1C7C53-00022F-00; Tue, 14 Sep 2004 14:06:41 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1C7C52-0003jl-00; Tue, 14 Sep 2004 14:06:40 +0200
Date: Tue, 14 Sep 2004 14:06:40 +0200
To: glame <glchen@ict.ac.cn>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: why gcc 2.95.3  generate different result with option -mips2 and -mips3 for the same code
Message-ID: <20040914120640.GF12969@rembrandt.csv.ica.uni-stuttgart.de>
References: <20040914092941Z8224931-1530+9945@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914092941Z8224931-1530+9945@linux-mips.org>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

glame wrote:
> hi,
> when i disassemble the code, the result is as the following
> 
> -ffffffff80010b8c:  01001021    move    $v0,$t0  (-mips2)
> +ffffffff80010b8c:  0100102d    move    $v0,$t0  (-mips3)
> 
> why? 

Because you told it to do so. :-)
The 32bit move is "addu v0, $0, t0", the 64bit move "daddu ...".


Thiemo
