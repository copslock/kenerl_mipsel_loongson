Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2012 16:31:26 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50391 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903844Ab2AJPbT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2012 16:31:19 +0100
Date:   Tue, 10 Jan 2012 15:31:19 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Jean Delvare <khali@linux-fr.org>
cc:     Matt Turner <mattst88@gmail.com>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of  
 interrupts
In-Reply-To: <20120110153834.531664db@endymion.delvare>
Message-ID: <alpine.LFD.2.00.1201101525440.3263@eddie.linux-mips.org>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>        <20110903103036.161616a5@endymion.delvare>        <20111031105354.4b888e44@endymion.delvare> <20120110153834.531664db@endymion.delvare>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 32213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, 10 Jan 2012, Jean Delvare wrote:

> > > Please address my concerns where you agree and send an updated patch.
> > 
> > Matt, care to send an updated patch addressing my concerns? Otherwise
> > it will be lost again.
> 
> It's been 3 more months. Matt (or anyone else who cares and has access
> to the hardware), please send an updated patch or I'll have to drop it.

 Thanks for nagging -- it seems unlikely I'll be able to have a look at it 
before February.  If Matt or anyone else cannot get at it before myself 
and you have to drop the change, then just do what you have to and drop 
it.  I'll try to resync with the current kernel as soon as I can, recheck 
my queue of outstanding patches and resend both this change and any other 
ones I'll consider necessary -- I reckon there were more than just this 
one.

 Thanks for your understanding and sorry about my recent lack of activity 
in this area.  All the best in the New Year! :)

  Maciej
