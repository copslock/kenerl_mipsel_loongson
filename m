Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 09:40:39 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:17673
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225387AbTIWIkG>; Tue, 23 Sep 2003 09:40:06 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A1iiL-0006fK-00; Tue, 23 Sep 2003 10:40:05 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A1iiL-0003mi-00; Tue, 23 Sep 2003 10:40:05 +0200
Date: Tue, 23 Sep 2003 10:40:05 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix character loss in drivers/tc/zs.c
Message-ID: <20030923084005.GU13578@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030921213104.GO13578@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030922193409.25762B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030922193409.25762B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Sun, 21 Sep 2003, Thiemo Seufer wrote:
> 
> > this patch reduces the zs driver's character lossage.
> 
>  Can you please elaborate?  tty is expected to be NULL if info->hook is
> not, so the code after the change should not differ effectively -- only a
> useless check is added at the end.  Am I missing anything?

AFAICS the

        while ((read_zsreg(info->zs_channel, R0) & Rx_CH_AV) != 0) {

loops over the FIFO contents and 'return' discards the remaining
part. The patch made a visible difference for me with some noisy
debug printk()'s in the kernel.


Thiemo
