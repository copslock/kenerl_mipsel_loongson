Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 09:45:17 +0000 (GMT)
Received: from guri.is.scarlet.be ([IPv6:::ffff:193.74.71.22]:52942 "EHLO
	guri.is.scarlet.be") by linux-mips.org with ESMTP
	id <S8225275AbVANJpN> convert rfc822-to-8bit; Fri, 14 Jan 2005 09:45:13 +0000
Received: from (everest.is.scarlet.be [193.74.71.40]) 
	by guri.is.scarlet.be  with ESMTP id j0E9jCC17372 
	for <linux-mips@linux-mips.org>; 
	Fri, 14 Jan 2005 10:45:12 +0100
Date: Fri, 14 Jan 2005 10:45:13 +0100
Message-Id: <IAAWFD$4F98CCF16BF719954F68F4C74E574DDA@scarlet.be>
Subject: Re: unresolved (soft)float symbols
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "Philippe De Swert" <philippedeswert@scarlet.be>
Cc: "linux-mips" <linux-mips@linux-mips.org>
X-XaM3-API-Version: 4.1 (B54)
X-type: 0
X-SenderIP: 195.144.76.34
To: unlisted-recipients:; (no To-header on input)
Return-Path: <philippedeswert@scarlet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: <IAAWFD$4F98CCF16BF719954F68F4C74E574DDA
Envelope-Id: <IAAWFD$4F98CCF16BF719954F68F4C74E574DDA
X-archive-position: 6914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippedeswert@scarlet.be
Precedence: bulk
X-list: linux-mips

Oeps I forgot to ask. Would it help if I linked it in statically with the
-static-libgcc option. I suppose these symbols will then be hard-coded in the
module binary itself. Or am I very wrong here...

Thanks,

Philippe
 
| Philippe De Swert    
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
