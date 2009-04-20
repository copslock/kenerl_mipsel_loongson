Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 11:15:04 +0100 (BST)
Received: from mail.sysgo.com ([62.8.134.5]:60063 "EHLO mail.sysgo.com")
	by ftp.linux-mips.org with ESMTP id S20024137AbZDTKO5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2009 11:14:57 +0100
Received: by mail.sysgo.com (Postfix, from userid 1001)
	id 3F1136001D; Mon, 20 Apr 2009 12:14:50 +0200 (CEST)
Received: from mail.sysgo.com (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 922916001F;
	Mon, 20 Apr 2009 12:14:41 +0200 (CEST)
Received: from www.sysgo.com (www.sysgo.com [62.8.134.6])
	by mail.sysgo.com (Postfix) with ESMTP id 8563C6001D;
	Mon, 20 Apr 2009 12:14:41 +0200 (CEST)
Received: by www.sysgo.com (Postfix, from userid 33)
	id 6BF44134316; Mon, 20 Apr 2009 12:14:40 +0200 (CEST)
Received: from 192.100.130.228 ([192.100.130.228]) 
	by www.sysgo.com (IMP) with HTTP 
	for <cam@172.20.1.30>; Mon, 20 Apr 2009 12:14:40 +0200
Message-ID: <1240222480.49ec4b105b59b@www.sysgo.com>
Date:	Mon, 20 Apr 2009 12:14:40 +0200
From:	Carlos Mitidieri <cam@sysgo.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Boot program interface
References: <1240213045.49ec26350fa49@www.sysgo.com> <200904201057.04833.florian@openwrt.org>
In-Reply-To: <200904201057.04833.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 192.100.130.228
X-AV-Checked: ClamAV using ClamSMTP
Return-Path: <cam@sysgo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cam@sysgo.com
Precedence: bulk
X-list: linux-mips

Hi,

> Hi Carlos,
>
> Le Monday 20 April 2009 09:37:25 Carlos Mitidieri, vous avez écrit :
> > Hello,
> >
> > I am working on a project that requires an extensive boot program
> > interface.
> >
> > It turns out that the device tree used on PPC architecture meets the
> > requirements.
> >
> > I have been looking, and I could not find any similar concept implemented
> > for MIPS.
>
> I do not know any MIPS board using a device tree either.
>
> >
> > So, I am now considering to port the OFDT library into the MIPS arch.
> >
> > What do you think about this? Is there anyone working on a similar project?
>
> You should see how Sparc, PowerPC and Microblaze use it and how they do share
> code. Also condiser seeing how u-boot handles device trees, specifically on
> PowerPC and Microblaze.


Ok, but what you think about doing such a port? I mean, is it something that
could be eventually accepted by the MIPS Linux community? Or do you have
problems with this approach?

I am looking forward for your answers.

Kind regards,

-- 
Carlos Mitidieri
Project Engineer
