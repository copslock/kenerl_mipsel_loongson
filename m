Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2010 17:10:17 +0100 (CET)
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59695 "EHLO
        out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492405Ab0ATQKO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2010 17:10:14 +0100
Received: from compute1.internal (compute1.internal [10.202.2.41])
        by gateway1.messagingengine.com (Postfix) with ESMTP id 8485ECE6AE;
        Wed, 20 Jan 2010 11:10:12 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Wed, 20 Jan 2010 11:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:in-reply-to:references:subject:date; s=smtpout; bh=nkFVd+9+lTuz33jQnI2GW2ReZG8=; b=GRFBWeUmEQHqtuhzg/CeH3wwc9MDqiNNu/TNKW6JnsuHp09p2oiJVJmS0SWuX5ZqyEl3dbqsN3D6kjR83/XuCMMnVYFQF2sqlZYORAxFljpsZ6Z9gKiepLRJIyV7th8P5LP9Hxv8o8CifzOG7jmqnildyhCrWIMlU5xti6lEka4=
Received: by web8.messagingengine.com (Postfix, from userid 99)
        id 669BA15B7E2; Wed, 20 Jan 2010 11:10:12 -0500 (EST)
Message-Id: <1264003812.20542.1355658217@webmail.messagingengine.com>
X-Sasl-Enc: BuPKQ8ueY2/LGQc96bq7BnWYU0seQQuDMQ7kix6Av13r 1264003812
From:   myuboot@fastmail.fm
To:     "David Daney" <ddaney@caviumnetworks.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <4B564496.3090509@caviumnetworks.com>
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
 <1263930694.9779.1355491925@webmail.messagingengine.com>
 <4B564496.3090509@caviumnetworks.com>
Subject: Re: loadable kernel module link failure -  endianness incompatible with
 that of the selected emulation
Date:   Wed, 20 Jan 2010 10:10:12 -0600
X-archive-position: 25620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13361



On Tue, 19 Jan 2010 15:47 -0800, "David Daney"
<ddaney@caviumnetworks.com> wrote:
> myuboot@fastmail.fm wrote:
> > I got a link error when compiling 2 loadable kernel modules -
> > "endianness incompatible with that of the selected emulation". 
> > 
> > But both kernel and the kernel modules of error are in big endian. I
> > don't know what I should check or fix. Any suggestions? I checked the
> > endianess of the kernel by checking the elf header of vmlinux file, is
> > that the right way to do it?
> > 
> > Below are the error info and the readelf output, showing both the kernel
> > and a kernel module are in big endian.
> > Thanks for your help. Andrew
> > 
> > 1) error log 
> > make -C /home/root123/sources/kernel/linux
> > CROSS_COMPILE=""/home/root123/sources/gcc3.4.3-be"/bin/mips-linux-"
> > M=/home/root123/sources/sdk/platform/src/linux/mxp/src modules    
> > 
> >   LD [M]  /home/root123/sources/sdk/platform/src/linux/mxp/src/mxpmod.o
> > /home/root123/sources/gcc3.4.3-be/bin/mips-linux-ld:
> > /home/root123/sources/sdk/platform/src/linux/mxp/src/mmxpcore.o:
> > compiled for a big endian system and target is little endian
> > /home/root123/sources/gcc3.4.3-be/bin/mips-linux-ld:
> > /home/root123/sources/sdk/platform/src/linux/mxp/src/mmxpcore.o:
> > endianness incompatible with that of the selected emulation
> > /home/root123/sources/gcc3.4.3-be/bin/mips-linux-ld: failed to merge
> > target specific data of file
> > /home/root123/sources/sdk/platform/src/linux/mxp/src/mmxpcore.o
> > make[13]: ***
> > [/home/root123/sources/sdk/platform/src/linux/mxp/src/mxpmod.o] Error 1
> > 
> 
> Looks like a toolchain bug/configuration-problem.  Hard to tell though 
> as you didn't pass 'V=1' on the make invocation line.
> 
> David Daney
With the V=1 option suggested, I found the culprit is this "-m
elf32ltsmip". It is working now.

Thanks. Andrew
