Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 00:09:50 +0100 (CET)
Received: from oss.sgi.com ([192.48.170.157]:25284 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S527418AbYC0XJL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Mar 2008 00:09:11 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2RN8VvV025570
	for <linux-mips@linux-mips.org>; Thu, 27 Mar 2008 16:08:32 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2RMVaxD027286;
	Thu, 27 Mar 2008 22:31:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2RMVZZn027285;
	Thu, 27 Mar 2008 22:31:35 GMT
Date:	Thu, 27 Mar 2008 22:31:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org, Nico Coesel <ncoesel@DEALogic.nl>
Subject: Re: FW: Alchemy power managment code.
Message-ID: <20080327223134.GA26997@linux-mips.org>
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF804@dealogicserver.DEALogic.nl> <47E7B970.30105@ru.mvista.com> <47E7BB4B.3080507@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47E7BB4B.3080507@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 24, 2008 at 05:31:39PM +0300, Sergei Shtylyov wrote:

>  >    The TOY cpunter 0 clockevent driver is also need to be written for
>> the recent kernel as CP0 timer stops ticking after wait insn is executed 
>> -- see arch/mips/au1000/common/time.c...
>
>    And here's found another possible issue with Alchemy PM -- the CP0 
> counter counts at unpredictable frequency in idle state (after executing 
> "wait"), so the MIPS clocksource will probably be unstable?

Correct - and cevt-r4k won't be usable either.  I guess that means you
leave the user the choice between either these two or using wait.  Not
nice but ...

  Ralf
