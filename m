Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2003 07:28:36 +0000 (GMT)
Received: from p508B69C2.dip.t-dialin.net ([IPv6:::ffff:80.139.105.194]:25518
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbTA2H2g>; Wed, 29 Jan 2003 07:28:36 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0T7SN015942;
	Wed, 29 Jan 2003 08:28:23 +0100
Date: Wed, 29 Jan 2003 08:28:23 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [RFC & PATCH]  fixing tlb flush race problem on smp
Message-ID: <20030129082822.C7741@linux-mips.org>
References: <20030121143726.C16939@mvista.com> <86bs297hpd.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <86bs297hpd.fsf@trasno.mitica>; from quintela@mandrakesoft.com on Wed, Jan 22, 2003 at 08:43:26AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 22, 2003 at 08:43:26AM +0100, Juan Quintela wrote:

> jun> +	__save_and_cli(flags);
> 
> s/__save_and_cli()/local_irq_save()/
> 
> jun> +	__restore_flags(flags);
> 
> s/__restore_flags()/local_irq_restore()/
> 
> Same in the other occurence, please.

I've already done this recently for large parts of arch/mips* and
include/asm-mips*.

  Ralf
