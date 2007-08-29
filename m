Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 09:58:06 +0100 (BST)
Received: from host86-208-dynamic.0-87-r.retail.telecomitalia.it ([87.0.208.86]:63246
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20022090AbXH2I54 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 09:57:56 +0100
Received: from 89-96-243-184.ip14.fastwebnet.it ([89.96.243.184] helo=[192.168.215.30])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IQJJw-00073z-CC
	for linux-mips@linux-mips.org; Wed, 29 Aug 2007 10:54:42 +0200
Subject: Re: Exception while loading kernel
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <816d36d30708290133w677756bbla8b8b2b25fe005f1@mail.gmail.com>
References: <1188030215.13999.14.camel@scarafaggio>
	 <1188196563.2177.13.camel@scarafaggio> <46D2CB0F.7020505@27m.se>
	 <1188321514.6882.3.camel@scarafaggio>
	 <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>
	 <20070829084622.156798b4.giuseppe@eppesuigoccas.homedns.org>
	 <816d36d30708290133w677756bbla8b8b2b25fe005f1@mail.gmail.com>
Content-Type: text/plain
Date:	Wed, 29 Aug 2007 10:54:53 +0200
Message-Id: <1188377693.7270.1.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Ricardo,

Il giorno mer, 29/08/2007 alle 04.33 -0400, Ricardo Mendoza ha scritto:
> Try to build the kernel with CONFIG_BUILD_ELF64=n
> 
> Also, there's no support for kgdb on ip32 at the moment.

I already tried the 32bit kernel and I found the same problem. Are you
telling me that I should use 32bit for debugging instead of 64?

Bye,
Giuseppe
