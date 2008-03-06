Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 10:06:32 +0000 (GMT)
Received: from ti-out-0910.google.com ([209.85.142.191]:23826 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28603243AbYCFKGa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Mar 2008 10:06:30 +0000
Received: by ti-out-0910.google.com with SMTP id j3so2455997tid.20
        for <linux-mips@linux-mips.org>; Thu, 06 Mar 2008 02:06:27 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=yzyTJlZxWmvXKsp4OVVyFxBrxkuWU4qbdCbKCc/k+zc=;
        b=Bt4o0yXo9Sh9ymJMtkj5TjbzfF7zmOEE6PVSdVQkT7AjyYO4P+WUZFYoDtseOAYj28NTcsXFEOvD4Ji2ZN/HciVGHDmsuPoMNEDUhwkptjDggvRbcNK/PzLx7k0qSEROa4IJIE9rSpsku0IRSdIEJnhVmRaTkup++cazlLtiLoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=syeQ4YXUVKh41UH2eJxMQCd7YXhBI2m+sG8Sn+imT77JP9/ixD/3T5C8gcxVSfmIhTuSWaPXj1GI0NGJLDTG+cTmsB54Nd+fpY+EQSSzBoWeYGBE5L8CepQR1ffJbCntSGZVS221zoktsyVRI7YiBfeq4plUoVaH35ZU61lLD9E=
Received: by 10.150.192.7 with SMTP id p7mr1826730ybf.90.1204797986035;
        Thu, 06 Mar 2008 02:06:26 -0800 (PST)
Received: by 10.151.14.12 with HTTP; Thu, 6 Mar 2008 02:06:26 -0800 (PST)
Message-ID: <56ef64000803060206n44a3b611h831effa4132d33b5@mail.gmail.com>
Date:	Thu, 6 Mar 2008 15:36:26 +0530
From:	"learn linux" <learn.mips.linux@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Need info in booting kernel using JTAG
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_24066_11345285.1204797986021"
Return-Path: <learn.mips.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: learn.mips.linux@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_24066_11345285.1204797986021
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

                 I am beginner to the Linux and JTAG. I have a board using
Infineon's "INCA-IP PSB 21553/PSB 21521 (which has MIPS 4kc core). I want to
boot the linux kernel in JTAG mode. I am using Lauterbach Trace32 tool,
which runs on a windows PC.
    I had gone through the help files provided in Trace 32 itself. It
mentions about the usage of the tool. But I need information about how to
make a setup in such a way that I could boot the kernel in JTAG mode.
Basically I wanted to debug a kernel module.

    Please guide how to make this setup and what are the things that I
should take care in achieving the same.

Thanks in advance,
Sudeep.

------=_Part_24066_11345285.1204797986021
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="ppt" id="_user_linux-mips@linux-mips.org">Hi all,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I am beginner to the Linux and JTAG. I have a board using Infineon&#39;s
&quot;INCA-IP PSB 21553/PSB 21521 (which has MIPS 4kc core). I want to boot
the linux kernel in JTAG mode. I am using Lauterbach Trace32 tool,
which runs on a windows PC.<br>
&nbsp;&nbsp;&nbsp; I had gone through the help files provided in Trace
32 itself. It mentions about the usage of the tool. But I need
information about how to make a setup in such a way that I could boot
the kernel in JTAG mode. Basically I wanted to debug a kernel module.<br>
<br>
&nbsp;&nbsp;&nbsp; Please guide how to make this setup and what are the things that I should take care in achieving the same.<br>
<br>
Thanks in advance,<br>
Sudeep.<br>
</span>

------=_Part_24066_11345285.1204797986021--
