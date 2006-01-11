Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 15:15:08 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.200]:21823 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133464AbWAKPOp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jan 2006 15:14:45 +0000
Received: by wproxy.gmail.com with SMTP id 71so177354wri
        for <linux-mips@linux-mips.org>; Wed, 11 Jan 2006 07:17:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JSPyKQQ6uPE8V5EuPZZfVm84EIASVdoPVRtzt+UIKDEH+zo/hHU3GVQ/y5qvkeYK8/BCXw4s7kWtgZFBTe1UvWPprDU4wa6rRLVWm89VyzPpzCM5Lpj0583W7uUcpB/rw0vj0RwGvKCKrdnRR4NJL+X3tnOvmiUAMjgX93fCB30=
Received: by 10.54.120.12 with SMTP id s12mr907192wrc;
        Wed, 11 Jan 2006 07:17:56 -0800 (PST)
Received: by 10.54.69.5 with HTTP; Wed, 11 Jan 2006 07:17:55 -0800 (PST)
Message-ID: <a59861030601110717n5708beeci@mail.gmail.com>
Date:	Wed, 11 Jan 2006 16:17:55 +0100
From:	Ivan Korzakow <ivan.korzakow@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
In-Reply-To: <20060110232006.GA3519@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
	 <200601101757.45297.p_christ@hol.gr>
	 <a59861030601100838oa89ac84n@mail.gmail.com>
	 <200601101857.26978.p_christ@hol.gr>
	 <a59861030601100915q6ffb4896v@mail.gmail.com>
	 <20060110232006.GA3519@linux-mips.org>
Return-Path: <ivan.korzakow@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ivan.korzakow@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/11, Ralf Baechle <ralf@linux-mips.org>:
> On Tue, Jan 10, 2006 at 06:15:18PM +0100, Ivan Korzakow wrote:
>
> > Why not simply keep CVS repository available for 1% of people willing
> > to browse the history ? And make life easier for 99% of people willing
> > to work on 2.6 ... (2.4 work may continue to use CVS too).
>
> The CVS repository is still available - and will stay for a long time so
> people have a chance to do diffs against their existing checked out trees.
> But no more changes.
>

again why not letting 2.2 2.4 stay in CVS ? I don't think there are
any active development, isn't it ?

Ivan
