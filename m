Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 09:19:56 +0000 (GMT)
Received: from web7903.mail.in.yahoo.com ([202.86.4.79]:10942 "HELO
	web7903.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037794AbXBVJTu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Feb 2007 09:19:50 +0000
Received: (qmail 34443 invoked by uid 60001); 22 Feb 2007 09:18:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=2bNMHyJH7qp38wz5WBPjMZuggn4Bi69QhuRVeEzPnQDVCl259Q1TCIJPZfCwafO68Rjc5smH+njOk12jAxzbq8c1pLj3pygpOjZ5sHHHQFyLW+n9vIj8nN409u063zuMetQcszHDcxYHEhoYI83bV6GWDqqCkPaxHB1hgXg9mKo=;
X-YMail-OSG: ferJ.F0VM1k6WKUtSXTi1LluqKtceHsN.tFBDlS_WB6NMp9PW9zPw5jsR.2yKxinLfyE6oOOf5GvxTqe.1HBtUMlxA4hEpfmhBVlMOoqSEjnnu57p.LRux_8ANfVFzsFYOMvDwfHtYAkxsuBVf43io6SDg--
Received: from [61.246.223.98] by web7903.mail.in.yahoo.com via HTTP; Thu, 22 Feb 2007 09:18:44 GMT
Date:	Thu, 22 Feb 2007 09:18:44 +0000 (GMT)
From:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Subject: Re: unaligned access
To:	Rajat Jain <rajat.noida.india@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <b115cb5f0702212353g4ee61a29ue0bd2636c811f297@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1274502747-1172135924=:32924"
Content-Transfer-Encoding: 8bit
Message-ID: <80178.32924.qm@web7903.mail.in.yahoo.com>
Return-Path: <sathesh_edara2003@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sathesh_edara2003@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-1274502747-1172135924=:32924
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Rajan.
   
  In case of arm processor, the alignment trap behavior can be changed by simply echo a number into  /proc/sys/debug/alignment 
   
  bit             behavior when set
---             -----------------
  0               A user process performing an unaligned memory access
                will cause the kernel to print a message indicating
                process name, pid, pc, instruction, address, and the
                fault code.
  1               The kernel will attempt to fix up the user process
                performing the unaligned access.  This is of course
                slow (think about the floating point emulator) and
                not recommended for production use.
  2               The kernel will send a SIGBUS signal to the user process
                performing the unaligned access.

I would like to know  Is there similar type of implimentation avalilable for MIPS processor in linux-2.6.12 kernel to view or log the unaligned access addresses and corresponding processor ID.
   
  Regards,
  Sathesh
   
  
Rajat Jain <rajat.noida.india@gmail.com> wrote:
  On 2/22/07, sathesh babu wrote:
> Hi,
> I have ported linux-2.6.12 kernel on MIPS processor.I would like to
> print the warning messges whenenver kernel or user code try to access
> unaligned address ( including proceor ID ).
> Is there any configuration option avaliable in the kernel to view
> the unaligned address?

Ummm ... not sure about MIPS, but in i386, exception 17 is raised for
every unaligned access. alignment_check() is invoked for every such
access.

Regards,

Rajat



 				
---------------------------------
 Here’s a new way to find what you're looking for - Yahoo! Answers 
--0-1274502747-1172135924=:32924
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Thanks Rajan.</div>  <div>&nbsp;</div>  <div>In case of arm processor, the alignment trap behavior can be changed by simply echo a number into &nbsp;/proc/sys/debug/alignment&nbsp;</div>  <div>&nbsp;</div>  <div>bit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; behavior when set<BR>---&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----------------</div>  <div>0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A user process performing an unaligned memory access<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; will cause the kernel to print a message indicating<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process name, pid, pc, instruction, address, and the<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fault code.</div> 
 <div>1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The kernel will attempt to fix up the user process<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; performing the unaligned access.&nbsp; This is of course<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; slow (think about the floating point emulator) and<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; not recommended for production use.</div>  <div>2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The kernel will send a SIGBUS signal to the user process<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; performing the unaligned access.<BR><BR>I would like to know&nbsp; Is there similar type of implimentation avalilable for MIPS processor in linux-2.6.12 kernel to view or
 log the unaligned access addresses and corresponding processor ID.</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Sathesh</div>  <div>&nbsp;</div>  <div><BR><B><I>Rajat Jain &lt;rajat.noida.india@gmail.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On 2/22/07, sathesh babu <SATHESH_EDARA2003@YAHOO.CO.IN>wrote:<BR>&gt; Hi,<BR>&gt; I have ported linux-2.6.12 kernel on MIPS processor.I would like to<BR>&gt; print the warning messges whenenver kernel or user code try to access<BR>&gt; unaligned address ( including proceor ID ).<BR>&gt; Is there any configuration option avaliable in the kernel to view<BR>&gt; the unaligned address?<BR><BR>Ummm ... not sure about MIPS, but in i386, exception 17 is raised for<BR>every unaligned access. alignment_check() is invoked for every such<BR>access.<BR><BR>Regards,<BR><BR>Rajat<BR><BR></BLOCKQUOTE><BR><p>&#32;
	

	
		<hr size=1></hr> 
Here’s a new way to find what you're looking for - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers</a> 
--0-1274502747-1172135924=:32924--
