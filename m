Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Sep 2011 04:09:05 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:45530 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490968Ab1IQCI7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Sep 2011 04:08:59 +0200
Received: by fxg7 with SMTP id 7so2827106fxg.36
        for <multiple recipients>; Fri, 16 Sep 2011 19:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=H3aBQ+Y2MrIo5o0m849mo+Y8YqJoXd3U49YF7Tf+M4o=;
        b=rjpKUoEjmQvgb2Tk11NReBmgFdvgSpkbTXIzMUjIUI3ULd4DHtfjkIHT4Fbw+Gs5TD
         hArk4B1oxCYzleRF9nFUh14X4YxaiM/WX6A42Kfh950TzqvinhFQMDoChXQYsOuPlt4a
         PcOinBU77d2j99LhGPTTLpWkqPjfPouj1k+Z4=
Received: by 10.223.101.2 with SMTP id a2mr245889fao.2.1316225333753;
        Fri, 16 Sep 2011 19:08:53 -0700 (PDT)
Received: from localhost (h59ec324b.selukar.dyn.perspektivbredband.net. [89.236.50.75])
        by mx.google.com with ESMTPS id e17sm12663348fae.17.2011.09.16.19.08.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Sep 2011 19:08:52 -0700 (PDT)
Date:   Sat, 17 Sep 2011 04:08:49 +0200
From:   "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        "Kevin D. Kissell" <kevink@paralogos.com>
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
Message-ID: <20110917020849.GI20455@zapo>
References: <20110829232029.GA15763@zapo>
 <4E5C2490.6040203@cavium.com>
 <20110915160054.GA10622@linux-mips.org>
 <20110917012315.GG20455@zapo>
 <20110917020032.GA24974@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110917020032.GA24974@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edgar.iglesias@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8908

On Sat, Sep 17, 2011 at 04:00:32AM +0200, Ralf Baechle wrote:
> On Sat, Sep 17, 2011 at 03:23:15AM +0200, Edgar E. Iglesias wrote:
> 
> > I agree, thanks!
> 
> You're welcome.
> 
> > BTW, in case anyone is intersted, it is now possible to boot malta
> > boards with SMP with the latest QEMU. The neat thing is that if you
> > debug the kernel with GDB, you'll see the different cores execution
> > contexts as differten threads and can singletep them individually.
> 
> Very interesting.  What type of SMP system does it emulate?

I'm not all familiar with the terminology, but it works with the kind
where you've got multiple VPEs with one TC per VPE, vSMP IIUC.

You need to pass these options to QEMU, -cpu 34Kf -smp 2, where 2 maybe
anything up to 16.

We've (AXIS) got models for the GIC aswell, but I need to check with MTI 
before publishing those.  IMO these models would help everybody cause
it's, to say the leaast, a huge pain to setup the GIC without having QEMU
or any emulator to check the interrupt routing.

Cheers
