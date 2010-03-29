Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2010 00:02:41 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:57398 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492433Ab0C2WCh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 Mar 2010 00:02:37 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1NwN2T-0001JB-En; Mon, 29 Mar 2010 22:02:29 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1NwN2N-0007ZM-O2; Tue, 30 Mar 2010 00:02:23 +0200
Date:   Tue, 30 Mar 2010 00:02:23 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Peter 'p2' De Schrijver <p2@debian.org>, linux-mips@linux-mips.org
Subject: Re: movidis x16 hard lockup using 2.6.33
Message-ID: <20100329220223.GK27216@mails.so.argh.org>
References: <20100326184132.GU2437@apfelkorn> <4BAD03A5.9070701@caviumnetworks.com> <20100327230744.GG27216@mails.so.argh.org> <4BB0DB2A.9080405@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BB0DB2A.9080405@caviumnetworks.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@not.so.argh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips

* David Daney (ddaney@caviumnetworks.com) [100329 18:54]:
> On 03/27/2010 04:07 PM, Andreas Barth wrote:
>> * David Daney (ddaney@caviumnetworks.com) [100326 19:57]:
>>> Also you could try running with the attached patch.  It is not the best
>>> watchdog, but it will print the register state for each core when things
>>> get stuck.  Occasionally that is enough to see where the problem is.
>>
>> Thanks.
>>
>> As our logging has only limited buffer size, I'd be happy about an
>> variant of the patch which doesn't reboot but just let the machine
>> hang after the third occurence.
>>
>> Any chances for it?

> You could just sit in a loop kicking the watchdog timer after you get to  
> the NMI handler.  That should prevent a reset, but still print the  
> machine state.

I need to admit that I'm totally unable to make code from that
statement.


Could you (or someone else) give me a hand? Also please note that it
usually takes a few hours to crash the machine, and I didn't see
anything in the normal syslog.


Andi
