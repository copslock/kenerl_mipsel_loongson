Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2006 05:06:12 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.4]:28891 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S8133373AbWCHFGD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2006 05:06:03 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k285EUDZ010463
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 7 Mar 2006 21:14:30 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k285ESTm028187;
	Tue, 7 Mar 2006 21:14:29 -0800
Date:	Tue, 7 Mar 2006 21:12:40 -0800
From:	Andrew Morton <akpm@osdl.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit unaligned access on 32bit kernel
Message-Id: <20060307211240.4b1bb373.akpm@osdl.org>
In-Reply-To: <20060308.135840.69058042.nemoto@toshiba-tops.co.jp>
References: <20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
	<20060306170552.0aab29c5.akpm@osdl.org>
	<20060307180907.GA13577@linux-mips.org>
	<20060308.135840.69058042.nemoto@toshiba-tops.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> >>>>> On Tue, 7 Mar 2006 18:09:07 +0000, Ralf Baechle <ralf@linux-mips.org> said:
> ralf> Below's fix results in exactly the same code size on all
> ralf> compilers and configurations I've tested it.
> 
> ralf> I also have another more elegant fix which as a side effect
> ralf> makes get_unaligned work for arbitrary data types but it that
> ralf> one results in a slight code bloat:
> 
> I tested the patch attached on several MIPS kernel (big/little,
> 32bit/64bit) with gcc 3.4.5.  In most (but not all) case, Ralf's fix
> resulted better than the previous fix.
> 

hmm, well, your earlier patch has had more testing on various platforms,
for what that's worth.  I think for 2.6.16 we should run with that.  If you
want to prepare a patch which implements Ralf's version for post-2.6.16
then that would be good, thanks.
