Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2005 10:55:02 +0100 (BST)
Received: from guri.is.scarlet.be ([IPv6:::ffff:193.74.71.22]:56549 "EHLO
	guri.is.scarlet.be") by linux-mips.org with ESMTP
	id <S8224987AbVFPJyp> convert rfc822-to-8bit; Thu, 16 Jun 2005 10:54:45 +0100
Received: from (everest.is.scarlet.be [193.74.71.40]) 
	by guri.is.scarlet.be  with ESMTP id j5G9sgn31505; 
	Thu, 16 Jun 2005 11:54:43 +0200
Date:	Thu, 16 Jun 2005 10:54:43 +0100
Message-Id: <II68V7$710BD802DB90EFADDBE27A92E7C5B2C2@scarlet.be>
Subject: Re:[Fwd: kernel compilation fails]
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From:	"Philippe De Swert" <philippedeswert@scarlet.be>
To:	"tom" <tom@voda.cz>
Cc:	"linux-mips" <linux-mips@linux-mips.org>
X-XaM3-API-Version: 4.1 (B54)
X-type:	0
X-SenderIP: 195.144.76.34
Return-Path: <philippedeswert@scarlet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: <II68V7$710BD802DB90EFADDBE27A92E7C5B2C2
Envelope-Id: <II68V7$710BD802DB90EFADDBE27A92E7C5B2C2
X-archive-position: 8100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippedeswert@scarlet.be
Precedence: bulk
X-list: linux-mips

Hello Tom,

> I am desperately trying to compile 2.4.30 mips kernel using uclibc 
> buildroot gcc 3.3.4 It fails in the following manner:

<snip> relevant error output </snip>
 
> 
> Looks like a stupid typo somewhere, but I lack experience to find. BTW, 
> the some code is taken from 2.4.18 kernel...
> Can anyone please tell me where to look ?

Basically 2.4.18 code is too old to compile as is with gcc 3.3.4. The
assembler code needs to be inlined with a different syntax. Just look at
similar files to see how it is done.

As a quick hint here is some code to show how it should look like.


        __asm__(".set\tmips3\n\t"
                "wait\n\t"
                ".set\tmips0");

Notice the \n and \t parts. You are probabely missing those.

Otherwise use an older compiler (2.95).

Cheers,

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
