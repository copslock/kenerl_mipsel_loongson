Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2005 09:42:44 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.203]:25349 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133467AbVKIJmI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Nov 2005 09:42:08 +0000
Received: by zproxy.gmail.com with SMTP id l8so124679nzf
        for <linux-mips@linux-mips.org>; Wed, 09 Nov 2005 01:43:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z2OWVqo5FjYcyYRPLc5PqeNd/dsaR/67sOpCaW6Q6KgCWpX02R7SFfIu6xjePXZDCTi7a7ypV9HFvoovoMeBGW5dmn14cvV02J1727RJpJm0uooVomXaWFsroha2iLuZdKMArZ0dTuOPEZ8E1UmZIyhtXZt4sFJzL0cOcuy9RyE=
Received: by 10.36.33.17 with SMTP id g17mr327318nzg;
        Wed, 09 Nov 2005 01:43:31 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Wed, 9 Nov 2005 01:43:31 -0800 (PST)
Message-ID: <cda58cb80511090143p314d6a76t@mail.gmail.com>
Date:	Wed, 9 Nov 2005 10:43:31 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Daniel Jacobowitz <dan@debian.org>
Subject: Re: git and tags...
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20051108213103.GA29835@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80511080249w7d902821n@mail.gmail.com>
	 <20051108110134.GA2689@linux-mips.org>
	 <cda58cb80511080925l2d441604i@mail.gmail.com>
	 <20051108184521.GB2689@linux-mips.org>
	 <20051108213103.GA29835@nevyn.them.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/11/8, Daniel Jacobowitz <dan@debian.org>:
> On Tue, Nov 08, 2005 at 06:45:21PM +0000, Ralf Baechle wrote:
> > On Tue, Nov 08, 2005 at 06:25:06PM +0100, Franck wrote:
> >
> > > OK, so tags have been renamed into "linux-2.6.x". Why not using the
> > > same mainline name convention (v2.6.x) ?
> >
> > The same reason that some people like blue and others prefer green ;-)
> >
> > > I have another question (which is the first one in my previous email),
> > > how can I make my working tree a kernel version 2.6.9 for example ?
> >
> > git-read-tree $(cat .git/refs/tags/linux-2.6.9)
> > git-checkout-index -f -a -u -q
>
> IIUC, this is just "git checkout linux-2.6.9" nowadays.
>

"checkout" command seems to work with branch, not tag. Which version
of git are you using ?

Thanks
--
               Franck
