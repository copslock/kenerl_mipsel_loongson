Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 12:17:37 +0000 (GMT)
Received: from oola.is.scarlet.be ([IPv6:::ffff:193.74.71.23]:26025 "EHLO
	oola.is.scarlet.be") by linux-mips.org with ESMTP
	id <S8225220AbULIMRc> convert rfc822-to-8bit; Thu, 9 Dec 2004 12:17:32 +0000
Received: from (fuji.is.scarlet.be [193.74.71.41]) 
	by oola.is.scarlet.be  with ESMTP id iB9CHNT15470; 
	Thu, 9 Dec 2004 13:17:23 +0100
Date: Thu,  9 Dec 2004 13:17:23 +0100
Message-Id: <I8GFGZ$181DD12A3DE3065A4DBC5982EAE9EA84@scarlet.be>
Subject: Re:o32_ret_from_sys_call
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "Philippe De Swert" <philippedeswert@scarlet.be>
To: "demiurg" <demiurg@ti.com>
Cc: "linux-mips" <linux-mips@linux-mips.org>
X-XaM3-API-Version: 4.1 (B54)
X-type: 0
X-SenderIP: 195.144.76.35
Return-Path: <philippedeswert@scarlet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: <I8GFGZ$181DD12A3DE3065A4DBC5982EAE9EA84
Envelope-Id: <I8GFGZ$181DD12A3DE3065A4DBC5982EAE9EA84
X-archive-position: 6614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippedeswert@scarlet.be
Precedence: bulk
X-list: linux-mips

Hi Alexander,

Do you happen to work with a clean kernel or a montavista one?
Montavista made a lot of changes which do not necessarely reflect in the
normal kernel code (especially on irq, pre-emptiveness and PCI)

> I have noticed that somewhere around 2.4.17 sys_sysmips() function from 
> sysmips.c
> was rewritten and call to o32_ret_from_sys_call disappear. This function 
> (o32_ret_from_sys_call)
> was responsible for calling do_softirq() after each system call. I'm 
> curious, what is the
> current mechanism in mips 2.4.x that ensures that do_softirq is called 
> after system call ?

regards,

Philippe
 
| Philippe De Swert -GNU/linux - uClinux freak-      
|      
| Stag developer http://stag.mind.be/  
| Emdebian developer: http://www.emdebian.org  
|   
| Please do not send me documents in a closed format. (*.doc,*.xls,*.ppt)    
| Use the open alternatives. (*.pdf,*.ps,*.html,*.txt)    
| Why? http://pallieter.is-a-geek.org:7832/~johan/word/english/    

-------------------------------------------------------
NOTE! My email address is changing to ... @scarlet.be
Please make the necessary changes in your address book. 
