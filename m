Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 22:53:16 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:9970
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225552AbVFWVw7>; Thu, 23 Jun 2005 22:52:59 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j5NLprY4020058;
	Thu, 23 Jun 2005 14:51:53 -0700 (PDT)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j5NLppjp015854;
	Thu, 23 Jun 2005 14:51:51 -0700 (PDT)
Message-ID: <42BB2FF1.8000902@mips.com>
Date:	Thu, 23 Jun 2005 23:56:01 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	rolf liu <rolfliu@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: keep getting "exec: Permission denied" at booting
References: <2db32b72050623135829f8c4e3@mail.gmail.com>
In-Reply-To: <2db32b72050623135829f8c4e3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

rolf liu wrote:
> I am running 2.4.31 on ab1550. When the start-up comes at the network
> config, ifup tries to bring up the ethernet interface. Then there
> comes tons of "exec: Permission denied" message. the box just stop
> there.
> 
> I am running through the NFS root filesystem got from redhat, possibly
> 7.1. pretty old. Is there a newer NFS available?
> 
> Any suggestion?

Check the options you're using to export the NFS root on the server.
For example, I note that I've got the no_root_squash and anongid=0
options set for the MIPS Linux boot area on my Linux PC - but it's
been a couple of years since I've actually used it, and I don't recall
where that came from.

		Regards,

		Kevin K.
