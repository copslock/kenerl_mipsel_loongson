Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2003 03:27:28 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:63211 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225387AbTIOC10> convert rfc822-to-8bit;
	Mon, 15 Sep 2003 03:27:26 +0100
Received: (qmail 13555 invoked from network); 15 Sep 2003 02:13:36 -0000
Received: from unknown (HELO xing) (159.226.39.104)
  by mail.ict.ac.cn with SMTP; 15 Sep 2003 02:13:36 -0000
From: "=?GB2312?Q?=B9=E3=D0=C7?=" <guangxing@ict.ac.cn>
To: linux-mips@linux-mips.org <linux-mips@linux-mips.org>
Subject: How to implement the combination of signal and alarm in the Kenel Module?
X-mailer: Foxmail 4.2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8BIT
Date: Mon, 15 Sep 2003 10:27:46 +0800
Message-Id: <20030915022726Z8225387-1272+5432@linux-mips.org>
Return-Path: <guangxing@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guangxing@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Hi,everyone!
   As my experience, in the application level we can use  the combination of signal() and alarm() to  
implement some simple works ,such as doing some scheduled task at a certain time, invoke some routine 
after a certain time...Now one thing confused me.I thing in the kernel module we can implement the same works.
And I have tried to use the  queue_task(&Task, &tq_timer),but when i try to "insmod", the LINUX will broken.
Who can tell why?And hoew to implement the combination of signal and alarm in the Kenel Module?
   Thank you in advance!


	

　  廝
宗慎 噪酔
 				

　　　　　　　　鴻佛
　　　　　　　　guangxing@ict.ac.cn
　　　　　　　　　　2003-09-15
