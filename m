Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2007 17:41:30 +0100 (BST)
Received: from agminet01.oracle.com ([141.146.126.228]:40667 "EHLO
	agminet01.oracle.com") by ftp.linux-mips.org with ESMTP
	id S20022567AbXHRQl2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Aug 2007 17:41:28 +0100
Received: from agmgw2.us.oracle.com (agmgw2.us.oracle.com [152.68.180.213])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id l7IGf8q7010358;
	Sat, 18 Aug 2007 11:41:08 -0500
Received: from acsmt351.oracle.com (acsmt351.oracle.com [141.146.40.151])
	by agmgw2.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id l7IGSxXP014938;
	Sat, 18 Aug 2007 10:41:06 -0600
Received: from pool-71-117-240-242.ptldor.fios.verizon.net by rcsmt252.oracle.com
	with ESMTP id 3139703771187455170; Sat, 18 Aug 2007 10:39:30 -0600
Date:	Sat, 18 Aug 2007 09:46:02 -0700
From:	Randy Dunlap <randy.dunlap@oracle.com>
To:	Jiri Slaby <jirislaby@gmail.com>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <source@mvista.com>,
	<dougthompson@xmission.com>,
	<bluesmoke-devel@lists.sourceforge.net>, <dtor@mail.ru>,
	<linux-input@atrey.karlin.mff.cuni.cz>, <netdev@vger.kernel.org>,
	<James.Bottomley@SteelEye.com>, <linux-scsi@vger.kernel.org>,
	<gtolstolytkin@ru.mvista.com>, <vitalywool@gmail.com>,
	<dsaxena@plexity.net>, <ralf@linux-mips.org>,
	<linux-mips@linux-mips.org>, <mchehab@infradead.org>,
	<video4linux-list@redhat.com>, <jbenc@suse.cz>,
	<flamingice@sourmilk.net>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 8/9] define global BIT macro
Message-Id: <20070818094602.0ea69c27.randy.dunlap@oracle.com>
In-Reply-To: <428714662539710215@wsc.cz>
References: <737828602404912540@wsc.cz>
	<428714662539710215@wsc.cz>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Return-Path: <randy.dunlap@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randy.dunlap@oracle.com
Precedence: bulk
X-list: linux-mips

On Sat, 18 Aug 2007 11:44:12 +0200 (CEST) Jiri Slaby wrote:

> define global BIT macro
> 
> move all local BIT defines to the new globally define macro.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
> 
>  include/linux/bitops.h                      |    1 +
>  include/video/sstfb.h                       |    1 -
>  include/video/tdfx.h                        |    2 --
>  net/mac80211/ieee80211_i.h                  |    2 --
>  18 files changed, 1 insertions(+), 37 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 3255b06..a57b81f 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -3,6 +3,7 @@
>  #include <asm/types.h>
>  
>  #ifdef	__KERNEL__
> +#define BIT(nr)			(1UL << (nr))
>  #define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
>  #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
>  #define BITS_TO_TYPE(nr, t)	(((nr)+(t)-1)/(t))


So users of the BIT() macro in include/linux/input.h can be
changed to use the global BIT_MASK() macro...
and the former can be removed.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
