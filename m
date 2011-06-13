Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2011 11:27:56 +0200 (CEST)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35233 "EHLO
        www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1490989Ab1FMJ1u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2011 11:27:50 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by www.etchedpixels.co.uk (8.14.4/8.14.4) with ESMTP id p5D9TtPu000333;
        Mon, 13 Jun 2011 10:29:55 +0100
Date:   Mon, 13 Jun 2011 10:29:54 +0100
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
To:     Jamie Iles <jamie@jamieiles.com>
Cc:     Alan Cox <alan@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
        linux-mips@linux-mips.org, Marc St-Jean <bluezzer@gmail.com>,
        Shane McDonald <mcdonald.shane@gmail.com>,
        Anoop P A <anoop.pa@gmail.com>
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct
 accessors
Message-ID: <20110613102954.4d65509c@lxorguk.ukuu.org.uk>
In-Reply-To: <20110613091926.GB2472@pulham.picochip.com>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
        <20110610035817.GA6740@linux-mips.org>
        <20110610075426.GM3711@pulham.picochip.com>
        <20110610145724.1e0c0983@bob.linux.org.uk>
        <20110613091926.GB2472@pulham.picochip.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEWysKsSBQMIAwIZCwj///8wIhxoRDXH9QHCAAABeUlEQVQ4jaXTvW7DIBAAYCQTzz2hdq+rdg494ZmBeE5KYHZjm/d/hJ6NfzBJpp5kRb5PHJwvMPMk2L9As5Y9AmYRBL+HAyJKeOU5aHRhsAAvORQ+UEgAvgddj/lwAXndw2laEDqA4x6KEBhjYRCg9tBFCOuJFxg2OKegbWjbsRTk8PPhKPD7HcRxB7cqhgBRp9Dcqs+B8v4CQvFdqeot3Kov6hBUn0AJitrzY+sgUuiA8i0r7+B3AfqKcN6t8M6HtqQ+AOoELCikgQSbgabKaJW3kn5lBs47JSGDhhLKDUh1UMipwwinMYPTBuIBjEclSaGZUk9hDlTb5sUTYN2SFFQuPe4Gox1X0FZOufjgBiV1Vls7b+GvK3SU4wfmcGo9rPPQzgIabfj4TYQo15k3bTHX9RIw/kniir5YbtJF4jkFG+dsDK1IgE413zAthU/vR2HVMmFUPIHTvF6jWCpFaGw/A3qWgnbxpSm9MSmY5b3pM1gvNc/gQfwBsGwF0VCtxZgAAAAASUVORK5CYII=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 30367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10480

On Mon, 13 Jun 2011 10:19:26 +0100
Jamie Iles <jamie@jamieiles.com> wrote:

> On Fri, Jun 10, 2011 at 02:57:24PM +0100, Alan Cox wrote:
> > > I found this series from Alan 
> > > (http://www.spinics.net/lists/linux-serial/msg03484.html) which looks 
> > > like it would do the job if we added the extra irq callback.  Ideally
> > > we just remove both of the UPIO_DWAPB and UPIO_DWAPB32 and let the
> > > platform specify the ops.
> > 
> > I've not yet had time to go back and revisit those patches and debug
> > them so they actually work but as and when someone gets time I think
> > it's the right basic path to follow, and the irq callback looks
> > sensible too.
> 
> As an intermediate step, how about adding the irq callback to 
> uart_8250_port and removing UPIO_DWAPB and UPIO_DWAPB32 from the driver? 

Feel free to - it makes the later job easier.
