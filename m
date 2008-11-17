Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2008 21:24:19 +0000 (GMT)
Received: from yx-out-1718.google.com ([74.125.44.152]:13975 "EHLO
	yx-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S23731857AbYKQVYM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Nov 2008 21:24:12 +0000
Received: by yx-out-1718.google.com with SMTP id 36so1040223yxh.24
        for <linux-mips@linux-mips.org>; Mon, 17 Nov 2008 13:24:08 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:x-google-sender-auth;
        bh=s+h6wAB43fQ1nrE1fGzoiHnKJEeNgAOQzNCTmpEfmQs=;
        b=sNgJon8W+fjxR/C7/xIxrtT5FsWcP87t8iRQEQWwMax2AgwMzIImyFSWpeg4QmLzaR
         m7WR2Hq1dkmn2/mJ/PQvL0N/Fws9jeba37QhRllAiU/iXfN/njgWgYNP3ntaiiXjVOkj
         gO7k2acSLfOpQbxGI7w1KNdosEOKzq+3yisXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :x-google-sender-auth;
        b=bLaTMyQ+uPWnK1KEbTI9+Z3zhR7C1cDmLr5HVG0moEOVEMPiQNZOhGtLUzBIpzazZM
         4XcVB9oxyB1Y7w/aWGQmRO6hpsHrWPEve2M/hBEtwYWH+K9Yb/90qx2Y1A7ajaI/S7a3
         64usQT6QAK4HmoN5qD+89MgkD5h6Fx18u/Y3M=
Received: by 10.142.231.7 with SMTP id d7mr2185003wfh.90.1226957047254;
        Mon, 17 Nov 2008 13:24:07 -0800 (PST)
Received: by 10.142.72.14 with HTTP; Mon, 17 Nov 2008 13:24:07 -0800 (PST)
Message-ID: <e8180c7f0811171324i35da6933mc29ce386afb7393a@mail.gmail.com>
Date:	Mon, 17 Nov 2008 13:24:07 -0800
From:	"Prasad B" <bprasad@cs.arizona.edu>
To:	linux-mips@linux-mips.org
Subject: traditional signal support in 64-bit mips linux
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_67550_32171699.1226957047254"
X-Google-Sender-Auth: fd6293bfa65d7fc1
Return-Path: <p.boddupalli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bprasad@cs.arizona.edu
Precedence: bulk
X-list: linux-mips

------=_Part_67550_32171699.1226957047254
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello All,

Is traditional signal support, enabled by the flag CONFIG_TRAD_SIGNALS
proscribed in 64-bit mode ?

In arch/mips/kernel/signal.c, functions sys_sigsuspend(), sys_sigaction(),
sys_sigreturn(), setup_frame() are conditionally compiled, depending on
whether the flag CONFIG_TRAD_SIGNALS is defined or not. If one defines the
constant, the compilation fails as the constants such as __NR_sigreturn are
not defined in asm-mips/unistd.h for 64-bit mips.


Does it mean that only realtime signals are supposed to be used in 64-bit
mode ?

thank you,
Prasad.

------=_Part_67550_32171699.1226957047254
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello All,<br><br>Is traditional signal support, enabled by the flag CONFIG_TRAD_SIGNALS proscribed in 64-bit mode ?<br><br>In arch/mips/kernel/signal.c, functions sys_sigsuspend(), sys_sigaction(), sys_sigreturn(), setup_frame() are conditionally compiled, depending on whether the flag CONFIG_TRAD_SIGNALS is defined or not. If one defines the constant, the compilation fails as the constants such as __NR_sigreturn are not defined in asm-mips/unistd.h for 64-bit mips. <br>
<br><br>Does it mean that only realtime signals are supposed to be used in 64-bit mode ?<br><br>thank you,<br>Prasad.<span class="HcCDpe"><span class="JDpiNd"></span></span>

------=_Part_67550_32171699.1226957047254--
