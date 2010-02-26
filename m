Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2010 21:50:27 +0100 (CET)
Received: from mail.codesourcery.com ([38.113.113.100]:34196 "EHLO
        mail.codesourcery.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492067Ab0BZUuX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2010 21:50:23 +0100
Received: (qmail 10627 invoked from network); 26 Feb 2010 20:50:20 -0000
Received: from unknown (HELO caradoc.them.org) (dan@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 26 Feb 2010 20:50:20 -0000
Date:   Fri, 26 Feb 2010 15:50:17 -0500
From:   Daniel Jacobowitz <dan@codesourcery.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     gdb-patches@sourceware.org, Joel Brobecker <brobecker@adacore.com>,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Make mips-linux signal frame unwinding more robust.
Message-ID: <20100226205016.GB2630@caradoc.them.org>
Mail-Followup-To: David Daney <ddaney@caviumnetworks.com>,
        gdb-patches@sourceware.org, Joel Brobecker <brobecker@adacore.com>,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
References: <4B82CEC4.2010607@caviumnetworks.com>
 <20100225174739.GA2851@adacore.com>
 <4B86C5EB.6090303@caviumnetworks.com>
 <4B881151.9070300@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B881151.9070300@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <dan@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@codesourcery.com
Precedence: bulk
X-list: linux-mips

On Fri, Feb 26, 2010 at 10:22:09AM -0800, David Daney wrote:
>   The current signal frame unwinding code in mips-linux-tdep.c assumes
>   a constant offset from the signal return trampoline to the signal
>   frame. The assumption does not hold for all kernels.  Specifically
>   those that have to be compiled with ICACHE_REFILLS_WORKAROUND_WAR
>   set (SGI O2 for example).  In the near future, it is likely that the
>   assumption will cease to hold universally, as we are attempting to
>   move the signal return trampoline off the stack entirely.

It's funny, I thought I'd already taught GDB about the WAR workaround,
but there's no hint of it.  Your patch looks good to me.

> OK to commit?
> 
> How about on the 7.1 branch?

OK both.

-- 
Daniel Jacobowitz
CodeSourcery
