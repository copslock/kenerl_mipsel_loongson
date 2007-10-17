Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 17:58:48 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2956 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20036706AbXJQQ6q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 17:58:46 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9HGwkEe007134;
	Wed, 17 Oct 2007 17:58:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9HGwj6M007133;
	Wed, 17 Oct 2007 17:58:45 +0100
Date:	Wed, 17 Oct 2007 17:58:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: plat_timer_setup, mips_timer_ack, etc.
Message-ID: <20071017165844.GA7065@linux-mips.org>
References: <20071017.005211.108739735.anemo@mba.ocn.ne.jp> <20071016163610.GA25794@linux-mips.org> <20071017.020113.63743059.anemo@mba.ocn.ne.jp> <20071017162837.GA5491@linux-mips.org> <471639AC.8080301@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <471639AC.8080301@ru.mvista.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 17, 2007 at 08:34:52PM +0400, Sergei Shtylyov wrote:

> Ralf Baechle wrote:
> 
> >>$ git-grep mips_timer_ack arch/mips
> >>arch/mips/dec/time.c:   mips_timer_ack = dec_timer_ack;
> >>arch/mips/jmr3927/rbhma3100/setup.c:    mips_timer_ack = 
> >>jmr3927_timer_ack;
> 
>    TX3927 has three channel timer of which only channel 0 is used to 
> implement a clocksource -- however, clocksource code whould also need to be 
> changed since it's now jiffy-based and HRT doesn't tolerate this -- of 
> course, if anybody still cared about this boards

Well, getting rid of the code where there are no users left is always the
other solution.

> >>arch/mips/philips/pnx8550/common/time.c:        mips_timer_ack = 
> >>timer_ack;
> 
>    Here we have a case of a vendor abusing the count/compare register and 
> also adding 3 more of them. One pair can be used for clockevents, the other 
> for clocksource (its compare reg. being programmed to all ones).

  Ralf
