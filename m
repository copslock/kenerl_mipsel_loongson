Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2010 20:58:42 +0100 (CET)
Received: from gateway06.websitewelcome.com ([69.56.195.6]:33037 "HELO
        gateway06.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492080Ab0LPT6j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Dec 2010 20:58:39 +0100
Received: (qmail 20147 invoked from network); 16 Dec 2010 19:58:51 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway06.websitewelcome.com with SMTP; 16 Dec 2010 19:58:51 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=rRw0lC6wjvqXrXzsrWH/Gmhm0PqgEJJVpCDtfvCff0IP2U1Bp+AJFm7RMHa6Tl3auz7TVNz+v3CgyMSVSjXEzg9qwxb7Y7aGPFxoA981PWrvgOG8I3RAeINYR5WICAn4;
Received: from [216.239.45.4] (port=10410 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PTJy4-0006Bf-CG; Thu, 16 Dec 2010 13:58:24 -0600
Message-ID: <4D0A6F63.8080206@paralogos.com>
Date:   Thu, 16 Dec 2010 11:58:27 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     STUART VENTERS <stuart.venters@adtran.com>
CC:     anoop.pa@gmail.com, linux-mips@linux-mips.org,
        Anoop_P.A@pmc-sierra.com
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB880@EXV1.corp.adtran.com> <4D0A677C.6040104@paralogos.com>
In-Reply-To: <4D0A677C.6040104@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Ralf tells me that this message got blocked by the LMO server due to 
HTML content.
So here it is again, textier.

On 12/16/10 11:24, Kevin D. Kissell wrote:
 > On 12/16/10 07:37, STUART VENTERS wrote:
 >
 > Two other possible clues:
 >
 > The EVP is clear in the MVPControl register.
 > Does this say that only VPE0, T0 gets to run?

That's correct.  In the maxtcs=1/maxvpes=1 boot state, it wouldn't 
matter.  It's just possible that setting EVP is conditional on more than 
one VPE being used, but that's not the way I remember it.

 > Also the EXCPT bits in VPEControl for VPE1 indicate a Gating Storage 
Exception dispatch.
 > But that seems to conflict the EVP bit above.

I don't have a copy of the ASE spec handy to see whether those bits have 
a defined power-on value, but particularly if maxvpes=1 was set at boot 
time, I would expect VPE1's registers to be in a partly random power-up 
state.

 > Perhaps these are an artifact of getting to a good state to dump 
things out.

As per my previous mail, I looked at the MT register dump source, and it 
really does pull values directly
out of registers and doesn't depend on having a sane kernel stack 
frame.  The exceptions to that rule
are the reported values for TCStatus of the executing TC, which is based 
on the perhaps-now-broken
assumption that local_irq_save(flags) stores the *entire* pre-invocation 
value of the TCStatus register
in the flags variable, and MVPcontrol, which is based on the assumption 
that dvpe() returns the pre-invocation
value of MVPcontrol.  Break those assumptions, and you'll get 
inconsistent state dumps like this,
and very possibly incorrect execution.   Particularly if what was done 
was that effectively replaces
the SMTC-specific implementation of local_irq_save()/local_irq_restore() 
with something that uses
the generic MIPS32R2 atomic interrupt enable/disable instructions.  That 
would have been a *very* bad idea...

              Regards,

              Kevin K.
