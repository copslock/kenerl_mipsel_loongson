Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB44pxn11154
	for linux-mips-outgoing; Mon, 3 Dec 2001 20:51:59 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB44pto11151
	for <linux-mips@oss.sgi.com>; Mon, 3 Dec 2001 20:51:56 -0800
Message-Id: <200112040451.fB44pto11151@oss.sgi.com>
Received: (qmail 1853 invoked from network); 4 Dec 2001 03:46:05 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 4 Dec 2001 03:46:05 -0000
Date: Tue, 4 Dec 2001 11:50:9 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: config problem?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,linux-mips,

   when upgrading to current CVS 2_4_branch,I find that the configure
scripts seems problematic:
       1. drivers/hotplug doesn't exist,so line 421:
             source "drivers/hotplug/config.in" 
         leads to failures of make xconfig/menuconfig 
       2. drivers/sound/config.in line 37 type error
                = 'y' should be = "y"
       3.the newly added "Embed root filesys ramdisk.." is not in 
         any mainmenu block,so "statement not in menu" occurs
        
  'make config' is ok            


Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
