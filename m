Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2011 22:42:53 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47125 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491853Ab1A0Vmu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Jan 2011 22:42:50 +0100
Date:   Thu, 27 Jan 2011 21:42:50 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ian Lance Taylor <iant@google.com>
cc:     loody <miloody@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>,
        gcc-help <gcc-help@gcc.gnu.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Fwd: about udelay in mips
In-Reply-To: <mcrlj26owrx.fsf@google.com>
Message-ID: <alpine.LFD.2.00.1101272138520.25047@eddie.linux-mips.org>
References: <AANLkTinvdEPwQ=DmcF8nnTAa0Py_O=+p7x1pobcTNHom@mail.gmail.com>        <AANLkTik8hQfd8cvNj=qeq5U=6zpQHw33a9hfK-q8+x1Z@mail.gmail.com>        <AANLkTikpUBtg2zz8tcbcz2rcG-O+fTFwb_pTi88uZe0h@mail.gmail.com>        <AANLkTi=zfr5YuwBCcvH2Jas50UxnUtvzp_CDyN25sT5h@mail.gmail.com>
        <AANLkTim_swh58fCUxZ4e6MDrM9Lqrbm+1ufnp8W767JL@mail.gmail.com>        <AANLkTim+Dy1_MFoMcXK3aPCKUcz6hpJY7B5kKY_nXNnP@mail.gmail.com>        <4D4156CF.1040909@mvista.com>        <AANLkTimdXa9WS7WLuKgD4iOCXcwvi5gPf5fQ2_eMsiW_@mail.gmail.com>
 <mcrlj26owrx.fsf@google.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 27 Jan 2011, Ian Lance Taylor wrote:

> I don't know the type of HZ.  But assuming it is a constant, then the
> rules of C are that the expression
>     us * 0x000010c7 * HZ * lpj
> gets evaluated in the type "unsigned long".  The fact that you then cast
> that "unsigned long" value to "unsigned long long" does not cause the
> multiplication to be done in the type "unsigned long long".
> 
> You need to write something like
>     (unsigned long long) us * 0x000010c7 * HZ * (unsigned long long) lpj
> to get the multiplication to be done in the "unsigned long long" type.

 Though as a matter of coding style, personally I'd rather assigned "us" 
to a local variable of the "unsigned long long" type and performed all the 
calculations on it instead, avoiding any explicit casts and doubts as to 
what type is being used altogether.

  Maciej
