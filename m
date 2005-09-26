Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2005 10:16:49 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.202]:61921 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133514AbVIZJQd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Sep 2005 10:16:33 +0100
Received: by zproxy.gmail.com with SMTP id j2so160668nzf
        for <linux-mips@linux-mips.org>; Mon, 26 Sep 2005 02:16:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eXFM4J32Zmu03HBl6Wpa1hEmkmOu0zjiX3Pa9fiBNEwEFO3HDiuv+Zd6oBzsZSNnL21BXxz3cxAxNVo1cg44x7iVOoeGg412s0AIcdPEbmPRrTHX75I0AbAi/Hu7FQU4st+KHXPufT/nj2lCSHS7aKFSqopvh8kB5UNUVUUiLxg=
Received: by 10.36.41.3 with SMTP id o3mr1286790nzo;
        Mon, 26 Sep 2005 02:16:27 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Mon, 26 Sep 2005 02:16:27 -0700 (PDT)
Message-ID: <cda58cb80509260216591eb96b@mail.gmail.com>
Date:	Mon, 26 Sep 2005 11:16:27 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Subject: DISCONTIGMEM suuport on 32 bits MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm working on a port of 32bit MIPS to a custom board with several
large holes in the memory map. I would like to know the status of
discontiguous memory on MIPS. I have noticed that ip27 Kconfig enables
this feature but I don't see any MIPS generic code that handles it...

Has anybody already done this ? If not then I'll try to work out what
needed from the corresponding i386 code, but I'd appreciate any
pointers.

Thanks
--
               Franck
