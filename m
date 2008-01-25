Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jan 2008 16:50:35 +0000 (GMT)
Received: from outbound2.ucsd.edu ([132.239.1.206]:49384 "EHLO
	outbound2.ucsd.edu") by ftp.linux-mips.org with ESMTP
	id S28580387AbYAYQuZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Jan 2008 16:50:25 +0000
Received: from smtp.ucsd.edu (smtp.ucsd.edu [132.239.1.49])
	by outbound2.ucsd.edu (8.13.6/8.13.6) with ESMTP id m0PGoMV5056544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 25 Jan 2008 08:50:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; s=2007001; d=ucsd.edu; c=simple; q=dns;
	b=FCbiml47klKjrEbCwdIT6Y62rkKICnhI3xySIYWckfLEz4SY8PwNZVLFuiuVtzTdL
	bcjB3zgHbW56o4tJJmo9A==
Received: from wave.wire.home (adsl-75-36-52-211.dsl.sndg02.sbcglobal.net [75.36.52.211])
	(authenticated bits=0)
	by smtp.ucsd.edu (8.13.6/8.13.6) with ESMTP id m0PGoL6T017834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jan 2008 08:50:22 -0800 (PST)
X-Authentication-Warning: smtp.ucsd.edu: Host adsl-75-36-52-211.dsl.sndg02.sbcglobal.net [75.36.52.211] claimed to be wave.wire.home
Message-ID: <479A134D.7090206@ucsd.edu>
Date:	Fri, 25 Jan 2008 08:50:21 -0800
From:	Max Okumoto <okumoto@ucsd.edu>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
Content-Type: multipart/alternative;
 boundary="------------050509010606030400050101"
Return-Path: <okumoto@ucsd.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: okumoto@ucsd.edu
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050509010606030400050101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a JMR3927 based system and I got it to work with the 2.6.23.14 kernel, but
used 0xff0000 instead of 0xff000.  The offset passed in was 0xfffec000 which isn't
within the 0xff000000 - 0xff0ff000.

     Max 

    Subject: [MIPS] Fix plat_ioremap for JMR3927

    TX39XX's "reserved" segment in CKSEG3 area is 0xff000000-0xfffeffff.

    Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
    ---
    diff --git a/include/asm-mips/mach-jmr3927/ioremap.h
    b/include/asm-mips/mach-jmr3927/ioremap.h
    index aa131ad..ac3be35 100644
    --- a/include/asm-mips/mach-jmr3927/ioremap.h
    +++ b/include/asm-mips/mach-jmr3927/ioremap.h
    @@ -25,7 +25,7 @@ static inline void __iomem *plat_ioremap(phys_t
    offset,
    unsigned long size,
    {
    #define TXX9_DIRECTMAP_BASE 0xff000000ul
    if (offset >= TXX9_DIRECTMAP_BASE &&
    - offset < TXX9_DIRECTMAP_BASE + 0xf0000)
    + offset < TXX9_DIRECTMAP_BASE + 0xff000)
    return (void __iomem *)offset;
    return NULL;
    }


--------------050509010606030400050101
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<pre>Hi,

I have a JMR3927 based system and I got it to work with the 2.6.23.14 kernel, but
used 0xff0000 instead of 0xff000.  The offset passed in was 0xfffec000 which isn't
within the <tt>0xff000000 - </tt>0xff0ff000.

     Max 
</pre>
<blockquote><tt>Subject: [MIPS] Fix plat_ioremap for JMR3927<br>
  <br>
TX39XX's "reserved" segment in CKSEG3 area is 0xff000000-0xfffeffff.<br>
  <br>
Signed-off-by: Atsushi Nemoto <a class="moz-txt-link-rfc2396E" href="mailto:anemo@mba.ocn.ne.jp">&lt;anemo@mba.ocn.ne.jp&gt;</a><br>
---<br>
diff --git a/include/asm-mips/mach-jmr3927/ioremap.h <br>
b/include/asm-mips/mach-jmr3927/ioremap.h<br>
index aa131ad..ac3be35 100644<br>
--- a/include/asm-mips/mach-jmr3927/ioremap.h<br>
+++ b/include/asm-mips/mach-jmr3927/ioremap.h<br>
@@ -25,7 +25,7 @@ static inline void __iomem *plat_ioremap(phys_t
offset, <br>
unsigned long size,<br>
{<br>
#define TXX9_DIRECTMAP_BASE 0xff000000ul<br>
if (offset &gt;= TXX9_DIRECTMAP_BASE &amp;&amp;<br>
- offset &lt; TXX9_DIRECTMAP_BASE + 0xf0000)<br>
+ offset &lt; TXX9_DIRECTMAP_BASE + 0xff000)<br>
return (void __iomem *)offset;<br>
return NULL;<br>
}</tt><br>
</blockquote>
</body>
</html>

--------------050509010606030400050101--
