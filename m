Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 15:59:38 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:64251 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491102Ab1FJN7f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 15:59:35 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 10 Jun 2011 06:59:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,347,1304319600"; 
   d="scan'208";a="14794275"
Received: from unknown (HELO bob.linux.org.uk) ([10.255.13.27])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jun 2011 06:59:25 -0700
Date:   Fri, 10 Jun 2011 14:57:24 +0100
From:   Alan Cox <alan@linux.intel.com>
To:     Jamie Iles <jamie@jamieiles.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org,
        Marc St-Jean <bluezzer@gmail.com>,
        Shane McDonald <mcdonald.shane@gmail.com>,
        Anoop P A <anoop.pa@gmail.com>
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct
 accessors
Message-ID: <20110610145724.1e0c0983@bob.linux.org.uk>
In-Reply-To: <20110610075426.GM3711@pulham.picochip.com>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
        <20110610035817.GA6740@linux-mips.org>
        <20110610075426.GM3711@pulham.picochip.com>
Organization: Intel
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Organisation: Intel Corporation UK Ltd, registered no. 1134945 (England),
 Registered office Pipers Way, Swindon, SN3 1RJ
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 30318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@linux.intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9215

> I found this series from Alan 
> (http://www.spinics.net/lists/linux-serial/msg03484.html) which looks 
> like it would do the job if we added the extra irq callback.  Ideally
> we just remove both of the UPIO_DWAPB and UPIO_DWAPB32 and let the
> platform specify the ops.

I've not yet had time to go back and revisit those patches and debug
them so they actually work but as and when someone gets time I think
it's the right basic path to follow, and the irq callback looks
sensible too.

Ultimately yes I'd also like to see all board specific ops banished
from 8250.c
