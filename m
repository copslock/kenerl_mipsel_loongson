Received:  by oss.sgi.com id <S553661AbQKGOuk>;
	Tue, 7 Nov 2000 06:50:40 -0800
Received: from boco.fee.vutbr.cz ([147.229.9.11]:32272 "EHLO boco.fee.vutbr.cz")
	by oss.sgi.com with ESMTP id <S553656AbQKGOuc>;
	Tue, 7 Nov 2000 06:50:32 -0800
Received: from fest.stud.fee.vutbr.cz (fest.stud.fee.vutbr.cz [147.229.9.16])
	by boco.fee.vutbr.cz (8.11.1/8.11.1) with ESMTP id eA7EoTf94482
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified OK)
	for <linux-mips@oss.sgi.com>; Tue, 7 Nov 2000 15:50:29 +0100 (CET)
Received: (from xmichl03@localhost)
	by fest.stud.fee.vutbr.cz (8.11.0/8.11.0) id eA7EoSw72535;
	Tue, 7 Nov 2000 15:50:28 +0100 (CET)
From:   Michl Ladislav <xmichl03@stud.fee.vutbr.cz>
Date:   Tue, 7 Nov 2000 15:50:28 +0100 (CET)
X-processed: pine.send
To:     linux-mips@oss.sgi.com
Subject: setenv eaddr
Message-ID: <Pine.BSF.4.05.10011071158500.58171-100000@fest.stud.fee.vutbr.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi all,

I was looking to the archives and HOWTOs to find way how to change eaddr
of sgi Indy (which was incorrectly set after 2.4.0-test6 crash) and find
couple of questions and no answer. I think about -p switch of setenv
mentioned in archives supposing that it means "permanent" and trying to
imagine how to FORCE set eaddr. This is the key.

>> setenv -f eaddr 12:34:56:78:9a:bc

Maybye you find this information usefull. I'm sorry to trouble you if you
already know it.

Regards
Ladislav Michl

PS: It's nice to see Linux running on sgi Indy. Thanks.
