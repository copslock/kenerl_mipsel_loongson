Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2004 09:57:22 +0100 (BST)
Received: from [IPv6:::ffff:211.155.249.251] ([IPv6:::ffff:211.155.249.251]:62225
	"EHLO nnt.neonetech.com") by linux-mips.org with ESMTP
	id <S8225005AbUICI5S>; Fri, 3 Sep 2004 09:57:18 +0100
Received: from wbar1 ([221.219.28.147]) by nnt.neonetech.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 3 Sep 2004 17:01:02 +0800
Date: Fri, 3 Sep 2004 16:57:16 +0800
From: "xuhaoz" <xuhaoz@neonetech.com>
To: "linux-mips" <linux-mips@linux-mips.org>
Subject: 
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NNT0kkZIhTrBoe2U8QV00000033@nnt.neonetech.com>
X-OriginalArrivalTime: 03 Sep 2004 09:01:02.0375 (UTC) FILETIME=[89A5D370:01C49194]
Return-Path: <xuhaoz@neonetech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xuhaoz@neonetech.com
Precedence: bulk
X-list: linux-mips

hi:

	does somebody meet a problem like this?

	static void __init init_mount_tree(void)
	{
		mnt=do_kern_mount("rootfs",0,"rootfs",NULL);
		if(IS_ERR(mnt))
			panic("can't creat rootfs");
	}

	when uclinux run here, it report panic, and i wonder which cause this problem?
	would you please give a hint? any suggestion will appreciated!! 
	thank you !!
