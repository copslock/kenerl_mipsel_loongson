Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2004 08:23:28 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:50376
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8224990AbUJYHXX>; Mon, 25 Oct 2004 08:23:23 +0100
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id A19EE2BC3C; Mon, 25 Oct 2004 09:23:21 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 08056-24; Mon, 25 Oct 2004 09:23:11 +0200 (CEST)
Received: from bogon.sigxcpu.org (unknown [62.157.100.134])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 808FF2BC4A; Mon, 25 Oct 2004 09:23:11 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 781404269; Mon, 25 Oct 2004 09:23:03 +0200 (CEST)
Date: Mon, 25 Oct 2004 09:23:03 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Stefan Deling <stefan.deling@web.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel conversion problem ELF -> ECOFF
Message-ID: <20041025072303.GA4380@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Stefan Deling <stefan.deling@web.de>, linux-mips@linux-mips.org
References: <417C2BB1.9030105@pain-net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <417C2BB1.9030105@pain-net.home>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: by amavisd-new-20030616-p7 (Debian) at honk.physik.uni-konstanz.de
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 25, 2004 at 12:24:49AM +0200, Stefan Deling wrote:
> Hi there!
> 
> I´ve just tried to compile the latest linux-mips 2.4.x kernel a few 
> dayas ago.It ended up with the following problem. elf2ecoof told me:
> "programm header type 3 1694766464 can´t be converted!"
> I got the same problem while compiling the gentoo-mips-sources kernel.
> I was not able to find a solution in the archives.
> Has anyone got a solution for this problem??
Why do you want an ecoff in the first place? If you can't boot ELF you
can use arcboot on IP22 and IP32.
Cheers,
 -- Guido
