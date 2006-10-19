Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 07:20:50 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:37430 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20027678AbWJSGUs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 07:20:48 +0100
Received: by nf-out-0910.google.com with SMTP id l23so943878nfc
        for <linux-mips@linux-mips.org>; Wed, 18 Oct 2006 23:20:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XSNS4naHIfUlFnsCWqLhQeMfx4nXZvdDQVxEue0rFRXwYrbkpSpVDzVt7/RLtUgbnQ34Vpr8wGAMe6kb1WSK5GB7Wrb2sVN13ALdq2FyAGsCaJlJpCAXQQBUsC0BfDLhqE0byMbMpi1Y5ISRcMJGcnk68402tiBYlcFItIP20q0=
Received: by 10.78.151.15 with SMTP id y15mr11215184hud;
        Wed, 18 Oct 2006 23:20:47 -0700 (PDT)
Received: by 10.78.124.19 with HTTP; Wed, 18 Oct 2006 23:20:47 -0700 (PDT)
Message-ID: <cda58cb80610182320x71c3ac87i4aa714822ed05438@mail.gmail.com>
Date:	Thu, 19 Oct 2006 08:20:47 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/7] Make __pa() aware of XKPHYS/CKSEG0 address mix for 64 bit kernels
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org
In-Reply-To: <20061019.130133.108306753.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
	 <1160743146824-git-send-email-fbuihuu@gmail.com>
	 <20061019.130133.108306753.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 10/19/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> A qiuck and non-intrusive hack would be cast CKSEG0 with "unsigned
> long" here, but it might be preferred to change _LLCONST_ definition
> like this.  What do you think?
>

I think _LLCONST_ change is the correct thing to do. Can you please
submit your patch to Ralf ?

thanks
-- 
               Franck
