Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 17:34:50 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:22145 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037018AbXJQQem (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2007 17:34:42 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 050B83EC9; Wed, 17 Oct 2007 09:34:39 -0700 (PDT)
Message-ID: <471639AC.8080301@ru.mvista.com>
Date:	Wed, 17 Oct 2007 20:34:52 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: plat_timer_setup, mips_timer_ack, etc.
References: <20071017.005211.108739735.anemo@mba.ocn.ne.jp> <20071016163610.GA25794@linux-mips.org> <20071017.020113.63743059.anemo@mba.ocn.ne.jp> <20071017162837.GA5491@linux-mips.org>
In-Reply-To: <20071017162837.GA5491@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>$ git-grep mips_timer_ack arch/mips
>>arch/mips/dec/time.c:   mips_timer_ack = dec_timer_ack;
>>arch/mips/jmr3927/rbhma3100/setup.c:    mips_timer_ack = jmr3927_timer_ack;

    TX3927 has three channel timer of which only channel 0 is used to 
implement a clocksource -- however, clocksource code whould also need to be 
changed since it's now jiffy-based and HRT doesn't tolerate this -- of course, 
if anybody still cared about this boards

>>arch/mips/philips/pnx8550/common/time.c:        mips_timer_ack = timer_ack;

    Here we have a case of a vendor abusing the count/compare register and 
also adding 3 more of them. One pair can be used for clockevents, the other 
for clocksource (its compare reg. being programmed to all ones).

WBR, Sergei
