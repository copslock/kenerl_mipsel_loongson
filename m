Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2005 16:21:26 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.204]:16241 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133735AbVJaQVI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Oct 2005 16:21:08 +0000
Received: by zproxy.gmail.com with SMTP id j2so886942nzf
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2005 08:21:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hUzyNx1AcICMPK1xDuYzilMgR9NWhXSfltgwR62IXgqL15ZZ5Dy2WJSutT1wab7QhquqNdtRcsNYuMCIkL8gYrMGjFEoWTSLwSK9ykgNAAVqgGVgLsTnorwXekoR/6kykplh5GCmSN5Dw2rrVyJm0xdh05RQjURXn/4oT3WunU8=
Received: by 10.37.22.27 with SMTP id z27mr362588nzi;
        Mon, 31 Oct 2005 08:21:38 -0800 (PST)
Received: by 10.36.48.2 with HTTP; Mon, 31 Oct 2005 08:21:33 -0800 (PST)
Message-ID: <cda58cb80510310821l5d869f71g@mail.gmail.com>
Date:	Mon, 31 Oct 2005 17:21:33 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] Add 4KSx support (try 2)
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <20051031111519.GA13281@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80510310034k60b273dfm@mail.gmail.com>
	 <4365DF22.8060004@mips.com> <20051031111519.GA13281@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/10/31, Ralf Baechle <ralf@linux-mips.org>:
> On Mon, Oct 31, 2005 at 10:08:50AM +0100, Kevin D. Kissell wrote:
> > Have you thought about what the ACX state would mean for
> > kernel debuggers in general and kgdb in particular?
>

should I add support of smartmips extension in kgdb ?

> The real issue I have with the patch is that ACX is extending the state
> that would need to be saved and restored in signal handlers and I have to
> solve the question where to keep that information without breaking
> compatibility - that's pretty much the same exercise which we had just
> recently with adding DSP support.

could you explain more on this point ?

Thanks
--
               Franck
