Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2004 01:48:48 +0100 (BST)
Received: from h014.c009.snv.cp.net ([IPv6:::ffff:209.228.34.127]:56722 "HELO
	c009.snv.cp.net") by linux-mips.org with SMTP id <S8225307AbUJPAsj>;
	Sat, 16 Oct 2004 01:48:39 +0100
Received: (cpmta 11854 invoked from network); 15 Oct 2004 17:48:31 -0700
Received: from 209.228.34.120 (HELO mail.canada.com.criticalpath.net)
  by smtp.canada.com (209.228.34.127) with SMTP; 15 Oct 2004 17:48:31 -0700
X-Sent: 16 Oct 2004 00:48:31 GMT
Received: from [69.193.111.169] by mail.canada.com with HTTP;
    Fri, 15 Oct 2004 17:48:31 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: linux-mips@linux-mips.org
From: thomas_blattmann@canada.com
Subject: crt1.o missing
X-Sent-From: thomas_blattmann@canada.com
Date: Fri, 15 Oct 2004 17:48:31 -0700 (PDT)
X-Mailer: Web Mail 5.6.4-0
Message-Id: <20041015174831.28904.h007.c009.wm@mail.canada.com.criticalpath.net>
Return-Path: <thomas_blattmann@canada.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas_blattmann@canada.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to crosscompile a hello-world program but it
fails:

/usr/local/lib/gcc-lib/mipsel-linux/2.96-mips3264-000710/../../../../mipsel-linux/bin/ld: cannot open crt1.o:
No such file or directory
collect2: ld returned 1 exit status

There are several postings in the archives but non of
them helped me on so far. I will probably have to get
the libc for mipsel-linux - but where can I get it and
what to do with it ??

Thanks,

Thomas
 
