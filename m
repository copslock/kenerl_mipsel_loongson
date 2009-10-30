Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2009 14:51:31 +0100 (CET)
Received: from rs1.rw-gmbh.net ([213.239.201.58]:59421 "EHLO rs1.rw-gmbh.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493353AbZJ3NvZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Oct 2009 14:51:25 +0100
Received: from p50992dee.dip0.t-ipconnect.de ([80.153.45.238] helo=ximap.rw-gmbh.biz)
	by rs1.rw-gmbh.net with esmtp (Exim 4.69)
	(envelope-from <ralf.roesch@rw-gmbh.de>)
	id 1N3rsu-0004YX-1Q; Fri, 30 Oct 2009 14:51:20 +0100
Received: from [192.168.178.44] (rr-2600 [192.168.178.44])
	by ximap.rw-gmbh.biz (Postfix) with ESMTP
	id 0407A174B2E; Fri, 30 Oct 2009 14:51:01 +0100 (CET)
Message-ID: <4AEAEF43.7060200@rw-gmbh.de>
Date:	Fri, 30 Oct 2009 14:50:59 +0100
From:	=?UTF-8?B?UmFsZiBSw7ZzY2g=?= <ralf.roesch@rw-gmbh.de>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:	sam@ravnborg.org, manuel.lauss@gmail.com
Subject: mips: fix build of vmlinux.lds
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

Hi Ralf,

could you please cherry-pick commit  
fd6b6a85c525824bece9543fae5ed68c00ad65a7
(or fd6b6a85c525824bece9543fae5ed68c00ad65a7, seems to be identical)
to linux-2.6.31-stable branch and may be others too ?

Thanks and regards
Ralf  R.
