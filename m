Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA2FngF10822
	for linux-mips-outgoing; Fri, 2 Nov 2001 07:49:42 -0800
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA2Fnc010819
	for <linux-mips@oss.sgi.com>; Fri, 2 Nov 2001 07:49:38 -0800
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP
	id CF3D6590A9; Fri,  2 Nov 2001 06:45:59 -0500 (EST)
Message-ID: <00dd01c163b6$064a39d0$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Marc Karasek" <marc_karasek@ivivity.com>,
   "Linux MIPS" <linux-mips@oss.sgi.com>
References: <1004708261.31067.6.camel@localhost.localdomain>
Subject: Re: BE Toolchain
Date: Fri, 2 Nov 2001 10:49:58 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I think it should be mips-linux, not mipseb-linux.

Regards,
Brad

----- Original Message ----- 
From: "Marc Karasek" <marc_karasek@ivivity.com>
To: "Linux MIPS" <linux-mips@oss.sgi.com>
Sent: Friday, November 02, 2001 8:37 AM
Subject: BE Toolchain


> Has anyone got the toolchain (binutils, gcc, glibc) to compile under
> BE?  I followed the instructions at Bradley D. LaRonde has put together
> and got the LE to work w/o a prolem.  I then proceeded to try the BE. 
> Binutils compiled ok, gcc says that mipseb-linux is not a valid target. 
> Looking in config.sub I saw a mips-linux, is this the BE option?  
> 
> Thanks,
> 
> -- 
> /*************************
> Marc Karasek
> Sr. Firmware Engineer
> iVivity Inc.
> marc_karasek@ivivity.com
> (770) 986-8925
> (770) 986-8926 Fax
> *************************/
> 
