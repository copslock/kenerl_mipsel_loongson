Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 19:22:49 +0100 (BST)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:57863 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225478AbUEQSWs>; Mon, 17 May 2004 19:22:48 +0100
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.6.0)); Mon, 17 May 2004 11:20:40 -0700
X-Server-Uuid: 97B92932-364A-4474-92D6-5CFE9C59AD14
Received: from mail-sj1-1.sj.broadcom.com (mail-sj1-1.sj.broadcom.com
 [10.16.128.231]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA14837; Mon, 17 May 2004 11:20:04 -0700 (PDT)
Received: from broadcom.com ([10.21.2.22]) by mail-sj1-1.sj.broadcom.com
 (8.12.9/8.12.4/SSM) with ESMTP id i4HIKcLn005472; Mon, 17 May 2004 11:
 20:38 -0700 (PDT)
Message-ID: <40A901DD.80308@broadcom.com>
Date: Mon, 17 May 2004 11:18:05 -0700
From: "Mitch Lichtenberg" <mpl@broadcom.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4)
 Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Ken Giusti" <manwithastinkydog@yahoo.com>
cc: linux-mips@linux-mips.org
Subject: Re: running 2.6 on swarm pass1
References: <20040517150631.13795.qmail@web13301.mail.yahoo.com>
In-Reply-To: <20040517150631.13795.qmail@web13301.mail.yahoo.com>
X-WSS-ID: 6CB7DDF21NG7203616-01-01
Content-Type: text/plain;
 charset=us-ascii;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mpl@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpl@broadcom.com
Precedence: bulk
X-list: linux-mips

Ken,

Pass1 BCM1250's have enough problems that it's no surprise
that things don't work anymore.    Most of the workarounds
to CPU core issues are deliberately not checked into the external
(linux-mips) tree, and some require some nasty toolchain
hacks (for example, taking exceptions on the instruction
in a branch delay slot is perilous).

I don't know how you got your SWARM, but you might want to
press for getting a new one.  No pass1's were ever shipped
in volume, so it would be best to NOT support it.

/Mitch.


Ken Giusti wrote:
> Hi,
> 
> I've got a swarm board with a pass1 sibyte sb1250. 
> Here's the relevant system info from the boot up
> console:
> 
<<snip>>
