Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2004 17:21:56 +0000 (GMT)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:64425
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8225248AbUBLRV4>; Thu, 12 Feb 2004 17:21:56 +0000
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id CF98D144; Thu, 12 Feb 2004 18:21:49 +0100 (NFT)
Received: from mx3.informatik.uni-tuebingen.de ([134.2.12.26])
 by localhost (mx5 [134.2.12.32]) (amavisd-new, port 10024) with ESMTP
 id 51726-01; Thu, 12 Feb 2004 18:21:48 +0100 (NFT)
Received: from dual (semeai [134.2.15.66])
	by mx3.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 4EE23134; Thu, 12 Feb 2004 18:21:47 +0100 (NFT)
Received: from mrvn by dual with local (Exim 3.36 #1 (Debian))
	id 1ArKX5-0004Lb-00; Thu, 12 Feb 2004 18:21:47 +0100
To: Wolfgang Denk <wd@denx.de>
Cc: "Ren, Manling" <Manling.Ren@gbr.xerox.com>,
	linux-mips@linux-mips.org
Subject: Re: questions about making a script file for YAMON command
References: <20040212142007.B7FDBC108D@atlas.denx.de>
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: 12 Feb 2004 18:21:45 +0100
In-Reply-To: <20040212142007.B7FDBC108D@atlas.denx.de>
Message-ID: <87znboxlg6.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Reasonable Discussion)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

Wolfgang Denk <wd@denx.de> writes:

> In message <8EAC52A94CD8D411A01000805FBB377606563AE8@gbrwgcms02.wgc.gbr.xerox.com> you wrote:
> > 
> > Dear the technical support team,
> 
> Did you pay a support contract? ;-)
> 
> > I am running YAMON on pb1100 board in Linux.  At the YAMON prompt, I need to
> > change some registers by using the command "edit -32 0x########"  several
> > times.  I wonder if I can put all these "edit" commands into a script file
> > then run this file without typing any more commands?  How can I achieve this
> 
> Use the standard tools you can find in your Unix environment. In this
> case, use expect.
> 
> Best regards,
> 
> Wolfgang Denk

Or rebuild yamon to your likeing.

MfG
        Goswin
