Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 22:29:50 +0100 (BST)
Received: from web10702.mail.yahoo.com ([IPv6:::ffff:216.136.130.210]:64701
	"HELO web10702.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225934AbUDWV3t>; Fri, 23 Apr 2004 22:29:49 +0100
Message-ID: <20040423212946.48261.qmail@web10702.mail.yahoo.com>
Received: from [207.46.238.133] by web10702.mail.yahoo.com via HTTP; Fri, 23 Apr 2004 14:29:46 PDT
Date: Fri, 23 Apr 2004 14:29:46 -0700 (PDT)
From: santosh khare <santosh_khare2002@yahoo.com>
Subject: Re: relocation overflow of type 4 __copy_user
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1446260502-1082755786=:47980"
Return-Path: <santosh_khare2002@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: santosh_khare2002@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1446260502-1082755786=:47980
Content-Type: text/plain; charset=us-ascii



I have changed 
CONFIG_IP_TABLES=y to 
CONFIG_IP_TABLES=m
 in .config file.
make modules now building ip_tables.o and I do not have this error any more.
Although, executing iptables utility is giving following error.
 
ip_tables: applet not found
can't initialize iptables table 'filter': table does not exist
perhaps iptables or your kernel needs to be upgraded.
 
Any ideas?
 
Santosh


"Steven J. Hill" <sjhill@realitydiluted.com> wrote:
santosh khare wrote:
>
> When I am trying to insmod iptables.o I am getting this error multiple 
> times.
> 
> relocation overflow of type 4 __copy_user
> relocation overflow of type 4 __copy_user
> relocation overflow of type 4 __copy_user
> .........
> 
> I was getting similar errors for printk etc but they disappeared after I 
> changed the CFLAGS for arch/mips/Makefile and included -mno-abicalls.
>
This flag is already included by default in both 2.4 and 2.6 kernels. How
did you compile your module?

-Steve

Santosh Khare
425 556 0845 (H)
425 241 3566 (C)

---------------------------------
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢


Santosh Khare
425 556 0845 (H)
425 241 3566 (C)
		
---------------------------------
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
--0-1446260502-1082755786=:47980
Content-Type: text/html; charset=us-ascii

<DIV><BR><BR>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">
<DIV>I have changed </DIV>
<DIV>CONFIG_IP_TABLES=y to </DIV>
<DIV>CONFIG_IP_TABLES=m</DIV>
<DIV>&nbsp;in .config file.</DIV>
<DIV>make modules now building ip_tables.o and I do not have this error any more.</DIV>
<DIV>Although, executing iptables utility is giving following error.</DIV>
<DIV>&nbsp;</DIV>
<DIV>ip_tables: applet not found</DIV>
<DIV>can't initialize iptables table 'filter': table does not exist</DIV>
<DIV>perhaps iptables or your kernel needs to be upgraded.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Any ideas?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Santosh</DIV>
<DIV><BR><BR><B><I>"Steven J. Hill" &lt;sjhill@realitydiluted.com&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">santosh khare wrote:<BR>&gt;<BR>&gt; When I am trying to insmod iptables.o I am getting this error multiple <BR>&gt; times.<BR>&gt; <BR>&gt; relocation overflow of type 4 __copy_user<BR>&gt; relocation overflow of type 4 __copy_user<BR>&gt; relocation overflow of type 4 __copy_user<BR>&gt; .........<BR>&gt; <BR>&gt; I was getting similar errors for printk etc but they disappeared after I <BR>&gt; changed the CFLAGS for arch/mips/Makefile and included -mno-abicalls.<BR>&gt;<BR>This flag is already included by default in both 2.4 and 2.6 kernels. How<BR>did you compile your module?<BR><BR>-Steve</BLOCKQUOTE><BR><BR>Santosh Khare<BR>425 556 0845 (H)<BR>425 241 3566 (C)
<P>
<HR SIZE=1>
<FONT face=arial size=-1>Do you Yahoo!?<BR>Yahoo! Photos: <A href="http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=23765/*http://photos.yahoo.com/ph/print_splash">High-quality 4x6 digital prints for 25¢</A></BLOCKQUOTE></DIV></FONT><BR><BR>Santosh Khare<br>425 556 0845 (H)<br>425 241 3566 (C)<p>
		<hr size=1><font face=arial size=-1>Do you Yahoo!?<br>
Yahoo! Photos: <a href="http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=23765/*http://photos.yahoo.c
om/ph/print_splash">High-quality 4x6 digital prints for 25¢</a>
--0-1446260502-1082755786=:47980--
