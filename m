Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA46101 for <linux-archive@neteng.engr.sgi.com>; Mon, 21 Dec 1998 13:16:25 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA64587
	for linux-list;
	Mon, 21 Dec 1998 13:15:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from odin.corp.sgi.com (odin.corp.sgi.com [192.26.51.194])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id NAA60557
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 21 Dec 1998 13:15:15 -0800 (PST)
	mail_from (aumenta@albany.sgi.com)
Received: from t-bar.albany.sgi.com by odin.corp.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/951211.SGI)
	for <linux@cthulhu.engr.sgi.com> id NAA12850; Mon, 21 Dec 1998 13:15:13 -0800
Received: from albany.sgi.com by t-bar.albany.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	for <linux@cthulhu.engr.sgi.com> id QAA14782; Mon, 21 Dec 1998 16:11:06 -0500
Message-ID: <367EB96A.AB060206@albany.sgi.com>
Date: Mon, 21 Dec 1998 16:11:06 -0500
From: Al Aumenta <aumenta@albany.sgi.com>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: bootp on IRIX server
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

<HTML>
I am attempting to install Linux on an Indy but I am running into a problem
<BR>the instructions are for using bootp on a i386 host, I am interpreting
the instructions
<BR>for an SGI host .
<BR>here is what I have:

<P>/etc/inetd.conf

<P>bootp&nbsp;&nbsp; dgram&nbsp;&nbsp; udp&nbsp;&nbsp;&nbsp;&nbsp; wait&nbsp;&nbsp;&nbsp;
root&nbsp;&nbsp;&nbsp; /usr/etc/bootp bootp -f /etc/bootptab
<BR>tftp&nbsp;&nbsp;&nbsp; dgram&nbsp;&nbsp; udp&nbsp;&nbsp;&nbsp;&nbsp;
wait&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp; /usr/etc/tftpd&nbsp; tftpd
-s&nbsp; /usr/src/sgi/installfs
<BR>bootparam/1 dgram&nbsp;&nbsp; rpc/udp wait&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;
/usr/etc/rpc.bootparamd bootparamd
<BR>&nbsp;
<BR>/etc/bootptab:

<P>(server info)
<BR>/usr/src/sgi/installfs
<BR>vmlinux
<BR>(client info)
<BR>cygnus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1 08:00:69:09:2d:9b&nbsp;&nbsp;&nbsp;&nbsp; 169.238.59.4&nbsp;&nbsp;&nbsp;
vmlinux
<BR>&nbsp;
<BR>&nbsp;

<P>I have successfully connected with the server -- the kernel boots -
but the kernel cannot
<BR>mount the network file system.

<P>I get RPC errors pointing to nfs and mountd :
<BR>Looking up port of RPC 100003/2 on 169.238.59.23
<BR>RPC: sendmsg returned error 128
<BR>portmap server 169.238.59.23 not responding , timed out

<P>Looking up port of RPC 100005/1 on 169.238.59.23
<BR>RPC: sendmsg returned error 128
<BR>portmap server 169.238.59.23 not responding , timed out
<BR>&nbsp;
<BR>Root-NFS: Unable to get mountd port number from serve, using default

<P>rpcinf -p output is :
<BR>&nbsp;&nbsp;&nbsp; 100000&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp; udp&nbsp;&nbsp;&nbsp;
111&nbsp; portmapper
<BR>&nbsp;&nbsp;&nbsp; 100000&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp; udp&nbsp;&nbsp;&nbsp;
111&nbsp; portmapper
<BR>&nbsp;&nbsp;&nbsp; 100000&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp; tcp&nbsp;&nbsp;&nbsp;
111&nbsp; portmapper
<BR>&nbsp;&nbsp;&nbsp; 100000&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp; tcp&nbsp;&nbsp;&nbsp;
111&nbsp; portmapper
<BR>&nbsp;&nbsp;&nbsp; 100005&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp; tcp&nbsp;&nbsp;
1024&nbsp; mountd
<BR>&nbsp;&nbsp;&nbsp; 100005&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp; tcp&nbsp;&nbsp;
1024&nbsp; mountd
<BR>&nbsp;&nbsp;&nbsp; 100005&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp; udp&nbsp;&nbsp;
1027&nbsp; mountd
<BR>&nbsp;&nbsp;&nbsp; 100005&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp; udp&nbsp;&nbsp;
1027&nbsp; mountd
<BR>&nbsp;&nbsp;&nbsp; 100003&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp; udp&nbsp;&nbsp;
2049&nbsp; nfs
<BR>&nbsp;&nbsp;&nbsp; 100003&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp; udp&nbsp;&nbsp;
2049&nbsp; nfs
<BR>&nbsp;&nbsp;&nbsp; 100003&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp; tcp&nbsp;&nbsp;
2049&nbsp; nfs
<BR>&nbsp;&nbsp;&nbsp; 100003&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp; tcp&nbsp;&nbsp;
2049&nbsp; nfs
<BR>****
<BR>I know I have permissions problems but I'm not sure where. oh by the
way
<BR>/etc/exports:
<BR>/usr/src/sgi/installfs -anon=root,nohide,root=cygnus
<BR>&nbsp;

<P>any information you can give will be most appreciated.

<P>Thanks

<P>Al
<BR>&nbsp;
<PRE>--&nbsp;
********************************************
Albert Aumenta
Systems Support Engineer
Silicon Graphics Inc.
Phone 518-434-5886
e-mail aumenta@albany.sgi.com</PRE>
&nbsp;</HTML>
