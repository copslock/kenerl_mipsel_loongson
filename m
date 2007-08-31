Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2007 08:40:59 +0100 (BST)
Received: from host78-221-dynamic.2-87-r.retail.telecomitalia.it ([87.2.221.78]:56337
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20022264AbXHaHk4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Aug 2007 08:40:56 +0100
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IR17Z-0003RN-SU
	for linux-mips@linux-mips.org; Fri, 31 Aug 2007 09:40:51 +0200
Subject: Re: Exception while loading kernel
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <46D7BFF1.6000304@27m.se>
References: <1188030215.13999.14.camel@scarafaggio>
	 <1188196563.2177.13.camel@scarafaggio> <46D2CB0F.7020505@27m.se>
	 <1188321514.6882.3.camel@scarafaggio>
	 <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>
	 <20070829084622.156798b4.giuseppe@eppesuigoccas.homedns.org>
	 <816d36d30708290133w677756bbla8b8b2b25fe005f1@mail.gmail.com>
	 <1188377693.7270.1.camel@scarafaggio>
	 <816d36d30708290305i4b34ae11s4b469cc48fb999aa@mail.gmail.com>
	 <1188539343.18249.2.camel@scarafaggio>  <46D7BFF1.6000304@27m.se>
Content-Type: text/plain
Date:	Fri, 31 Aug 2007 09:41:15 +0200
Message-Id: <1188546075.18249.11.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno ven, 31/08/2007 alle 09.14 +0200, Markus Gothe ha scritto:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> Which version are the toolchain binutils,gcc) you're using?

2.17-3 from Debian stable "etch".
I reported the problem on gcc bugzilla, but I read the note about
binutils version when unset CONFIG_BUILD_ELF64.

Bye,
Giuseppe
