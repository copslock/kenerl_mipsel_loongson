Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A1b6d00574
	for linux-mips-outgoing; Thu, 9 Aug 2001 18:37:06 -0700
Received: from webo.vtcif.telstra.com.au (webo.vtcif.telstra.com.au [202.12.144.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A1b5V00570
	for <linux-mips@oss.sgi.com>; Thu, 9 Aug 2001 18:37:05 -0700
Received: (from uucp@localhost) by webo.vtcif.telstra.com.au (8.8.2/8.6.9) id LAA27191 for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 11:36:59 +1000 (EST)
Received: from maili.vtcif.telstra.com.au(202.12.142.17)
 via SMTP by webo.vtcif.telstra.com.au, id smtpdAf9QI_; Fri Aug 10 11:36:43 2001
Received: (from uucp@localhost) by maili.vtcif.telstra.com.au (8.8.2/8.6.9) id LAA00278 for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 11:36:42 +1000 (EST)
Received: from localhost(127.0.0.1), claiming to be "mail.cdn.telstra.com.au"
 via SMTP by localhost, id smtpdl8wZx_; Fri Aug 10 11:36:06 2001
Received: from ntmsg0028.corpmail.telstra.com.au (ntmsg0028.corpmail.telstra.com.au [192.168.174.24]) by mail.cdn.telstra.com.au (8.8.2/8.6.9) with ESMTP id LAA03258 for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 11:36:06 +1000 (EST)
Received: by ntmsg0028.corpmail.telstra.com.au with Internet Mail Service (5.5.2653.19)
	id <QTQ5X9K4>; Fri, 10 Aug 2001 11:32:07 +1000
Message-ID: <C1CCF0351229D311BBEB0008C75B9A8A02CAFACC@ntmsg0080.corpmail.telstra.com.au>
From: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: FW: indigo2 kernel build failures
Date: Fri, 10 Aug 2001 11:31:58 +1000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk





> Keith / Ralf  / All
> 
> I just wondering if  the UNKNOW  aspect "mips-unknown-linux-gnu" of
> building packages has some detrimental affect
> on the success of building a kernel.
> IE
> The machine status isn't detected properly.
> 
> 
> If so what do  i do to fix?
> 
> Thanks
> 
> EG when updating binutils I get:
> ########################################
> bash-2.04# pwd
> /binutils-2.9.5.0.37
> bash-2.04# ./configure
> Configuring for a mips-unknown-linux-gnu host.
> *** This configuration is not supported in the following subdirectories:
>      gprof
>     (Any other directories should still work fine.)
> ###############################################
> 
