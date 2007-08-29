Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 07:47:05 +0100 (BST)
Received: from host86-208-dynamic.0-87-r.retail.telecomitalia.it ([87.0.208.86]:27397
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20022054AbXH2Gq5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 07:46:57 +0100
Received: from localhost ([127.0.0.1] helo=sgi)
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IQHK5-0003J6-Bt
	for linux-mips@linux-mips.org; Wed, 29 Aug 2007 08:46:43 +0200
Date:	Wed, 29 Aug 2007 08:46:22 +0200
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Subject: Re: Exception while loading kernel
Message-Id: <20070829084622.156798b4.giuseppe@eppesuigoccas.homedns.org>
In-Reply-To: <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>
References: <1188030215.13999.14.camel@scarafaggio>
	<1188196563.2177.13.camel@scarafaggio>
	<46D2CB0F.7020505@27m.se>
	<1188321514.6882.3.camel@scarafaggio>
	<F288AA63-099B-4140-81B2-6A8E21887057@27m.se>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; mips-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Markus,

On Wed, 29 Aug 2007 04:25:35 +0200 Markus Gothe <markus.gothe@27m.se> wrote:
> Use gdb and list the read address.
> 
> //Markus

I never debugged the kernel. From what I read I should use something like kgdb. Did I understand correctly? Would you please point me the some documentation source for debugging as you wish?

Thanks,
Giuseppe
