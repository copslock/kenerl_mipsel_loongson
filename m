Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 00:52:15 +0000 (GMT)
Received: from agile.dsl.onthenet.net ([IPv6:::ffff:203.144.28.2]:54303 "EHLO
	surfers.oz.agile.tv") by linux-mips.org with ESMTP
	id <S8225226AbTA1AwO>; Tue, 28 Jan 2003 00:52:14 +0000
Received: from agile.tv (tugun.oz.agile.tv [192.168.16.20])
	by surfers.oz.agile.tv (8.11.6/8.11.2) with ESMTP id h0S0pku05828;
	Tue, 28 Jan 2003 10:51:47 +1000
Message-ID: <3E35D422.5030101@agile.tv>
Date: Tue, 28 Jan 2003 10:51:46 +1000
From: Liam Davies <ldavies@agile.tv>
Reply-To: ldavies@agile.tv
Organization: AgileTV Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karsten Merker <karsten@excalibur.cologne.de>
CC: linux-mips@linux-mips.org, tom@maisl.net,
	cobalt-22 <cobalt-22@devel.alal.com>
Subject: Re: [PATCH] Cobalt interrupthandler fix
References: <20030124141524.GA685@excalibur.cologne.de>
In-Reply-To: <20030124141524.GA685@excalibur.cologne.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ldavies@agile.tv>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ldavies@agile.tv
Precedence: bulk
X-list: linux-mips

Karsten Merker wrote:
> Hallo,
> 
> the Cobalt NASRaQ (as well as other RaQ models) has the problem of freezing
> when there is activity on the serial port and on the ethernet at the same
> time. Peter de Schrijver has tracked this down to a bug in the interrupt
> handler. The handler currently does not check whether an interrupt is masked
> and calls the handling routine for _every_ interrupt, not only for those
> that are not masked out currently.
> 
> The following patch fixes this. Ralf, could you please apply the fix
> to the CVS?
Good find, applied to CVS. The patch works great here!


Liam
