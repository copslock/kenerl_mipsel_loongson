Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Oct 2004 19:12:11 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:15661
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225262AbUJCSMH>; Sun, 3 Oct 2004 19:12:07 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CEAq7-00017r-00
	for <linux-mips@linux-mips.org>; Sun, 03 Oct 2004 20:12:07 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CEAq6-0001ge-00
	for <linux-mips@linux-mips.org>; Sun, 03 Oct 2004 20:12:06 +0200
Date: Sun, 3 Oct 2004 20:12:06 +0200
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] Kconfig for R5k/RM7k sc
Message-ID: <20041003181206.GU21351@rembrandt.csv.ica.uni-stuttgart.de>
References: <1096821864.3883.11.camel@sex-machine.chi.ldsys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096821864.3883.11.camel@sex-machine.chi.ldsys.net>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Christopher G. Stach II wrote:
>     This should prevent the rm7k sc code from being built for IP32, etc.

Why do you want to do that? IMHO it's quite sensible to do a generic
O2 kernel which runs on both R5x00 and RM7000 while still using the
scache if available.


Thiemo
