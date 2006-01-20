Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 20:59:59 +0000 (GMT)
Received: from mail-out.m-online.net ([212.18.0.9]:3490 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S3950163AbWATU7g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 20:59:36 +0000
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 6A69270299;
	Fri, 20 Jan 2006 22:03:33 +0100 (CET)
X-Auth-Info: Bc1aKy2xnrwQXHNvlekoxVovonLlrU949Dl2MTRyBqU=
X-Auth-Info: Bc1aKy2xnrwQXHNvlekoxVovonLlrU949Dl2MTRyBqU=
X-Auth-Info: Bc1aKy2xnrwQXHNvlekoxVovonLlrU949Dl2MTRyBqU=
Received: from mail.denx.de (p54965939.dip.t-dialin.net [84.150.89.57])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 53457B9629;
	Fri, 20 Jan 2006 22:03:33 +0100 (CET)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id D66BA6D006D;
	Fri, 20 Jan 2006 22:03:32 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id C73F0354113;
	Fri, 20 Jan 2006 22:03:32 +0100 (MET)
To:	Marc Karasek <marckarasek@ivivity.com>
cc:	"P. Christeas" <p_christ@hol.gr>,
	Linux-Mips <linux-mips@linux-mips.org>
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Fri, 20 Jan 2006 15:47:33 EST."
             <1137790053.22994.58.camel@localhost.localdomain> 
Date:	Fri, 20 Jan 2006 22:03:32 +0100
Message-Id: <20060120210332.C73F0354113@atlas.denx.de>
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <1137790053.22994.58.camel@localhost.localdomain> you wrote:
> Basically due to design issues and cost issues having a flash based
> system is not possible.  Currently we have only 16MB total of flash and

If you have enough flash to store a compressed ramdisk image, you can
store a compressed flash file system as well. For example, you  could
use  a  cramfs file system. In most cases the ramdisk solution is the
worst option to chose. See for example
http://www.denx.de/wiki/view/DULG/RootFileSystemSelection


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There are bugs and then there are bugs.  And then there are bugs.
                                                    - Karl Lehenbauer
