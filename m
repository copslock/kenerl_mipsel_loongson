Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2005 18:50:33 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.201]:37057 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8224850AbVDTRuR> convert rfc822-to-8bit;
	Wed, 20 Apr 2005 18:50:17 +0100
Received: by wproxy.gmail.com with SMTP id 57so353884wri
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2005 10:50:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gCSxb683HoWwmCGfeE3ly8p1NeiISGcj9nHOFMJjWwzY4n1hNRph2Ko3zPbbBODOJJxd1mO5oBoNalMtI7YgHLYl3/Pg9VN8dma4R0RRqWpg3ZQEybVaQNEW5/N+09N1MRz7THoHtvK/0zH/j853ipZl/whoQ3aqEvjCYtMeylY=
Received: by 10.54.73.10 with SMTP id v10mr892528wra;
        Wed, 20 Apr 2005 10:50:10 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Wed, 20 Apr 2005 10:50:10 -0700 (PDT)
Message-ID: <ecb4efd10504201050a00f941@mail.gmail.com>
Date:	Wed, 20 Apr 2005 13:50:10 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: mdelay() from board_setup() [is default value for loops_per_jiffy way off?]
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm working on a linux port for a custom Au1550 based board. Inside of
board_setup() I need to wait for some hardware to power up. So, I
called mdelay(), but it seems to wait for far too short a time. It
seems that loops_per_jiffy still has the default value (4096) in
board_setup(), the computed value is more like 245248. So, what is the
proper way to spin wait this early in the startup process? Also, isn't
the default value for loops_per_jiffy off by quite a bit? I'm running
the Au1550 at 492MHz, so that would make the default value good for a
~8MHz processor?

                               --Clem
