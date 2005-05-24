Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 16:47:55 +0100 (BST)
Received: from xizor.is.scarlet.be ([IPv6:::ffff:193.74.71.21]:59792 "EHLO
	xizor.is.scarlet.be") by linux-mips.org with ESMTP
	id <S8225291AbVEXPrh> convert rfc822-to-8bit; Tue, 24 May 2005 16:47:37 +0100
Received: from (everest.is.scarlet.be [193.74.71.40]) 
	by xizor.is.scarlet.be  with ESMTP id j4OFl1h19253; 
	Tue, 24 May 2005 17:47:01 +0200
Date:	Tue, 24 May 2005 16:47:02 +0100
Message-Id: <IH03UE$F4786E1557576A5F497FC95F9CBA3255@scarlet.be>
Subject: Re:Unable to handle kernel paging request at virtual address 04000460
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From:	"Philippe De Swert" <philippedeswert@scarlet.be>
To:	"raghunathan\.venkatesan" <raghunathan.venkatesan@wipro.com>
Cc:	"linux-mips" <linux-mips@linux-mips.org>
X-XaM3-API-Version: 4.1 (B54)
X-type:	0
X-SenderIP: 195.144.76.34
Return-Path: <philippedeswert@scarlet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: <IH03UE$F4786E1557576A5F497FC95F9CBA3255
Envelope-Id: <IH03UE$F4786E1557576A5F497FC95F9CBA3255
X-archive-position: 7970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippedeswert@scarlet.be
Precedence: bulk
X-list: linux-mips

Decode this dump with ksymoops

See here:
http://freshmeat.net/projects/ksymoops/

This will help you discover in which function it is dying, on which offset in
your kernel code etc... Very helpful for debugging. (in 2.6 you can even
compile something alike in the kernel (kallsyms))


---------- Initial header -----------

> We are facing the following crash in custom Linux 2.4.26 kernel, when we
> run a netperf TCP Stream (sizes varying from 64 to 32586 bytes) test
> over an IPSEC tunnel created between a host and a VPN server through our
> box. This is a Au1550 MIPS32 based board (DB1550 Cabernet board from
> AMD). We observe that crash happens randomly (the PrId keeps changing at
> each crash), because of burstiness in the netperf tool generated
> traffic. Please look into the following capture below. I'd like some
> help in debugging this issue. The same set of IPSEC drivers works fine
> on a custom Linux 2.4.25 based kernel. Is there a patch that needs to be
> applied for Linux 2.4.26 ? 
>  
> Unable to handle kernel paging request at virtual address 04000460, epc
> == 802501cc, 8Oops in fault.c::do_page_fault, line 206:
> 
> $0 : 00000000 1000fc00 00000000 00000001 00000000 8b5f61b2 04000460
> 00000000
<SNIP> KERNEL DUMP

CHEERS,

Philippe
 
| Philippe De Swert       
|      
| Stag developer http://stag.mind.be/  
| Emdebian developer: http://www.emdebian.org  
|   
| Please do not send me documents in a closed 
| format.(*.doc,*.xls,*.ppt)    
| Use the open alternatives. (*.pdf,*.ps,*.html,*.txt)    
| http://www.gnu.org/philosophy/no-word-attachments.html  

-------------------------------------------------------
NOTE! My email address is changing to ... @scarlet.be
Please make the necessary changes in your address book. 
