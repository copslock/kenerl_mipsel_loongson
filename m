Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2014 18:26:30 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:63622 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010262AbaJAQ02aI8sk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Oct 2014 18:26:28 +0200
Received: by mail-pd0-f176.google.com with SMTP id fp1so496824pdb.7
        for <multiple recipients>; Wed, 01 Oct 2014 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tPEnHBPazCc3zAnABQdGRhzohUYK1mX+HYSurtSTEmM=;
        b=00XaV7S4cEpu/mffma/YKAtFLwrCgH0HW1e6rKn7cRU80ThKzhV17MWGqX63raJGe7
         IyAti8hu/vre2o0FTymf61G2YeRP0DOM1AGAhf30BN3VBpBI2ow8CTJLM//YGlxEymmm
         /A9X+hB0nI4LYCgYnmFmuvRa1T1vFkVtTwFibPKJsHBj7FG3e1zbQ0WW/Bbp2x/RYcq7
         PBD2yB/mrMRcX7vEN9BZO+ESdEo0gFQ43cOh+uN8fLF7X3iaFYPf2CVH0Dzo+7VrhZSW
         ANKU8Mc856NaJ6zJmU4jVrNB48odZQdyk/KhE/Q9sAVKWgV7ERKBdJmXZ3CkdWd6Yz+R
         wqQQ==
X-Received: by 10.66.145.167 with SMTP id sv7mr79020673pab.5.1412180781798;
        Wed, 01 Oct 2014 09:26:21 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id qf3sm1332276pbc.96.2014.10.01.09.26.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 09:26:21 -0700 (PDT)
Date:   Wed, 1 Oct 2014 09:26:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC PATCH 10/16] mips: support poweroff through poweroff
 handler call chain
Message-ID: <20141001162617.GC11708@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
 <1412100056-15517-11-git-send-email-linux@roeck-us.net>
 <20141001133238.GJ19854@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141001133238.GJ19854@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Wed, Oct 01, 2014 at 03:32:39PM +0200, Ralf Baechle wrote:
> On Tue, Sep 30, 2014 at 11:00:50AM -0700, Guenter Roeck wrote:
> 
> > The kernel core now supports a poweroff handler call chain
> > to remove power from the system. Call it if pm_power_off
> > is set to NULL.
> > 
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  arch/mips/kernel/reset.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
> > index 07fc524..c3391d7 100644
> > --- a/arch/mips/kernel/reset.c
> > +++ b/arch/mips/kernel/reset.c
> > @@ -41,4 +41,6 @@ void machine_power_off(void)
> >  {
> >  	if (pm_power_off)
> >  		pm_power_off();
> > +	else
> > +		do_kernel_poweroff();
> 
> I'm happy with this as long as in a later version pm_power_off indeed
> goes away.
> 
Yes, that would be the ultimate goal. Hope we can get there.

Guenter
