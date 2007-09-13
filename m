Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 08:00:32 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.179]:59182 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021444AbXIMHAY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 08:00:24 +0100
Received: by wa-out-1112.google.com with SMTP id m16so509248waf
        for <linux-mips@linux-mips.org>; Thu, 13 Sep 2007 00:00:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=Wd9Zj+bfdgKIMEQJWnCe6NZpFTpIbvSWujS/vkvbVSA=;
        b=QzbGNnEY3sSWe3ez0OmPRQWew9VaCFaab00SR2Z/gkW4pFplgMr1EQeLIhNF2vHRjr+xiW/rLpuuiD16RFQ60iTaysA50FEtchsEGhvlrJWnAVmds0IzjchaqVChjReX9+a38aHmpbxaMwcpMO8p5lPPDwlCLXUiMMH3AO43fac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Rrjbv7U7V4TtrLU+KA1Ye/4O5BHb5NUBZE5H44kB4C/5KQK1l++zr9F7lvs772gNGHwMhH+4Fc3zVOnLf1lqjHJQzOLICioGzmN9wv4JxSS/CVZlNiOYf48rWcMsFh/pbHwXDBZylzgoFFRBzL4oXPhdq0VEc6VHMPjc7+lcMsA=
Received: by 10.114.193.1 with SMTP id q1mr322438waf.1189666811944;
        Thu, 13 Sep 2007 00:00:11 -0700 (PDT)
Received: by 10.114.166.4 with HTTP; Thu, 13 Sep 2007 00:00:06 -0700 (PDT)
Message-ID: <50c9a2250709130000l9e463e3v17e0954424abb4f9@mail.gmail.com>
Date:	Thu, 13 Sep 2007 15:00:06 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: does the SAVE_ALL nesting in kernel?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <00b301c7f51c$f0709d30$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4141_30128833.1189666806938"
References: <50c9a2250709111921g1b49cb0du7f97ebb3e1fb7d07@mail.gmail.com>
	 <00b301c7f51c$f0709d30$10eca8c0@grendel>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_4141_30128833.1189666806938
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 9/12/07, Kevin D. Kissell <kevink@mips.com> wrote:
>
>  SAVE_ALL can certainly nest in MIPS Linux.  This is why there's a check
> at the beginning of SAVE_SOME to determine whether the exception was take in
> user-mode, to see if the kernel stackpointer should be loaded from memory or
> computed relative to the current stack frame.   Another thing to keep in
> mind in looking at these sorts of optimizations is that each scheduling
> thread has its own kernel stack area. So if you're very very motivated, you
> could conceivably come up with a hack whereby the first level of exceptions
> uses your internal RAM array for a stack, but nested ones use external
> memory, *but*, you'd at least need room for as many first-level stack frames
> in your internal RAM as you have concurrent processes/threads in the system,
> or you'd need to mutilate the context switch code to copy the first level
> stack frames in and out of external memory on a context switch.  I don't
> think that's a good path to go down.
>

thanks for your advice, i  think a hack whereby the first level of
exceptions maybe is easy to modify.i will try it


If you have functioning caches, they won't be as perfect as a scratchpad,
> but you won't have all the additional context switch overhead, and they will
> automagically do approximately what you want, without your having to change
> any code.
>
>             Kevin K.
>
> ----- Original Message -----
> *From:* zhuzhenhua <zzh.hust@gmail.com>
> *To:* linux-mips <linux-mips@linux-mips.org>
> *Sent:* Wednesday, September 12, 2007 4:21 AM
> *Subject:* does the SAVE_ALL nesting in kernel?
>
> hello, all
>             i have a mips board,  and the SDRAM speed(bus clock) is not
> too fast.
>              so i want change  the SAVE_ALL and RESTORE_ALL to use
> internal-ram(high speed).
>             i just wonder whether the SAVE_ALL netsting in kernel  for
> mips arch?
>             if not, i think  maybe 1k byte for SAVE_ALL is enough( 32regs
> X4, and some cp0_regs).
>             but if  the SAVE_ALL nesting, maybe i need to keep a stack in
> internal-ram.
>             thanks for any hints．
>
> Best Regards
>
> --
> zzh
>
>

------=_Part_4141_30128833.1189666806938
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 9/12/07, <b class="gmail_sendername">Kevin D. Kissell</b> &lt;<a href="mailto:kevink@mips.com">kevink@mips.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">






