Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0N2S4H09078
	for linux-mips-outgoing; Tue, 22 Jan 2002 18:28:04 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0N2RwP09075
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 18:27:59 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0N1QLB22454;
	Tue, 22 Jan 2002 17:26:21 -0800
Message-ID: <3C4E1195.9996C16@mvista.com>
Date: Tue, 22 Jan 2002 17:27:49 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Mips IRQ support
References: <CBD6266EA291D5118144009027AA63353F92B7@xboi05.boi.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"TWEDE,ROGER (HP-Boise,ex1)" wrote:
> 
> Are there any plans to provide full MIPS irq support in the general mips irq
> code?
> 
> The only machine that appears to attempt to fully support the MIPS interrupt
> set currently is the gt64120/momenco_ocelot machine.
> 
> It uses the define CP0_S1_INTCONTROL ($20) to get at the upper interrupt
> lines ( > 8 ).
> 
> Anyone else find that support for this MIPS hardware would be best placed in
> the standard irq code rather than each machine variant having to
> re-implement it itself (as the irq code was in the past).
> 

Yes.

The best way is to provide hw_irq_controller structure for the extended CPU
IRQ feature.  See arch/mips/kernel/irq_cpu.c file and its related config
option.

Jun
