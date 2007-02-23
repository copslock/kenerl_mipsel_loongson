Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 09:49:52 +0000 (GMT)
Received: from web7914.mail.in.yahoo.com ([202.86.4.90]:14739 "HELO
	web7914.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037707AbXBWJtr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 09:49:47 +0000
Received: (qmail 89556 invoked by uid 60001); 23 Feb 2007 09:48:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=n6RjLV+82WGXCwqqjudRDHRPudETAKusK09k1MRNnSfk0fK841s/nRjFzqQp6QzC9z0A2kcxw5FuyCcB+o4FP7nqZoFZBZP7ALOrpszPs7LM/chWKlcZyfxsg2jMd+7cGZ4GRnew/AH90CNxYFhai5UuEwAfH9zS2sBD3C9bm3U=;
X-YMail-OSG: be7womkVM1ncZ5y.BN6Q9QCOh_GkYYTfKbq8S_YC.7jYJe9wMUWtFVwhANbtGGJqjOIFs7bRHeG2x1EXXjjsNAsFf6ljgr.wzOA__c7XntutQYdQRtAQZwq85RKVbwlG5uZdYz2J5tT8cIPUqzlsKQ--
Received: from [61.246.223.98] by web7914.mail.in.yahoo.com via HTTP; Fri, 23 Feb 2007 09:48:38 GMT
Date:	Fri, 23 Feb 2007 09:48:38 +0000 (GMT)
From:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Subject: Re: unaligned access
To:	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>
Cc:	sathesh babu <sathesh_edara2003@yahoo.co.in>,
	Rajat Jain <rajat.noida.india@gmail.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20070223030645.GA1349@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1192634343-1172224118=:88566"
Content-Transfer-Encoding: 8bit
Message-ID: <623154.88566.qm@web7914.mail.in.yahoo.com>
Return-Path: <sathesh_edara2003@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sathesh_edara2003@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-1192634343-1172224118=:88566
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

It would be good idea to know which process hitting unaligned access and PC.
  So that we can try to fix unaligned access when it causes the  performance bottleneck.
   
  Could you please share details about logging the unaligned accesses using sysctl.
   
  Thanks in advance
   
  Regards,
  Sathesh

Ralf Baechle <ralf@linux-mips.org> wrote:
  On Thu, Feb 22, 2007 at 04:06:57PM +0100, Kevin D. Kissell wrote:

> Default behavior in MIPS is to silently fix up and emulate. A MIPS-specific
> system call (sys_sysmips with the command argument of MIPS_FIXADE
> and a parameter agument of zero) allows for this to be overridden, so that 
> such accesses will be fatal. It looks as if there was once support to log the events 
> to syslog, independently of whether or not they were fixed up, but it doesn't look to me 
> as if that still works in 2.6.x kernels.

There used to be a configuration option to allow logging which was a
leftover from the times when I implemented the unaligned emulation. I
did never find it useful later on, so I removed that in almost 9 years
ago and nobody missed it since :-)

But I don't mind putting it back, controllable by sysctl if there is any
demand for it.

Ralf



 				
---------------------------------
 Here’s a new way to find what you're looking for - Yahoo! Answers 
--0-1192634343-1172224118=:88566
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>It would be good idea to know which process hitting unaligned access and PC.</div>  <div>So that we can try to fix unaligned access when it causes the &nbsp;performance bottleneck.</div>  <div>&nbsp;</div>  <div>Could you please share details about logging the unaligned accesses using sysctl.</div>  <div>&nbsp;</div>  <div>Thanks in advance</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Sathesh<BR><BR><B><I>Ralf Baechle &lt;ralf@linux-mips.org&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On Thu, Feb 22, 2007 at 04:06:57PM +0100, Kevin D. Kissell wrote:<BR><BR>&gt; Default behavior in MIPS is to silently fix up and emulate. A MIPS-specific<BR>&gt; system call (sys_sysmips with the command argument of MIPS_FIXADE<BR>&gt; and a parameter agument of zero) allows for this to be overridden, so that <BR>&gt; such accesses will be fatal. It looks as if there was once support to log the
 events <BR>&gt; to syslog, independently of whether or not they were fixed up, but it doesn't look to me <BR>&gt; as if that still works in 2.6.x kernels.<BR><BR>There used to be a configuration option to allow logging which was a<BR>leftover from the times when I implemented the unaligned emulation. I<BR>did never find it useful later on, so I removed that in almost 9 years<BR>ago and nobody missed it since :-)<BR><BR>But I don't mind putting it back, controllable by sysctl if there is any<BR>demand for it.<BR><BR>Ralf<BR><BR></BLOCKQUOTE><BR><p>&#32;
	

	
		<hr size=1></hr> 
Here’s a new way to find what you're looking for - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers</a> 
--0-1192634343-1172224118=:88566--
