Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 11:49:53 +0100 (BST)
Received: from mail.domino-uk.com ([193.131.116.193]:7442 "EHLO
	UK-HC-PS1.domino-printing.com") by ftp.linux-mips.org with ESMTP
	id S20038498AbWIYKtt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 Sep 2006 11:49:49 +0100
Received: from emea-exchange3.emea.dps.local (EMEA-EXCHANGE3) by 
    UK-HC-PS1.domino-printing.com (Clearswift SMTPRS 5.2.5) with ESMTP id 
    <T7af139d89bc18374c18d4@UK-HC-PS1.domino-printing.com> for 
    <linux-mips@linux-mips.org>; Mon, 25 Sep 2006 11:51:50 +0100
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by 
    emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830); 
    Mon, 25 Sep 2006 12:49:42 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: How to emulate lw/sw instruction by lb/sb instruction
Date:	Mon, 25 Sep 2006 12:49:40 +0200
User-Agent: KMail/1.9.3
References:	<OF041A6F77.FC0AA7D2-ON482571F4.00036CCB-482571F4.0003EC56@LocalDomain>
In-Reply-To:	 <OF041A6F77.FC0AA7D2-ON482571F4.00036CCB-482571F4.0003EC56@LocalDomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609251249.40995.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 25 Sep 2006 10:49:42.0705 (UTC) 
    FILETIME=[4EB53A10:01C6E090]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Monday 25 September 2006 02:41, william_lei@ali.com.tw wrote:
> Could someone tell me how to modify GCC as titled?because we have met
> problem while porting some middleware,which will generate some lw/sw
> instruction to unaligned address,so I would modify GCC to not generate
> lw/sw instructions for this pieces code.

I'm not exactly sure what problem you are facing but if I understand you 
correctly and you have code that simply does misaligned accesses, you would 
be better off fixing the code. The reason is that such unaligned accesses 
would have to be emulated with bytewise access and combining/dissecting the 
values accordingly, which hurts performance (processing and cache). Even when 
run on x86 (where such accesses don't cause bus errors) this would be the 
better choice, because even there these are emulated in hardware and only 
cause hidden performance losses.

Other than that, I would rather filter the output of GCC, i.e. use -S (or what 
it was) to generate assembler code and then replace the lw/sw instructions 
via your $FAVOURITE_TEXTPROCESSING_TOOL in the affected files. Most other 
software isn't that broken and would only suffer from such changes.

Thinking about it, I believe there is also a way (some __attribute__) to tell 
GCC that some pointer is not aligned and it will then output suitable code 
for unaligned accesses. This requires changes to the generated sourcecode 
though, but would be a rather clean solution because it would work on other 
platforms, too.

Just wondering, what middleware are you talking about?

Uli


**************************************************************************************
           Visit our website at <http://www.satorlaser.de/>
**************************************************************************************

Diese E-Mail und jede mit dieser E-Mail versandte Datei ist vertraulich und ausschließlich für die Nutzung durch den vorgesehenen Empfänger bestimmt. Sollten Sie nicht der vorgesehene Empfänger dieser E-Mail sein, informieren Sie bitte den Absender.  Jeder unbefugte Zugriff oder unbefugte Weiterleitung, die Fertigung einer Kopie oder sonstige in diesem Zusammenhang stehende Handlung ist untersagt.


This e-mail and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this e-mail in error, please be so kind to inform the sender. Any other unauthorised access, unauthorised forwarding, copying or other action in this connection at all, is prohibited.
**************************************************************************************
