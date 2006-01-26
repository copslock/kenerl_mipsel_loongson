Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 08:07:03 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.193]:7969 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133467AbWAZIGo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 08:06:44 +0000
Received: by zproxy.gmail.com with SMTP id l8so311766nzf
        for <linux-mips@linux-mips.org>; Thu, 26 Jan 2006 00:11:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jJFCgum7A0j3/Ith/4+/bouiLpl8IeUebLs472xlnKAwahwJWksvV0S04A+TQmSODwnk0ttR8A90BGEE3NQ4fJT8ndo0ju3NOYo5NRu1X8LRQMEm/VJjBYZ5Mex4TolbE/pATmcFs7qDCvia/VXEpBxB04PJzMcPvOOE2UwhiqI=
Received: by 10.37.13.24 with SMTP id q24mr1247238nzi;
        Thu, 26 Jan 2006 00:11:12 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 26 Jan 2006 00:11:12 -0800 (PST)
Message-ID: <cda58cb80601260011r6136c3fq@mail.gmail.com>
Date:	Thu, 26 Jan 2006 09:11:12 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <43D7C050.5090607@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <20060125124738.GA3454@linux-mips.org>
	 <cda58cb80601250534r5f464fd1v@mail.gmail.com>
	 <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org>
	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>
	 <20060125150404.GF3454@linux-mips.org>
	 <cda58cb80601251003m6ba4379w@mail.gmail.com>
	 <43D7C050.5090607@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/25, Kevin D. Kissell <kevink@mips.com>:
> Franck wrote:
> > OK. So the patch I sent to you 3 months ago that adds support for
> > 4ks[cd] cpu and smartmips extension is wrong. It added new
> > CONFIG_CPU_4KS[CD] macro whereas it must have used MIPS32_R[12] macros
> > like Kevin suggested...
>
> Not really.  As we discussed at the time, the 4KSc is a superset of
> MIPS32 which includes some, but not all MIPS32R2 features (plus other
> stuff), and the 4KSd is a strict superset of MIPS32R2.  So some additional
> information is required to express the desired support.  I was just pointing
> out, in the case of the SWAB optimizations, that there was no need to invent
> yet another way of describing MIPS32R2.
>

Let's say that the 4KSC has "wsbh" instruction which is part of
MIPS32R2 instructrion set (I haven't checked it). The question is how
the 4KSC would use the SWAB optimizations since it doesn't define
CONFIG_CPU_MIPS32_R2  ? The 4KSC might not be the only one case...

Thanks
--
               Franck
