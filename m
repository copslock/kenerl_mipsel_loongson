Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2006 06:39:07 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.193]:48750 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133357AbWCPGi6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Mar 2006 06:38:58 +0000
Received: by nproxy.gmail.com with SMTP id i2so209123nfe
        for <linux-mips@linux-mips.org>; Wed, 15 Mar 2006 22:48:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EE9swc8ftsiT0wUqSmmyfFk8NOilDES4qNi+eiSBJXB2ERaJGbDaJGe92R4EtZByYuFPn4knlZNpuWLOXx0rF6APIfxB3xno6OrU6unEYtuk8CtZpYzKjx1hwpOqaX0d8nNH3ma2QOyjLbd21p9Iu7YoMZi9+M0isNpCsTD67zY=
Received: by 10.48.206.14 with SMTP id d14mr687204nfg;
        Wed, 15 Mar 2006 22:48:12 -0800 (PST)
Received: by 10.48.144.19 with HTTP; Wed, 15 Mar 2006 22:48:12 -0800 (PST)
Message-ID: <50c9a2250603152248s4e0343ccwfb44f9ad30300f67@mail.gmail.com>
Date:	Thu, 16 Mar 2006 14:48:12 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to use telnetd of busybox
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i use busybox-1.0-rc for my board
and i want to run telnetd in buysbox
on the target(192.168.81.100), in start with command:$telnetd

and on host, &telnet 192.168.81.100, it show as follow:
telnet
Trying 192.168.81.100...
Connected to 192.168.81.100 (192.168.81.100).
Escape character is '^]'.
Connection closed by foreign host.

on the target i use netstat to check
$ netstat -l
Active Internet connections (only servers) Proto Recv-Q Send-Q Local
Address Foreign Address State tcp 0 0 *:23 *:* LISTEN udp 0 0 *:800
*:* Active UNIX domain sockets (only servers) Proto RefCnt Flags Type
State I-Node Path


in my rootfs it has /etc/passwd, group
login, telnetd is also in busybox.
and i also have add devfs both for kernel and busybox

do i miss something? maybe need any other service for telnetd?

thanks for any hints

Best Regards!

zhuzhenhua
