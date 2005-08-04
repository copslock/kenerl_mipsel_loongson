Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2005 12:10:09 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:60933 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225716AbVHDLJv>;
	Thu, 4 Aug 2005 12:09:51 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1E0duu-0005zh-00; Thu, 04 Aug 2005 12:29:40 +0100
Received: from highbury.mips.com ([192.168.192.236])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1E0deE-0000GQ-00; Thu, 04 Aug 2005 12:12:26 +0100
Message-ID: <42F1F81A.6020002@mips.com>
Date:	Thu, 04 Aug 2005 12:12:26 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	colin <colin@realtek.com.tw>
CC:	linux-mips@linux-mips.org
Subject: Re: Compiling uClibc with MIPS SDE6
References: <009b01c598d5$2ede3e20$106215ac@realtek.com.tw>
In-Reply-To: <009b01c598d5$2ede3e20$106215ac@realtek.com.tw>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-3.815,
	required 4, AWL, BAYES_00, XENO_CONTENT)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



colin wrote:

>Hi there,
>I encounter a problem when compiling uClibc with SDE6. If compiling with
>debug information enabled, the output executable file of busybox is about
>the same with the one that is compiled with SDE5, but uClibc libraries are
>over 10 times the size of the ones that are compiled with SDE5. I am
>wondering if it is because GCC 3.4.4 of SDE6 has changed some parameters
>setting?
>
>  
>

SDE 6 uses Dwarf-2 debug data, whereas SDE 5 used Stabs. That may
explain the difference.

Nigel

-- 
                         Nigel Stephens         Mailto:nigel@mips.com
    _    _ ____  ___     MIPS Technologies      Phone.: +44 1223 706200
    |\  /|||___)(___     The Fruit Farm         Direct: +44 1223 706207
    | \/ |||    ____)    Ely Road, Chittering   Fax...: +44 1223 706250
     TECHNOLOGIES UK     Cambridge CB5 9PH      Cell..: +44 7976 686470
                         England                http://www.mips.com
