Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2011 11:19:39 +0200 (CEST)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:40760 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491056Ab1FMJTf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2011 11:19:35 +0200
Received: by wwi18 with SMTP id 18so2358286wwi.0
        for <multiple recipients>; Mon, 13 Jun 2011 02:19:29 -0700 (PDT)
Received: by 10.216.235.157 with SMTP id u29mr2338811weq.24.1307956769814;
        Mon, 13 Jun 2011 02:19:29 -0700 (PDT)
Received: from localhost (gw-ba1.picochip.com [94.175.234.108])
        by mx.google.com with ESMTPS id z66sm2762709weq.24.2011.06.13.02.19.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 02:19:28 -0700 (PDT)
Date:   Mon, 13 Jun 2011 10:19:26 +0100
From:   Jamie Iles <jamie@jamieiles.com>
To:     Alan Cox <alan@linux.intel.com>
Cc:     Jamie Iles <jamie@jamieiles.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
        linux-mips@linux-mips.org, Marc St-Jean <bluezzer@gmail.com>,
        Shane McDonald <mcdonald.shane@gmail.com>,
        Anoop P A <anoop.pa@gmail.com>
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct
 accessors
Message-ID: <20110613091926.GB2472@pulham.picochip.com>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
 <20110610035817.GA6740@linux-mips.org>
 <20110610075426.GM3711@pulham.picochip.com>
 <20110610145724.1e0c0983@bob.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110610145724.1e0c0983@bob.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie@jamieiles.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10473

On Fri, Jun 10, 2011 at 02:57:24PM +0100, Alan Cox wrote:
> > I found this series from Alan 
> > (http://www.spinics.net/lists/linux-serial/msg03484.html) which looks 
> > like it would do the job if we added the extra irq callback.  Ideally
> > we just remove both of the UPIO_DWAPB and UPIO_DWAPB32 and let the
> > platform specify the ops.
> 
> I've not yet had time to go back and revisit those patches and debug
> them so they actually work but as and when someone gets time I think
> it's the right basic path to follow, and the irq callback looks
> sensible too.

As an intermediate step, how about adding the irq callback to 
uart_8250_port and removing UPIO_DWAPB and UPIO_DWAPB32 from the driver?  

Jamie
