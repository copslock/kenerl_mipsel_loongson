Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2006 06:12:24 +0100 (BST)
Received: from web38404.mail.mud.yahoo.com ([209.191.125.35]:2403 "HELO
	web38404.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133503AbWDTFMN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Apr 2006 06:12:13 +0100
Received: (qmail 38879 invoked by uid 60001); 20 Apr 2006 05:24:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=s53VdCeKd+P0qoBqBVGFmxVJeLKLhJcCdZ3TIWdxBU/mgKVJ872dp8neMKBL+tfEt9xz6rSnH9im1WeeBYFyf+lAGm6j0UJOfiNvSUZjHEJV8jdCpTyoPpp/phyd1H/AeB9Pu/7+GMl65gcd5aCLURvy9FhzGA+eR9Osu41tlFE=  ;
Message-ID: <20060420052447.38877.qmail@web38404.mail.mud.yahoo.com>
Received: from [203.92.57.132] by web38404.mail.mud.yahoo.com via HTTP; Wed, 19 Apr 2006 22:24:47 PDT
Date:	Wed, 19 Apr 2006 22:24:47 -0700 (PDT)
From:	ashley jones <ashley_jones_2000@yahoo.com>
Subject: Re: single step on sibyte board
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20060419152228.GA14058@nevyn.them.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1368257701-1145510687=:37781"
Content-Transfer-Encoding: 8bit
Return-Path: <ashley_jones_2000@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashley_jones_2000@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1368257701-1145510687=:37781
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi daniel,
            it works now, host gdb was not properly configured. thanks for your help.
   
  Thanks n Regards,
  A'Jones.
  

Daniel Jacobowitz <dan@debian.org> wrote:
  On Tue, Apr 18, 2006 at 10:25:06PM -0700, ashley jones wrote:
> But i am able to setup initial connection, and also first
> breakpoint gets hit. Is it like gdbserver (for mips) doesnt support
> single step command? or is it like i have not configured gdb
> properly ? I have downloaded fresh gdb-6.4 src, and ran "configure"
> scripts on my target (sibyte). Am i missing anything ?

How did you configure your host gdb?

Use mips-linux or mips64-linux and it will not attempt to single step.

-- 
Daniel Jacobowitz
CodeSourcery



		
---------------------------------
Yahoo! Messenger with Voice. Make PC-to-Phone Calls to the US (and 30+ countries) for 2¢/min or less.
--0-1368257701-1145510687=:37781
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>hi daniel,</div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; it works now, host gdb was not properly configured. thanks for your help.</div>  <div>&nbsp;</div>  <div>Thanks n Regards,</div>  <div>A'Jones.</div>  <div><BR><BR><B><I>Daniel Jacobowitz &lt;dan@debian.org&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On Tue, Apr 18, 2006 at 10:25:06PM -0700, ashley jones wrote:<BR>&gt; But i am able to setup initial connection, and also first<BR>&gt; breakpoint gets hit. Is it like gdbserver (for mips) doesnt support<BR>&gt; single step command? or is it like i have not configured gdb<BR>&gt; properly ? I have downloaded fresh gdb-6.4 src, and ran "configure"<BR>&gt; scripts on my target (sibyte). Am i missing anything ?<BR><BR>How did you configure your host gdb?<BR><BR>Use mips-linux or mips64-linux and it will not attempt to single step.<BR><BR>-- <BR>Daniel
 Jacobowitz<BR>CodeSourcery<BR><BR></BLOCKQUOTE><BR><p>
		<hr size=1>Yahoo! Messenger with Voice. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman1/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com">Make PC-to-Phone Calls</a> to the US (and 30+ countries) for 2¢/min or less.
--0-1368257701-1145510687=:37781--
