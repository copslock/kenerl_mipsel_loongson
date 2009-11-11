Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 16:49:05 +0100 (CET)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54464 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492871AbZKKPs7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 16:48:59 +0100
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B727ABEC42;
	Wed, 11 Nov 2009 10:48:55 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Wed, 11 Nov 2009 10:48:55 -0500
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=AiZkKhxXq2YK4MkTOz3m3FhWpEY=; b=ZXb2WfUdh6BIy8grOYum6bsUG17KDZVzbGzPYKLcK7/MaGRD7c6IN6bAKIwvPUEh995gzvcx/NRbvDJ5gmKrMOe1a3+JriuWhU18cK29wIZRPJVAHF4PkbiyaXH2OZ00yHIxPA9fX+HIw+sdmkRI47rlpE6hvmBNA1ffTqo6/40=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id 98707127BC8; Wed, 11 Nov 2009 10:48:55 -0500 (EST)
Message-Id: <1257954535.18468.1344702051@webmail.messagingengine.com>
X-Sasl-Enc: 1XW7eUZyIIOZnWVNJo6lBtrdjAa8HDhZNgnQzdrIAaZe 1257954535
From:	myuboot@fastmail.fm
To:	"Gaye Abdoulaye Walsimou" <walsimou@walsimou.com>
Cc:	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
 <1257898975.30125.1344591929@webmail.messagingengine.com>
 <4AFA6B7F.10404@walsimou.com>
Subject: Re: Kernel panic - not syncing: Attempted to kill init!
In-Reply-To: <4AFA6B7F.10404@walsimou.com>
Date:	Wed, 11 Nov 2009 09:48:55 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips


On Wed, 11 Nov 2009 08:45 +0100, "Gaye Abdoulaye Walsimou"
<walsimou@walsimou.com> wrote:
> myuboot@fastmail.fm wrote:
> > Hi, 
> >
> > I got the following error trying to bring up the /sbin/init with Kernel
> > 2.6.31 using cramfs filesystem on a MIPS 32 board:
> >   
> 
> Just to be sure does:
> $file vmlinux
> $file busybox
> give the same result?
> 
> Regards
The file result looks ok. The readelf result looks fine too.

file linux-2.6.31/vmlinux root/bin/busybox
linux-2.6.31/vmlinux: ELF 32-bit MSB executable, MIPS, MIPS32 version 1
(SYSV), statically linked, not stripped
root/bin/busybox:     setuid ELF 32-bit MSB executable, MIPS, MIPS32
version 1 (SYSV), dynamically linked (uses shared libs), stripped

Thanks, Andrew
