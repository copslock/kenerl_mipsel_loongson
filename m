Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Mar 2007 23:20:05 +0000 (GMT)
Received: from rrcs-64-183-102-11.west.biz.rr.com ([64.183.102.11]:52426 "EHLO
	jg555.com") by ftp.linux-mips.org with ESMTP id S20038414AbXCDXUD
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Mar 2007 23:20:03 +0000
Received: from [192.168.55.157] ([::ffff:192.168.55.157])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Sun, 04 Mar 2007 15:18:57 -0800
  id 0047C25C.45EB53E1.0000556C
Message-ID: <45EB53D5.8060007@jg555.com>
Date:	Sun, 04 Mar 2007 15:18:45 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Building 64 bit kernel on Cobalt
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Last working Kernel was 2.6.19 series.

Some changes from 2.6.19 and the 2.6.20 make it impossible to build a 64 
bit kernel to boot on the cobalt. Ya, I know why, building a N32 
actually but need a 64 bit kernel in order to do that. Anyone got any 
suggestions. Looking through the difference between the kernels to 
figure this out, but it's like looking for a needle in a haystack. Any 
suggestions as to a starting point?
