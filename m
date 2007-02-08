Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 20:06:09 +0000 (GMT)
Received: from nz-out-0506.google.com ([64.233.162.234]:26645 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038678AbXBHUGF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 20:06:05 +0000
Received: by nz-out-0506.google.com with SMTP id x7so623665nzc
        for <linux-mips@linux-mips.org>; Thu, 08 Feb 2007 12:05:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O7er7CwmzqEvt3Ht1aRStkfp7pHHoWmA8LiHXA1poMJ7Z0GzvatUQvPDkS4SUG77G1sx/pqAhNk4FjtQa2//lCE3jMtHqrBSe5LilMtq9Qtf1UKcM+QGntDnbaW1mTTAohOroBDWu8jPwVu4LElEKzZDpIv7Begcs/G3oDuX3zg=
Received: by 10.115.76.1 with SMTP id d1mr4806894wal.1170965103573;
        Thu, 08 Feb 2007 12:05:03 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Thu, 8 Feb 2007 12:05:03 -0800 (PST)
Message-ID: <cda58cb80702081205s1e23a5c3qe0ae53859cfca83d@mail.gmail.com>
Date:	Thu, 8 Feb 2007 21:05:03 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 9/10] signal: do not use save_static_function() anymore
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20070209.013507.52129192.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80702080053m6f22dc15td3b8c447e2abbda1@mail.gmail.com>
	 <20070208.223637.108120499.anemo@mba.ocn.ne.jp>
	 <cda58cb80702080739y18d31a34gc184a0cc96c86fb0@mail.gmail.com>
	 <20070209.013507.52129192.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/8/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Thu, 8 Feb 2007 16:39:42 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > But the points are:
> >
> >       - get rid of saving static registers in setup_sigcontext()
> >       - get rid of restoring static registers in restore_sigcontext()
> >       - free space in the signal frame
>
> I'm afraid of ABI compatibility.  Someone might try to handle SIGSEGV
> and dump all registers to debug the program without debugger...
>

Yes that's the main issue with this change. We could make it
configurable with an option which would depend on CONFIG_EMBEDDED or
something. Therefore someone can turn on the optimization if he really
wants it on his platform. But we would still lose the extra space gain
in the signal frame.

Note: I think that such programs can have trouble with current code
anyway... What would happen if the sig handler is run when returning
from a syscall ? In this case wouldn't sig context contain almost
garbage ?

-- 
               Franck
