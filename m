Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 15:35:59 +0100 (BST)
Received: from web7913.mail.in.yahoo.com ([202.86.4.89]:56987 "HELO
	web7913.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20038873AbWJCOfw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Oct 2006 15:35:52 +0100
Received: (qmail 37397 invoked by uid 60001); 3 Oct 2006 14:35:45 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MY9tr2kuW6EfQZedwCAhtDSFt7DUQXuxVssnTZ1TzQvfbFdumxondJFp5ZVV01YwXahHsuBa+MgfCOKuJICDvYBNKTf2DHwlHCiZpCWFxEJ6C2zin49giS6ToJwKVYcxFY1HtPAii+xw9kkmaHlXZZrM+gZLyGjNTp0/0LmXjO0=  ;
Message-ID: <20061003143545.37395.qmail@web7913.mail.in.yahoo.com>
Received: from [61.246.223.98] by web7913.mail.in.yahoo.com via HTTP; Tue, 03 Oct 2006 15:35:44 BST
Date:	Tue, 3 Oct 2006 15:35:44 +0100 (BST)
From:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Subject: Re: linux-libc-headers-2.6.17
To:	Jim Gifford <maillist@jg555.com>, Jim Wilson <wilson@specifix.com>
Cc:	sathesh babu <sathesh_edara2003@yahoo.co.in>,
	linux-mips@linux-mips.org
In-Reply-To: <4512134B.40006@jg555.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1092621611-1159886144=:35963"
Content-Transfer-Encoding: 8bit
Return-Path: <sathesh_edara2003@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sathesh_edara2003@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-1092621611-1159886144=:35963
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Jim,
      
I have downloaded 2.6.18 sanitized headers from the following link which was suggested by you.
  http://ftp.jg555.com/headers 
   
  I am trying to build the toolchain for MIPS for linux-2.6.18 kernel using these headers and uClibc-0.9.28 and gcc-3.4.3.
  When i tried to compile busybox-1.00 i get the following error 
  "undefined reference to `getpageshift' ".
   
  Then i searched in the mailing list and found your article
  http://linuxfromscratch.org/pipermail/lfs-dev/2006-July/057591.html
   
  I added the following definition for getpageshift(), suggested in the above link in the asm-mips/page.h file
   
   Here is a santized version
> #define PAGE_SIZE       (getpagesize())
> static __inline__ int getpageshift()
> {
>     int pagesize = getpagesize();
>     return (__builtin_clz(pagesize) ^ 31);
> }

  I am not able to find definition for getpagesize().Can you please help me finding the definition for same. Is it in kernel or in userland?.
   
  BTW:
   
    I tried the same thing on Linux-2.6.17.13. I could build the toolchain by modifying the page.h as mentioned above. I could build the images for both Linux-2.6.17.13 and root file system for MIPS processor.But when i tried to execute any command pointing to busybox i was getting kernel crash.
   
  When i tried to debug this issue i found that "asm/page.h" file is included in some of the files in the busybox.
   
  Is this crash because of getpageshift() which is defined in asm-mips/page.h.?.
   
  What is the expected output of getpagesize()?.
   
  Could you advise a solution for this?.
   
   
  Regards,
  Sathesh
   
   
  
Jim Gifford <maillist@jg555.com> wrote:
  Jim Wilson wrote:
> I'd suggest looking at Dan Kegel's crosstool package, which provides
> scripts showing how to do a build from scratch. There is a pointer to
> it on the www.linux-mips.org wiki. See
> http://www.linux-mips.org/wiki/Toolchains
> 
Actually my Cross-LFS team has created a sanitation script to clean the 
headers, you can get the script from http://headers.cross-lfs.org, or 
you can download a bundle from http://ftp.jg555.com/headers




 				
---------------------------------
 Find out what India is talking about on  - Yahoo! Answers India 
 Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. Get it NOW
--0-1092621611-1159886144=:35963
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Jim,</div>  <div>&nbsp;&nbsp;&nbsp; <BR>I have downloaded 2.6.18 sanitized headers from the following link which was suggested by you.</div>  <div><A href="http://ftp.jg555.com/headers">http://ftp.jg555.com/headers</A> </div>  <div>&nbsp;</div>  <div>I am trying to build the toolchain for MIPS&nbsp;for linux-2.6.18 kernel using these headers and uClibc-0.9.28 and gcc-3.4.3.</div>  <div>When i tried to compile busybox-1.00 i get the following error </div>  <div>"undefined reference to `getpageshift' ".</div>  <div>&nbsp;</div>  <div>Then i searched in the mailing list and found your article</div>  <div><A href="http://linuxfromscratch.org/pipermail/lfs-dev/2006-July/057591.html">http://linuxfromscratch.org/pipermail/lfs-dev/2006-July/057591.html</A></div>  <div>&nbsp;</div>  <div>I added the following definition for getpageshift(), suggested in the above link in the asm-mips/page.h file</div>  <div>&nbsp;</div>  <div><EM>&nbsp;Here is a santized
 version<BR></EM>&gt;<I> #define PAGE_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (getpagesize())<BR></I>&gt;<I> static __inline__ int getpageshift()<BR></I>&gt;<I> {<BR></I>&gt;<I>&nbsp;&nbsp;&nbsp;&nbsp; int pagesize = getpagesize();<BR></I>&gt;<I>&nbsp;&nbsp;&nbsp;&nbsp; return (__builtin_clz(pagesize) ^ 31);<BR></I>&gt;<I> }<BR></I></div>  <div><I>I am not able to find definition for getpagesize().Can you please help me finding the definition for same. Is it in kernel or in userland?.</I></div>  <div><EM></EM>&nbsp;</div>  <div><EM>BTW:</EM></div>  <div><EM></EM>&nbsp;</div>  <div><EM>&nbsp; I tried the same thing on Linux-2.6.17.13. I could build the toolchain by modifying the page.h as mentioned above. I could build the images for both Linux-2.6.17.13 and root file system for MIPS processor.But when i tried to execute any command pointing to busybox i was getting kernel crash.</EM></div>  <div><EM></EM>&nbsp;</div>  <div><EM>When i tried to debug this issue i found that
 "asm/page.h" file is included in some of the files in the busybox.</EM></div>  <div><EM></EM>&nbsp;</div>  <div><EM>Is this crash because of getpageshift() which is defined in asm-mips/page.h.?.</EM></div>  <div><EM></EM>&nbsp;</div>  <div><EM>What is the expected output of getpagesize()?.</EM></div>  <div><EM></EM>&nbsp;</div>  <div><EM>Could you advise a solution for this?.</EM></div>  <div><EM></EM>&nbsp;</div>  <div><EM></EM>&nbsp;</div>  <div><EM>Regards,</EM></div>  <div><EM>Sathesh</EM></div>  <div><I></I>&nbsp;</div>  <div><I>&nbsp;</div></I>  <div><BR><B><I>Jim Gifford &lt;maillist@jg555.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Jim Wilson wrote:<BR>&gt; I'd suggest looking at Dan Kegel's crosstool package, which provides<BR>&gt; scripts showing how to do a build from scratch. There is a pointer to<BR>&gt; it on the www.linux-mips.org wiki. See<BR>&gt;
 http://www.linux-mips.org/wiki/Toolchains<BR>&gt; <BR>Actually my Cross-LFS team has created a sanitation script to clean the <BR>headers, you can get the script from http://headers.cross-lfs.org, or <BR>you can download a bundle from http://ftp.jg555.com/headers<BR><BR><BR></BLOCKQUOTE><BR><p>&#32;
	

	
		<hr size=1></hr> 
Find out what India is talking about on  - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers India</a> <BR> 
Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. <a href="http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com">Get it NOW</a>
--0-1092621611-1159886144=:35963--
