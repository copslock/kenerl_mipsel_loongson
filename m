Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 08:27:37 +0000 (GMT)
Received: from [IPv6:::ffff:209.226.172.94] ([IPv6:::ffff:209.226.172.94]:11416
	"EHLO semigate.zarlink.com") by linux-mips.org with ESMTP
	id <S8225263AbSLQI1g>; Tue, 17 Dec 2002 08:27:36 +0000
Received: from ottmta01.zarlink.com (ottmta01 [134.199.14.110])
	by semigate.zarlink.com (8.10.2+Sun/8.10.2) with ESMTP id gBH8RNL16854;
	Tue, 17 Dec 2002 03:27:23 -0500 (EST)
Subject: Re: Problems with CONFIG_PREEMPT
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF78526308.B4153FAC-ON80256C92.002B416F@zarlink.com>
From: Colin.Helliwell@Zarlink.Com
Date: Tue, 17 Dec 2002 08:27:16 +0000
X-MIMETrack: Serialize by Router on ottmta01/Semi(Release 5.0.11  |July 24, 2002) at 12/17/2002
 03:27:23 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Return-Path: <Colin.Helliwell@Zarlink.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Colin.Helliwell@Zarlink.Com
Precedence: bulk
X-list: linux-mips


NEW_TIME_C is set. URL to the patch is:
http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-2.patch

We ultimately want to add in real-time support, such as Ingo's O(1)
scheduler - if this is 'complete' for MIPS. I don't know if it would be
better just to go for this in one hit, or if we'd need the preemption
sorted out anyway first. Or should we just go to a 2.5.x kernel instead?

Colin




                                                                                                                                       
                      Jun Sun                                                                                                          
                      <jsun@mvista.com>        To:       Colin.Helliwell@Zarlink.Com                                                   
                                               cc:       linux-mips@linux-mips.org, jsun@mvista.com                                    
                      16-Dec-2002 08:45        Subject:  Re: Problems with CONFIG_PREEMPT                                              
                      PM                                                                                                               
                                                                                                                                       
                                                                                                                                       





Several possibilities:

1) Not all MIPS boards can run pre-k.  At minimum, you need to use
NEW_TIME_C, Or else you have to take a lot of stuff youself.

2) Not sure if all MIPS patches are in RML's patch.  If you pass the URL
pointer, I can take a look.

3) Even with all above taken care of, there are still unsolved issues
(such as math emul not pre-k safe, some cache operations, etc).
However, these problems usually are much harder to show up.  You won't
see them unless you delibrately want to. :-)

Jun
