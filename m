Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2003 14:56:27 +0100 (BST)
Received: from [IPv6:::ffff:193.232.173.35] ([IPv6:::ffff:193.232.173.35]:42996
	"EHLO tux.NIISI") by linux-mips.org with ESMTP id <S8225404AbTION4X>;
	Mon, 15 Sep 2003 14:56:23 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by tux.NIISI (8.11.6/8.11.6) with ESMTP id h8FDtfd08089
	for <linux-mips@linux-mips.org>; Mon, 15 Sep 2003 17:55:41 +0400
Date: Mon, 15 Sep 2003 17:55:41 +0400 (MSD)
From: Tommy Tovbin <tovbin@niisi.msk.ru>
X-X-Sender: tovbin@tux.NIISI
To: linux-mips@linux-mips.org
Subject: Problem with passwd&cracklib
Message-ID: <Pine.LNX.4.44.0309151751430.8078-100000@tux.NIISI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <tovbin@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tovbin@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Hi All! 

I cross-compiled the passwd-0.67-1 and cracklib,2.7, and then I try to 
execute passwd, i get error:
usr/lib/cracklib_dict: magic mismatch
PWOpen: Success

My filesystem is not writeable. Can somebody help me?

-- 
With regards, Tommy Tovbin. tovbin at niisi dot msk dot ru.
