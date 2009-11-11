Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 01:23:04 +0100 (CET)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:49068 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492662AbZKKAW5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 01:22:57 +0100
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D4002BE2CF;
	Tue, 10 Nov 2009 19:22:55 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Tue, 10 Nov 2009 19:22:55 -0500
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=s2Pzj4N7L9FfVflOdXuBhrcpkKg=; b=E1Se3SRovlsnwMaXgTczYYTF5MeeI6HAr2fYv0Om1D9qPx8ORC5aZDPILMCJsAY/d821wH63Doj5OCr/frNCq9OobPaNZ+CdCQo2342B7twavUm007zbN61oLwCtnlB9erPxYEecy0/OUtEbrb5v4OwfqLT84SudMtJFifbK8s0=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id AC42111A861; Tue, 10 Nov 2009 19:22:55 -0500 (EST)
Message-Id: <1257898975.30125.1344591929@webmail.messagingengine.com>
X-Sasl-Enc: s92qWSs4qSf3+xZ+nEzHtfheneeWvOEq7FylA6G8v895 1257898975
From:	myuboot@fastmail.fm
To:	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
Subject: Kernel panic - not syncing: Attempted to kill init!
In-Reply-To: <4AD906D8.3020404@caviumnetworks.com>
Date:	Tue, 10 Nov 2009 18:22:55 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

Hi, 

I got the following error trying to bring up the /sbin/init with Kernel
2.6.31 using cramfs filesystem on a MIPS 32 board:

[    1.160000] VFS: Mounted root (cramfs filesystem) readonly on device
31:2.
[    1.171000] Freeing unused kernel memory: 116k freed
[    1.223000] Kernel panic - not syncing: Attempted to kill init!
[    1.229000] Rebooting in 3 seconds..

Using BDI I know the kernel panic happens as soon as
run_init_process("/sbin/init") in init_post() is called. The filesystem
itself seems to be ok, because I can use 'ls' command under u-boot to
see /sbin/init is a symbolic link to busybox. Also the kernel seems to
like the filesystem and can mount the filesystem.  I have for checked
for similar questions for this error, so I tried replacing /sbin/init
with a hello world program, but the result is exactly the same. It seems
neither hello-world or /sbin/init got executed. 

At this point, I don't know how to debug this issue. Any suggestion on
how to debug this issue will be greatly appreciated.

Andrew
