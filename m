Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 11:27:27 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.202]:43381 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133511AbWAZL1K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 11:27:10 +0000
Received: by zproxy.gmail.com with SMTP id l8so339906nzf
        for <linux-mips@linux-mips.org>; Thu, 26 Jan 2006 03:31:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rJOO+iWPUlBOYLk//bRglk53Eu4ya4wLiLBX13Bbdp11WHeBjr5GVPg/4cf0BmQqm4dvov+oLGnEwiC9hSsV2Qn3PNoBjNEVejskOnZWid8tUjNsX6bnn9BP1dLGi4W/pnKVcGeAkyS7EgHZg80wzcdfZUciJMIP9KkCxC3tCGA=
Received: by 10.36.42.5 with SMTP id p5mr1402128nzp;
        Thu, 26 Jan 2006 03:31:39 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 26 Jan 2006 03:31:39 -0800 (PST)
Message-ID: <cda58cb80601260331p700dc982n@mail.gmail.com>
Date:	Thu, 26 Jan 2006 12:31:39 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Optimize swab operations
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <20060126112638.GC3411@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601260308v3eecf0d0w@mail.gmail.com>
	 <20060126112638.GC3411@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/26, Ralf Baechle <ralf@linux-mips.org>:
> On Thu, Jan 26, 2006 at 12:08:25PM +0100, Franck wrote:
>
> > This patch uses 'wsbh' instruction to optimize swab operations. This
> > instruction is part of the MIPS Release 2 instructions set.
>
> Will apply.  Small nit - you must include <linux/config.h> in every file
> that is refering to a CONFIG_* symbols, I'll take care of that.
>

OK

Thanks
--
               Franck
