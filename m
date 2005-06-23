Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 08:21:42 +0100 (BST)
Received: from hosting-bess-43.66.rev.fr.colt.net ([IPv6:::ffff:213.41.66.43]:37862
	"EHLO smtp.acscom.fr") by linux-mips.org with ESMTP
	id <S8225472AbVFWHVZ>; Thu, 23 Jun 2005 08:21:25 +0100
Received: from [192.168.38.26] (cyber25-3.paris.imaginet.fr [195.68.3.25])
	by smtp.acscom.fr (Postfix) with SMTP id 75FD1564C4
	for <linux-mips@linux-mips.org>; Thu, 23 Jun 2005 09:24:08 +0200 (CEST)
Message-ID: <42BA62AA.9040602@cypou.net>
Date:	Thu, 23 Jun 2005 09:20:10 +0200
From:	Cyprien Laplace <cyprien@cypou.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: booting error on db1550 for kernel 2.4.31
References: <2db32b720506221648eed011b@mail.gmail.com>
In-Reply-To: <2db32b720506221648eed011b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IPACS-MailScanner-Information: Please contact the ISP for more information
X-IPACS-MailScanner: Found to be clean
X-IPACS-MailScanner-SpamCheck: 
X-IPACS-MailScanner-From: cyprien@cypou.net
Return-Path: <cyprien@cypou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cyprien@cypou.net
Precedence: bulk
X-list: linux-mips

rolf liu wrote:

>I compiled the kernel 2.4.31 using sde tools. Download linux to db1550
>through yamon. but the kernel can't find the NFS root. I tried the NFS
>system from other linux box, and the NFS is ok. Who met this same
>problem?
>
>Looking up port of RPC 100003/2 on 10.200.0.198
>RPC: sendmsg returned error 128
>portmap: RPC call returned error 128
>Root-NFS: Unable to get nfsd port number from server, using default
>Looking up port of RPC 100005/1 on 10.200.0.198
>RPC: sendmsg returned error 128
>portmap: RPC call returned error 128
>Root-NFS: Unable to get mountd port number from server, using default
>RPC: sendmsg returned error 128
>mount: RPC call returned error 128
>Root-NFS: Server returned error -128 while mounting /nfsroot/mipsel
>VFS: Unable to mount root fs via NFS, trying floppy.
>kmod: failed to exec /sbin/modprobe -s -k block-major-2, errno = 2
>VFS: Cannot open root device "" or 02:00
>Please append a correct "root=" boot option
>Kernel panic: VFS: Unable to mount root fs on 02:00 
>
>Thanks for the suggestion
>
>  
>
What cmdline did you give to the kernel ?
Had it an IP address ?
Can you tcpdump your local ethernet traffic ? Is there any correct ARP 
traffic ?

Regards,
Cyp
