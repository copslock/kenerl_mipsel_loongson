Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 08:59:57 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.182]:33042 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022670AbXFGH7y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 08:59:54 +0100
Received: by py-out-1112.google.com with SMTP id f31so735330pyh
        for <linux-mips@linux-mips.org>; Thu, 07 Jun 2007 00:59:53 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mN4Uqpvn+wt9KgOaz+MLEGat+odnEyTIYYCWAtSeDa7mUYkO4AP0VxNfAlrLeBAMUM8gt+Wi3K5Zr6AyueVcYdQeq5opIhdalefyO6h5anKLESjKanv8Dx4zlPXEDtTHDCgGM2gAwfN9jipJrvAsaBJoewFGcqcRlRutf3MiO70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z1bBYkZTyGIA2Hdb5EIhCIbI118XE29jGIPf4eisUK8UZrXgYnrccxdw4zsfjTnoLxLN2oek2TegBt5RBQ/K/oZa0NIVduy5PHm4im3vcQKrya3RCLu0D3LMcGOhpLsx15jEyz8HbpRVQa2rwEqwAQRB/kRzkPWYKWvWsGL4LgM=
Received: by 10.64.184.16 with SMTP id h16mr466028qbf.1181203193402;
        Thu, 07 Jun 2007 00:59:53 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 7 Jun 2007 00:59:53 -0700 (PDT)
Message-ID: <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com>
Date:	Thu, 7 Jun 2007 09:59:53 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Tickless/dyntick kernel, highres timer and general time crapectomy
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070606185450.GA10511@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070606185450.GA10511@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Ralf Baechle wrote:
> Time to send bring this to a larger audience.
>
> I'm working on getting dyntick and highres timer support working for MIPS.
> This unavoidably implies dumping most of the MIPS-private time
> infrastructure we've piled up over the past decade.  Which really is a
> major crapectomy.  A first cut of the patches which are tested to
> run

That's definitely true. I wrote my own version of clockevent support
yesterday based on your patchset "dyntick-quilt" and I end up rewrite
the whole time.c. The biggest part of the job would be to split this
into several patches to ease the review but I doubt it worth it since
we rewrite it almost from scratch.

Another issue I have is to implement clockevent set_mode() method. You
left it empty but I think we need at least to shut down the timer
interrupt when setting the clock event device. Strangely I haven't
found a "generic" way to stop them through cp0. Have I missed
something ? If not, that would mean that either we need a new hook to
achieve that or we find a way/hack to do that in a mips generic
way. Advice on this point would be appreciated.

> well on uniprocessor and VSMP Malta kernels is at:

>
>   ftp://ftp.linux-mips.org/pub/linux/mips/people/ralf/dyntick-quilt
>
> It will also likely work on various other simple systems.  A more recent
> version of these patches which I haven't yet gotten around to test on
> silicon is available at:
>
>   ftp://ftp.linux-mips.org/pub/linux/mips/people/ralf/linux-time.patches
>

BTW any idea when "time-ntp-make-cmos-update-generic.patch" is going
to be merged into mainline ? Note: I think there's a bug in
notify_cmos_timer(). The following test should be negated, shouldn't
it ?

+	if (no_sync_cmos_clock)
+		mod_timer(&sync_cmos_timer, jiffies + 1);

The other patch named "time-move-to_tm-to-lib.patch" create a new file
in arch/mips/lib directory. This new file is called
"to_tm.c". Shouldn't we call it something less specific like "time.c" ?

-- 
               Franck
