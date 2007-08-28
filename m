Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2007 18:21:46 +0100 (BST)
Received: from host86-208-dynamic.0-87-r.retail.telecomitalia.it ([87.0.208.86]:43787
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20021297AbXH1RVi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Aug 2007 18:21:38 +0100
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IQ4hm-0000y8-BF
	for linux-mips@linux-mips.org; Tue, 28 Aug 2007 19:18:20 +0200
Subject: Re: Exception while loading kernel
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <46D2CB0F.7020505@27m.se>
References: <1188030215.13999.14.camel@scarafaggio>
	 <1188196563.2177.13.camel@scarafaggio>  <46D2CB0F.7020505@27m.se>
Content-Type: text/plain
Date:	Tue, 28 Aug 2007 19:18:34 +0200
Message-Id: <1188321514.6882.3.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Markus,

Il giorno lun, 27/08/2007 alle 15.01 +0200, Markus Gothe ha scritto:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> What about trying 2.6.22 from linux-mips.org in first place?
> 
> //Markus

2.6.22.2, downloaded from linux-mips.org, display the same problem. I
got:

Exception PC: 0x8022051c, Exception RA: 0x804da7ec
tmp: 81070000 1000 80516868 fff8054b ffffffff 81412ef4 a13fab68 7

and, from my System.map file,

ffffffff802204e4 T __bzero
ffffffff80220544 t memset_partial

ffffffff804da728 t init_bootmem_core
ffffffff804da808 t $L99

ffffffff80516860 B percpu_pagelist_fraction
ffffffff80516868 b contig_bootmem_data

Bye,
Giuseppe
