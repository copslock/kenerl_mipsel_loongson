Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f39I9KK13306
	for linux-mips-outgoing; Mon, 9 Apr 2001 11:09:20 -0700
Received: from yes.home.krftech.com ([194.90.113.98])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f39I9GM13303
	for <linux-mips@oss.sgi.com>; Mon, 9 Apr 2001 11:09:17 -0700
Received: from athena.home.krftech.com (shay@athena.home.krftech.com [199.204.71.19])
	by yes.home.krftech.com (8.8.7/8.8.7) with SMTP id WAA21188
	for <linux-mips@oss.sgi.com>; Mon, 9 Apr 2001 22:15:56 +0300
Content-Type: text/plain;
  charset="iso-8859-1"
From: Shay Deloya <shay@jungo.com>
Reply-To: shay@jungo.com
Organization: Jungo Corp.
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Insmod messages and modules space
Date: Mon, 9 Apr 2001 20:10:16 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01040921101605.01025@athena.home.krftech.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All,

1.Should text segment of module after insmod be in KSEG2 or KUSEG ? 
I've notices that the module address after insmod are c0... instead of 80...
Is it insmod Bug  ?
2. I keep getting in insmod of busybox pkg , "relocation overflow" message 
especially on printk symbols , when I debug the code, changing some function 
declaration from static int func () to int func()  , makes the module to 
insert correctly , anyone ?

Thanks,
-- 
Shay Deloya
______________________________________
Software Developer
Jungo - R&D
email: shayd@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 221
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
