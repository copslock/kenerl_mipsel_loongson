Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jul 2004 17:31:47 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:47193
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224992AbUGPQbm>; Fri, 16 Jul 2004 17:31:42 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BlVcc-0007bn-00
	for <linux-mips@linux-mips.org>; Fri, 16 Jul 2004 18:31:42 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BlVcb-0001hE-00
	for <linux-mips@linux-mips.org>; Fri, 16 Jul 2004 18:31:41 +0200
Date: Fri, 16 Jul 2004 18:31:41 +0200
To: linux-mips@linux-mips.org
Subject: Re: Help with MOP network boot install on DECstation 5000/240
Message-ID: <20040716163141.GE24828@rembrandt.csv.ica.uni-stuttgart.de>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org> <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org> <000701c468ae$141c3e50$0a9913ac@swift> <20040713080320.GC18841@lug-owl.de> <000e01c4696f$f65cf4f0$0a9913ac@swift> <20040714124318.GQ2019@lug-owl.de> <000c01c46b42$fd6f9b60$0a9913ac@swift> <Pine.LNX.4.55.0407161644440.6227@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0407161644440.6227@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
[snip]
>  This is supposedly an ECOFF image for booting with TFTP.  If you can't 
> get the ELF image it was converted from, you may try converting it back to 
> ELF like this:

It isn't converted ELF but the output of the t-rex utility, which combines
ECOFF header, ELF stub, kernel and ramdisk into one file.


Thiemo
