Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 17:29:52 +0100 (CET)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46896 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493543AbZKRQ3q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2009 17:29:46 +0100
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0DD0FC0611;
	Wed, 18 Nov 2009 11:29:45 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute2.internal (MEProxy); Wed, 18 Nov 2009 11:29:45 -0500
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=L5tByxea1rJ30uE9jpgPaBx9odY=; b=haWNO4EfmdU9jenYGyxI5a9+ieqzcSqVvSXVrSEMZPrbAuqjelK45D9eQNGZZaMThbq8o2BLA4DhhAbZO0uC4jcAjllgy//T8K1uxlq87s/vxudKJF7qP2fPT8umMMtS2lts1RTemsXzU9avpx05o0WZVu3yYtPgGUgKc6RoSO4=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id DF9A512D032; Wed, 18 Nov 2009 11:29:44 -0500 (EST)
Message-Id: <1258561784.6054.1345873883@webmail.messagingengine.com>
X-Sasl-Enc: EtkeUJykIbh4QQ+mtA0M8OVxulqa5FXQR7z1Bi/Kxmfb 1258561784
From:	myuboot@fastmail.fm
To:	"David VomLehn" <dvomlehn@cisco.com>
Cc:	"Florian Fainelli" <florian@openwrt.org>,
	"Chris Dearman" <chris@mips.com>,
	"linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4B031B78.5030204@mips.com>
 <1258504293.3627.1345755107@webmail.messagingengine.com>
 <200911180139.29283.florian@openwrt.org>
 <1258505915.7077.1345760963@webmail.messagingengine.com>
 <20091118010351.GA21728@dvomlehn-lnx2.corp.sa.net>
Subject: Re: problem bring up initramfs and busybox
In-Reply-To: <20091118010351.GA21728@dvomlehn-lnx2.corp.sa.net>
Date:	Wed, 18 Nov 2009 10:29:44 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

At this point, I just want to be able to bring up the shell so that I
debug further, either with or without initramfs. For initramfs, do I
need to do anything for endianess? I am not aware of anything. 

Thanks, Andrew

On Tue, 17 Nov 2009 20:03 -0500, "David VomLehn" <dvomlehn@cisco.com>
wrote:
> On Tue, Nov 17, 2009 at 06:58:35PM -0600, myuboot@fastmail.fm wrote:
> > 
> > On Wed, 18 Nov 2009 01:39 +0100, "Florian Fainelli"
> > <florian@openwrt.org> wrote:
> > > -------------------------------
> > Actually I already got this patch for the board in little endian mode,
> > and it is still there for the big endian mode. And this is one of the
> > place I have been wondering if that needs to be changed for big endian. 
> 
> It sounds like you've done a good job getting the bootloader and kernel
> to work, so this may be a silly suggestion, but are you sure your root
> filesystem and busybox aAt re little-endian? It would be an easy mistake to
> make...
> 
> > thanks. Andrew
> 
> David VL
