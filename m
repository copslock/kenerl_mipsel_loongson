Received:  by oss.sgi.com id <S553809AbQKBMol>;
	Thu, 2 Nov 2000 04:44:41 -0800
Received: from mail.hks.com ([208.157.129.5]:22048 "HELO mail.hks.com")
	by oss.sgi.com with SMTP id <S553778AbQKBMoM>;
	Thu, 2 Nov 2000 04:44:12 -0800
Received: from maru.hks.com (fw.hks.com [208.157.128.1])
	by mail.hks.com (Postfix) with ESMTP id 62A8A2002331
	for <linux-mips@oss.sgi.com>; Thu,  2 Nov 2000 07:44:11 -0500 (EST)
Received: from perseus.hks.com (perseus.hks.com [172.16.2.12])
	by maru.hks.com (Postfix) with ESMTP id 24534144
	for <@hks.com:linux-mips@oss.sgi.com>; Thu,  2 Nov 2000 07:42:37 -0500 (EST)
Received: (from donath@localhost) by perseus.hks.com (980427.SGI.8.8.8/970903.SGI) id HAA50057 for linux-mips@oss.sgi.com; Thu, 2 Nov 2000 07:42:36 -0500 (EST)
From:   "Clarence Donath" <donath@hks.com>
Message-Id: <1001102074235.ZM349830@perseus.hks.com>
Date:   Thu, 2 Nov 2000 07:42:35 -0500
In-Reply-To: Keith M Wesolowski <wesolows@chem.unr.edu>
        "Re: GCC Compile Failed" (Nov  1, 16:25)
References: <20001101224303.A28369@woody.ichilton.co.uk> 
	<20001101162556.C17186@chem.unr.edu>
X-Mailer: Z-Mail (5.0.0 30July97)
To:     linux-mips@oss.sgi.com
Subject: GCC Compile Failed
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I've been trying to get GCC to compile on my Indy for weeks now.  I started out
with the latest version of GCC, and have stepped back to egsc-1.1.2.  Each time
I try to 'make bootstap', which takes days, I get this error:

cc ERROR parsing -W:  bad syntax for option
cc WARNING:  phase key (-)  is no longer supported
cc ERROR parsing -W:  bad phase for -W option
cc WARNING:  phase key (W)  is no longer supported
cc ERROR parsing -W:  bad phase for -W option
cc ERROR parsing -W:  unknown flag
*** Error code 2 (bu21)
*** Error code 1 (bu21)
*** Error code 1 (bu21)
*** Error code 1 (bu21)

I'm trying to compile it using CC as I don't have GCC on this machine now.  I
do not have the ability to install the freeware copy of GCC from SGI because I
do not have root privileges to install.  I've configured with a --prefix in my
own work area.

Can anyone help me out here?

Much appreciated.

Clarence Donath
