Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2010 15:11:38 +0200 (CEST)
Received: from mx2-v2.alinto.net ([83.145.109.32]:43046 "EHLO
        mx2-v2.alinto.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492184Ab0EZNLf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 May 2010 15:11:35 +0200
X-Virus-Scanned: amavisd-new at alinto.net
Received: from http2alinto.alinto.net (http2alinto.alinto.net [83.145.109.62])
        by mx2-v2.alinto.net (Postfix) with ESMTP id D3516244192;
        Wed, 26 May 2010 15:11:22 +0200 (CEST)
Received: by http2alinto.alinto.net (Postfix, from userid 48)
        id B3F94E219D; Wed, 26 May 2010 15:11:22 +0200 (CEST)
Received: from unknown (octane/alinto.com@82.228.201.195); 26 May 2010 15:11:22 -0000
Message-ID: <1274879482.4bfd1dfa91e70@www.inmano.com>
Date:   Wed, 26 May 2010 15:11:22 +0200
To:     Ralf Baechle <ralf@linux-mips.org>
From:   octane indice <octane@alinto.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Cross compiling MIPS kernel under x86
In-Reply-To: <20100525144400.GA30900@linux-mips.org>
References: <1274711094.4bfa8c3675983@www.inmano.com> <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com> <20100525131341.GA26500@linux-mips.org> <1274795905.4bfbd781a17fa@www.inmano.com>
 <20100525144400.GA30900@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <octane@alinto.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: octane@alinto.com
Precedence: bulk
X-list: linux-mips

Sorry to bother you another time, but it's a FAIL :-(

I'm exactly in that situation:
http://gcc.gnu.org/ml/gcc-help/2009-08/msg00198.html

I read some docs, relaunched the configure process another time, read that I
should build with
make all-gcc 
But error is still present.

thanks

En réponse à Ralf Baechle <ralf@linux-mips.org> :
> ------------------ Début du message d'origine --------------------
> 
> On Tue, May 25, 2010 at 03:58:25PM +0200, octane indice wrote:
> 
> > Ok. I'm following the info there:
> > http://www.linux-mips.org/wiki/Toolchains
> > but infos seems a bit old, so I followed the main idea
> > with newer binutils and gcc-4.4.4
> 
> That page just documents available toolchains and is suffering
> from too
> many details.  Somebody should do a bit weed killing on that
> page.
> 
> The build dependencies for the kernel are documented on
> 
>   http://www.linux-mips.org/wiki/Kernel_Build
> 
> which I've updated just before my previous posting.
> 
> > It is still compiling gcc. When it will finish, I will ping
> back
> > and say if it compiles an octeon kernel 2.6.34
> 
> It will :-)
> 
>   Ralf
> 
> ------------------- Fin du message d'origine ---------------------




Envoyé avec Inmano, ma messagerie renversante et gratuite : http://www.inmano.com
