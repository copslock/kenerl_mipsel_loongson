Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7M2FCJ04771
	for linux-mips-outgoing; Tue, 21 Aug 2001 19:15:12 -0700
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7M2FA904767
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 19:15:10 -0700
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP id 504BD590A9
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 22:11:15 -0400 (EDT)
Message-ID: <14df01c12ab0$81ee66e0$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Tim Moss" <linux-mips@oss.sgi.com>
References: <3B830249.4060708@oss.sgi.com>
Subject: Re: serial console bug?
Date: Tue, 21 Aug 2001 22:16:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

What if you just close minicom or pull the cable?

Regards,
Brad

----- Original Message ----- 
From: "Tim Moss" <linux-mips@oss.sgi.com>
To: <linux-mips@oss.sgi.com>
Cc: <ralf@gnu.org>
Sent: Tuesday, August 21, 2001 8:52 PM
Subject: serial console bug?


> If I am connected to my Challenge S server via serial console using 
> minicom from Linux and minicom dies (eg - the X server where minicom was 
> running from crashes), the Challenge box resets. I haven't done really 
> extensive testing but this error is definitely recreatable.
> 
> My current kernel is 2.4.5. I compiled it myself from CVS but I'm pretty 
> sure this also happened with the precompiled 2.4.3 kernel from the oss 
> ftp site.
> 
> 
