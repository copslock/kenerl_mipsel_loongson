Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2005 09:10:07 +0100 (BST)
Received: from smtp1.euronet.nl ([IPv6:::ffff:194.134.35.133]:30866 "EHLO
	smtp1.euronet.nl") by linux-mips.org with ESMTP id <S8225209AbVESIJw>;
	Thu, 19 May 2005 09:09:52 +0100
Received: from Rene (htm-c-e0ae.mxs.adsl.euronet.nl [81.68.254.174])
	by smtp1.euronet.nl (Postfix) with SMTP id 7DF6B67258
	for <linux-mips@linux-mips.org>; Thu, 19 May 2005 10:09:50 +0200 (MEST)
Message-ID: <002901c55c4a$2030ede0$0a21a8c0@Rene>
From:	=?iso-8859-1?Q?Ren=E9_Schouten?= <reneschouten@seldi.nl>
To:	<linux-mips@linux-mips.org>
Subject: compiling pcmcia utils for mips
Date:	Thu, 19 May 2005 10:09:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
x-mimeole: Produced By Microsoft MimeOLE V6.00.2900.2527
Return-Path: <reneschouten@seldi.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: reneschouten@seldi.nl
Precedence: bulk
X-list: linux-mips

Hi,

I want to enable pcmcia on a mips32 processor

I do have everything exept the cardmgr and cardctl programs that should be 
in the /sbin directory

I downloaded the pcmcia-cs-3.2.8.tar.tar., and i'm able to compile it with 
the standard compiler, but i'm not able to build "cardctl" and "cardmgr" 
with the crosscomipler.

My question: Can somebody give a link on where i can download the 2 files 
already compiled, or tell me what to change in the "pcmcia-cs-3.2.8.tar.tar" 
files for only compiling the two utilitis with a cross compiler?

René 
