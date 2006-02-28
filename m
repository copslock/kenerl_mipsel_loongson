Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 20:14:51 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.205]:29908 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133623AbWB1UOn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 20:14:43 +0000
Received: by wproxy.gmail.com with SMTP id i12so222158wra
        for <linux-mips@linux-mips.org>; Tue, 28 Feb 2006 12:22:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QcNKpxpnYGaBPsxGA2Celc0/sCEMNUi3NxLUyn3LVNsOxK5xi3mMNf9EC6elBnF4/uwCtwW6MEBa7s/9SGFlqfXzejORObiGgsxtiKFUsfS50D2RQJ/4YR6GgKYQjyEjzKwWGoC3JunzQl51fdSkihpRrKFrXCDOiuyf2TL8Yts=
Received: by 10.65.212.4 with SMTP id o4mr4125672qbq;
        Tue, 28 Feb 2006 12:22:27 -0800 (PST)
Received: by 10.64.181.7 with HTTP; Tue, 28 Feb 2006 12:22:27 -0800 (PST)
Message-ID: <d120d5000602281222q2a49de53g35ef432b050b8529@mail.gmail.com>
Date:	Tue, 28 Feb 2006 15:22:27 -0500
From:	"Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To:	"Martin Michlmayr" <tbm@cyrius.com>
Subject: Re: Diff between Linus' and linux-mips git: small changes
Cc:	linux-mips@linux-mips.org, ppopov@mvista.com
In-Reply-To: <20060227190729.GA22383@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060219234318.GA16311@deprecation.cyrius.com>
	 <20060220000141.GX10266@deprecation.cyrius.com>
	 <20060227190729.GA22383@deprecation.cyrius.com>
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/27/06, Martin Michlmayr <tbm@cyrius.com> wrote:
> * Martin Michlmayr <tbm@cyrius.com> [2006-02-20 00:01]:
> > I noticed the following difference between the Linus and the
> > linux-mips tree.  Who is correct and can the other one be changed
> > please?
>
> ping.
>
>
> > --- linux-2.6.16-rc4/drivers/char/qtronix.c   2006-02-19 20:08:44.000000000 +0000
> > +++ mips-2.6.16-rc4/drivers/char/qtronix.c    2006-02-19 20:15:07.000000000 +0000
> > @@ -535,8 +535,7 @@
> >               i--;
> >       }
> >       if (count-i) {
> > -             struct inode *inode = file->f_dentry->d_inode;
> > -             inode->i_atime = current_fs_time(inode->i_sb);
> > +             file->f_dentry->d_inode->i_atime = get_seconds();
> >               return count-i;
> >       }
> >       if (signal_pending(current))
> >

Oh, that's an input driver, that's why I am on CC list ;) How about
registering it with the input system and ripping this psaux code off
competely?

--
Dmitry
