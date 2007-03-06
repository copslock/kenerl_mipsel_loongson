Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 08:16:33 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.249]:29691 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20021344AbXCFIQG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Mar 2007 08:16:06 +0000
Received: by an-out-0708.google.com with SMTP id c8so1598998ana
        for <linux-mips@linux-mips.org>; Tue, 06 Mar 2007 00:16:03 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=XS3/oSqi6gX/1KKa+gg9Vs7NmAf/Y9AiX7wKrzpYickd8dB3F4DdwxlyUU+rGt/XctnqZl5kAzyXYLHTgT0Czdd8Rm1ukTk4tR54RXl9izuNKff5vAlKP5Zluo3+jBVw1GHi7yIqDAznxDDKQXAjS9cQnxzuISv/vjJc7npxi28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=BTIsMbt0ReEYY0If9SvLT+C4AOBQnRHODvaAlqcp4Wwow/EN+lJdzr4Yc237rDOcvDBpdA8evZSM+XdBwfiLPtoslUq7PM/Aw0Kxue9qw9D38M7Kp9BymD0gTE4WUsCvEiM4pgwTdaLHEtetNEpTuNslNpZa3VW4lNZXpQnZtjY=
Received: by 10.114.193.1 with SMTP id q1mr1634889waf.1173168963406;
        Tue, 06 Mar 2007 00:16:03 -0800 (PST)
Received: by 10.114.80.18 with HTTP; Tue, 6 Mar 2007 00:16:03 -0800 (PST)
Message-ID: <d459bb380703060016o350e4070w77d2954071f3c40a@mail.gmail.com>
Date:	Tue, 6 Mar 2007 09:16:03 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: Linux kernel 2.6.20, PCI and hpt266
Cc:	linux-mips@linux-mips.org
In-Reply-To: <45EC101D.8050600@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_156766_29971928.1173168963355"
References: <d459bb380703040427g4a8cad08kd8e3190f7d109c86@mail.gmail.com>
	 <45EC101D.8050600@ru.mvista.com>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_156766_29971928.1173168963355
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have a quick update on the situation. I've compiled kernel 2.6.17.14 for
the same architecture and the hard disk controller works. Moreover I've
imported the new hpt366.c driver from kernel 2.6.20 into kernel 2.6.17 and
it works perfectly, managing the "missing first channel" issue with 371N
without a problem. Still I'd like to understand where is the problem with
kernel 2.6.20. It seems to me that resource and pci mamagement has changed a
lot, sadly I'm not experienced enough to understand the exact details or
follow up the problem. My only clue here is that "inb" does not work
correctly on PCI I/O mapped registers.

Thank you for any help on this issue!

------=_Part_156766_29971928.1173168963355
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I have a quick update on the situation. I&#39;ve compiled kernel <a href="http://2.6.17.14">2.6.17.14</a> for the same architecture and the hard disk controller works. Moreover I&#39;ve imported the new hpt366.c
 driver from kernel 2.6.20 into kernel 2.6.17 and it works perfectly, managing the &quot;missing first channel&quot; issue with 371N without a problem. Still I&#39;d like to understand where is the problem with kernel 2.6.20
. It seems to me that resource and pci mamagement has changed a lot, sadly I&#39;m not experienced enough to understand the exact details or follow up the problem. My only clue here is that &quot;inb&quot; does not work correctly on PCI I/O mapped registers.
<br><br>Thank you for any help on this issue!<br><br><br>

------=_Part_156766_29971928.1173168963355--
