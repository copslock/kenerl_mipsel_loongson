Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Mar 2006 21:28:09 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.200]:20391 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133620AbWCWV2A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Mar 2006 21:28:00 +0000
Received: by zproxy.gmail.com with SMTP id x7so576968nzc
        for <linux-mips@linux-mips.org>; Thu, 23 Mar 2006 13:37:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=F8ZhSaA84ts2qjR65N0I849Ja/G1ADKFcsL74qOBHZ+9wUaE2i6RXqWg3ItrNaGWl3rkc3YX4WFlBaiLzLGoY3g63S7+5obsJa5XdIfJvBrJxFzkW5qBCNsbo7iKhrNCPaB/T8nzVPFc6nAI9QIlmPpj0xbAe5RmkqGgXq/nHvk=
Received: by 10.65.232.17 with SMTP id j17mr83580qbr;
        Thu, 23 Mar 2006 13:37:56 -0800 (PST)
Received: by 10.65.154.10 with HTTP; Thu, 23 Mar 2006 13:37:56 -0800 (PST)
Message-ID: <7f0c7cce0603231337g3d6534c9p@mail.gmail.com>
Date:	Thu, 23 Mar 2006 16:37:56 -0500
From:	"Eric Gaulin" <eric.gaulin@gmail.com>
Reply-To: eric@egaulin.com
To:	linux-mips@linux-mips.org
Subject: insmod: ELF file not for this architecture
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8490_15127623.1143149876524"
Return-Path: <eric.gaulin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.gaulin@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_8490_15127623.1143149876524
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I built linux 2.6.11 with amd patch for Alchemy Au1200 and also built the
mae-driver.ko. When i load the driver i get this error "insmod: ELF file no=
t
for this architecture". I was told on #elinux irc channel tha i need to
enable ELF support in my kernel configuration! There is no such option!

Is anybody have any hints to solve that?

TIA.

------=_Part_8490_15127623.1143149876524
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I built linux 2.6.11 with amd patch for Alchemy Au1200 and also built
the mae-driver.ko. When i load the driver i get this error &quot;insmod: EL=
F
file not for this architecture&quot;. I was told on #elinux irc channel tha
i need to enable ELF support in my kernel configuration! There is no
such option!<br>
<br>
Is anybody have any hints to solve that?<br>
<br>
TIA.<br>
<br>

------=_Part_8490_15127623.1143149876524--
