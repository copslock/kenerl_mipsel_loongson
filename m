Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 17:57:09 +0100 (BST)
Received: from mailhost.taec.toshiba.com ([IPv6:::ffff:209.243.128.33]:51370
	"EHLO mailhost.taec.toshiba.com") by linux-mips.org with ESMTP
	id <S8225201AbUHQQ5F>; Tue, 17 Aug 2004 17:57:05 +0100
Received: from hdqmta.taec.com (hdqmta.taec.com [209.243.180.59])
	by mailhost.taec.toshiba.com (8.12.7/8.12.7) with ESMTP id i7HGuwMC006397;
	Tue, 17 Aug 2004 09:56:59 -0700 (PDT)
Subject: Re: Yamon compiling and linking
To: "Roman Mashak" <mrv@tusur.ru>
Cc: linux-mips@linux-mips.org
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OFBBD37EA1.A7922B89-ON88256EF3.005D0F89-88256EF3.005D49DB@taec.com>
From: Saugata.Chatterjee@taec.toshiba.com
Date: Tue, 17 Aug 2004 09:58:57 -0700
X-MIMETrack: Serialize by Router on HDQMTA/TOSHIBA_TAEC(Release 6.5|September 26, 2003) at
 08/17/2004 09:59:08 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Return-Path: <Saugata.Chatterjee@taec.toshiba.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Saugata.Chatterjee@taec.toshiba.com
Precedence: bulk
X-list: linux-mips






Reset code (reset.S) IS compiled and linked (at bfc00000 like it should
be), and pretty early on in there YAMON detects endianness and jumps to the
location of the appropriate endian image. Dump the output of make to a log
file and look for the compilation of reset.S.

 Hope that helps,
-Saugata.




                                                                                                                                           
                      "Roman Mashak"                                                                                                       
                      <mrv@tusur.ru>               To:       <linux-mips@linux-mips.org>                                                   
                      Sent by:                     cc:                                                                                     
                      linux-mips-bounce@lin        Subject:  Yamon compiling and linking                                                   
                      ux-mips.org                                                                                                          
                                                                                                                                           
                                                                                                                                           
                      08/16/2004 06:57 PM                                                                                                  
                                                                                                                                           
                                                                                                                                           




Hello!

I solved the problem with Yamon compiling I asked recently, but still have
technical related questions about Yamon linking & code allocating in
memory.

Here it is.

When I compile little-endian only image, as far as I understood, I got
image
without RESET code at the beginning, so according to the memory map and
link
script (link_el.xn) - starting entry point is __RESET_HANDLER_END (locating
in init.S) and its address is 0x9fc10000.
So, I don't quite understand, how will be going after CPU reset? As
documentation's saying "following a reset, hardware fetches instructions
starting at the reset exception vector 0xBFC00000". But what is waiting at
this address, because reset code (reset.S) is not compiled and is not
linked?

Could you please make it clear to me?

Thanks in advance!

With best regards, Roman Mashak.  E-mail: mrv@tusur.ru
