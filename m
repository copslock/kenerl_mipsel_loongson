Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 17:50:04 +0000 (GMT)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.195]:26256 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225346AbVAURt6>;
	Fri, 21 Jan 2005 17:49:58 +0000
Received: by wproxy.gmail.com with SMTP id 69so148353wra
        for <linux-mips@linux-mips.org>; Fri, 21 Jan 2005 09:49:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=NcM9US/DRleFz4Mw5/ln72+qsyIxM0uuLhydVp9N7Cxzp5dDFZ0hVN0XaTKmUuxkPpVsZfi6AK5+VLVm2Ki/e+5teP1HZaDsh/miT7IwszKkkRxenqfAaIZod1FGZ6dYHz7lXu9Fjl8ka0s/pxJYcjUWnl+5okuzv1yeegK0c9A=
Received: by 10.54.52.40 with SMTP id z40mr145565wrz;
        Fri, 21 Jan 2005 09:49:47 -0800 (PST)
Received: by 10.54.41.39 with HTTP; Fri, 21 Jan 2005 09:49:47 -0800 (PST)
Message-ID: <ecb4efd10501210949db48ce1@mail.gmail.com>
Date:	Fri, 21 Jan 2005 12:49:47 -0500
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: CONFIG_PM depends on CONFIG_MACH_AU1X00?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

I was looking at the TOY (time of year stuff) in
arch/mips/au1000/common/time.c and noticed that it depends on
CONFIG_PM, but I couldn't select the CONFIG_PM with xconfig. It seems
that PM depends on MACH_AU1X00. It seems that MACH_AU1X00 was replaced
with SOC_AU1X00 but not updated for the PM line in Kconfig. Here is a
patch:

RCS file: /home/cvs/linux/arch/mips/Kconfig,v
retrieving revision 1.126
diff -U3 -r1.126 Kconfig
--- Kconfig     27 Dec 2004 18:23:53 -0000      1.126
+++ Kconfig     21 Jan 2005 17:47:09 -0000
@@ -1575,7 +1575,7 @@
 
 config PM
        bool "Power Management support (EXPERIMENTAL)"
-       depends on EXPERIMENTAL && MACH_AU1X00
+       depends on EXPERIMENTAL && SOC_AU1X00
 
 endmenu

                                          --Clem