<div bgcolor="#ffffff">
<div><font face="Arial" size="2">SAVE_ALL can certainly nest in MIPS Linux.&nbsp; 
This is why there&#39;s a check at the beginning of SAVE_SOME to determine whether 
the exception was take in user-mode, to see if the kernel stackpointer should be 
loaded from memory or computed relative to the current stack 
frame.&nbsp;&nbsp;&nbsp;Another thing to keep in mind in looking at these sorts 
of optimizations is that each scheduling thread has its own kernel stack area. 
So if you&#39;re very very motivated, you could conceivably come up with a hack 
whereby the first level&nbsp;of exceptions uses your internal RAM array for a 
stack, but nested ones use external memory, *but*, you&#39;d at least need room for 
as many first-level stack frames in your internal RAM&nbsp;as you have 
concurrent processes/threads in the system, or you&#39;d need to mutilate the 
context switch code to copy the first level stack frames in and out of external 
memory on a context switch.&nbsp; I don&#39;t think&nbsp;that&#39;s</font><font face="Arial" size="2">&nbsp;a good path to go down.</font></div></div></blockquote><div><br>
thanks for your advice, i&nbsp; think <font face="Arial" size="2">a hack 
whereby the first level&nbsp;of exceptions maybe is easy to modify.i will try it</font><br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div bgcolor="#ffffff"><div><font face="Arial" size="2">If you have functioning caches, they won&#39;t be as 
perfect as a scratchpad, but you&nbsp;won&#39;t have all the additional context 
switch overhead, and they will automagically do&nbsp;approximately what you 
want, without your having to change any code.</font></div>
<div><font face="Arial" size="2"></font>&nbsp;</div>
<div><font face="Arial" size="2">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; Kevin K.</font></div><div><span class="e" id="q_114f8fd0cd17ce14_1">
<blockquote style="border-left: 2px solid rgb(0, 0, 0); padding-right: 0px; padding-left: 5px; margin-left: 5px; margin-right: 0px;">
  <div style="font-family: arial; font-style: normal; font-variant: normal; font-weight: normal; font-size: 10pt; line-height: normal; font-size-adjust: none; font-stretch: normal;">----- Original Message ----- </div>
  <div style="background: rgb(228, 228, 228) none repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; font-family: arial; font-style: normal; font-variant: normal; font-weight: normal; font-size: 10pt; line-height: normal; font-size-adjust: none; font-stretch: normal;">
<b>From:</b> 
  <a title="zzh.hust@gmail.com" href="mailto:zzh.hust@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">zhuzhenhua</a> 
  </div>
  <div style="font-family: arial; font-style: normal; font-variant: normal; font-weight: normal; font-size: 10pt; line-height: normal; font-size-adjust: none; font-stretch: normal;"><b>To:</b> <a title="linux-mips@linux-mips.org" href="mailto:linux-mips@linux-mips.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
linux-mips</a> </div>
  <div style="font-family: arial; font-style: normal; font-variant: normal; font-weight: normal; font-size: 10pt; line-height: normal; font-size-adjust: none; font-stretch: normal;"><b>Sent:</b> Wednesday, September 12, 2007 4:21 
  AM</div>
  <div style="font-family: arial; font-style: normal; font-variant: normal; font-weight: normal; font-size: 10pt; line-height: normal; font-size-adjust: none; font-stretch: normal;"><b>Subject:</b> does the SAVE_ALL nesting in 
  kernel?</div>
  <div><br></div>hello, 
  all<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i 
  have a mips board,&nbsp; and the SDRAM speed(bus clock) is not too 
  fast.<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; so i want 
  change&nbsp; the SAVE_ALL and RESTORE_ALL to use internal-ram(high 
  speed).<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  i just wonder whether the SAVE_ALL netsting in kernel&nbsp; for mips 
  arch?<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if not, i think&nbsp; maybe 
  1k byte for SAVE_ALL is enough( 32regs X4, and some cp0_regs).<br>&nbsp; 
  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; but if&nbsp; the SAVE_ALL nesting, maybe i 
  need to keep a stack in 
  internal-ram.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  thanks for any hints．<br><br>Best 
Regards<br><br>--<br>zzh<br><br></blockquote></span></div></div>
</blockquote></div><br>

------=_Part_4141_30128833.1189666806938--
