Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0N2OcR09004
	for linux-mips-outgoing; Tue, 22 Jan 2002 18:24:38 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0N2OXP09001
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 18:24:33 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0N1MtB22274;
	Tue, 22 Jan 2002 17:22:55 -0800
Subject: Re: Mips IRQ support
From: Pete Popov <ppopov@pacbell.net>
To: "TWEDE,ROGER   ""(HP-Boise,ex1)" <roger_twede@hp.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <CBD6266EA291D5118144009027AA63353F92B7@xboi05.boi.hp.com>
References: <CBD6266EA291D5118144009027AA63353F92B7@xboi05.boi.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 22 Jan 2002 17:26:19 -0800
Message-Id: <1011749179.28944.262.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-01-22 at 17:15, TWEDE,ROGER (HP-Boise,ex1) wrote:
> 
> Are there any plans to provide full MIPS irq support in the general mips irq
> code?
> 
> The only machine that appears to attempt to fully support the MIPS interrupt
> set currently is the gt64120/momenco_ocelot machine.
 
> It uses the define CP0_S1_INTCONTROL ($20) to get at the upper interrupt
> lines ( > 8 ).

That's really a QED rm7k cpu feature, not a mips generic one.
 
> Anyone else find that support for this MIPS hardware would be best placed in
> the standard irq code rather than each machine variant having to
> re-implement it itself (as the irq code was in the past).

Might be a good feature for arch/mips/kernel/irq_cpu.c and it wouldn't
be difficult to add.  I don't think arch/mips/kernel/irq.c needs to
change.

Pete
