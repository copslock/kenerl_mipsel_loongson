Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 17:21:21 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.234]:17121 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039694AbWJIQVT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Oct 2006 17:21:19 +0100
Received: by wr-out-0506.google.com with SMTP id 55so311087wri
        for <linux-mips@linux-mips.org>; Mon, 09 Oct 2006 09:21:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=VSlQ4NPkQfCz81yqLkagikMkq2EPupd3TMkg/+Z7GDQ9mCro7/lGejhimQ5m29W7S9VJKx3/Hqft+NFJgqU4NkuMgRkcjBW9ltGUedwJaBJmueBBeq7m2UN50OdlYeR/QFJopDKAAHCRYHr2XK0WM4M/n9uNrtQ7+BabIgXWb2I=
Received: by 10.90.104.14 with SMTP id b14mr2791707agc;
        Mon, 09 Oct 2006 09:21:18 -0700 (PDT)
Received: by 10.90.66.14 with HTTP; Mon, 9 Oct 2006 09:21:18 -0700 (PDT)
Message-ID: <103e245f0610090921g5348dbd3hd806129e75668763@mail.gmail.com>
Date:	Mon, 9 Oct 2006 18:21:18 +0200
From:	"Igal Chernobelsky" <igalch@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Math-emu issue
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_38565_29102388.1160410878107"
Return-Path: <igalch@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: igalch@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_38565_29102388.1160410878107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I started to use LinuxThread in Linux 2.4 (version
2.4.17_mvl21-malta-mips_fp_le) and sometimes encounter a problem of
arithmetic exception while performing dividing of two variables of double
type. Our MIPS core does not include FPU coprosessor so math-emu is used. Is
there any known problems/patches for kernel math emulation when LinuxThreads
is used?

------=_Part_38565_29102388.1160410878107
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I started to use LinuxThread in Linux 2.4 (version
2.4.17_mvl21-malta-mips_fp_le) and sometimes encounter a problem of
arithmetic exception while performing dividing of two variables of
double type. Our MIPS core does not include FPU coprosessor so math-emu
is used. Is there any known problems/patches for kernel math emulation
when LinuxThreads is used?<br>
<br>

------=_Part_38565_29102388.1160410878107--
