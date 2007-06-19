Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 08:34:37 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.183]:33622 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023435AbXFSHee (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Jun 2007 08:34:34 +0100
Received: by py-out-1112.google.com with SMTP id f31so3745158pyh
        for <linux-mips@linux-mips.org>; Tue, 19 Jun 2007 00:33:33 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qo7DBTFOrf/FbVO+E4EI5rxGRSa9teQazHVWWLWBuJDVINuhlyA3ShcbJJuT651Jj4YZugE87JL4lWPfQkRt8HBwZnQjV0cDhfLinNspWrL7TinhJygZQSOT6C5UTD8z/MTTg0yYYHKvqAB8JWrpDcdbQMBZ8zWSpvFle6eQmhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jzkoY1RcYJHU147h7mbTIYJ4as6b6uNSS/NJuNChZ8rJx9hJoykFz0/G04f9T7167wef0khv3ABJ1YQ/T48m4ctH+gAG8L/zyLmtkh59rukNbUm/WryECaITWnm/MtLEK+HLXd2Mel6/bNn819MA5GWh8jl7CHg90k1TkOWFBNM=
Received: by 10.65.186.18 with SMTP id n18mr10962256qbp.1182238413446;
        Tue, 19 Jun 2007 00:33:33 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Tue, 19 Jun 2007 00:33:33 -0700 (PDT)
Message-ID: <cda58cb80706190033y47ccec58u8fc8254ced24f96f@mail.gmail.com>
Date:	Tue, 19 Jun 2007 09:33:33 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	ralf@linux-mips.org, macro@linux-mips.org, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org
In-Reply-To: <20070619.005121.118948229.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80706170636kbff000cw849fa1d5ccf31152@mail.gmail.com>
	 <20070618.011425.93018724.anemo@mba.ocn.ne.jp>
	 <cda58cb80706180238r17da4434jcdee307b0385729b@mail.gmail.com>
	 <20070619.005121.118948229.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

On 6/18/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Mon, 18 Jun 2007 11:38:28 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > What do you think ?
>
> For now, I think bloating generic setup_cp0_hpt() for this particular
> chip is not good.  The pnx8550 can have customized copy of cp0_hpt
> routines.  But it's just a thought...
>

What do you mean by "pnx8550 can have customized copy of cp0_hpt
routines" ? Do you mean that it should copy the whole clock event
driver ?

It seems to me that using cp0 hpt as a clock event only is a valid usage...
-- 
               Franck
