Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 17:43:22 +0200 (CEST)
Received: from gateway14.websitewelcome.com ([67.18.44.10]:51506 "HELO
        gateway14.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492084Ab0EEPnS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 17:43:18 +0200
Received: (qmail 17164 invoked from network); 5 May 2010 15:48:14 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway14.websitewelcome.com with SMTP; 5 May 2010 15:48:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=QtyVELYXXpm+RgltGeJhlC/IWrUk9DkoEzoraWQLRZbtOgnH3W5tE0aQpIAKB8Z8Q4FDrB1zyjnBh2KRoHrv2SraHQoy4HDTX4dVtaZgvzC47MHznfMG5LZkYo7zbU9m;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:1141 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1O9gkd-0004gy-TI; Wed, 05 May 2010 10:43:08 -0500
Message-ID: <4BE19214.4010209@paralogos.com>
Date:   Wed, 05 May 2010 08:43:16 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable
 by ctc1
References: <E1O9VoP-0001Zl-Qw@localhost> <4BE122D1.3000609@paralogos.com> <20100505091159.GA4016@linux-mips.org>
In-Reply-To: <20100505091159.GA4016@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
>> I'm glad to hear that the patch is functional.  It was pretty clear that
>> it would solve your problem, but I was concerned that the inability to
>> write the Cause bits was done as a way around some other problem. 
>> Someone went to a certain amount of trouble to not accept them as
>> inputs, in violation of spec.  I just looked back, and the bug was
>> introduced as part of a patch of Ralf's from April 2005 entitled "Fix
>> Preemption and SMP problems in the FP emulator".  It's unlikely that
>> overriding CTC semantics actually fixed any underlying problems, but it
>> may have masked symptoms of problems that we can only hope have been
>> fixed in the mean time. Anyone run this patch on an FPUless SMP?   Oh,
>> for a 34Kf with a bunch of TCs! ;o)
>>     
>
> That's commit ID 72402ec9efdb2ea7e0ec6223cf20e7301a57da02 and the patch
> was comitted during the CVS days which only records the comitter but not
> the author.  The actual author is Atsushi Nemoto.
>   
Well,. I certainly understood that you were simply the guy who did the
commit.  Didn't mean to make it sound like an accusation, but it was
marginally easier to type your name and date than to find, cut, and
paste the commit ID.  Sorry if it came off wrong.  It would be cool if
Atsushi remembered the reasoning behind the change, but empirical proof
that undoing it doesn't create a subtle problem for current SMP kernels
would be better still.

          Regards,

          Kevin K.
