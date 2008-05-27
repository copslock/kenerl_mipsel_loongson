Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2008 09:52:41 +0100 (BST)
Received: from mx03.syneticon.net ([87.79.32.166]:27919 "HELO
	mx03.syneticon.net") by ftp.linux-mips.org with SMTP
	id S20023342AbYE0Iwj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 May 2008 09:52:39 +0100
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by mx03.syneticon.net (Postfix) with ESMTP id 96C2D95A1;
	Tue, 27 May 2008 10:52:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mx03.syneticon.net
Received: from mx03.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id Cdh+07daZE9E; Tue, 27 May 2008 10:52:33 +0200 (CEST)
Received: from [192.168.10.145] (koln-4d0b6fdf.pool.mediaWays.net [77.11.111.223])
	by mx03.syneticon.net (Postfix) with ESMTP;
	Tue, 27 May 2008 10:52:33 +0200 (CEST)
Message-ID: <483BCB75.4050901@wpkg.org>
Date:	Tue, 27 May 2008 10:51:01 +0200
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 2.0.0.12 (X11/20080305)
MIME-Version: 1.0
To:	Kexec Mailing List <kexec@lists.infradead.org>,
	linux-mips@linux-mips.org
Subject: kexec on mips - anyone has it working?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

I'm trying to use kexec on a ASUS WL-500gP router (BCM47XX, little 
endian MIPS) with a 2.6.25.4 kernel with some additional changes from 
OpenWRT.

Unfortunately, it doesn't work for me - when I load a new kernel and try 
to execute it, it just says "Bye" and the router is dead:

# kexec -l vmlinux
# kexec -e
(...)
Bye


I signalled the issue before in the past, with a 2.6.23.1 kernel:

http://lists.infradead.org/pipermail/kexec/2008-February/001315.html


Ideas? Ways to debug it?



-- 
Tomasz Chmielewski
http://wpkg.org
