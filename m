Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2009 01:49:57 +0200 (CEST)
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49797 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493237AbZJSXtu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Oct 2009 01:49:50 +0200
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F31ECB4080;
	Mon, 19 Oct 2009 19:49:48 -0400 (EDT)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Mon, 19 Oct 2009 19:49:49 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:in-reply-to:references:subject:date; s=smtpout; bh=T4bXUDO0Z3ayUMDU+y7hOLVsGUA=; b=pth8b8Lq6WK4FLBCbLkMdWI5KUnS/ONyE0T/QZy8rVrQ9GBJpVS+65uLoxqXknlenjwpyfHHI6odbhXGCyk502xOkp8PTwdbQjZpScXt5Pv9aLVVjGOHreoQKXshhaiHFh2O6Ve3VuqVKei4zeAVhau3BHJTu84vHu94khdvZCQ=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id 3D70F10CC78; Mon, 19 Oct 2009 19:49:49 -0400 (EDT)
Message-Id: <1255996189.8924.1340920415@webmail.messagingengine.com>
X-Sasl-Enc: 2C/JxUDPUuDMaN/KbtFC0bNsFPtcXVpXKBIPdG8a7qcc 1255996189
From:	myuboot@fastmail.fm
To:	"David Daney" <ddaney@caviumnetworks.com>
Cc:	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <4AD906D8.3020404@caviumnetworks.com>
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
Subject: Re: 2.6.31 kernel for mips compile failure - war.h:12:17: error: war.h:
 No such file or directory
Date:	Mon, 19 Oct 2009 18:49:49 -0500
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

Thanks. This issue is fixed now. In 2.6.31 the directory
include/asm-mips  is moved as arch/mips/include/asm/. I need to change
my Makefile accordingly.

On Fri, 16 Oct 2009 16:50 -0700, "David Daney"
<ddaney@caviumnetworks.com> wrote:
> mips-linux questions will get more attention if you send them to 
> linux-mips@linux-mips.org.
> 
> 
> myuboot@fastmail.fm wrote:
> > I am trying to use buildroot 2009.08 to compile kernel 2.6.31 for mips,
> > but it fails to error -" war.h can't be found". I used the same
> > buildroot to build kernel version 2.6.29 with no problem. 
> > 
> > Please give me some suggestion on how to fix this issue. The file 
> > ./arch/mips/include/asm/war.h is there with no problem. Thanks a lot.
> > 
> [...]
> >   CC      arch/mips/kernel/asm-offsets.s
> > In file included from
> > /home/root123/sources/buildroot-2009.08-k/project_build_mips/f1/linux-2.6.31/arch/mips/include/asm/bitops.h:24,
> >                  from include/linux/bitops.h:17,
> >                  from include/linux/kernel.h:15,
> >                  from include/linux/sched.h:52,
> >                  from arch/mips/kernel/asm-offsets.c:13:
> 
> What does your .config look like?
> 
> Also try make V=1 so we can see the exact compiler command line that the 
> build process is generating.
> 
> David Daney
