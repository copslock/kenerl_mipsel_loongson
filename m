Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 16:35:13 +0100 (BST)
Received: from web31912.mail.mud.yahoo.com ([68.142.207.92]:21893 "HELO
	web31912.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133768AbWC2PfE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Mar 2006 16:35:04 +0100
Received: (qmail 46530 invoked by uid 60001); 29 Mar 2006 15:45:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AHhwaiLSdn8szXJwEtSYckUeSCpeOASR1oxfDxuGMLRSXymfxexwBtGgDbOUQ15Rb6zQtQTCnK3HQmeVZC+r+9fZAOSt4wIX4382kYgVTL7S0pRdNu3ODPc62sRQRVuevZoucWXNB8gayzyrGwVH1uwmRqmK9qxRue8Uh5pU9nc=  ;
Message-ID: <20060329154531.46528.qmail@web31912.mail.mud.yahoo.com>
Received: from [129.188.33.221] by web31912.mail.mud.yahoo.com via HTTP; Wed, 29 Mar 2006 07:45:31 PST
Date:	Wed, 29 Mar 2006 07:45:31 -0800 (PST)
From:	Kumaraswamy Mudide <kumara_mudide@yahoo.com>
Subject: Re: gdb info threads with core files
To:	linux-mips@linux-mips.org
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060328223757.GB12609@nevyn.them.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-567865972-1143647131=:44340"
Content-Transfer-Encoding: 8bit
Return-Path: <kumara_mudide@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumara_mudide@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-567865972-1143647131=:44340
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Everyone,
   
       We are using 2.4.25and gdb 6.4 version. "info threads" with core file, it does always shows only one thread.
   
  Any ideas???
  

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
Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls.  Great rates starting at 1&cent;/min.
--0-567865972-1143647131=:44340
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Everyone,</div>  <div>&nbsp;</div>  <div>&nbsp;&nbsp; &nbsp;&nbsp;We are using 2.4.25and gdb 6.4 version. "info threads" with core file, it does always shows only one thread.</div>  <div>&nbsp;</div>  <div>Any ideas???</div>  <div><BR><BR><B><I>Daniel Jacobowitz &lt;dan@debian.org&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On Tue, Mar 28, 2006 at 02:28:35PM -0800, Kumaraswamy Mudide wrote:<BR>&gt; Hi Everyone,<BR>&gt; <BR>&gt; We are using linux 2.4.25 and gdb 6.4, info threads with the core files always shows only single thread. This threads is same as to which we have sent segv or abort signal. <BR>&gt; <BR>&gt; bt and info reg seems to be working fine. but not info threads.<BR>&gt; <BR>&gt; Any idea??<BR><BR>Then your kernel probably does not support multithreaded core dumping.<BR><BR>-- <BR>Daniel Jacobowitz<BR>CodeSourcery<BR></BLOCKQUOTE><BR><BR><BR>Thanks &amp;
 Regards,<br>Kumar<br>603-542-4834<p>
		<hr size=1>Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman7/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com"> Great rates starting at 1&cent;/min.
--0-567865972-1143647131=:44340--
