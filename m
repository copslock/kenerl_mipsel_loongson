Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 14:44:50 +0100 (BST)
Received: from qb-out-0506.google.com ([72.14.204.233]:45260 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022934AbXFNNos (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 14:44:48 +0100
Received: by qb-out-0506.google.com with SMTP id q17so209187qba
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2007 06:43:47 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VjVszxTQgDUrdwuzzUwo/0Zttgaxi1T4PP/tPEuKFHKE67c+E8oEUyu2DKzuyaPSFmXG+A2dSc/lOQLvMY5hQ1HrSjiiUlaLep1143+BmIXL4EoTft7x7pZNXFxlpxWzqex8s5O2w3d6CGUtPI9EYNcNKD/+daSr9gdrmVyv8z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UYIoFSypvpNyDrtyD7VJpJnABv7ON8aeEiMEQmrVCLRiYBUtf80Yk5ZDNWo3rZHBJqp2BViiltkmk64/Ybge2dr/QFxJ+/RQbIhzs6N7Av4LY+cYxDSwMdLcF1hnxQOojaS5h7PQ09Howeh+I1iPp8lRLmd4zsfd1FEt9KSsHFk=
Received: by 10.65.237.15 with SMTP id o15mr3220253qbr.1181828627061;
        Thu, 14 Jun 2007 06:43:47 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 14 Jun 2007 06:43:47 -0700 (PDT)
Message-ID: <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>
Date:	Thu, 14 Jun 2007 15:43:47 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
In-Reply-To: <20070614111748.GA8223@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
	 <11818164023940-git-send-email-fbuihuu@gmail.com>
	 <20070614111748.GA8223@alpha.franken.de>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 6/14/07, Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> On Thu, Jun 14, 2007 at 12:19:59PM +0200, Franck Bui-Huu wrote:
> >  arch/mips/sni/a20r.c                      |    1 -
> >  arch/mips/sni/ds1216.c                    |    4 +-
> >  arch/mips/sni/pcimt.c                     |    3 -
> >  arch/mips/sni/pcit.c                      |    3 -
> >  arch/mips/sni/rm200.c                     |    2 -
> >  arch/mips/sni/time.c                      |    2 +-
>
> the SNI part is broken and can't work that way.
>

I don't get you there. Are you talking about patch 3/5 (you're
replying on this one) or the patch 5/5 ?

patch #3 is only clean up, so it shouldn't break anything....
patch #5 does not migrate any platforms, so it's actually broken for
all current platforms.

> 1. SNI used two different RTC chips (ds126 and mc146818) and it's no big
>    deal support them in just one kernel with the current framework

That's the point now, if the current implementation can fit well with
all platforms.

> 2. One line of SNI machines (a20r) can't use the cp0 counter, so it's not
>    a really good idea to calibrate it
>

The current code doesn't automatically calibrate any hpt. It was
really hard to guess which ones need that so now if you need to
calibrate your hpt, then you have to call calibrate_hpt().

Thanks
-- 
               Franck
