Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2004 16:27:56 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:13870
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225225AbUAQQ1z>; Sat, 17 Jan 2004 16:27:55 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AhtIf-0001Qc-00
	for <linux-mips@linux-mips.org>; Sat, 17 Jan 2004 17:27:53 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AhtIf-0003m3-00
	for <linux-mips@linux-mips.org>; Sat, 17 Jan 2004 17:27:53 +0100
Date: Sat, 17 Jan 2004 17:27:53 +0100
To: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
Message-ID: <20040117162753.GC22218@rembrandt.csv.ica.uni-stuttgart.de>
References: <200401171711.34964@korath> <200401171736.49803@korath>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401171736.49803@korath>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Adam Nielsen wrote:
> > as: unrecognized option `-O2'
> 
> Ok, I just worked out the problem - or at least I discovered a workaround.  If 
> I run:
> 
> 	./configure --prefix=/usr/local [...]
> 
> then I get the error during compilation, but if instead I run
> 
> 	./configure --prefix=/usr [...]
> 
> then it appears to work perfectly...!
> 
> No idea what's going on, but at least it works and hopefully it won't 
> overwrite my existing compiler when I install it ;-)

IIRC you need to configure with AS=mips-linux-as.


Thiemo
