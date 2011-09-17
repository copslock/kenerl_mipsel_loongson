Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Sep 2011 03:23:31 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:39290 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491189Ab1IQBXY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Sep 2011 03:23:24 +0200
Received: by fxg7 with SMTP id 7so2803125fxg.36
        for <multiple recipients>; Fri, 16 Sep 2011 18:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WXc2AasZvpfmWIOFMFVsQt2MgN3m1kR0vTJd4SNVjh8=;
        b=pIZv1HamhxJHKKOUF5VuXD/YYlHqOSvub9oBfHFR2w7OO/n337jJBpCoPNXkm4OGAp
         BQZy4rbMF4oMCKQAOTUhtJXqqeT3d5UwwJNPxOrkKXhJuWLoMEIKyiZH7S/XBzk3S+8F
         bm5w2YOuNRI5GxLcMbagjjwUev3VBTJqV8Vp0=
Received: by 10.223.88.23 with SMTP id y23mr130835fal.95.1316222599425;
        Fri, 16 Sep 2011 18:23:19 -0700 (PDT)
Received: from localhost (h59ec324b.selukar.dyn.perspektivbredband.net. [89.236.50.75])
        by mx.google.com with ESMTPS id e17sm12555665fae.17.2011.09.16.18.23.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Sep 2011 18:23:18 -0700 (PDT)
Date:   Sat, 17 Sep 2011 03:23:15 +0200
From:   "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        "Kevin D. Kissell" <kevink@paralogos.com>
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
Message-ID: <20110917012315.GG20455@zapo>
References: <20110829232029.GA15763@zapo>
 <4E5C2490.6040203@cavium.com>
 <20110915160054.GA10622@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110915160054.GA10622@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edgar.iglesias@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8897

On Thu, Sep 15, 2011 at 06:00:54PM +0200, Ralf Baechle wrote:
> On Mon, Aug 29, 2011 at 04:45:20PM -0700, David Daney wrote:
> 
> > How about the attached completely untested one instead?
> 
> Applied.  I like it more than than Edgar's patch because of the better
> scheduling.

I agree, thanks!

BTW, in case anyone is intersted, it is now possible to boot malta
boards with SMP with the latest QEMU. The neat thing is that if you
debug the kernel with GDB, you'll see the different cores execution
contexts as differten threads and can singletep them individually.

You need a QEMU from latest git.

Cheers
