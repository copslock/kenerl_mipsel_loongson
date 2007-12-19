Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Dec 2007 15:00:44 +0000 (GMT)
Received: from rn-out-0910.google.com ([64.233.170.189]:23900 "EHLO
	rn-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20025044AbXLSOys (ORCPT <rfc822;linux-mips@ftp.linux-mips.org>);
	Wed, 19 Dec 2007 14:54:48 +0000
Received: by rn-out-0102.google.com with SMTP id i19so834236rng.2
        for <linux-mips@ftp.linux-mips.org>; Wed, 19 Dec 2007 06:53:46 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=jPs5rW1WFs0vdW38MGlxY1JcBw3C7UB1uctW/K1fuII=;
        b=Qm8BozsdFV40s4eY+wYKeOHgJKbpR02usmG+cIDj+9Fv2KyBu15CxbswIhns+fjbrRJAkwLrOqWAmNmOLF6uy1VzjaczK8PNLHx52pMTXNErRvc2rRYcyLypH/bL7eM9WA39Cel8uafDang0wJcHhpnFQ57wnFtVqOrkZZ+42+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=sbl4sZQ4PLKVTedQODrgyFEPjYz/aZJwnFL0gxMapJLtutYu94Uqs+FWSwp+CjgqdWnA6I4RPlaYj/8nMaO3v37fSY+kx0VkZSBOOxm7OltunPqtcRpUvyKOcuJ3TtzEA3YrPzOEViVMvwpsIzyT4MhVo4E0ueJre3zn/VyoDkM=
Received: by 10.150.195.21 with SMTP id s21mr1181191ybf.9.1198076025287;
        Wed, 19 Dec 2007 06:53:45 -0800 (PST)
Received: by 10.150.96.3 with HTTP; Wed, 19 Dec 2007 06:53:45 -0800 (PST)
Message-ID: <c58a7a270712190653i56644c5ei469b171cb9bd016a@mail.gmail.com>
Date:	Wed, 19 Dec 2007 14:53:45 +0000
From:	"Alex Gonzalez" <alex@langabe.org>
To:	linux-mips@ftp.linux-mips.org
Subject: Re: [MIPS] Build an embedded initramfs into mips kernel
In-Reply-To: <20071218224702.GI15227@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e0cf0bf0712181208m7f16b9acpf3dba67f3556a613@mail.gmail.com>
	 <47683B2D.9030608@zytor.com>
	 <9e0cf0bf0712181409p2475e1fdk779fdee4fa274722@mail.gmail.com>
	 <20071218224702.GI15227@1wt.eu>
X-Google-Sender-Auth: 2209a145c5657f04
Return-Path: <langabe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@langabe.org
Precedence: bulk
X-list: linux-mips

Hi,

I have a detailed description of the process I went through at my blog
http://www.langabe.org/2007/10/adding-initramfs-support-to-linux.html

It might help you to compare notes.

Alex

On Dec 18, 2007 10:47 PM, Willy Tarreau <w@1wt.eu> wrote:
> On Wed, Dec 19, 2007 at 12:09:46AM +0200, Alon Bar-Lev wrote:
> > On 12/18/07, H. Peter Anvin <hpa@zytor.com> wrote:
> > > Make sure your /init doesn't depend on an interpreter or library which
> > > isn't available.
> >
> > Thank you for your answer.
> >
> > I already checked.
> >
> > /init is hardlink to busybox, it depends on libc.so.0 which is available at /lib
>
> Are you sure that libc.so.0 is enough and that you don't need any ld.so ?
>
> > But shouldn't I get a different error code if this is the case?
>
> If it does not find part of the dynamic linker or libraries, this error
> makes sense to me.
>
> You should try to build a static init with any stupid thing such as a
> hello world to ensure that the problem really comes from the init and
> nothing else.
>
> Regards,
> Willy
>
>
>
