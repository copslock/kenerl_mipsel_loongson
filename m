Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 03:37:38 +0000 (GMT)
Received: from uproxy.gmail.com ([66.249.92.206]:52892 "EHLO uproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133544AbWAQDhV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 03:37:21 +0000
Received: by uproxy.gmail.com with SMTP id m3so871508uge
        for <linux-mips@linux-mips.org>; Mon, 16 Jan 2006 19:40:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fRNX/OhDOdYqxB8QJlCvivCdFjO1qmWfzX03Hd6bBNP7lgLai5549OmlDjm8g2X2OWQQHZXwFW74j9dOXptKQgk3nt6/5mw+E/ty+lT7/DsiozoYrcbLlknfYmosA9CMZymLBvktd1n+BFwEb0xqw/vjhZe6qSmXXd97IPog8OI=
Received: by 10.48.12.4 with SMTP id 4mr284881nfl;
        Mon, 16 Jan 2006 19:40:56 -0800 (PST)
Received: by 10.48.243.16 with HTTP; Mon, 16 Jan 2006 19:40:56 -0800 (PST)
Message-ID: <38dc7fce0601161940s5e4375dci798f66dff58d882@mail.gmail.com>
Date:	Tue, 17 Jan 2006 12:40:56 +0900
From:	Youngduk Goo <ydgoo9@gmail.com>
To:	linux-mips@linux-mips.org
Subject: using the 36bit physical address on AMD AU1200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <ydgoo9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ydgoo9@gmail.com
Precedence: bulk
X-list: linux-mips

Hello all,

I am trying to use the DM9000 Ethernet controller on the AU1200.
so we connected the DM9000 on the Static bus controller #3 on the au1200.
and we configured the RCS#3 as a I/O device.
The Physical address of I/O device on au1200 is from the 0xD 0000 0000 to
0xD ffff ffff.
I guess I need to convert this address to virtual address for access it.
But I don't know exactly how to do it. Do I need to configure the TBL?
I am using the YAMON as a bootloader. and try to access the DM9000.
But It is not easy for me.

Any advice or examples are welcome.
Thanks,
