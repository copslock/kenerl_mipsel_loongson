Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 14:27:52 +0000 (GMT)
Received: from web35408.mail.mud.yahoo.com ([66.163.179.117]:58246 "HELO
	web35408.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S23931844AbYKZO1p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Nov 2008 14:27:45 +0000
Received: (qmail 26096 invoked by uid 60001); 26 Nov 2008 14:27:36 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=mqCV7LfVdFNyPl8FLXwyG4RBe9/8ZfwK8YayIiU9hWAE3+71EOvzX1ii2rtk3xnHKzvPVKScDrfXoCeoPHjkT/Ria0WwK+NRW5WwBq4AYcq1mbQ8J4S/SlUdGugmSjxJQZpUnlk6bp01WBWsUODX+KPiPaz0BBPl1BVFUsQTP7c=;
X-YMail-OSG: agdWzBgVM1nTlYMggsKv8sR7N4ifyp07Jzv88e9os2h6VSvNseFa.xRwgVDm1WICvsJ97HHDJ0taElnBtIbzoMe30q0D2jPv_ta17NajF5l.CNY0ovgmYoRGY6xJKir6pbrhyIVDfZgdb9aFJkyNJSvMyo15r7AgoacmiTzSpOLnsOxJ6MEtGiBuaZI-
Received: from [170.129.50.120] by web35408.mail.mud.yahoo.com via HTTP; Wed, 26 Nov 2008 06:27:36 PST
X-Mailer: YahooMailWebService/0.7.260.1
Date:	Wed, 26 Nov 2008 06:27:36 -0800 (PST)
From:	jscottkasten@yahoo.com
Reply-To: jscottkasten@yahoo.com
Subject: Re: Looking for Extreme graphics technical documentation
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-866311890-1227709656=:25969"
Message-ID: <512303.25969.qm@web35408.mail.mud.yahoo.com>
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-866311890-1227709656=:25969
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dmitri,

I'm going to wish you luck here.=A0 I should point you to this thread betwe=
en "Kumba" and myself over on the Gentoo Mips list from days long past.

http://www.gossamer-threads.com/lists/gentoo/mips/58437

In short, someone did get basic functionality, but wouldn't release his wor=
k for anyone to see.=A0 I tried nicely to contact the guy a few times mysel=
f.=A0 No dice.

Regards,

-S-

--- On Tue, 11/25/08, Dmitri Vorobiev <dmitri.vorobiev@gmail.com> wrote:
From: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Subject: Looking for Extreme graphics technical documentation
To: linux-mips@linux-mips.org
Date: Tuesday, November 25, 2008, 5:49
 PM

Hi,

I am looking for Extreme graphics technical documentation. Indigo2
PROM reports the graphics board as follows:

controller display SGI-GU1-Extreme key 0 ( ConsoleOut Output )
p: video(0)
  peripheral monitor key 0
  p: video(0)monitor(0)

So far I have been able to find (apart from a handful of marketing
documents) only the following two sources:

http://en.wikipedia.org/wiki/Extreme_Graphics
http://www.futuretech.blinkenlights.nl/i2sec5.html#5.6

These, however, do not seem to be enough to write a console driver.

Can anyone help, please?

Thanks,
Dmitri


--0-866311890-1227709656=:25969
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><div id="yiv1599467549">Hi Dmitri,<br><br>I'm going to wish you luck here.&nbsp; I should point you to this thread between "Kumba" and myself over on the Gentoo Mips list from days long past.<br><br>http://www.gossamer-threads.com/lists/gentoo/mips/58437<br><br>In short, someone did get basic functionality, but wouldn't release his work for anyone to see.&nbsp; I tried nicely to contact the guy a few times myself.&nbsp; No dice.<br><br>Regards,<br><br>-S-<br><br>--- On <b>Tue, 11/25/08, Dmitri Vorobiev <i>&lt;dmitri.vorobiev@gmail.com&gt;</i></b> wrote:<br><blockquote style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">From: Dmitri Vorobiev &lt;dmitri.vorobiev@gmail.com&gt;<br>Subject: Looking for Extreme graphics technical documentation<br>To: linux-mips@linux-mips.org<br>Date: Tuesday, November 25, 2008, 5:49
 PM<br><br><pre>Hi,<br><br>I am looking for Extreme graphics technical documentation. Indigo2<br>PROM reports the graphics board as follows:<br><br>controller display SGI-GU1-Extreme key 0 ( ConsoleOut Output )<br>p: video(0)<br>  peripheral monitor key 0<br>  p: video(0)monitor(0)<br><br>So far I have been able to find (apart from a handful of marketing<br>documents) only the following two sources:<br><br>http://en.wikipedia.org/wiki/Extreme_Graphics<br>http://www.futuretech.blinkenlights.nl/i2sec5.html#5.6<br><br>These, however, do not seem to be enough to write a console driver.<br><br>Can anyone help, please?<br><br>Thanks,<br>Dmitri<br><br></pre></blockquote></div></td></tr></table>
--0-866311890-1227709656=:25969--
