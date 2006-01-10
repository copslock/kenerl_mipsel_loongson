Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 17:12:42 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.197]:14383 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133442AbWAJRMN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jan 2006 17:12:13 +0000
Received: by wproxy.gmail.com with SMTP id 71so3682921wri
        for <linux-mips@linux-mips.org>; Tue, 10 Jan 2006 09:15:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=djh5j5BiFviIDAWhc37UPmvdEM9hKVUH2l4wBPV+d8+LqDyQI0ZrHyfkak97Y/p/1wjWPOP3V38gB21Xldg53Lfg2NgMFPgxuJOBc8UP0ZBeKca9cgU32k9/Cbyxsl/aB8S9zvYipc8oS51A1RA/Z6Yb/gOXHH9wImFd9Ajev0U=
Received: by 10.54.76.4 with SMTP id y4mr9711599wra;
        Tue, 10 Jan 2006 09:15:18 -0800 (PST)
Received: by 10.54.69.5 with HTTP; Tue, 10 Jan 2006 09:15:18 -0800 (PST)
Message-ID: <a59861030601100915q6ffb4896v@mail.gmail.com>
Date:	Tue, 10 Jan 2006 18:15:18 +0100
From:	Ivan Korzakow <ivan.korzakow@gmail.com>
To:	"P. Christeas" <p_christ@hol.gr>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <200601101857.26978.p_christ@hol.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
	 <200601101757.45297.p_christ@hol.gr>
	 <a59861030601100838oa89ac84n@mail.gmail.com>
	 <200601101857.26978.p_christ@hol.gr>
Return-Path: <ivan.korzakow@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ivan.korzakow@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/10, P. Christeas <p_christ@hol.gr>:
> On Tuesday 10 January 2006 6:38 pm, Ivan Korzakow wrote:
> > 2006/1/10, P. Christeas <p_christ@hol.gr>:
>
> > > You make sure you have the two trees and diff them.
> > > They 're both in git and typically you could do that only using git.
> >
> > Have you ever tried what you're talking about or is it a guess ?
> > For example, let's say that there's a bug introduced when merging
> > Linus tree with mips branch. How do you easily "bisect" in order to do
> > a binary seek of this bug ?
>
>  I was about to mention the git incompatibility as I gave you the first
> answer. It's true what you say and I also find it annoying. That's why I use
> Linus tree.
> I cannot, though, complaint to Ralph about this practice. It seems that he has
> done his best to preserve the CVS history of his tree. We can only thank him
> for that. It is just a lot of work to trim the tree and make it
> Linus-parallel.
Why not simply keep CVS repository available for 1% of people willing
to browse the history ? And make life easier for 99% of people willing
to work on 2.6 ... (2.4 work may continue to use CVS too).

Ivan
