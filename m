Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Sep 2004 08:49:07 +0100 (BST)
Received: from bay19-f29.bay19.hotmail.com ([IPv6:::ffff:64.4.53.79]:34310
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8224988AbUILHtC>; Sun, 12 Sep 2004 08:49:02 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Sun, 12 Sep 2004 00:48:55 -0700
Received: from 218.75.247.251 by by19fd.bay19.hotmail.msn.com with HTTP;
	Sun, 12 Sep 2004 07:48:54 GMT
X-Originating-IP: [218.75.247.251]
X-Originating-Email: [paozhaokeats@hotmail.com]
X-Sender: paozhaokeats@hotmail.com
From: "Bao zhao" <paozhaokeats@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Cannot find the source code of handle_tlbl
Date: Sun, 12 Sep 2004 15:48:54 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY19-F29WOApQF88Un00011c0a@hotmail.com>
X-OriginalArrivalTime: 12 Sep 2004 07:48:55.0376 (UTC) FILETIME=[F445ED00:01C4989C]
Return-Path: <paozhaokeats@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paozhaokeats@hotmail.com
Precedence: bulk
X-list: linux-mips

   hi, I am a newbie to learn mips kernel.  As I know,there is no hardware 
support for pagetable,only has support for tlb miss. Following is my 
question:
   (1) In entry.S.   I found the following exception's handlers:
                 BUILD_HANDLER(adel,ade,ade,silent)		/* #4  */
	BUILD_HANDLER(ades,ade,ade,silent)		/* #5  */
	BUILD_HANDLER(ibe,ibe,cli,verbose)		/* #6  */
	BUILD_HANDLER(dbe,dbe,cli,silent)		/* #7  */
	BUILD_HANDLER(bp,bp,sti,silent)			/* #9  */
	BUILD_HANDLER(ri,ri,sti,silent)			/* #10 */
	...
         but not all of exception's handlers are there.I cannot find 
handlers such as  handle_mod, handle_tlb,handle_tlbs;

  (2)do_page_fault should be called by tlb miss handler, but I cannot find 
which function called it.

btw, Is there any documentations about mips-kernel's implementaion?

Any help would be greatly appreciated.

                                                       Keats

_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE* 
http://join.msn.com/?page=features/virus
