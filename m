Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2007 19:01:35 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.177]:44006 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20033512AbXJMSB0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 13 Oct 2007 19:01:26 +0100
Received: by py-out-1112.google.com with SMTP id p76so2283666pyb
        for <linux-mips@linux-mips.org>; Sat, 13 Oct 2007 11:01:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=n6IeUvlsTHKyzj5LJLdO8c6bCPG7NQYDwVgFndkQ3HM=;
        b=q3vlxSad1xGgxcLdxEnPpMO4KOGzHxYjE3BObdOgbVzsD1Obd3eMJ/BgVvT6jSF4h1NX2E1GK7cSCvy+1Y3BtuXrp3lqJzBISn7pXEatOpyTSW/zlnRsSdfuqPg6fjiAi4ifHYkiBaFWY1hNS2oyGBFMQx/fQclZBb/q5oSKGEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=BMMBFVMZsddRbVdq385Mq32+nH1KejzDtkQPHTgou8cTPCBzZ2vNEp2DaC9r5suK1h/gwllHEiumXAvObKNnK2Dr6nOem+cz4hEbB3TTL+B5CMDQUqkWJsy1OgeZQNAOFKfr1Z5hV/a7U+D8Xc91YB63GzhW/2ja6GVs0mEq1aE=
Received: by 10.35.83.20 with SMTP id k20mr5288918pyl.1192298467520;
        Sat, 13 Oct 2007 11:01:07 -0700 (PDT)
Received: by 10.35.39.19 with HTTP; Sat, 13 Oct 2007 11:01:07 -0700 (PDT)
Message-ID: <eea8a9c90710131101r2a8690f5t80ef21dc756dd50c@mail.gmail.com>
Date:	Sat, 13 Oct 2007 23:31:07 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org.
Subject: insmod: unknown symbol error(updated)
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_67213_21852137.1192298467513"
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_67213_21852137.1192298467513
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

Actually we have wriitten a framebuffer driver for MIPS platform(cross
compiled at intel86 linux box).
We are installing it by insmod command.
Then we are getting the following error.
<name> Cannot insert <name> unknown symbol in module(8) no such file or
directory
Also it has some code and function for propertiary graphics code.
For that i have we have added supplementary <supp.ko> file to be linked with
the main frame buffer driver
in the makefile to provide the reference for the symbols for the propertiary
graphics code.
We have added the line LICENCE_MODULE(GPL) in main frame buffer driver
code(<name>)

Can anybody help in this regard?
Thanks in advance.



-- 
Thanks & Regards,
kaka

-- 
Thanks & Regards,
kaka

------=_Part_67213_21852137.1192298467513
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>Actually we have wriitten a framebuffer driver for MIPS platform(cross compiled at intel86 linux box).</div>
<div>We are installing it by insmod command.</div>
<div>Then we are getting the following error.</div>
<div>&lt;name&gt; Cannot insert &lt;name&gt; unknown symbol in module(8) no such file or directory<br>Also it has some code and function for propertiary graphics code.</div>
<div>For that i have we have added supplementary &lt;supp.ko&gt; file to be linked with the main frame buffer driver </div>
<div>in the makefile to provide the reference for the symbols for the propertiary graphics code.</div>
<div>We have added the line LICENCE_MODULE(GPL) in main frame buffer driver code(&lt;name&gt;)</div>
<div>&nbsp;</div>
<div>Can anybody help in this regard?</div>
<div>Thanks in advance.<br>&nbsp;</div><br clear="all"><br>-- <br>Thanks &amp; Regards,<br><span>kaka </span><br clear="all"><br>-- <br>Thanks &amp; Regards,<br>kaka 

------=_Part_67213_21852137.1192298467513--
