Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 08:31:20 +0100 (BST)
Received: from bay1-f148.bay1.hotmail.com ([IPv6:::ffff:65.54.245.148]:46095
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225195AbTEMHbR>; Tue, 13 May 2003 08:31:17 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Tue, 13 May 2003 00:31:07 -0700
Received: from 4.35.224.219 by by1fd.bay1.hotmail.msn.com with HTTP;
	Tue, 13 May 2003 07:31:07 GMT
X-Originating-IP: [4.35.224.219]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Tue, 13 May 2003 00:31:07 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F148TJjwW2RbV300012183@hotmail.com>
X-OriginalArrivalTime: 13 May 2003 07:31:07.0772 (UTC) FILETIME=[9E587BC0:01C31921]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

>MIPS_RedHat7.1_Release-02.00.tar from
>ftp://ftp.mips.com/pub/linux/mips/installation/redhat7.1/02.00
>

Thats not the right one. The right file for NFS root for mips is the one 
(nfsroot.mips.redhat7.1.eb-01.00.tar.gz) at 
ftp://ftp.mips.com/pub/linux/mips/rootfs_nfs/redhat7.1

I extracted it to my /export/... folder & Linux booted well on the Atlas 
board.

Question:
1. I could see some interactive configuration menus with buttons <'OK' , 
'Cancel' surrounded with a couple of dots>. As I press the tab key to 
navigate to a button, nothing gets highlighted or there isnt a means to know 
a particlar button got selected. Is there a special config in minicom to 
view these better? I even tried the First char of the string to enble it 
<like 'O' for "OK" button & 'C' for Cancel button & 'N' for Next button>, 
but did not work. Please let me know a better way for this.

2. I got this message at last & nothing seems to happen after which <But I 
see a lot of ethernet activity between the Atlas & the host>.

clipping of the messages from linux as seen on minicom:
-----------------------------------------------------------------------------
Starting keytable:  Loading keymap: /etc/rc3.d/S17keytable: /dev/tty0: No 
such e[FAILED]
Loading system font: [  OK  ]
[FAILED]
Initializing random number generator:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting automounter:[  OK  ]
Starting atd: [  OK  ]
Starting xinetd: [  OK  ]
Starting NFS file locking services:
Starting NFS lockd: lockdsvc: Function not implemented
[FAILED]
Starting NFS statd: [  OK  ]
Starting postfix: [  OK  ]
Starting crond: [  OK  ]
Starting anacron: [  OK  ]
.?...?..??..?.?..??..?..??.??.?    ???  ?.?  ?. ?  ?????.  ??  ?  ? ??? ? .? 
. ?

3. Did I miss some key configs during the 1st time setup menus? If so, How 
to revisite the linux config menus?

Please advice me. Also point me to relevant documentation. Mean while let me 
search for one...

Thanks,
-Mike.

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail
