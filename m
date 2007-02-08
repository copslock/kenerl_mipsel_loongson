Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 15:40:49 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.224]:57845 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038595AbXBHPko (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 15:40:44 +0000
Received: by qb-out-0506.google.com with SMTP id e12so79517qba
        for <linux-mips@linux-mips.org>; Thu, 08 Feb 2007 07:39:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AUNyRSTkYnrSmhhea0ByVb06xwXGyVVvGHRBxiW+aKdSKwfBDXJYXbYcYVNQMXsrRIL0U1eB6amK0xKv5wMWQBIFYebHc1gYzKj5o1XJD9QgfVkpC0tZhx3H92XTOXJVFCGILfW2CaJri7AeWi9XGx30dpBcJBHmWnFiIeI+5ik=
Received: by 10.115.17.1 with SMTP id u1mr4257577wai.1170949183097;
        Thu, 08 Feb 2007 07:39:43 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Thu, 8 Feb 2007 07:39:42 -0800 (PST)
Message-ID: <cda58cb80702080739y18d31a34gc184a0cc96c86fb0@mail.gmail.com>
Date:	Thu, 8 Feb 2007 16:39:42 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 9/10] signal: do not use save_static_function() anymore
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20070208.223637.108120499.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11706854703880-git-send-email-fbuihuu@gmail.com>
	 <20070208.004049.51866970.anemo@mba.ocn.ne.jp>
	 <cda58cb80702080053m6f22dc15td3b8c447e2abbda1@mail.gmail.com>
	 <20070208.223637.108120499.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> If you did not restore static registers in kernel stack on
> restore_sigcontext(), succeeding RESTORE_STATIC in restore_all will
> load garbages to static registers.
>

You're right the patch I sent is not sufficient. However, we actually
could restore save_static_function (well if we do it, I think it's
much better to do it in assembly code...) for sys_sigreturn() _only_.
In that case RESTORE_STATIC should load correct values, shouldn't it ?

But the points are:

	- get rid of saving static registers in setup_sigcontext()
	- get rid of restoring static registers in restore_sigcontext()
	- free space in the signal frame

what do you think ?
-- 
               Franck
