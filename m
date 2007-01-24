Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 04:28:40 +0000 (GMT)
Received: from mailserver.astro.rug.nl ([129.125.6.166]:23469 "EHLO
	mailserver.astro.rug.nl") by ftp.linux-mips.org with ESMTP
	id S20037480AbXAXE2e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 04:28:34 +0000
Received: from [145.99.147.185] (this-guy.isa-geek.org [145.99.147.185])
	(authenticated bits=0)
	by mailserver.astro.rug.nl (8.12.11.20060308/8.12.11) with ESMTP id l0O4RPBg029885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 24 Jan 2007 05:27:28 +0100
Message-ID: <45B6E02D.1040206@gmail.com>
Date:	Wed, 24 Jan 2007 05:27:25 +0100
From:	Maarten Lankhorst <m.b.lankhorst@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
MIME-Version: 1.0
To:	zhuzhenhua <zzh.hust@gmail.com>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: how to choose journal filesystem for embedded linux?
References: <50c9a2250701231805y62ec67f0v83d2fcf3ae2c55da@mail.gmail.com>
In-Reply-To: <50c9a2250701231805y62ec67f0v83d2fcf3ae2c55da@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <m.b.lankhorst@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.b.lankhorst@gmail.com
Precedence: bulk
X-list: linux-mips

zhuzhenhua schreef:
> hello all:
>          i now work on a mips board, and want to store my system code
> on NAND Flash.
> our Flash driver can handle the Flash features(bad block,  phy  to
> logic addr, spare,etc.),
> so i just want to select a journal filesystem to handle sudden poweroff.
> Our system code(writeable) is about 10M~50M. i am not sure what
> journal filesystem will be suitable, ext3,xfs,jfs,or reiserFS?
> i have try ext3, it runs well, but seems to waste too much space
> while mkfs.ext3.
Have you tried jffs2? Journaled Flash FileSystem 2
