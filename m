Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 15:58:38 +0200 (CEST)
Received: from mx2-v2.alinto.net ([83.145.109.32]:47477 "EHLO
        mx2-v2.alinto.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492098Ab0EYN6e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 May 2010 15:58:34 +0200
X-Virus-Scanned: amavisd-new at alinto.net
Received: from http3alinto.alinto.net (http3alinto.alinto.net [83.145.109.63])
        by mx2-v2.alinto.net (Postfix) with ESMTP id 1AE2A244087;
        Tue, 25 May 2010 15:58:26 +0200 (CEST)
Received: by http3alinto.alinto.net (Postfix, from userid 48)
        id 0D034576CE; Tue, 25 May 2010 15:58:25 +0200 (CEST)
Received: from unknown (octane/alinto.com@82.228.201.195); 25 May 2010 15:58:25 -0000
Message-ID: <1274795905.4bfbd781a17fa@www.inmano.com>
Date:   Tue, 25 May 2010 15:58:25 +0200
To:     Ralf Baechle <ralf@linux-mips.org>
From:   octane indice <octane@alinto.com>
Cc:     Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
        octane indice <octane@alinto.com>, linux-mips@linux-mips.org
Subject: Re: Cross compiling MIPS kernel under x86
In-Reply-To: <20100525131341.GA26500@linux-mips.org>
References: <1274711094.4bfa8c3675983@www.inmano.com> <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>
 <20100525131341.GA26500@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <octane@alinto.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: octane@alinto.com
Precedence: bulk
X-list: linux-mips

En réponse à Ralf Baechle <ralf@linux-mips.org> :
> 
> On Mon, May 24, 2010 at 05:33:01PM +0300, Dmitri Vorobiev
> wrote:
> 
> > It looks like your toolchain is quite old. I just tried building a
> > Cavium Octeon defconfig using my custom toolchain based on
> > GCC 4.3.1 and binutils 2.19.51.20090304, and the build was
> > successfull. Before you ask: yes, GCC did receive
> > `-march=octeon' :)
> 
Ok, thanks :)

> Tools requirements to build a kernel have become a little bit
> confusing. I'm sure there are more restrictions that I've forgot.
> 
>  * The Lemote 2F defconfig requires binutils 2.20 to build.
>  * GCC 3.2 is a lost cause for building 64-bit kernels
>  * GCC 3.3 is broken but can just about be kludged to build a
> 64-bit kernel.
>  * GCC 4.4 or a patched older version is required to build a
> kernel O2 or
>    Indigo² with R10000 processors.
>  * GCC 3.2 used to work for the rest but it's a very long time
> since I tested this for a modern kernel.
>  * Linux 2.6.29 and older need a GCC older than 4.4.0 to
> compile. 
> 
Ok. I'm following the info there:
http://www.linux-mips.org/wiki/Toolchains
but infos seems a bit old, so I followed the main idea
with newer binutils and gcc-4.4.4

It is still compiling gcc. When it will finish, I will ping back
and say if it compiles an octeon kernel 2.6.34


> ------------------- Fin du message d'origine ---------------------




Envoyé avec Inmano, ma messagerie renversante et gratuite : http://www.inmano.com
