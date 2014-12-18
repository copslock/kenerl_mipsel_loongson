Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 18:16:06 +0100 (CET)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:50401 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008443AbaLRRQFYJ1sm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 18:16:05 +0100
Received: by mail-pd0-f169.google.com with SMTP id z10so1792900pdj.28;
        Thu, 18 Dec 2014 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=inYLH73+G3zB/WtoPdweevVv09kFsW4gsBZz2Skfm+g=;
        b=I9YmObYahta9lqRVPkiAK9a/2CZ0SBrcmUNHBYpA1BX+1SR38bPR0WTbABDK4KpSL2
         wrt0o6AmExU+UtZyIbDnx7vPdKeZsq7n+4Ip977SK5PSpEwM50W8y0/4lWJ6BqYVMGxY
         zvb3fo5efP6b+ie75xftl5Q/hu3TBdIWGgqIF6zF1FKHT481aqtrvth+uOcykBB+FAUz
         69wIaSxpEQVdV1omnIwZZ0M6CAkaqw1FAcWe5858azh/zeyduqVKbs1CXBs1uFdpUTwX
         1v0XRzwMhWZ46QporkvwzLK/Xl0ektiZxQEryqKBeh2d8g/pBqfO+RomGKSTQsEG8GK9
         pS+w==
X-Received: by 10.70.91.176 with SMTP id cf16mr5237871pdb.100.1418922958652;
        Thu, 18 Dec 2014 09:15:58 -0800 (PST)
Received: from brian-ubuntu (cpe-76-173-170-164.socal.res.rr.com. [76.173.170.164])
        by mx.google.com with ESMTPSA id uq15sm7378769pab.8.2014.12.18.09.15.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 09:15:58 -0800 (PST)
Date:   Thu, 18 Dec 2014 09:15:55 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: JZ4740: fixup #include's (sparse)
Message-ID: <20141218171555.GI7112@brian-ubuntu>
References: <1418870341-16618-1-git-send-email-computersforpeace@gmail.com>
 <20141218130203.GC25711@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141218130203.GC25711@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Dec 18, 2014 at 02:02:03PM +0100, Ralf Baechle wrote:
> On Wed, Dec 17, 2014 at 06:39:01PM -0800, Brian Norris wrote:
> 
> > Fixes sparse warnings:
> > 
> >   arch/mips/jz4740/irq.c:63:6: warning: symbol 'jz4740_irq_suspend' was not declared. Should it be static?
> >   arch/mips/jz4740/irq.c:69:6: warning: symbol 'jz4740_irq_resume' was not declared. Should it be static?
> > 
> > Also, I've seen some elusive build errors on my automated build test
> > where JZ4740_IRQ_BASE and NR_IRQS are missing, but I can't reproduce
> > them manually for some reason. Anyway, mach-jz4740/irq.h should help us
> > avoid relying on some implicit include.
> 
> Patch is looking good.
> 
> There is a known issue building jz in a separate build directory; building
> in the source directory itself will succeed.  Could that be why you can't
> seem to reproduce the build issue?

Yes, that is quite likely the problem.
