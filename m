Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 23:45:57 +0100 (BST)
Received: from web31902.mail.mud.yahoo.com ([68.142.207.82]:30296 "HELO
	web31902.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133724AbWC1Wps (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Mar 2006 23:45:48 +0100
Received: (qmail 44046 invoked by uid 60001); 28 Mar 2006 22:56:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jOYHf4d0Z0PQAM90ytNAiQs/oSd9U9fXR/rYcdP5QhGMVanDFkMWckIhNmY0zWCJHSVclFoyuqNwmm5FSgkR6CUt7w2kIynNKIdv8hy0XIDgiSD4XNf57ia9EvL6SlELVCiuCCjulyX3x7HoC8xJbe7fbG5A+VR3pXfq6oh7kLc=  ;
Message-ID: <20060328225612.44044.qmail@web31902.mail.mud.yahoo.com>
Received: from [129.188.33.221] by web31902.mail.mud.yahoo.com via HTTP; Tue, 28 Mar 2006 14:56:11 PST
Date:	Tue, 28 Mar 2006 14:56:11 -0800 (PST)
From:	Kumaraswamy Mudide <kumara_mudide@yahoo.com>
Subject: Re: gdb info threads with core files
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060328223757.GB12609@nevyn.them.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-652826468-1143586571=:43718"
Content-Transfer-Encoding: 8bit
Return-Path: <kumara_mudide@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumara_mudide@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-652826468-1143586571=:43718
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Is there a way to make my kernel multithreads core dump. 
   
  However, when I run gdb program at the gdb prompt I can see various threads with info threads commands.
   
  I think something is missing in core files.
   
  Any adias???
                              

Daniel Jacobowitz <dan@debian.org> wrote:
  On Tue, Mar 28, 2006 at 02:28:35PM -0800, Kumaraswamy Mudide wrote:
> Hi Everyone,
> 
> We are using linux 2.4.25 and gdb 6.4, info threads with the core files always shows only single thread. This threads is same as to which we have sent segv or abort signal. 
> 
> bt and info reg seems to be working fine. but not info threads.
> 
> Any idea??

Then your kernel probably does not support multithreaded core dumping.

-- 
Daniel Jacobowitz
CodeSourcery



Thanks & Regards,
Kumar
603-542-4834
		
---------------------------------
New Yahoo! Messenger with Voice. Call regular phones from your PC for low, low rates.
--0-652826468-1143586571=:43718
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Is there a way to make my kernel multithreads core dump. </div>  <div>&nbsp;</div>  <div>However, when I run gdb program at the gdb prompt I can see various threads with info threads commands.</div>  <div>&nbsp;</div>  <div>I think something is missing in core files.</div>  <div>&nbsp;</div>  <div>Any adias???</div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR><BR><B><I>Daniel Jacobowitz &lt;dan@debian.org&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On Tue, Mar 28, 2006 at 02:28:35PM -0800, Kumaraswamy Mudide wrote:<BR>&gt; Hi Everyone,<BR>&gt; <BR>&gt; We are using linux 2.4.25 and gdb 6.4, info threads with the core files always shows only single thread. This threads is same as to which we have sent segv or abort signal. <BR>&gt; <BR>&gt; bt and info reg seems to be
 working fine. but not info threads.<BR>&gt; <BR>&gt; Any idea??<BR><BR>Then your kernel probably does not support multithreaded core dumping.<BR><BR>-- <BR>Daniel Jacobowitz<BR>CodeSourcery<BR></BLOCKQUOTE><BR><BR><BR>Thanks &amp; Regards,<br>Kumar<br>603-542-4834<p>
		<hr size=1>New <a href="http://us.rd.yahoo.com/mail_us/taglines/postman4/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com">Yahoo! Messenger with Voice.</a> Call regular phones from your PC for low, low rates.
--0-652826468-1143586571=:43718--
