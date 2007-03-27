Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 17:07:14 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.238]:30474 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021955AbXC0QHM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 17:07:12 +0100
Received: by nz-out-0506.google.com with SMTP id x7so1790812nzc
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2007 09:06:11 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=awpwRox12s78MCC5duqQ8S9TXUrnYrQGvp1ifjS5aySXya2Fitw85kjeZzWeSBaRCNktoeV843l10SCIbtpJGpwFNNfk4bcNwIPBunJJpMvLpao1tq7HzjCHEC6aeQncz6dJjfQBMrpvH5FNXYoXpAgQKudAQ4K5bQ/g730Bwvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zd77u1ICOn/mS2R9sUdzydgwlape+ZiukEvYqKbtFf38kccv3jnuv0PLEV9gWlIWjZsJPUta0B7eG8/ftORDknnvIJzT5z6fmyIHF0aDgjmSxzjrkjLUQxI4LFhYdlIMO2e2/yWj2SSZVXApJNUNZYXMbaKggG7dZqtFuEUdJVY=
Received: by 10.115.61.1 with SMTP id o1mr3217457wak.1175011570750;
        Tue, 27 Mar 2007 09:06:10 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Tue, 27 Mar 2007 09:06:10 -0700 (PDT)
Message-ID: <cda58cb80703270906j74d6bf6fsb6259f24427faff5@mail.gmail.com>
Date:	Tue, 27 Mar 2007 18:06:10 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Early printk recent changes.
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Linux MIPS List" <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.64N.0703271620080.5547@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80703270716s6c95c66cgd03482a4852a69eb@mail.gmail.com>
	 <Pine.LNX.4.64N.0703271526000.5547@blysk.ds.pg.gda.pl>
	 <cda58cb80703270803g7c1119e4w22272e9e18c0d251@mail.gmail.com>
	 <Pine.LNX.4.64N.0703271620080.5547@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/27/07, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Tue, 27 Mar 2007, Franck Bui-Huu wrote:
>
> > >  Don't fix what isn't broken...
> > >
> >
> > Well with such advice, Linux would have been stuck to version 0.4 ;)
>
>  Fortunately, there is a feature called "common sense" and it has
> prevented a halt from happening.  Also I wouldn't be brave enough to claim
> any particular version of Linux, nor any other piece of software, is
> perfect, though, admittedly, the level of imperfection varies highly
> across different versions and pieces.
>

you did notice the smiley, didn't you ?

>  In this case I gather this was a bulk change and some platforms have
> benefited and the DECstation has lost.  You seem to have problems as well.
> These issues can be dealt with somehow and they do not mean the change was
> bad as a whole.

I think that's the reason why I started this thread: To see if this
change is good and really woth...

Making a new file 'early_printk' to gather 3 tiny functions. In the
other way we lose the possibilty to register the console earlier, and
we need to make some hacks to configure the console if it needs to be.

I understand that such change is needed by x86 arch but for mips I'm skeptical.
-- 
               Franck
