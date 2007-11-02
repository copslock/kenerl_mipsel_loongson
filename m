Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2007 05:05:23 +0000 (GMT)
Received: from n7.bullet.mud.yahoo.com ([216.252.100.58]:29071 "HELO
	n7.bullet.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20023061AbXKBFFN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2007 05:05:13 +0000
Received: from [68.142.194.244] by n7.bullet.mud.yahoo.com with NNFMP; 02 Nov 2007 05:03:51 -0000
Received: from [209.191.119.173] by t2.bullet.mud.yahoo.com with NNFMP; 02 Nov 2007 05:03:51 -0000
Received: from [127.0.0.1] by omp104.mail.mud.yahoo.com with NNFMP; 02 Nov 2007 05:03:51 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 580923.52540.bm@omp104.mail.mud.yahoo.com
Received: (qmail 37262 invoked by uid 60001); 2 Nov 2007 05:03:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=HYIk+tGdJDYOhaamjMBrgvatfLo9/N2VcppwpN6wyMBe6xI98kJuhtOzMrpaEVxE037ykOc8zScVXVf1Xwghq1etCxlfKHrZ/0yoiBaGmtXEoy5xbvvyXqkrHxC7x/4IqyOOWpEmtzpvx5JM5SpeS8h8rIA1tci67XEuZimnu6o=;
X-YMail-OSG: zcBAlgsVM1npj70zcSTiGKcAZF7C7USAUiLvHnXTJXeIPTTwW_JswRhF_ZtVklRV94A5UehWBfeosFm8jwJCRpHyURwMNskOtDPXOpnme28Rl3Z2HZ8oMzJwk02xHg--
Received: from [199.239.167.162] by web8414.mail.in.yahoo.com via HTTP; Fri, 02 Nov 2007 10:33:49 IST
X-Mailer: YahooMailRC/814.06 YahooMailWebService/0.7.134.12
Date:	Fri, 2 Nov 2007 10:33:49 +0530 (IST)
From:	veerasena reddy <veerasena_b@yahoo.co.in>
Subject: NPTL support
To:	uclibc@uclibc.org, linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>,
	buildroot@uclibc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <335463.37228.qm@web8414.mail.in.yahoo.com>
Return-Path: <veerasena_b@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: veerasena_b@yahoo.co.in
Precedence: bulk
X-list: linux-mips

Hi,

I am trying to build the toolchain for MIPS processor using buildroot.
I am using gcc version of 3.4.3, binutils-2.15, uclibc-0.9.28 and linux-2.6.18.8 kernel.

Basically i need to enable NPTL feature support in my toolchain.
does uclibc-0.9.28 has the support for NPTL?
If not, how can i get it enabled for my above build configuration?

I see there is separate branch "uclibc-nptl" in uclibc. 
Do i need to use this (uclibc-nptl) to meet my requirement?

Could you please suggest me right approach to succssfully enable NPTL?

Thanks in advance.

Regards,
Veerasena.


      Why delete messages? Unlimited storage is just a click away. Go to http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html
