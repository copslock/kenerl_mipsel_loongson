Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 13:30:47 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.193]:11090 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133529AbWAYNa3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 13:30:29 +0000
Received: by zproxy.gmail.com with SMTP id l8so102987nzf
        for <linux-mips@linux-mips.org>; Wed, 25 Jan 2006 05:34:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oVQ0PClnHqAtu39j4G33DhMe2kJi0nyRRX9JRMZwrm5MrXtSZMAeGgGKQZczEPC5RooXDPIoGlnBMi+U0o/GEUpcgyqjXQK4yC48tzLvQvUu5hHTspouRYoEPAwGljFFAhwwgrS8kzgIavtZrf8+BNyg9FoeODIiYxA1EkB+/lY=
Received: by 10.36.42.5 with SMTP id p5mr530585nzp;
        Wed, 25 Jan 2006 05:34:52 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Wed, 25 Jan 2006 05:34:52 -0800 (PST)
Message-ID: <cda58cb80601250534r5f464fd1v@mail.gmail.com>
Date:	Wed, 25 Jan 2006 14:34:52 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060125124738.GA3454@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <20060125124738.GA3454@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf

2006/1/25, Ralf Baechle <ralf@linux-mips.org>:
> On Wed, Jan 25, 2006 at 10:36:46AM +0100, Franck wrote:
>
> > Here is a little patch to optimize swab operations by using "wsbh"
> > instruction available on mips revision 2 cpus. I do not know what
> > condition I should use to compile this only for mips r2 cpu though.
> >
> > Comments ?
>
> Looks good aside of the one issue you've already raised yourself:
>
> > +/* FIXME: MIPS_R2 only */
>

I was actually asking for advices :)

I can see only two simple ways to do that:
(a) we can define a couple of new macro ie CONFIG_MIPS32_ISET_R[12]
that can be set depending on the selected CPU;
(b) define a new macro CONFIG_CPU_HAS_WSBH;

What do you think ?

Thanks
--
               Franck
