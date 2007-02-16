Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 16:07:16 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.231]:52273 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038909AbXBPQHM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Feb 2007 16:07:12 +0000
Received: by qb-out-0506.google.com with SMTP id e12so292206qba
        for <linux-mips@linux-mips.org>; Fri, 16 Feb 2007 08:06:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZmjNnemaBCFTZpLrUp/fJu3+mL+aeZuamwX9GbxG+5mnTc6wKgP1rJoUgc8aXWQ7HYUH+vwIx6ohb3GPSzNVHMtlUx/L+zr+mP95oGRpHA6pmBX16bo+rQd9lekyRkzdUYRQrbIOln69Inxo7LaiNgkMS6ranBJb/vbq0uAx9LA=
Received: by 10.115.78.1 with SMTP id f1mr1831904wal.1171641970362;
        Fri, 16 Feb 2007 08:06:10 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Fri, 16 Feb 2007 08:06:10 -0800 (PST)
Message-ID: <cda58cb80702160806r51de5b06xdcaa0731e100d9d2@mail.gmail.com>
Date:	Fri, 16 Feb 2007 17:06:10 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] Fix __copy_{to,from}_user_inatomic
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20070216155441.GA26835@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45D5CEA5.3050604@innova-card.com>
	 <20070216155441.GA26835@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/16/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Feb 16, 2007 at 04:32:53PM +0100, Franck Bui-Huu wrote:
>
> > These functions are aliases to __copy_{to,from}_user resp but they
> > are not allowed to sleep. Therefore might_sleep() must not be used
> > by their implementions.
>
> The _inatomic functions are know to buggy but this doesn't quite fix the
> whole issues with them.

ok so the patch's should have been: "Fix console warnings triggered by
__copy_{to,from}_user_inatomic()"

> On error __copy_from_user_inatomic should not
> clear the non-copied part of the destination buffer.  See
> 01408c4939479ec46c15aa7ef6e2406be50eeeca and
> 7c12d81134b130ccd4c286b434ca48c4cda71a2f for the rationale.

I'll try to take a look at it.

Thanks
-- 
               Franck
