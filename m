Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 16:56:11 +0100 (BST)
Received: from bay1-f3.bay1.hotmail.com ([IPv6:::ffff:65.54.245.3]:65029 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225278AbTEJP4J>;
	Sat, 10 May 2003 16:56:09 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Sat, 10 May 2003 08:56:01 -0700
Received: from 4.35.224.219 by by1fd.bay1.hotmail.msn.com with HTTP;
	Sat, 10 May 2003 15:56:01 GMT
X-Originating-IP: [4.35.224.219]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: jbglaw@lug-owl.de, linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Sat, 10 May 2003 08:56:01 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F3AmEaJswFCHOz0000b1d9@hotmail.com>
X-OriginalArrivalTime: 10 May 2003 15:56:01.0357 (UTC) FILETIME=[A77D77D0:01C3170C]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

>"init" is another thing. Your NFS root should include a /sbin/init or
>or /etc/init or /bin/init or /bin/sh. If none of those exists, you
>loose.


For setting up the NFS, I did the following:
1. exported the /export/RedHat7.1
2. downloaded MIPS_RedHat7.1_Release-02.00.tar from 
ftp://ftp.mips.com/pub/linux/mips/installation/redhat7.1/02.00

this tar file has the following:

linux\installation\RedHat7.1\RPMS\mips\ <contains a lot of rpms>
linux\installation\RedHat7.1\RPMS\mipsel\ <contains a lot of rpms>
linux\installation\RedHat7.1\RPMS\noarch\ <contains a lot of rpms>
linux\installation\RedHat7.1\install\ <contains a Makefile, install.list, 
install.script>
linux\installation\RedHat7.1\install\root\etc\ <contains inittab, securetty>
linux\installation\RedHat7.1\install\root\etc\sysconfig\ <contains network>
linux\installation\RedHat7.1\install\root\etc\xinetd.d\ <contains telnet, 
rlogin, rsh,rexec, hosts>

& some more files.

Now tell me what should be extracted to my NFS export /export/RedHat7.1 
(along with their relative path info.).

Also let me know what path to be passed on to the kernel as parameter to 
nfsroot=
Is it simply /export/Redhat7.1?

Another question: I don't see a init file in the tar. or is inittab similar? 
Is this "MIPS_RedHat7.1_Release-02.00.tar" tar file the right file & the 
only file that is needed for now; that has the right stuff in it? Or do I 
need to get the right file from a different tar file?


Thanks,
-Mike.

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*.  
http://join.msn.com/?page=features/featuredemail
