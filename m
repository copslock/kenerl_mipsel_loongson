Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 07:19:28 +0100 (BST)
Received: from mf2.realtek.com.tw ([IPv6:::ffff:220.128.56.22]:36368 "EHLO
	mf2.realtek.com.tw") by linux-mips.org with ESMTP
	id <S8225010AbUJVGTN>; Fri, 22 Oct 2004 07:19:13 +0100
Received: from msx.realtek.com.tw (unverified [172.20.1.77]) by mf2.realtek.com.tw
 (Content Technologies SMTPRS 4.3.14) with ESMTP id <T6ccd6b21aadc803816a20@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Fri, 22 Oct 2004 14:20:18 +0800
Received: from rtpdii3098 ([172.19.26.139])
          by msx.realtek.com.tw (Lotus Domino Release 6.0.2CF1)
          with ESMTP id 2004102214201694-16708 ;
          Fri, 22 Oct 2004 14:20:16 +0800 
Message-ID: <010201c4b7ff$08bcf040$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-mips@linux-mips.org>
Subject: Use Cramfs as root
Date: Fri, 22 Oct 2004 14:19:01 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/10/22 =?Bog5?B?pFWkyCAwMjoyMDoxNw==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/10/22
 =?Bog5?B?pFWkyCAwMjoyMDoxOA==?=,
	Serialize complete at 2004/10/22 =?Bog5?B?pFWkyCAwMjoyMDoxOA==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi all,
I had successfully used JFFS2 as root.
Then I tried to use the same way to use Cramfs as root, and it cannot work.

Use JFFS2 as root:
    mtd/util/mkfs.jffs2 -d root root.jffs2
    go 0x802b2018 rootfstype=jffs2 root=31:01
mtdparts=maltaflash:1536k(ldr),2048k(root)

Use Cramfs as root:
    /sbin/mkfs.cramfs root root.cramfs
    go 0x802b2018 rootfstype=cramfs root=31:01
mtdparts=maltaflash:1536k(ldr),2048k(root)

Error message:
    VFS: Cannot open root device "31:01" or unknown-block(31,1)
    Please append a correct "root=" boot option
    Kernel panic: VFS: Unable to mount root fs on unknown-block(31,1)


I donot know the right way to boot up Linux with cramfs root image.
There is not much information about it.
Could anyone give me a clue?

Thanks and regards,
Colin
