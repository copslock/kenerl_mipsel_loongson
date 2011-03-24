Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 15:45:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37595 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491906Ab1CXOpv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 15:45:51 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p2OEjW3q009207;
        Thu, 24 Mar 2011 15:45:32 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p2OEjWfw009206;
        Thu, 24 Mar 2011 15:45:32 +0100
Date:   Thu, 24 Mar 2011 15:45:32 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org
Subject: Re: [patch 27/38] mips: pnx855: Convert to new irq_chip functions
Message-ID: <20110324144532.GB30990@linux-mips.org>
References: <20110323210437.398062704@linutronix.de>
 <20110323210537.126033119@linutronix.de>
 <4D8B39CA.9010605@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D8B39CA.9010605@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 24, 2011 at 03:32:10PM +0300, Sergei Shtylyov wrote:

> >Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> 
>    Typo in the subject: s/pnx855/pnx8550/

Queued for 2.6.39 with the typo fixed.  Thanks!

  Ralf
