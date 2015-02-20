Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Feb 2015 10:53:50 +0100 (CET)
Received: from astoria.ccjclearline.com ([64.235.106.9]:36641 "EHLO
        astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013134AbbBTJxsb3SVo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Feb 2015 10:53:48 +0100
Received: from [99.240.204.5] (port=41001 helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.80)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1YOkHG-0003Iv-Lm
        for linux-mips@linux-mips.org; Fri, 20 Feb 2015 04:53:42 -0500
Date:   Fri, 20 Feb 2015 04:53:42 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To:     linux-mips@linux-mips.org
Subject: what is the purpose of the following LE->BE patch to
 arch/mips/include/asm/io.h?
Message-ID: <alpine.LFD.2.11.1502200445290.26212@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


  was recently handed a MIPS-based dev board (can't name the vendor,
NDA) that *typically* runs in LE mode but, because of a proprietary
binary that must be run on the board and was compiled as BE, has to be
run in BE mode.

  the vendor supplied a yoctoproject layer that seems to work fine
but, in changing the DEFAULTTUNE to big-endian, the following patch
had to be applied to the 3.14 kernel tree to the file
arch/mips/include/asm/io.h in order to get output from the console
port as the system was booting:

326c326,333
< 		*__mem = __val;						\
---
> 	{										\
> 		if (sizeof(type) == sizeof(u32))		\
> 		{									\
> 			*__mem = __cpu_to_le32(__val);	\
> 		}									\
> 		else								\
> 			*__mem = __val;						\
> 	}											\
356a364
> 	{										\
357a366,368
> 		if (sizeof(type) == sizeof(u32))	\
> 			__val = __cpu_to_le32(__val);	\
> 	}											\

  without that patch, the initial conclusion was that the board was
just hanging at boot, but i was told, no, it was booting, there was
just no output at the console port. applied the patch and, voila.

  can someone explain *precisely* what the above is doing? i am by no
means a MIPS expert, but clearly the above is doing some sort of
explicit BE/LE conversion. can anyone supply more detail? thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
