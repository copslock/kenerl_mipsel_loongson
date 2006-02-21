Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 03:48:15 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:48097 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8133626AbWBUDsG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Feb 2006 03:48:06 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 20 Feb 2006 19:55:05 -0800
  id 001CD14D.43FA8F19.00003975
Message-ID: <43FA8F04.3040606@jg555.com>
Date:	Mon, 20 Feb 2006 19:54:44 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: GLIBC moved mips to Ports
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Just an FYI, I've been working trying to keep MIPS updated in glibc. 
Again some changes were made that broke the MIPS build with the current 
snapshot. I guess all of Daniel's and my work just got thrown away. As 
of today MIPS is no longer going to be support in trunk. Here's the 
message I received today.

In my opinion this seems to mean that MIPS is not a high priority in 
their book.

------- Additional Comments From roland at gnu dot org  2006-02-21 02:14 -------
For the trunk, mips has moved to the ports repository.
Daniel should be able to commit his fixes there directly.
Items needing merge in the 2.3 branch can be reassigned to me.

-- What |Removed |Added 
---------------------------------------------------------------------------- 
AssignedTo|drepper at redhat dot com |drow at false dot org Status|NEW 
|ASSIGNED Component|nptl |ports 
http://sourceware.org/bugzilla/show_bug.cgi?id=2340 ------- You are 
receiving this mail because: ------- You reported the bug, or are 
watching the reporter.


-- 
----
Jim Gifford
maillist@jg555.com
