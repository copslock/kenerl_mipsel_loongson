Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2RCGq603570
	for linux-mips-outgoing; Wed, 27 Mar 2002 04:16:52 -0800
Received: from ms45.hinet.net (root@ms45.hinet.net [168.95.4.45])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2RCGmq03567
	for <linux-mips@oss.sgi.com>; Wed, 27 Mar 2002 04:16:49 -0800
Received: from sam (61-220-89-134.HINET-IP.hinet.net [61.220.89.134])
	by ms45.hinet.net (8.8.8/8.8.8) with SMTP id UAA04657
	for <linux-mips@oss.sgi.com>; Wed, 27 Mar 2002 20:19:06 +0800 (CST)
From: "Y.H. Ku" <iskoo@ms45.hinet.net>
To: <linux-mips@oss.sgi.com>
Subject: RE: BootLoader on MIPS
Date: Wed, 27 Mar 2002 20:14:38 +0800
Message-ID: <NGBBILOAMLLIJMLIOCADCEOKCCAA.iskoo@ms45.hinet.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
In-Reply-To: <3CA0B924.2030003@mvista.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by oss.sgi.com id g2RCGoq03568
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks All!!!!

What I want to know is how PMON jump to linux kernel image,

when mips.S function "_go" execute "j k0" command, 
(k0 is assigned by LREG(k0,R_EPC,gp)  /* EPC */)
k0 will be 40*(DBGREG)=40* (0x7ff00bad), 

the address is kuseg's domain. is it really work to turnin linux kernel image??
(In common case, linux kernl image always start from 0x100000)

any suggestion?
I just want to know MORE about the LINK method between PMON and MIPS-Linux?

best regards,
--Ku
