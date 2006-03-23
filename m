Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Mar 2006 02:14:51 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:31496 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133580AbWCWCOm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Mar 2006 02:14:42 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 0B43F64D3E; Thu, 23 Mar 2006 02:24:35 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id CD34466ED7; Thu, 23 Mar 2006 02:23:45 +0000 (GMT)
Date:	Thu, 23 Mar 2006 02:23:45 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Michael J. Hammel" <mips@graphics-muse.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: sb1250_hpt_setup fails for BigSur build and sb1250 MAC (re: 1480) queue lockups
Message-ID: <20060323022345.GA7123@deprecation.cyrius.com>
References: <1143070821.9093.18.camel@europa.cri-dsp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143070821.9093.18.camel@europa.cri-dsp.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Michael J. Hammel <mips@graphics-muse.org> [2006-03-22 16:40]:
>   LD      .tmp_vmlinux1
> arch/mips/sibyte/swarm/lib.a(setup.o): In function `swarm_time_init':
> setup.c:(.init.text+0x0): undefined reference to `sb1250_hpt_setup'
> setup.c:(.init.text+0x0): relocation truncated to fit: R_MIPS_26 against
> `sb1250_hpt_setup'
> make: *** [.tmp_vmlinux1] Error 

I posted this error message and a fix a few days ago, see
http://www.linux-mips.org/archives/linux-mips/2006-03/msg00132.html
Ralf told me off-list that the fix is not corract (as I sort of had
assumed already) but you can use it as a workaround.

> I was trying the latest 2.6.16 to see if the recent mods related to the
> sb1250 MAC fixed a problem where the incoming queue (and eventually
> outbound queue) get blocked.

The fix that was posted for this didn't make 2.6.16.  You need to
manually apply the patch from
http://www.linux-mips.org/archives/linux-mips/2006-03/msg00087.html
-- 
Martin Michlmayr
http://www.cyrius.com/
