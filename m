Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 23:19:45 +0100 (BST)
Received: from web14503.mail.yahoo.com ([IPv6:::ffff:216.136.224.66]:27149
	"HELO web14503.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225278AbTDOWTh>; Tue, 15 Apr 2003 23:19:37 +0100
Message-ID: <20030415221914.47873.qmail@web14503.mail.yahoo.com>
Received: from [209.243.184.191] by web14503.mail.yahoo.com via HTTP; Tue, 15 Apr 2003 15:19:14 PDT
Date: Tue, 15 Apr 2003 15:19:14 -0700 (PDT)
From: Steve Taylor <godzilla1357@yahoo.com>
Subject: Basic cache questions
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1972951073-1050445154=:47718"
Return-Path: <godzilla1357@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: godzilla1357@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1972951073-1050445154=:47718
Content-Type: text/plain; charset=us-ascii

Hello All,   I am hoping some of you mips-linux gurus will be able to help me give me some tips and help me get started on some cache stuff which I want to do. (I know decently well about caches - but only at a theoretical Hennessy & Patterson level - and have just started looking under arch/mips/mm to familiarize myself with the mips-linux implementation).   Here's what I want to do - I have a CPU with 4 way SA I and D caches, and I want to write a module that will lock a certain memory region in these caches (for example, let's say I want to lock the ISR in the I-cache). So my questions are a) Is the kernel going to crash if I try to mess around with the caches like locking out a particular way of the cache or something like that? b) I'm sure there are many issues and complications involved in this that I probably havent even thought of  - any obvious and/or subtle pitfalls? and c) Do you think locking out, say, an entire way of a 4-way cache for a dedicated frequently used routine improves or degrades overall system performance?   TIA, -Steve.


---------------------------------
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
--0-1972951073-1050445154=:47718
Content-Type: text/html; charset=us-ascii

<DIV>Hello All,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; I am hoping some of you mips-linux gurus will be able to help me give me some tips and help me get started on some cache stuff which&nbsp;I want to do. (I know decently well about caches - but only at a theoretical Hennessy &amp; Patterson level - and have just started looking under arch/mips/mm to familiarize myself with the mips-linux implementation).</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; Here's what I want to do - I have a CPU with 4 way SA I and D caches, and I want to write a module that will lock a certain memory region in these caches (for example, let's say I want to lock the ISR in the I-cache). So my questions are a) Is the kernel going to crash if I try to mess around with the caches like locking out a particular way of the cache or something like that? b) I'm sure there are many issues and complications involved in this that&nbsp;I probably havent even thought of &nbsp;- any obvious and/or subtle pitfalls? and c) Do you think locking out, say, an entire way of a 4-way cache for a dedicated frequently used routine improves or degrades overall system performance?&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;TIA,</DIV>
<DIV>&nbsp;</DIV>
<DIV>-Steve.</DIV><p><br><hr size=1>Do you Yahoo!?<br>
<a href="http://us.rd.yahoo.com/search/mailsig/*http://search.yahoo.com">The New Yahoo! Search</a> - Faster. Easier. Bingo.
--0-1972951073-1050445154=:47718--
