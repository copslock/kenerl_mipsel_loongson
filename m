Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2005 15:26:40 +0100 (BST)
Received: from xizor.is.scarlet.be ([IPv6:::ffff:193.74.71.21]:2473 "EHLO
	xizor.is.scarlet.be") by linux-mips.org with ESMTP
	id <S8224914AbVDFO0Z> convert rfc822-to-8bit; Wed, 6 Apr 2005 15:26:25 +0100
Received: from (fuji.is.scarlet.be [193.74.71.41]) 
	by xizor.is.scarlet.be  with ESMTP id j36EQJ202801; 
	Wed, 6 Apr 2005 16:26:19 +0200
Date:	Wed,  6 Apr 2005 15:26:19 +0100
Message-Id: <IEJ43V$0C5BA57403CC7EFC09D35453D3E9129E@scarlet.be>
Subject: Re:cross compiling
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From:	"Philippe De Swert" <philippedeswert@scarlet.be>
To:	"b\.srinivas" <b.srinivas@conexant.com>
Cc:	"linux-mips" <linux-mips@linux-mips.org>
X-XaM3-API-Version: 4.1 (B54)
X-type:	0
X-SenderIP: 195.144.76.34
Return-Path: <philippedeswert@scarlet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: <IEJ43V$0C5BA57403CC7EFC09D35453D3E9129E
Envelope-Id: <IEJ43V$0C5BA57403CC7EFC09D35453D3E9129E
X-archive-position: 7608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippedeswert@scarlet.be
Precedence: bulk
X-list: linux-mips

Hello,


>      Iam trying to set up a cross compiler tool chain for mips 64 bit
> big endian.
> 
> Iam fixed in a chicken-egg kind of situation ......  during the
> compilation the linker doesn't find the crti.o which is built using the
> glibc but I still don't have glibc which need the compiler !!!. can
> anybody point me to a solution.

As you seem quite unexperienced I would recommend using Dan Kegel's crosstool
at www.kegel.com/crosstool. And if you really need help after trying that or
reading up on resources, we will need a more detailed description of your
problem. Error output, versions, procedure you are using, etc....

You do realize that the --without-headers option is broken from gcc-3.2.x
onwards....?

regards,

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
