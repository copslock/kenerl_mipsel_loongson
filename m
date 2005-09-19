Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2005 19:31:48 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:55011 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8225399AbVISSb3>;
	Mon, 19 Sep 2005 19:31:29 +0100
Received: from port-195-158-179-11.dynamic.qsc.de ([195.158.179.11] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1EHQQB-0001y9-00; Mon, 19 Sep 2005 20:31:19 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1EHQQA-0004Eu-Rp; Mon, 19 Sep 2005 20:31:18 +0200
Date:	Mon, 19 Sep 2005 20:31:18 +0200
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Performance bug in c-r4k.c cache handling code
Message-ID: <20050919183118.GH3386@hattusa.textio>
References: <20050919154056.GG3386@hattusa.textio> <20050920.015424.41632255.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920.015424.41632255.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.10i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> >>>>> On Mon, 19 Sep 2005 17:40:56 +0200, Thiemo Seufer <ths@networkno.de> said:
> 
> ths> I found an performance bug in c-r4k.c:r4k_dma_cache_inv, where a
> ths> Hit_Writeback_Inv instead of Hit_Invalidate is done. Ralf
> ths> mentioned this is probably due to broken Hit_Invalidate cache ops
> ths> on some CPUs, does anybody have more information about this? The
> ths> appended patch works apparently fine on R4400, R4600v2.0, R5000.
> 
> Just a question: Are there any performance advantage of using
> Hit_Invalidate instead of Hit_Writeback_Inv if the target line was
> CLEAN?

I wouldn't think so, but it depends on the particular implementation.


Thiemo
