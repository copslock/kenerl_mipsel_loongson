Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2004 21:16:54 +0100 (BST)
Received: from web50806.mail.yahoo.com ([IPv6:::ffff:206.190.38.115]:17751
	"HELO web50806.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225241AbUHEUQu>; Thu, 5 Aug 2004 21:16:50 +0100
Message-ID: <20040805201643.6422.qmail@web50806.mail.yahoo.com>
Received: from [65.204.143.11] by web50806.mail.yahoo.com via HTTP; Thu, 05 Aug 2004 13:16:43 PDT
Date: Thu, 5 Aug 2004 13:16:43 -0700 (PDT)
From: G H <giles67@yahoo.com>
Subject: Re: do_ri failure in cache flushing routines
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <411277BD.7070108@mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-470146373-1091737003=:5841"
Return-Path: <giles67@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giles67@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-470146373-1091737003=:5841
Content-Type: text/plain; charset=us-ascii

At the moment I don't have the board set up for using kgdb and it's complicated by the fact that we only have one serial console port. But I am looking into setting it up for kgdb now.
 
As far as stressing the system, it doesn't have enough resources ( disk space ) to be able to compile the kernel, but we did write a simple program that would stress the system by spawning multiple threads, each one performing floating point calculations. With this test, top reported a load average of over 400 and we have seen no failure so far.

Pete Popov <ppopov@mvista.com> wrote:
G H wrote:

> I've not had much response to this question so I would like to 
> rephrase it :
> 
> Can anyone think of any possible scenario where do_ri could occur in 
> blast_icache32() ??
> 
> Is this possibly a cache synchronisation problem ??
> 

Could be a hardware memory glitch. I would use kgdb to put a breakpoint 
there and see what the data in memory looks like when this happens -- 
look for memory corruption, etc.

Pete

> TIA
> 
> >While testing out an amd au1500 based board I have been getting " 
> do_ri " exceptions >that always occur in the cache flushing routines. 
> More often than not in >blast_icache_32().
> 
> >So far this has mainly happened after running the board for days on 
> end while running >multiple telnet sessions to it. It has sometimes ( 
> quite rarely ) happened after a few >hours to a day of multiple telnet 
> session use.
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam? Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
>


		
---------------------------------
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
--0-470146373-1091737003=:5841
Content-Type: text/html; charset=us-ascii

<DIV>At the moment I don't have the board set up for using kgdb and it's complicated by the fact that we only have one serial console port. But I am looking into setting it up for kgdb now.</DIV>
<DIV>&nbsp;</DIV>
<DIV>As far as stressing the system, it doesn't have enough resources ( disk space ) to be able to compile the kernel, but we did write a simple program that would stress the system by spawning multiple threads, each one performing floating point calculations. With this test, top reported a load average of over 400 and we&nbsp;have seen&nbsp;no&nbsp;failure so far.<BR><BR><B><I>Pete Popov &lt;ppopov@mvista.com&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">G H wrote:<BR><BR>&gt; I've not had much response to this question so I would like to <BR>&gt; rephrase it :<BR>&gt; <BR>&gt; Can anyone think of any possible scenario where do_ri could occur in <BR>&gt; blast_icache32() ??<BR>&gt; <BR>&gt; Is this possibly a cache synchronisation problem ??<BR>&gt; <BR><BR>Could be a hardware memory glitch. I would use kgdb to put a breakpoint <BR>there and see what the data in memory looks like when this happens -- <BR>look for memory corruption, etc.<BR><BR>Pete<BR><BR>&gt; TIA<BR>&gt; <BR>&gt; &gt;While testing out an amd au1500 based board I have been getting " <BR>&gt; do_ri " exceptions &gt;that always occur in the cache flushing routines. <BR>&gt; More often than not in &gt;blast_icache_32().<BR>&gt; <BR>&gt; &gt;So far this has mainly happened after running the board for days on <BR>&gt; end while running &gt;multiple telnet sessions to it.
 It has sometimes ( <BR>&gt; quite rarely ) happened after a few &gt;hours to a day of multiple telnet <BR>&gt; session use.<BR>&gt;<BR>&gt; __________________________________________________<BR>&gt; Do You Yahoo!?<BR>&gt; Tired of spam? Yahoo! Mail has the best spam protection around<BR>&gt; http://mail.yahoo.com<BR>&gt;<BR><BR></BLOCKQUOTE><p>
		<hr size=1>Do you Yahoo!?<br>
<a href="http://us.rd.yahoo.com/mail_us/taglines/aac/*http://promotions.yahoo.com/new_mail/static/ease.html">Yahoo! Mail Address AutoComplete</a> - You start. We finish.
--0-470146373-1091737003=:5841--
