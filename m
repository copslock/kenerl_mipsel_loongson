Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 05:20:03 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.181]:61690 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021723AbXGTET6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 05:19:58 +0100
Received: by wa-out-1112.google.com with SMTP id m16so848834waf
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 21:19:38 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=XV7zfDWurITxLxszlsNJDWn6Xc1m1rdzam8gRM5WuKhq2OPnVZc5TqIY4hCfIdhSnsrKz6YbmcBrsa9uLZtySrnW30INTnMQmdH9Lt3eZ7fvs1C2eGq/Mb2NbfyuxV1OtNwGOZjq4b0VKLNWGXuFJ63biPtVMUyNv45Q4AEYW2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=JW0xOcSKXMwWwrHRE+YiAEcVImgs+VUmC/TY3TbZ5T7uFwTsqs46DUv8SMgwC+9jXZVGK5xMMpxsLmgH9iuBdPDueEyF3AHGMBukdiFjOlbu+TpWsJJy0BrCsUCLRHF/J1H978SnzPLDBeezq7B0hlmbu5Ff5qeUbe3PUnLR2f4=
Received: by 10.115.78.1 with SMTP id f1mr93081wal.1184905178712;
        Thu, 19 Jul 2007 21:19:38 -0700 (PDT)
Received: by 10.114.110.6 with HTTP; Thu, 19 Jul 2007 21:19:38 -0700 (PDT)
Message-ID: <b2b2f2320707192119i43ede918y888c86e7ae4f8add@mail.gmail.com>
Date:	Thu, 19 Jul 2007 22:19:38 -0600
From:	"Shane McDonald" <mcdonald.shane@gmail.com>
To:	sadarul.firos@nestgroup.net
Subject: RE: "Segfault/illegal instruction" - udevd - ntpd - glibc
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_119819_14579621.1184905178649"
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_119819_14579621.1184905178649
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Sadarul:

  I'm not sure if you've found a solution to your problem with udevd and
ntpd dying during your repetitive bootups.  As Ralf has pointed out, it
sounds like a TLB or cache management problem.  I believe it is the same
problem that I've run across using the PMC-Sierra Xiao Hu board, whose
solution is described here:
http://www.linux-mips.org/archives/linux-mips/2007-07/msg00205.html.

  The XH is basically the same platform as your MIPSEL board.  Looking at
the code to your BSP, release 1.8.3, I can see that the described workaround
will not be used for either of your boards.  I know definitely that the
workaround is required for your MIPSEL platform; I suspect it is also
required for the MIPS board you have, as that is using the RM9150 which uses
the E9000 core.

  Anyways, give that fix a try and see how it goes.  I'll bet it will solve
your problem.

Shane

------=_Part_119819_14579621.1184905178649
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Sadarul:<br><br>&nbsp; I&#39;m not sure if you&#39;ve found a solution to your problem with udevd and ntpd dying during your repetitive bootups.&nbsp; As Ralf has pointed out, it sounds like a TLB or cache management problem.&nbsp; I believe it is the same problem that I&#39;ve run across using the PMC-Sierra Xiao Hu board, whose solution is described here: 
<a href="http://www.linux-mips.org/archives/linux-mips/2007-07/msg00205.html">http://www.linux-mips.org/archives/linux-mips/2007-07/msg00205.html</a>.<br><br>&nbsp; The XH is basically the same platform as your MIPSEL board.&nbsp; Looking at the code to your BSP, release 
1.8.3, I can see that the described workaround will not be used for either of your boards.&nbsp; I know definitely that the workaround is required for your MIPSEL platform; I suspect it is also required for the MIPS board you have, as that is using the RM9150 which uses the E9000 core.
<br><br>&nbsp; Anyways, give that fix a try and see how it goes.&nbsp; I&#39;ll bet it will solve your problem.<br><br>Shane<br>

------=_Part_119819_14579621.1184905178649--
