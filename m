Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jul 2004 22:08:51 +0100 (BST)
Received: from web50801.mail.yahoo.com ([IPv6:::ffff:206.190.38.110]:21903
	"HELO web50801.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224992AbUG3VIq>; Fri, 30 Jul 2004 22:08:46 +0100
Message-ID: <20040730210639.81429.qmail@web50801.mail.yahoo.com>
Received: from [65.204.143.11] by web50801.mail.yahoo.com via HTTP; Fri, 30 Jul 2004 14:06:39 PDT
Date: Fri, 30 Jul 2004 14:06:39 -0700 (PDT)
From: G H <giles67@yahoo.com>
Subject: Re: Strange, strange occurence
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1227787752-1091221599=:78382"
Return-Path: <giles67@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giles67@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1227787752-1091221599=:78382
Content-Type: text/plain; charset=us-ascii

Is the suggested patch below going to be added to CVS or is considered too experimental to add ?
 
>No and yes - but here is a simpler solution.  Below patch solves the
>problem and adds just 32 bytes of code but removes the special case for
>TX49/H2 entirely.

>  Ralf

> arch/mips/mm/c-r4k.c        |   59 
>-------------------------------------------- include/asm-mips/r4kcache.h |   18 
>++++++++-----
> include/asm-mips/war.h      |   14 ----------
> 3 files changed, 13 insertions(+), 78 deletions(-)
>
>
>Index: arch/mips/mm/c-r4k.c
>===================================================================
>RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
>retrieving revision 1.88
>diff -u -r1.88 c-r4k.c
>--- arch/mips/mm/c-r4k.c        16 Jul 2004 12:06:13 -0000      1.88
>+++ arch/mips/mm/c-r4k.c        16 Jul 2004 12:17:05 -0000
>@@ -96,16 +96,6 @@
>                r4k_blast_dcache = blast_dcache32;
> }


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1227787752-1091221599=:78382
Content-Type: text/html; charset=us-ascii

<DIV>Is the suggested patch below going to be added to CVS or is considered too experimental to add ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt;No and yes - but here is a simpler solution.&nbsp; Below patch solves the<BR>&gt;problem and adds just 32 bytes of code but removes the special case for<BR>&gt;TX49/H2 entirely.<BR><BR>&gt;&nbsp; Ralf<BR><BR>&gt; arch/mips/mm/c-r4k.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 59 <BR>&gt;-------------------------------------------- include/asm-mips/r4kcache.h |&nbsp;&nbsp; 18 <BR>&gt;++++++++-----<BR>&gt; include/asm-mips/war.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 14 ----------<BR>&gt; 3 files changed, 13 insertions(+), 78 deletions(-)<BR>&gt;<BR>&gt;<BR>&gt;Index: arch/mips/mm/c-r4k.c<BR>&gt;===================================================================<BR>&gt;RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v<BR>&gt;retrieving revision 1.88<BR>&gt;diff -u -r1.88 c-r4k.c<BR>&gt;--- arch/mips/mm/c-r4k.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 Jul 2004 12:06:13 -0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.88<BR>&gt;+++
 arch/mips/mm/c-r4k.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 Jul 2004 12:17:05 -0000<BR>&gt;@@ -96,16 +96,6 @@<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r4k_blast_dcache = blast_dcache32;<BR>&gt; }<BR></DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-1227787752-1091221599=:78382--
