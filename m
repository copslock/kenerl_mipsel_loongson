Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2005 23:25:58 +0000 (GMT)
Received: from chrom.openbsd-geek.de ([IPv6:::ffff:217.160.135.112]:51031 "EHLO
	chrom.openbsd-geek.de") by linux-mips.org with ESMTP
	id <S8225824AbVCCXZn>; Thu, 3 Mar 2005 23:25:43 +0000
Received: by chrom.openbsd-geek.de (Postfix, from userid 1000)
	id 63B9732555; Fri,  4 Mar 2005 00:25:41 +0100 (CET)
Date:	Fri, 4 Mar 2005 00:25:41 +0100
From:	Waldemar Brodkorb <wbx@openbsd-geek.de>
To:	Christophe Jelger <Christophe.Jelger@unibas.ch>
Cc:	linux-mips@linux-mips.org
Subject: Re: Newbie : Cross-compiling module for wrt54g
Message-ID: <20050303232540.GA12906@openbsd-geek.de>
References: <42272589.7000802@unibas.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42272589.7000802@unibas.ch>
X-Editor: VIM
X-Operating-System: OpenBSD 3.6 i386
User-Agent: Mutt/1.5.6i
Return-Path: <wbx@openbsd-geek.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wbx@openbsd-geek.de
Precedence: bulk
X-list: linux-mips

Hi,
Christophe Jelger wrote,

> Hi everybody,
> 
> Well I am a complete newbie to using MIPS devices and I would like to 
> cross-compile an extra linux module for the Linksys wrt54g wireless 
> router. The module is not a standard linux module, it is an underlay 
> routing protocol (LUNAR) for wireless ad hoc networks.
> 
> I checked on the web, but I'm not sure on how I should proceed as many 
> information I found seem outdated.
> 
> If somebody could help me to get on tracks, I'd of course appreciate. 
> The issues I have are : tools to use, kernel-header files versions 
> (wrt54g uses 2.4.20, means do I have to compile on a 2.4.20 machine ?), 
> debugging on wrt54g (can I use standard log-file ?).
> 
> Looking forward to some help.

You could try www.openwrt.org. There is even an experimental
version, which uses a kernel 2.4.29.

bye
    Waldemar
