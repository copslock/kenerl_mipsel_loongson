Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Feb 2008 18:15:07 +0000 (GMT)
Received: from web8406.mail.in.yahoo.com ([202.43.219.154]:63377 "HELO
	web8406.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20030019AbYBASO6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Feb 2008 18:14:58 +0000
Received: (qmail 7972 invoked by uid 60001); 1 Feb 2008 18:14:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=XXiF+t2gJVn66gjvUZ1OjONzOY2n8+66gUGFHpAuU5bdh6XgkCPE42Pzmyn+Rf9Lri0eULQgbzk+mcPIOjvt73HnsS04Q4ELhxXxoubGdKgrH7HEiF/aqdYl+tY+Z7gQavbBEVgOT+q4Mfjyt9qaKk3vDiILkI7smyeRIozfxhE=;
X-YMail-OSG: o4AhGD4VM1m0ingH3EVKHgslw5dNrvUWpYDEaxUKXDO5ojWa98Bg_WGIc029TG0d5G8Xj0i7OUGpZFForF.2be46odapEYPA1xm7Ta2uMosV7TJrtfXpUprDL_g9Cw--
Received: from [199.239.167.162] by web8406.mail.in.yahoo.com via HTTP; Fri, 01 Feb 2008 23:44:47 IST
X-Mailer: YahooMailRC/818.31 YahooMailWebService/0.7.162
Date:	Fri, 1 Feb 2008 23:44:47 +0530 (IST)
From:	veerasena reddy <veerasena_b@yahoo.co.in>
To:	"linux-kernel.org" <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Message-ID: <416607.4159.qm@web8406.mail.in.yahoo.com>
Return-Path: <veerasena_b@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18165
Subject: (no subject)
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: veerasena_b@yahoo.co.in
Precedence: bulk
X-list: linux-mips

Hi,

I have a requirement where i need to execute a user process even when the kernel is utilizing 100% of CPU time.

Actual scenario is as below:
I have a device on my board. this device keeps generating regular (for every 2secs) messages for a user process. the user process has to poll on the device for any message is there to read and get the message from the device. once the user process reads the message it will be removed in device and uses for further/subsequent messages.

I have a test case where i need to send so much traffic through my board such that the kernel will be utilizing 100% CPU time to process this data. At this time (when CPU is 100% utilized) the user space process is not getting scheduled even after a long duration (say 10 minutes to 45 minutes). Mean time the message buffer in the device is filled up and the device halts (aka controlled crash; the device firmware has been designed like this) as there is no more memory on the device.
To avoid this scenario of device's message queue getting filled up because of the user space process not reading them, could you please anyone suggest some technique for getting my user space process scheduled even when there is very heavy traffic as described above.

In simple, i can put my requirement like this:
    Is there any way i can get a user space process get scheduled in the above condition (kernel occupying 100% of CPU due to heavy traffic)

Thanks in Advance.

Regards,
Veerasena.


      Now you can chat without downloading messenger. Go to http://in.messenger.yahoo.com/webmessengerpromo.php
