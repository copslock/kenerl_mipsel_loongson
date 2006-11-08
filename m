Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2006 19:23:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53961 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039502AbWKHTX6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Nov 2006 19:23:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kA8JOMsf008430;
	Wed, 8 Nov 2006 19:24:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kA8JOKeG008429;
	Wed, 8 Nov 2006 19:24:20 GMT
Date:	Wed, 8 Nov 2006 19:24:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Trevor Hamm <Trevor_Hamm@pmc-sierra.com>
Cc:	"'Atsushi Nemoto'" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
Message-ID: <20061108192420.GA8080@linux-mips.org>
References: <E8C8A5231DDE104C816ADF532E0639120194F4C6@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8C8A5231DDE104C816ADF532E0639120194F4C6@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 08, 2006 at 11:09:37AM -0800, Trevor Hamm wrote:

> So just for fun, I built a linux image to use a write-through caching policy, and it boots from power-up every time.
> 
> With this information, I would conclude the problem is due to cache management, either in the way we're initializing the cache, or something else in the squashfs code.  Or is there another explanation that I'm overlooking?

Does your processor have cache aliases?

  Ralf
