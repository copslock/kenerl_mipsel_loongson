Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 08:35:12 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.179]:14812 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20027085AbXJOHfC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 08:35:02 +0100
Received: by py-out-1112.google.com with SMTP id p76so2977666pyb
        for <linux-mips@linux-mips.org>; Mon, 15 Oct 2007 00:34:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=UqZEJ8/VVh9sN/kZSHeuK+QYrjUZ0CpyNRB6UBZA+Q4=;
        b=PA0Y4OPN1Ou/+JLNz/Id4YOzU0Ce/w4n+qPtLK2z3G4gHQuZNo9AGQNTmglTEQ1n807BOu7vOnE/Gtk+pRENlcd8zOqo8AQ+WH0/RV6KQHe0raurF9XAuxV/5eHtpcPaFcjVlnO/tT+IEcedi9UhvOGzfYruDDfdhKYv5w5l/ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=kQT/bZwXr5tdrcm4Je2VRVv9RVBaq5IGhAtQEdImrhTLvfLxPcQEQgZshbP+qPjinvMQ2/DDuENAOjF+a/RiZTZguLo9HvCE5FC6jZF8oROGYnFPaBBKRPhyGWSP0ydc60NyvE2Kewp4aixTSaDi1buDNHWuUBPKUIqg2O7lt4Q=
Received: by 10.35.49.4 with SMTP id b4mr7359816pyk.1192433680516;
        Mon, 15 Oct 2007 00:34:40 -0700 (PDT)
Received: by 10.35.39.19 with HTTP; Mon, 15 Oct 2007 00:34:40 -0700 (PDT)
Message-ID: <eea8a9c90710150034m40be367cmae5a42c028592c8c@mail.gmail.com>
Date:	Mon, 15 Oct 2007 13:04:40 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org, 
	linux-fbdev-users@lists.sourceforge.net.
Subject: insmod: Cannot insert Framebuffer_Driver.ko unknown symbol in module(urgent)
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1216_32461206.1192433680503"
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_1216_32461206.1192433680503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

we have wriitten a framebuffer driver for MIPS platform(cross compiled at
intel86 linux box).
We are installing it by insmod command.
Then we are getting the following error.
Framebuffer_Driver.ko  Cannot insert Framebuffer_Driverko unknown symbol in
module(8) no such file or directory
Also it has some code and function for propertiary graphics code.
For that i have we have added supplementary <supp.ko> file to be linked with
the main frame buffer driver (Framebuffer_Driver.ko )
in the makefile to provide the reference for the symbols for the propertiary
graphics code.
We have added the line LICENCE_MODULE(GPL) in main frame buffer driver
code(Framebuffer_Driver.ko ).

It is giving error that multiple definition of init_module function.
i guess 1 for Framebuffer_Driver.ko  and the other supplementary <supp.ko>
which is linked in the make file.

Could anybody please help to resolve the error?
Thanks in advance.

Regards,
kaka


-- 
Thanks & Regards,
kaka

-- 
Thanks & Regards,
kaka

-- 
Thanks & Regards,
kaka

-- 
Thanks & Regards,
kaka

------=_Part_1216_32461206.1192433680503
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>we have wriitten a framebuffer driver for MIPS platform(cross compiled at intel86 linux box).</div>
<div>We are installing it by insmod command.</div>
<div>Then we are getting the following error.</div>
<div>Framebuffer_Driver.ko &nbsp;Cannot insert Framebuffer_Driverko unknown symbol in module(8) no such file or directory<br>Also it has some code and function for propertiary graphics code.</div>
<div>For that i have we have added supplementary &lt;supp.ko&gt; file to be linked with the main frame buffer driver (Framebuffer_Driver.ko )</div>
<div>in the makefile to provide the reference for the symbols for the propertiary graphics code.</div>
<div>We have added the line LICENCE_MODULE(GPL) in main frame buffer driver code(Framebuffer_Driver.ko ).</div>
<div>&nbsp;</div>
<div>It is&nbsp;giving error&nbsp;that multiple definition of init_module function.</div>
<div>i guess 1 for Framebuffer_Driver.ko&nbsp; and the other supplementary &lt;supp.ko&gt; which is linked in the make file.</div>
<div>&nbsp;</div>
<div>Could&nbsp;anybody please help to resolve the error?</div>
<div>Thanks in advance.<br>&nbsp;</div>
<div>Regards,</div>
<div>kaka</div><br clear="all"><br>-- <br>Thanks &amp; Regards,<br><span>kaka </span><br clear="all"><br>-- <br>Thanks &amp; Regards,<br><span>kaka </span><br clear="all"><br>-- <br>Thanks &amp; Regards,<br><span class="sg">
kaka </span><br clear="all"><br>-- <br>Thanks &amp; Regards,<br>kaka 

------=_Part_1216_32461206.1192433680503--
