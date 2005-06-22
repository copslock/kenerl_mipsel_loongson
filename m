Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 00:26:07 +0100 (BST)
Received: from straum.hexapodia.org ([IPv6:::ffff:64.81.70.185]:27430 "EHLO
	straum.hexapodia.org") by linux-mips.org with ESMTP
	id <S8225426AbVFVXZv>; Thu, 23 Jun 2005 00:25:51 +0100
Received: by straum.hexapodia.org (Postfix, from userid 22448)
	id 1F7E029C; Wed, 22 Jun 2005 16:24:47 -0700 (PDT)
Date:	Wed, 22 Jun 2005 16:24:46 -0700
From:	Andy Isaacson <adi@hexapodia.org>
To:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] various sibyte 2.6.x bugfixes
Message-ID: <20050622232446.GA3141@hexapodia.org>
References: <17081.32401.574987.337795@cortez.sw.starentnetworks.com> <Pine.LNX.4.61L.0506221616020.4849@blysk.ds.pg.gda.pl> <17081.42083.756755.92799@cortez.sw.starentnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17081.42083.756755.92799@cortez.sw.starentnetworks.com>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Return-Path: <adi@hexapodia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@hexapodia.org
Precedence: bulk
X-list: linux-mips

Great minds think alike...

On Wed, Jun 22, 2005 at 01:48:19PM -0400, Dave Johnson wrote:
> Now that I look at it more that check isn't needed at all.
> 
> zero bits wont make it past irq_affinity_write_proc() so that's not
> needed.
> 
> multiple bits are valid (it's also the default) so just using the
> first bit that is set should be fine.

Multiple bits are valid at the API, but the current implementation of
sb1250_set_affinity can only handle setting affinity to a single CPU, so
the test should remain.  Unless I'm missing something, which is entirely
possible.

>  	/* Convert logical CPU to physical CPU */
> -	cpu = cpu_logical_map(i);
> +	cpu = cpu_logical_map(first_cpu(mask));

Ah, but that's not right, is it?  If I as the admin say "please bind
IRQs to CPUs 0 and 1" I'll be annoyed to have them all hitting 0.  And
with the BCM1480 it's no longer an academic question.

-andy
