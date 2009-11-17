Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 22:54:22 +0100 (CET)
Received: from dns1.mips.com ([63.167.95.197]:38653 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493269AbZKQVyP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Nov 2009 22:54:15 +0100
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id nAHLs1K0017490;
	Tue, 17 Nov 2009 13:54:01 -0800
Received: from [192.168.65.41] ([192.168.65.41]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Nov 2009 13:54:01 -0800
Message-ID: <4B031B78.5030204@mips.com>
Date:	Tue, 17 Nov 2009 13:54:00 -0800
From:	Chris Dearman <chris@mips.com>
Organization: MIPS Technologies
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:	myuboot@fastmail.fm
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: problem bring up initramfs and busybox
References: <1255735395.30097.1340523469@webmail.messagingengine.com> <4AD906D8.3020404@caviumnetworks.com> <1257898975.30125.1344591929@webmail.messagingengine.com> <4AFA6B7F.10404@walsimou.com> <1258417281.1921.1345554581@webmail.messagingengine.com> <20091117093330.GA24000@linux-mips.org> <1258479580.17116.1345691629@webmail.messagingengine.com> <4B030F76.1040904@paralogos.com>
In-Reply-To: <4B030F76.1040904@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Nov 2009 21:54:01.0198 (UTC) FILETIME=[78DB58E0:01CA67D0]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> This looks like another boot file system setup problem to me.  Are you 
> sure that there's an executable init image at /mnt/root/sbin/init?  I'm 
> pretty sure that the path that you provide to your new init has to be 
> relative to the new root.

That sounds right.

Andrew, my suggestion would be to change your initramfs /init script to 
invoke "/bin/busybox sh" as the last command instead of "exec 
switch_root". The "Kernel panic - not syncing: Attempted to kill init!" 
says that switch_root is exiting for some reason. It could be anything 
from missing files/devices on the /mnt/root file system to a bug in 
busy_box.
By booting into the shell you can run the command by hand (maybe with 
strace if you have it) to help identify where the problem is.

Chris

-- 
Chris Dearman               Desk: +1 408 530 5092  Cell: +1 408 398 5531
MIPS Technologies Inc            955 East Arques Ave, Sunnyvale CA 94085
