Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 08:45:12 +0100 (BST)
Received: from shosh.galileo.co.il ([IPv6:::ffff:199.203.130.250]:59718 "EHLO
	gravity8.il.marvell.com") by linux-mips.org with ESMTP
	id <S8225238AbUC3HpL>; Tue, 30 Mar 2004 08:45:11 +0100
Received: from il.marvell.com ([10.2.1.99])
	by gravity8.il.marvell.com (8.12.10/8.12.10) with ESMTP id i2U7hksJ024623
	for <linux-mips@linux-mips.org>; Tue, 30 Mar 2004 09:43:46 +0200 (IST)
Message-ID: <40692540.9090800@il.marvell.com>
Date: Tue, 30 Mar 2004 09:44:00 +0200
From: Ronen Shitrit <rshitrit@il.marvell.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: mips-linux cross-compiler
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <rshitrit@il.marvell.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rshitrit@il.marvell.com
Precedence: bulk
X-list: linux-mips

Hi

I have a mips-linux cross compiler on i686 host, which is using gcc 2.95.3 .
This compiler doesn't support the MIPS 4 Instruction Set,
So I'm trying to build a new mips-linux cross compiler using any gcc 3.3/2.*
but without any luck,
Did anyone succeed to build such a cross compiler??
which gcc and binutils version did you use??
what are the configure flags you used??
Did you used any special steps?? (except for configure ... , make, make 
install )

Thanks a lot

-- 
Ronen Shitrit

M.S.I.L
D.N. Misgav  20184
Tel:   +972-4-9951000
Fax:   +972-4-9951001
Email: mailto: ronen.shitrit@il.marvell.com
_____________________________________________________________
This message may contain confidential, proprietary or legally privileged 
information. The information is intended only for the use of the individual 
or entity named above. If the reader of this message is not the intended 
recipient, you are hereby notified that any dissemination, distribution 
or copying of this communication is strictly prohibited. If you have 
received this communication in error, please notify us immediately by 
telephone, or by e-mail and delete the message from your computer.
