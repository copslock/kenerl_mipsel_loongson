Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2004 19:04:39 +0100 (BST)
Received: from web50806.mail.yahoo.com ([IPv6:::ffff:206.190.38.115]:48532
	"HELO web50806.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224918AbUHESEe>; Thu, 5 Aug 2004 19:04:34 +0100
Message-ID: <20040805180427.59029.qmail@web50806.mail.yahoo.com>
Received: from [65.204.143.11] by web50806.mail.yahoo.com via HTTP; Thu, 05 Aug 2004 11:04:27 PDT
Date: Thu, 5 Aug 2004 11:04:27 -0700 (PDT)
From: G H <giles67@yahoo.com>
Subject: RE: do_ri failure in cache flushing routines
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-732148992-1091729067=:57330"
Return-Path: <giles67@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giles67@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-732148992-1091729067=:57330
Content-Type: text/plain; charset=us-ascii

I've not had much response to this question so I would like to rephrase it :
 
Can anyone think of any possible scenario where do_ri could occur in blast_icache32() ??
 
Is this possibly a cache synchronisation problem ??
 
TIA
 
>While testing out an amd au1500 based board I have been getting " do_ri " exceptions >that always occur in the cache flushing routines. More often than not in >blast_icache_32().
 
>So far this has mainly happened after running the board for days on end while running >multiple telnet sessions to it. It has sometimes ( quite rarely ) happened after a few >hours to a day of multiple telnet session use.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-732148992-1091729067=:57330
Content-Type: text/html; charset=us-ascii

<DIV>
<DIV>I've not had much response to this question so I would like to rephrase it :</DIV>
<DIV>&nbsp;</DIV>
<DIV>Can anyone think of any possible scenario where do_ri could occur in blast_icache32() ??</DIV>
<DIV>&nbsp;</DIV>
<DIV>Is this possibly a cache synchronisation problem ??</DIV>
<DIV>&nbsp;</DIV>
<DIV>TIA</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt;While testing out an amd au1500 based board I have been getting " do_ri "&nbsp;exceptions &gt;that always occur in the cache flushing routines. More often than not in &gt;blast_icache_32().</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt;So far this has mainly happened after&nbsp;running the board for days on end while running &gt;multiple telnet sessions to it. It has sometimes ( quite rarely ) happened after a few &gt;hours to a day of multiple telnet session use.</DIV></DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-732148992-1091729067=:57330--
