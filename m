Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2007 08:56:06 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.231]:51050 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021514AbXCHI4C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Mar 2007 08:56:02 +0000
Received: by qb-out-0506.google.com with SMTP id e12so707409qba
        for <linux-mips@linux-mips.org>; Thu, 08 Mar 2007 00:54:52 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N9pAsqiOkX7099d3ztDO5h2Dl3u8dmE63IMyiHPG22MIzc2TPBEMUG+z/9zfQ4nUhzurzromrefU6SKlxQQLFyKTM3QnsA9XRUg8mnQRJbUyZRfZu2v6dPsQk6E/sTUqivF+jY8CjrCyGBL5OY84OotiGZ55HqLTYhpa7/xgPK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ha2HVnpBEpHjcTJLCstRVpL+7Ij8ahf2bsjpd5VFE7i1XUyYrZDzC0QtIXnLbcOF9KFO4Ve29nv1fcCbQZyWDWAVNsT/CDaHXmuO8woBFvO3y2usCWqPShTujKt4ibKFVbaZWjCYdY4e4Y6WmVzjK7HoJ204KRsrHzM8KetcUVE=
Received: by 10.114.137.2 with SMTP id k2mr47542wad.1173344091894;
        Thu, 08 Mar 2007 00:54:51 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Thu, 8 Mar 2007 00:54:51 -0800 (PST)
Message-ID: <cda58cb80703080054q52f9977cm2ee43f381816a348@mail.gmail.com>
Date:	Thu, 8 Mar 2007 09:54:51 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	mbizon@freebox.fr
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <cda58cb80703061339l2f8cfc09m5823b090b69a7aa7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <116841864595-git-send-email-fbuihuu@gmail.com>
	 <1172879147.964.65.camel@sakura.staff.proxad.net>
	 <cda58cb80703050615r4e559ca1u78517634ac23a27@mail.gmail.com>
	 <1173112433.7093.36.camel@sakura.staff.proxad.net>
	 <cda58cb80703061339l2f8cfc09m5823b090b69a7aa7@mail.gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/6/07, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> So to fix this you have 2 possibilities:
>
>     - load your kernel at 0x8000xxxx addresses,

OMG, this is totaly crap ! That's what happen when I try to answer and
my brain is not working ! Even if you play with VMA/LMA in your linker
script it won't work...

So forget about this point.
-- 
               Franck
