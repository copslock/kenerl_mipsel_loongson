Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2007 10:37:46 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.177]:18808 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022076AbXFZJhm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Jun 2007 10:37:42 +0100
Received: by py-out-1112.google.com with SMTP id p76so3035960pyb
        for <linux-mips@linux-mips.org>; Tue, 26 Jun 2007 02:37:31 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BHfI0Ugj16RPUyRvme8FpVZB6PCMVFidDVU4R5HfyxbQLjZvaFflwqD62aJ4MWbGkgoIQGPQMVE9C+qQMWLBdUh3rviIOsz9T7rC2EShcoeidNcms8WMqpBFCfAPKhGnlYAg1dVdsD+kYldCk/pGhxFEWKgxM3BNKQvl3zPoUxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FnoXWVqIIa/NMD5mtFqluhvCsGpv1wjGHI+OC4ewvCOIKWSQ794I4xTsfAx6MXo2XYtHiXfqSqhc52dlKk3HJXVhKwHEhNeU/1rJWjrURweYlJsYPQ2n/r/s+t9OvHsBPervjV+wbComKO9CfQmYPLSI3qQV4SehxFJgLrJdPf4=
Received: by 10.65.113.17 with SMTP id q17mr10862702qbm.1182850651234;
        Tue, 26 Jun 2007 02:37:31 -0700 (PDT)
Received: by 10.65.185.1 with HTTP; Tue, 26 Jun 2007 02:37:31 -0700 (PDT)
Message-ID: <cda58cb80706260237r60a0b6b3obeba7daac7cf114a@mail.gmail.com>
Date:	Tue, 26 Jun 2007 11:37:31 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] generic clk API implementation for MIPS
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20070626.011449.132112302.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070626.011449.132112302.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

On 6/25/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> The clock framework (clk_get(), etc.) would be useful to provide some
> clock values to platform devices or so.
>

yes it can be usefull.

> This MIPS implementation is derived (and stripped) from the SH
> implementation.
>

Did you consider Atmel implementation which is even more stripped ?

The main difference seems that your version has module support. I'm
not sure how usefull it is though.

Thanks
-- 
               Franck
