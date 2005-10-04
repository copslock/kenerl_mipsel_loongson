Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 16:11:25 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.205]:64899 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133466AbVJDPK6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 16:10:58 +0100
Received: by zproxy.gmail.com with SMTP id j2so184197nzf
        for <linux-mips@linux-mips.org>; Tue, 04 Oct 2005 08:10:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=azPCltp/P86HLYt955oXYKpYS2gMtU3tF3sn5UsK/rB0kubopNBGCI090+g1X89ADFw5/OjED87zcx+8nv1wHCu7xJtqw2+JTaT6noTT2zXjXi43bLtZnBOvCFEly0B/lnjnuF97Qm6tt2GufutVReg2WxtTRQradnkVYk91Z00=
Received: by 10.37.18.46 with SMTP id v46mr305945nzi;
        Tue, 04 Oct 2005 08:10:52 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Tue, 4 Oct 2005 08:10:52 -0700 (PDT)
Message-ID: <cda58cb80510040810y286b06bcx@mail.gmail.com>
Date:	Tue, 4 Oct 2005 17:10:52 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] Add support for 4KS cpu.
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0510041430120.10696@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80510040149p690397afo@mail.gmail.com>
	 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
	 <cda58cb80510040610k1a7f430fn@mail.gmail.com>
	 <Pine.LNX.4.61L.0510041430120.10696@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/10/4, Maciej W. Rozycki <macro@linux-mips.org>:
>  See my other comment in this thread.  As to the SmartMIPS/crypto
> instructions -- unless they are going to be emitted by GCC for the kernel
> build (which I seriously doubt), there is no point in enabling them.
>

some assembly code could...

> > algorithms. And have some extra bits in TLB to protect pages from
> > being execute for example. These are the main differences that I can
>
>  Now that may be of potential interest of the kernel, but again, that's in
> principle probably not specific to these processors,
>

hmm, I'm not an expert in MIPS cpu as you guys, so can you give me an
example of others processors that have such TLB features ?

> > remember. Big fat warning: I sent all support I have done for these
> > cpu, _not_ more, _not_ less. I agree it's almost nothing but it's a
> > start...
>
>  Well, it's probably a bit too early for inclusion, but it's certainly not
> for a review.  By sending changes here for discussion early you may avoid
> a lot of hassle later when you may discover a major update is required for
> them to be accepted.  Good luck!

Actually Ralf asked for it in a previous thread.

Thanks
--
               Franck
