Received:  by oss.sgi.com id <S553787AbQKWPvG>;
	Thu, 23 Nov 2000 07:51:06 -0800
Received: from [207.81.221.34] ([207.81.221.34]:54370 "EHLO relay")
	by oss.sgi.com with ESMTP id <S553736AbQKWPup>;
	Thu, 23 Nov 2000 07:50:45 -0800
Received: from vcubed.com ([207.81.96.153])
	by relay (8.8.7/8.8.7) with ESMTP id LAA15994
	for <linux-mips@oss.sgi.com>; Thu, 23 Nov 2000 11:12:52 -0500
Message-ID: <3A1D3DA1.E982879B@vcubed.com>
Date:   Thu, 23 Nov 2000 10:54:09 -0500
From:   Dan Aizenstros <dan@vcubed.com>
Organization: V3 Semiconductor
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Strange messages.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello All,

Recently I upgraded my Linux/MIPS kernel from 2.2.12 to 
2.4.0-test9 and I started getting messages like the following:

Setting flush to zero for awk.

I did not get this message when using a 2.2.12 kernel but I am
getting them with a 2.4.0-test9 kernel.

The 2.4.0-test9 kernel is based on the code from the snapshot
at oss.sgi.com in the following file,
/pub/linux/mips/mips-linux/simple/crossdev/src/linux-001027.tar.gz
with the patches from the same directory applied.

I get the message many times and for different programs during
system startup.

Has anyone seen this before?

Dan Aizenstros
Software Engineer
V3 Semiconductor Corp.
