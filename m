Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2005 13:46:30 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.193]:64437 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133532AbVIZMqM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Sep 2005 13:46:12 +0100
Received: by zproxy.gmail.com with SMTP id j2so202565nzf
        for <linux-mips@linux-mips.org>; Mon, 26 Sep 2005 05:46:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mfMWmvTlVaHRIq70DnN3y06dOfb133pm8M6zxNQmyZ08MS1v72AXhoqZeohxXp2RFSbqN7jj/puzGlx1P/a5zDsIPMhh3yOfoosJW9bsA+I/qTQBdofallIChUY6VZOzh1o5pSh9/pYd9ulgy4hdwsYDn1lpL/AEc/UxWjUKGCI=
Received: by 10.36.41.3 with SMTP id o3mr1424344nzo;
        Mon, 26 Sep 2005 05:46:02 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Mon, 26 Sep 2005 05:46:02 -0700 (PDT)
Message-ID: <cda58cb80509260546a6f4118@mail.gmail.com>
Date:	Mon, 26 Sep 2005 14:46:02 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: DISCONTIGMEM suuport on 32 bits MIPS
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050926122114.GC3175@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80509260216591eb96b@mail.gmail.com>
	 <20050926122114.GC3175@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

2005/9/26, Ralf Baechle <ralf@linux-mips.org>:
> On Mon, Sep 26, 2005 at 11:16:27AM +0200, Franck wrote:
>
> > I'm working on a port of 32bit MIPS to a custom board with several
> > large holes in the memory map. I would like to know the status of
> > discontiguous memory on MIPS. I have noticed that ip27 Kconfig enables
> > this feature but I don't see any MIPS generic code that handles it...
>
> IP27 currently the only system that absolutely needs discontiguous
> memory in order to work at all.  A few other systems could make use of
> discontiguous memory to reduce the waste of memory - the family of
> Broadcom SB1 based systems comes to mind.
>

Isn't discontiguous memory common for embedded system as well ? I
thought so...Anyways can we make discontiguous memory thing move into
generic MIPS code so every future needs for that will profit ? I
looked at other arch, and they seem to implement it that way (in
arch/xxx/mm/discontig.c).

Thanks
--
               Franck
