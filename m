Received:  by oss.sgi.com id <S42415AbQH1XkE>;
	Mon, 28 Aug 2000 16:40:04 -0700
Received: from saturn.mikemac.com ([216.99.199.88]:18489 "EHLO mikemac.com")
	by oss.sgi.com with ESMTP id <S42401AbQH1Xjf>;
	Mon, 28 Aug 2000 16:39:35 -0700
Received: from Saturn (localhost [127.0.0.1]) by mikemac.com (8.8.7/8.7.3) with ESMTP id QAA00056 for <linux-mips@oss.sgi.com>; Mon, 28 Aug 2000 16:39:04 -0700
Message-Id: <200008282339.QAA00056@mikemac.com>
To:     linux-mips@oss.sgi.com
Subject: PCMCIA memory window
Date:   Mon, 28 Aug 2000 16:39:03 -0700
From:   Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


  Where should the PCMCIA memory window be mapped to? I have no ISA
bus so the default 0xc0000-0xfffff isn't appropriate. I do have PCI
working and it's mapped at 0xB0000000 to 0xB6000000.

  Thanks,

  Mike McDonald
  mikemac@mikemac.com
