Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2002 09:48:45 +0200 (CEST)
Received: from newgate1.zarlink.com ([209.226.172.66]:50309 "EHLO
	semigate.zarlink.com") by linux-mips.org with ESMTP
	id <S1123396AbSJGHso>; Mon, 7 Oct 2002 09:48:44 +0200
Received: from ottmta01.zarlink.com (ottmta01 [134.199.14.110])
	by semigate.zarlink.com (8.10.2+Sun/8.10.2) with ESMTP id g977mbE24161
	for <linux-mips@linux-mips.org>; Mon, 7 Oct 2002 03:48:37 -0400 (EDT)
Subject: MIPS32/MIPS4K kernel compilation settings
To: linux-mips@linux-mips.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFFFD113F8.B40CC667-ON80256C4B.0028865D@zarlink.com>
From: Colin.Helliwell@Zarlink.Com
Date: Mon, 7 Oct 2002 08:48:26 +0100
X-MIMETrack: Serialize by Router on ottmta01/Semi(Release 5.0.11  |July 24, 2002) at 10/07/2002
 03:48:37 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Return-Path: <Colin.Helliwell@Zarlink.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Colin.Helliwell@Zarlink.Com
Precedence: bulk
X-list: linux-mips

Was just wondering why the (2.4.19) kernel compilation for MIPS4K systems
appears to be using the "-mips2" compiler setting - shouldn't it be using
-mips4 or -mips32 to get the full instruction set?
Thanks.
