Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Apr 2006 06:12:47 +0100 (BST)
Received: from web38415.mail.mud.yahoo.com ([209.191.125.46]:45912 "HELO
	web38415.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133443AbWDSFMh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Apr 2006 06:12:37 +0100
Received: (qmail 9666 invoked by uid 60001); 19 Apr 2006 05:25:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cykdPOz4JMahGx6WweuHMxxxtQcH+c1NjD+chlDc5TvrRwvkIvjq6CHLILpRBYVOrorLhzayj/5ZirsA5a9J/7h+1NyO7h0kaMxplIe3zVvCjM6v1HvA377P6n8L3mfpRPzpREtBZuJDGupEaIJpbBSBYAjOl4gC1fTQPtCFg3I=  ;
Message-ID: <20060419052506.9664.qmail@web38415.mail.mud.yahoo.com>
Received: from [203.92.57.132] by web38415.mail.mud.yahoo.com via HTTP; Tue, 18 Apr 2006 22:25:06 PDT
Date:	Tue, 18 Apr 2006 22:25:06 -0700 (PDT)
From:	ashley jones <ashley_jones_2000@yahoo.com>
Subject: Re: single step on sibyte board
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20060418200034.GA8200@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1888674231-1145424306=:5426"
Content-Transfer-Encoding: 8bit
Return-Path: <ashley_jones_2000@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashley_jones_2000@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1888674231-1145424306=:5426
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


hi ralf, 
          thanks for your reply,
  
Ralf Baechle <ralf@linux-mips.org> wrote:
    On Tue, Apr 18, 2006 at 09:14:04AM -0700, ashley jones wrote:

> I am trying to debug an application running on sibyte (linux 2.6.14) using gdbserver from AMD board. I am able to setup breakpoints and initial break point also gets hit, but when i do single step using "step" it prompts foll. error
> ptrace: Input/Output Error
> and board gets hang. is this supported or am doing some thing wrong ? can you please give some pointers from here ? I am using gdb-6.4 version on host (AMD) and target ( sibyte )

That looks like you may have a problem with the connection to your
target, so gdb can't really talk to the gdb server.

Ralf
  But i am able to setup initial connection, and also first breakpoint gets hit. Is it like gdbserver (for mips) doesnt support single step command? or is it like i have not configured gdb properly ? I have downloaded fresh gdb-6.4 src, and ran "configure" scripts on my target (sibyte). Am i missing anything ?
   
   
  Regards,
  A'Jones.


		
---------------------------------
Love cheap thrills? Enjoy PC-to-Phone  calls to 30+ countries for just 2¢/min with Yahoo! Messenger with Voice.
--0-1888674231-1145424306=:5426
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV><BR>hi ralf, </DIV>  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thanks for your&nbsp;reply,</DIV>  <DIV><BR><B><I>Ralf Baechle &lt;ralf@linux-mips.org&gt;</I></B> wrote:</DIV>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">  <DIV>On Tue, Apr 18, 2006 at 09:14:04AM -0700, ashley jones wrote:<BR><BR>&gt; I am trying to debug an application running on sibyte (linux 2.6.14) using gdbserver from AMD board. I am able to setup breakpoints and initial break point also gets hit, but when i do single step using "step" it prompts foll. error<BR>&gt; ptrace: Input/Output Error<BR>&gt; and board gets hang. is this supported or am doing some thing wrong ? can you please give some pointers from here ? I am using gdb-6.4 version on host (AMD) and target ( sibyte )<BR><BR>That looks like you may have a problem with the connection to your<BR>target, so gdb can't really talk to the gdb server.<BR><BR>Ralf</DIV></BLOCKQUOTE> 
 <DIV>But i am able to setup initial connection, and also first breakpoint gets hit. Is it like gdbserver (for mips) doesnt support single step command? or is it like i have not configured gdb properly ? I have downloaded fresh gdb-6.4 src, and ran "configure" scripts on my target (sibyte). Am i missing anything ?</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;</DIV>  <DIV>Regards,</DIV>  <DIV>A'Jones.<BR></DIV><p>
		<hr size=1>Love cheap thrills? Enjoy PC-to-Phone <a href="http://us.rd.yahoo.com/mail_us/taglines/postman9/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com/"> calls to 30+ countries</a> for just 2¢/min with Yahoo! Messenger with Voice.
--0-1888674231-1145424306=:5426--
