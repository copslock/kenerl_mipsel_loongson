Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 19:44:46 +0100 (BST)
Received: from web10707.mail.yahoo.com ([IPv6:::ffff:216.136.130.215]:1340
	"HELO web10707.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225842AbUDWSop>; Fri, 23 Apr 2004 19:44:45 +0100
Message-ID: <20040423184441.36215.qmail@web10707.mail.yahoo.com>
Received: from [207.46.238.143] by web10707.mail.yahoo.com via HTTP; Fri, 23 Apr 2004 11:44:41 PDT
Date: Fri, 23 Apr 2004 11:44:41 -0700 (PDT)
From: santosh khare <santosh_khare2002@yahoo.com>
Subject: relocation overflow of type 4 __copy_user
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1118446702-1082745881=:36150"
Return-Path: <santosh_khare2002@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: santosh_khare2002@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1118446702-1082745881=:36150
Content-Type: text/plain; charset=us-ascii

Hi
When I am trying to insmod iptables.o I am getting this error multiple times.
 
relocation overflow of type 4 __copy_user
relocation overflow of type 4 __copy_user
relocation overflow of type 4 __copy_user
.........
 
I was getting similar errors for printk etc but they disappeared after I changed the CFLAGS  for arch/mips/Makefile and included -mno-abicalls.
 
Please let me know how can I get rid of this relocation overflow.
 
Looking at /proc/ksyms I see following.
 
#cat /proc/ksyms | grep __copy_user
802e0144 __copy_user
 
Santosh
 



		
---------------------------------
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
--0-1118446702-1082745881=:36150
Content-Type: text/html; charset=us-ascii

<DIV>Hi</DIV>
<DIV>When I am trying to insmod iptables.o I am getting this error multiple times.</DIV>
<DIV>&nbsp;</DIV>
<DIV>relocation overflow of type 4 __copy_user</DIV>
<DIV>
<DIV>relocation overflow of type 4 __copy_user</DIV>
<DIV>
<DIV>relocation overflow of type 4 __copy_user</DIV>
<DIV>.........</DIV>
<DIV>&nbsp;</DIV>
<DIV>I was getting similar errors for printk etc but they disappeared after I changed the CFLAGS&nbsp; for arch/mips/Makefile and included -mno-abicalls.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Please let me know how can I get rid of this relocation overflow.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Looking at /proc/ksyms I see following.</DIV>
<DIV>&nbsp;</DIV>
<DIV>#cat /proc/ksyms | grep __copy_user</DIV>
<DIV>802e0144 __copy_user</DIV>
<DIV>&nbsp;</DIV>
<DIV>Santosh</DIV>
<DIV>&nbsp;</DIV></DIV></DIV><p>
		<hr size=1><font face=arial size=-1>Do you Yahoo!?<br>
Yahoo! Photos: <a href="http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=23765/*http://photos.yahoo.c
om/ph/print_splash">High-quality 4x6 digital prints for 25¢</a>
--0-1118446702-1082745881=:36150--
