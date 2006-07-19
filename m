Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2006 15:35:59 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:25749 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133425AbWGSOfv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Jul 2006 15:35:51 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 465D945D53; Wed, 19 Jul 2006 16:35:50 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1G3D8f-0007tA-6z; Wed, 19 Jul 2006 15:35:01 +0100
Date:	Wed, 19 Jul 2006 15:35:01 +0100
To:	hemanth.venkatesh@wipro.com
Cc:	linux-mips@linux-mips.org
Subject: Re: CRAMFS  Ramdisk image as Rootfs
Message-ID: <20060719143500.GI4613@networkno.de>
References: <2156B1E923F1A147AABDF4D9FDEAB4CB09D2DE@blr-m2-msg.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2156B1E923F1A147AABDF4D9FDEAB4CB09D2DE@blr-m2-msg.wipro.com>
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

hemanth.venkatesh@wipro.com wrote:
> Hi All,
> 
>  
> 
> I was trying to mount cramfs image as Ramdisk rootfs for 2.6.14 kernel.
> Even though the kernel seems to detect the cramfs image, it is not able
> to mount it as rootfs. It throws the error "cramfs: bad root offset
> 4864" The target is little endian, and  RHEL host on which the image was
> built is also little endian. 

Sounds like the fs image is somewhat broken. Is the cramfs loop-mountable
on RHEL without showing the error message?


Thiemo
