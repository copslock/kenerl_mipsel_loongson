Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 13:53:21 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:62169 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038706AbWJCMxT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2006 13:53:19 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id CC1BB462C6; Tue,  3 Oct 2006 14:53:18 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GUicV-0001Kn-Ml; Tue, 03 Oct 2006 12:39:31 +0100
Date:	Tue, 3 Oct 2006 12:39:31 +0100
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] add TV810 board support
Message-ID: <20061003113931.GE30302@networkno.de>
References: <20061003153611.def3118f.vitalywool@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003153611.def3118f.vitalywool@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Vitaly Wool wrote:
[snip]
> +/* CP0 hazard avoidance. */
> +#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
> +				     "nop; nop; nop; nop; nop; nop;\n\t" \
> +				     ".set reorder\n\t")

Didn't we just get rid of that BARRIER stuff?


Thiemo
