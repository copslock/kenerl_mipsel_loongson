Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2003 03:37:27 +0000 (GMT)
Received: from smtp106.mail.sc5.yahoo.com ([IPv6:::ffff:66.163.169.226]:64619
	"HELO smtp106.mail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225373AbTLRDhR>; Thu, 18 Dec 2003 03:37:17 +0000
Received: from unknown (HELO Warrior) (thesistarball@61.149.153.203 with login)
  by smtp106.mail.sc5.yahoo.com with SMTP; 18 Dec 2003 03:37:10 -0000
Date: Thu, 18 Dec 2003 11:36:59 +0800
From: "He Jin" <thesistarball@yahoo.com.cn>
To: "linux-mips" <linux-mips@linux-mips.org>
Subject: AutoNegotiation could not complete in PB1500 platform
X-mailer: Foxmail 5.0 beta2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20031218033717Z8225373-16706+1429@linux-mips.org>
Return-Path: <thesistarball@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thesistarball@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

Hi, Dear all,

I'm porting my own firmware code to PB1500, however some troubles ocurred with the Au1x NIC and LSI PHY. The dump of PHY register (the NIC initialization code is borrowed from the driver inside YAMON) is as follow:

////////////////////////////////////
 MII status: Link is up
 1th 0x3000
 2th 0x7809			=> should be 0x7829
		^^^^^^^^^^
 3th 0x16
 4th 0xf840
 5th 0x1e1
 6th 0x 0 			=> should be 0x45e1
		^^^^^^^^^^
17th 0x22
18th 0xffc0
////////////////////////////////////

It shows the MII interface couldn't finish the AutoNegotiation process. The values I think right is the output of some small probe programs using YAMON to boot the board and running those small probe programs . Besides, the LED in NIC interface could flash normally and we observed the LSI PHY chips should have been reset sucessfully in our firmware code using oscillograph device to probe the 'reset' pin in the PHY chips. 

If I use YAMON, everything OK. Could somebody tell me why ? 

Thanks a lot !
