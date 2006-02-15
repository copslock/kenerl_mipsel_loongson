Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2006 15:03:17 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:19214 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133529AbWBOPDJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Feb 2006 15:03:09 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1FF8ea4011160;
	Wed, 15 Feb 2006 15:08:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1FF8dG1011159;
	Wed, 15 Feb 2006 15:08:39 GMT
Date:	Wed, 15 Feb 2006 15:08:39 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: Please pull drivers/scsi/dec_esp.c from Linus' git
Message-ID: <20060215150839.GA27719@linux-mips.org>
References: <20060213225331.GA5315@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213225331.GA5315@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 13, 2006 at 10:53:31PM +0000, Martin Michlmayr wrote:

> @@ -230,7 +230,7 @@
>  			mem_start = get_tc_base_addr(slot);
>  
>  			/* Store base addr into esp struct */
> -			esp->slot = mem_start;
> +			esp->slot = CPHYSADDR(mem_start);
>  
>  			esp->dregs = 0;
>  			esp->eregs = (void *)CKSEG1ADDR(mem_start +

I merged allmost all of the differences from mainline except this one.

Maciej, does this need the CPHYSADDR() op or not here?

  Ralf
