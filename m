Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 11:03:48 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:53769 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133631AbWBTLDl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 11:03:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1KB9YeA006856;
	Mon, 20 Feb 2006 11:09:34 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1KB9Xul006855;
	Mon, 20 Feb 2006 11:09:33 GMT
Date:	Mon, 20 Feb 2006 11:09:33 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, mark.e.mason@broadcom.com
Subject: Re: [MIPS] Fix compiler warnings in arch/mips/sibyte/bcm1480/irq.c
Message-ID: <20060220110933.GA5594@linux-mips.org>
References: <20060220045700.GA2519@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060220045700.GA2519@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 04:57:00AM +0000, Martin Michlmayr wrote:

> Fix the following compiler warnings:
> 
>   CC      arch/mips/sibyte/bcm1480/irq.o
> arch/mips/sibyte/bcm1480/irq.c: In function ‘bcm1480_set_affinity’:
> arch/mips/sibyte/bcm1480/irq.c:168: warning: ISO C90 forbids mixed declarations and code
> arch/mips/sibyte/bcm1480/irq.c: In function ‘ack_bcm1480_irq’:
> arch/mips/sibyte/bcm1480/irq.c:230: warning: ISO C90 forbids mixed declarations and code

Not only ISO C - it simply doesn't build with gcc 3.2.  Applied,

  Ralf
