Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 16:49:00 +0200 (CEST)
Received: from mx3-v2.alinto.net ([83.145.109.33]:49363 "EHLO
        mx3-v2.alinto.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491832Ab0FIOs5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 16:48:57 +0200
X-Virus-Scanned: amavisd-new at alinto.net
Received: from http4alinto.alinto.net (http4alinto.alinto.net [83.145.109.64])
        by mx3-v2.alinto.net (Postfix) with ESMTP id 99E0574307;
        Wed,  9 Jun 2010 16:48:46 +0200 (CEST)
Received: by http4alinto.alinto.net (Postfix, from userid 48)
        id 81254FDA6F; Wed,  9 Jun 2010 16:48:46 +0200 (CEST)
Received: from unknown (octane/alinto.com@82.228.201.195); 09 Jun 2010 16:48:46 -0000
Message-ID: <1276094926.4c0fa9ce566aa@www.inmano.com>
Date:   Wed, 09 Jun 2010 16:48:46 +0200
To:     phils@windriver.com, Phil Staub <phils@windriver.com>
From:   octane indice <octane@alinto.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Cross compiling MIPS kernel under x86
In-Reply-To: <op.vdz4mmlornd9a3@poker>
References: <1274711094.4bfa8c3675983@www.inmano.com> <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com> <20100525131341.GA26500@linux-mips.org> <1274795905.4bfbd781a17fa@www.inmano.com> <20100525144400.GA30900@linux-mips.org> <1274879482.4bfd1dfa91e70@www.inmano.com> <AANLkTikbZmTWh8X4KOKLAUaJxKS5-PO39hmiTVICB5Zm@mail.gmail.com> <1274977788.4bfe9dfc7680f@www.inmano.com> <4BFEE551.8000306@gmail.com>
 <op.vdz4mmlornd9a3@poker>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 27111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: octane@alinto.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6475

En réponse à Phil Staub <phils@windriver.com> :
> In the top level Makefile, you'll find this:
> 
> # Use --build-id when available.
> LDFLAGS_BUILD_ID = $(patsubst -Wl$(comma)%,%,\
> 			      $(call cc-ldoption, -Wl$(comma)--build-id,))
> 
> Comment that out and it should fix you up.
>
Excellent. It boots. It fails next because it can't find
the root device, but I know how to manage that 


> Phil
>
Thanks
 
> -- 
> Phil Staub, Senior Member of Technical Staff, Wind River
> Direct: 702.290.0470 Fax: 702.982.0085
> 





Envoyé avec Inmano, ma messagerie renversante et gratuite : http://www.inmano.com
