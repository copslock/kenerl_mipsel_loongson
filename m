Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 14:01:03 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:54695 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491112Ab1CXNBA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 14:01:00 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2k9m-0005W2-PI; Thu, 24 Mar 2011 14:00:55 +0100
Date:   Thu, 24 Mar 2011 14:00:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch 37/38] mips: vr41xx: Cleanup the direct access to
 irq_desc[]
In-Reply-To: <4D8B3CBC.3080307@mvista.com>
Message-ID: <alpine.LFD.2.00.1103241400250.31464@localhost6.localdomain6>
References: <20110323210437.398062704@linutronix.de> <20110323210538.070462971@linutronix.de> <4D8B3CBC.3080307@mvista.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Thu, 24 Mar 2011, Sergei Shtylyov wrote:
> > -		if (!(desc->status&  IRQ_DISABLED)&&  desc->chip->unmask)
> > -			desc->chip->unmask(source_irq);
> > +		if (!(desc->status&  IRQ_DISABLED)&&  chip->irq_unmask)
> > +			chip->irq_unmask(idata);
> 
>    Hm, doesn't this (I mean the old) code break after the previous patch?

Not as long as the compat functions are active in the core.
