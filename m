Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 12:41:54 +0000 (GMT)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:5347 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8225220AbULIMlt>;
	Thu, 9 Dec 2004 12:41:49 +0000
Received: from dlep91.itg.ti.com ([157.170.152.55])
	by go4.ext.ti.com (8.13.1/8.13.1) with ESMTP id iB9Cfctp007641;
	Thu, 9 Dec 2004 06:41:38 -0600 (CST)
Received: from DILE2K01.ent.ti.com (localhost [127.0.0.1])
	by dlep91.itg.ti.com (8.12.11/8.12.11) with ESMTP id iB9CfajP015756;
	Thu, 9 Dec 2004 06:41:37 -0600 (CST)
Received: from [137.167.5.34] ([137.167.5.34]) by DILE2K01.ent.ti.com with Microsoft SMTPSVC(5.0.2195.6747);
	 Thu, 9 Dec 2004 14:41:35 +0200
Message-ID: <41B847FF.5080309@ti.com>
Date: Thu, 09 Dec 2004 14:41:35 +0200
From: Alexander Sirotkin <demiurg@ti.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Philippe De Swert <philippedeswert@scarlet.be>
CC: linux-mips <linux-mips@linux-mips.org>
Subject: Re: o32_ret_from_sys_call
References: <I8GFGZ$181DD12A3DE3065A4DBC5982EAE9EA84@scarlet.be>
In-Reply-To: <I8GFGZ$181DD12A3DE3065A4DBC5982EAE9EA84@scarlet.be>
Content-Type: multipart/alternative;
 boundary="------------090202080702090509010500"
X-OriginalArrivalTime: 09 Dec 2004 12:41:35.0976 (UTC) FILETIME=[6B8ED680:01C4DDEC]
Return-Path: <demiurg@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiurg@ti.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090202080702090509010500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

I do work with montavista kernel, but regarding this particular change - 
I can see it in all kernels
(montavista, kernel.org and linux-mips). In kernel.org this change 
happened between 2.4.18 and
2.4.19, don't know when exatcly it was introduced into other kernels.

10x.


Philippe De Swert wrote:

>Hi Alexander,
>
>Do you happen to work with a clean kernel or a montavista one?
>Montavista made a lot of changes which do not necessarely reflect in the
>normal kernel code (especially on irq, pre-emptiveness and PCI)
>
>  
>
>>I have noticed that somewhere around 2.4.17 sys_sysmips() function from 
>>sysmips.c
>>was rewritten and call to o32_ret_from_sys_call disappear. This function 
>>(o32_ret_from_sys_call)
>>was responsible for calling do_softirq() after each system call. I'm 
>>curious, what is the
>>current mechanism in mips 2.4.x that ensures that do_softirq is called 
>>after system call ?
>>    
>>
>
>regards,
>
>Philippe
> 
>| Philippe De Swert -GNU/linux - uClinux freak-      
>|      
>| Stag developer http://stag.mind.be/  
>| Emdebian developer: http://www.emdebian.org  
>|   
>| Please do not send me documents in a closed format. (*.doc,*.xls,*.ppt)    
>| Use the open alternatives. (*.pdf,*.ps,*.html,*.txt)    
>| Why? http://pallieter.is-a-geek.org:7832/~johan/word/english/    
>
>-------------------------------------------------------
>NOTE! My email address is changing to ... @scarlet.be
>Please make the necessary changes in your address book. 
>
>
>
>  
>

-- 
Alexander Sirotkin
SW Engineer

Texas Instruments
Broadband Communications Israel (BCIL)
Tel:  +972-9-9706587
________________________________________________________________________
"Those who do not understand Unix are condemned to reinvent it, poorly."
      -- Henry Spencer 


--------------090202080702090509010500
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi.<br>
<br>
I do work with montavista kernel, but regarding this particular change
- I can see it in all kernels <br>
(montavista, kernel.org and linux-mips). In kernel.org this change
happened between 2.4.18 and<br>
2.4.19, don't know when exatcly it was introduced into other kernels.<br>
<br>
10x.<br>
<br>
<br>
Philippe De Swert wrote:
<blockquote cite="midI8GFGZ$181DD12A3DE3065A4DBC5982EAE9EA84@scarlet.be"
 type="cite">
  <pre wrap="">Hi Alexander,

Do you happen to work with a clean kernel or a montavista one?
Montavista made a lot of changes which do not necessarely reflect in the
normal kernel code (especially on irq, pre-emptiveness and PCI)

  </pre>
  <blockquote type="cite">
    <pre wrap="">I have noticed that somewhere around 2.4.17 sys_sysmips() function from 
sysmips.c
was rewritten and call to o32_ret_from_sys_call disappear. This function 
(o32_ret_from_sys_call)
was responsible for calling do_softirq() after each system call. I'm 
curious, what is the
current mechanism in mips 2.4.x that ensures that do_softirq is called 
after system call ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
regards,

Philippe
 
| Philippe De Swert -GNU/linux - uClinux freak-      
|      
| Stag developer <a class="moz-txt-link-freetext" href="http://stag.mind.be/">http://stag.mind.be/</a>  
| Emdebian developer: <a class="moz-txt-link-freetext" href="http://www.emdebian.org">http://www.emdebian.org</a>  
|   
| Please do not send me documents in a closed format. (*.doc,*.xls,*.ppt)    
| Use the open alternatives. (*.pdf,*.ps,*.html,*.txt)    
| Why? <a class="moz-txt-link-freetext" href="http://pallieter.is-a-geek.org:7832/~johan/word/english/">http://pallieter.is-a-geek.org:7832/~johan/word/english/</a>    

-------------------------------------------------------
NOTE! My email address is changing to ... @scarlet.be
Please make the necessary changes in your address book. 



  </pre>
</blockquote>
<br>
<pre class="moz-signature" cols="72">-- 
Alexander Sirotkin
SW Engineer

Texas Instruments
Broadband Communications Israel (BCIL)
Tel:  +972-9-9706587
________________________________________________________________________
"Those who do not understand Unix are condemned to reinvent it, poorly."
      -- Henry Spencer 
</pre>
</body>
</html>

--------------090202080702090509010500--
