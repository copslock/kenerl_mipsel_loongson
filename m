Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 16:13:08 +0100 (CET)
Received: from mail-gx0-f227.google.com ([209.85.217.227]:37291 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493930AbZKBPNB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 16:13:01 +0100
Received: by gxk27 with SMTP id 27so1326132gxk.7
        for <multiple recipients>; Mon, 02 Nov 2009 07:12:53 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AAheWRTzcqsnmGvBBj3JgqTPdVoCdn58XvMSb1/CsoU=;
        b=L4qN6tr5/RdiXz5AjqMZR2kDs3ZoH4Wn71yudk/mwsYq4C+jURPsc1UkJTDq6s0RLn
         QiEIUNTffuY//qYRYGimrfRG9nhGCL5pMM9BgxzL4ZbBOTkx3JvrFS8G4H4GQQzJkzy9
         eeDprSL0StLPW+DEb1Qwpn6b5Z9ffZkbQPvXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fyxAviaxKi9IaKewatUjb/Ro4ZDydGO2/nZmanY3uGjMHd53l4sEuoLPsxBKz4bXd4
         ClwC96M+Q5tUthg/wvs/qsJRGQQKz7vhD83uNil0TGNLbvb0eWNi0wno0lNkzGr4d0Aj
         SKQxDZmflyWIo0yIpjK76KXlDFwrUb6r2ddKw=
MIME-Version: 1.0
Received: by 10.91.102.6 with SMTP id e6mr8775970agm.99.1257174772986; Mon, 02 
	Nov 2009 07:12:52 -0800 (PST)
In-Reply-To: <20091101071407.GC4551@linux-mips.org>
References: <e997b7420910281651p24b8e367m1e2ddbc1b95ac623@mail.gmail.com>
	 <20091101071407.GC4551@linux-mips.org>
Date:	Mon, 2 Nov 2009 23:12:52 +0800
Message-ID: <e997b7420911020712w74913c8dw86f19ebf04fc7bdc@mail.gmail.com>
Subject: Re: Problem in booting when calling calibrate_delay
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

2009/11/1 Ralf Baechle <ralf@linux-mips.org>:
> On Thu, Oct 29, 2009 at 07:51:52AM +0800, wilbur.chan wrote:

> When something like this happens it is in most cases caused by timer
> interrupt not working.
>
>  Ralf
>

Today , I found that ,  the code never enter the do_timer function.

As a matter of fact, I'm testing kexec on mips64 smp.   In the end of
the first kernel , I' ve  used local_irq_disable

and jumped directly into second kernel. However it hang at calibrate_delay.

In a normal booting on mips64, I found that , do_timer was invoked
after console_init.

Here is my dump_stack of do_timer, in a successfully booting log:

0:Call Trace:
0:[ <834243cc>]0: dump_stack+0x8/0x34
0:[ <83451ee0>]0: do_timer+0x70/0xa8
0:[ <8342333c>]0: timer_interrupt+0x64/0x160
0:[ <834234b4>]0: ll_timer_interrupt+0x7c/0xd8
0:[ <8341d220>]0: ret_from_irq+0x0/0x4
0:[ <83443a64>]0: release_console_sem+0x1e0/0x328
0:[ <8377cf88>]0: serial8250_console_init+0x1c/0x2c
0:[ <8377ae58>]0: console_init+0x4c/0x6c
0:[ <83762dd8>]0: start_kernel+0x3e0/0x75c


So, I thought that , it might be release_console_sem being failed in
my second kernel of kexec when booting, but I don't know why
