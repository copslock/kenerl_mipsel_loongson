Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3CDW3L06930
	for linux-mips-outgoing; Thu, 12 Apr 2001 06:32:03 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3CDW2M06924
	for <linux-mips@oss.sgi.com>; Thu, 12 Apr 2001 06:32:02 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id IAA07569
	for <linux-mips@oss.sgi.com>; Thu, 12 Apr 2001 08:32:02 -0500
Message-ID: <3AD5BCF9.862FCE33@cotw.com>
Date: Thu, 12 Apr 2001 07:34:33 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: ld.script.in  Missing  PROVIDE (etext = .);
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Shouldn't there be a :

 PROVIDE (etext = .);

Scott
