Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 23:07:15 +0100 (BST)
Received: from moutng.kundenserver.de ([212.227.126.177]:12030 "EHLO
	moutng.kundenserver.de") by ftp.linux-mips.org with ESMTP
	id S20022324AbXJQWHG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 23:07:06 +0100
Received: from [192.168.99.21] (p57A6AA93.dip0.t-ipconnect.de [87.166.170.147])
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis)
	id 0ML29c-1IiH2Z2x7n-0006ki; Thu, 18 Oct 2007 00:07:00 +0200
Message-ID: <47168782.1000301@web.de>
Date:	Thu, 18 Oct 2007 00:06:58 +0200
From:	=?ISO-8859-1?Q?G=FCnter_Dannoritzer?= <dannoritzer@web.de>
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Which gcc version for MIPS?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: V01U2FsdGVkX18uPm7I5FYsuOZZsepyjWB7ALIZkWEaQ3CBH5p
 ns6Q9pzVi+EHD0xuiy8iEEWRPk1GMfJKI2Vk45ppMAKadfY2/O
 7agex1xeV4ly/Zu5e1wvA==
Return-Path: <SRS0=zqNM=PL=web.de=dannoritzer@srs.kundenserver.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dannoritzer@web.de
Precedence: bulk
X-list: linux-mips

Hi,

I am trying to get my feed wet with the MIPS architecture and I am
looking into getting the gcc cross compiler going on my openSuse 10.2
system.

On openSuse there is already a binutils 2.17 package available and I was
wondering whether it is as simple as compiling gcc with MIPS support for
that binutils package?

I looked at the Toolchain page at

  http://www.linux-mips.org/wiki/Toolchains

and it explains the compilation of gcc fairly simple. On the page it
says to use gcc 3.4.4 as that seems to be the version that allows to
compile a Linux Kernel without problems, however, if I look at the
crosstools page of Dan Kegel

 http://kegel.com/crosstool/crosstool-0.43/buildlogs/

it shows that there is no version that compiles a listed Linux Kernel
successful.

Can anybody give me some help in deciding what gcc version to use?

Does the gcc version need to match a certain binutils version?

Another question I have about having a mips and mipsel toolchain. I am
aware that some MIPS procecessors can change the endian-ness. In the gcc
documentation I saw that there is a -EB and -EL switch to select the
endianes. What is then the reason to have two toolchains?

Thanks for your help.

Cheers,

Guenter
