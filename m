Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jul 2004 17:51:36 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:36823 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224992AbUGPQvc>; Fri, 16 Jul 2004 17:51:32 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 39C9C4787C; Fri, 16 Jul 2004 18:51:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 2349747855; Fri, 16 Jul 2004 18:51:26 +0200 (CEST)
Date: Fri, 16 Jul 2004 18:51:26 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Help with MOP network boot install on DECstation 5000/240
In-Reply-To: <20040716163141.GE24828@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.55.0407161849230.6227@jurand.ds.pg.gda.pl>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org>
 <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org>
 <000701c468ae$141c3e50$0a9913ac@swift> <20040713080320.GC18841@lug-owl.de>
 <000e01c4696f$f65cf4f0$0a9913ac@swift> <20040714124318.GQ2019@lug-owl.de>
 <000c01c46b42$fd6f9b60$0a9913ac@swift> <Pine.LNX.4.55.0407161644440.6227@jurand.ds.pg.gda.pl>
 <20040716163141.GE24828@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 16 Jul 2004, Thiemo Seufer wrote:

> >  This is supposedly an ECOFF image for booting with TFTP.  If you can't 
> > get the ELF image it was converted from, you may try converting it back to 
> > ELF like this:
> 
> It isn't converted ELF but the output of the t-rex utility, which combines
> ECOFF header, ELF stub, kernel and ramdisk into one file.

 I stand corrected.  The image should still work if converted to ELF and
then loaded, though, shouldn't it?

  Maciej
