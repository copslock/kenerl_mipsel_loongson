Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 06:50:47 +0100 (BST)
Received: from web41209.mail.yahoo.com ([IPv6:::ffff:66.218.93.42]:2990 "HELO
	web41209.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225193AbTGWFup>; Wed, 23 Jul 2003 06:50:45 +0100
Message-ID: <20030723055031.64921.qmail@web41209.mail.yahoo.com>
Received: from [64.132.226.151] by web41209.mail.yahoo.com via HTTP; Wed, 23 Jul 2003 15:50:31 EST
Date: Wed, 23 Jul 2003 15:50:31 +1000 (EST)
From: =?iso-8859-1?q?fpga=20dsp?= <fpga_dsp@yahoo.com.au>
Subject: Debug linux kernel with bdi2000 debugger?
To: linux-mips@linux-mips.org
In-Reply-To: <56BEF0DBC8B9D611BFDB00508B5E263410301E@tlexposeidon.teralogic-inc.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1099539574-1058939431=:64324"
Content-Transfer-Encoding: 8bit
Return-Path: <fpga_dsp@yahoo.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fpga_dsp@yahoo.com.au
Precedence: bulk
X-list: linux-mips

--0-1099539574-1058939431=:64324
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hi all,

I just got my hand on a bdi2000 debugger recently and try to play around with it. It does everything i want but i am trying to figure out how to debug linux kernel. The linux kernel from AMD is used on a db1500 board. I did enable debuging option -g in the makefile, load it into the target and run it. But in the minicom window i alway got the TLB exception ( on load or store or instruction fetch). 

I suspect that i didn't initialize TLB table so it will cause the above error. However, what doesn't make sense to me is:

The same kernel, if i loaded using yamon through ethernet, it booted ok even i didn't initialize TLB table. Now if I loaded it by bdi2000, and run by bdi2000, it cause exception. In both methods, the hardware is initialized by yamon code. My assumption that it is the same in both case. So what is the difference? Any explanation will be appreciated. And am i correct that I need to initialize TLB before boot the kernel in bdi2000 ?

Many thanks!

Khuong



---------------------------------
Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
--0-1099539574-1058939431=:64324
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<P>Hi all,</P>
<P>I just got my hand on a bdi2000 debugger recently and try to play around with it. It does everything i want but i am trying to figure out how to debug linux kernel. The linux kernel from AMD is used on a db1500 board. I did enable debuging option -g in the makefile, load it into the target and run it. But in the minicom window i alway got the TLB exception ( on load or store or instruction fetch). </P>
<P>I suspect that i didn't initialize TLB table so it will cause the above error. However, what doesn't make sense to me is:</P>
<P>The same kernel, if i loaded using yamon through ethernet, it booted ok even i didn't initialize TLB table. Now if I loaded it by bdi2000, and run by bdi2000, it cause exception. In both methods, the hardware is initialized by yamon code. My assumption that it is the same in both case. So what is the difference? Any explanation will be appreciated. And am i correct that I need to initialize TLB before boot the kernel in bdi2000 ?</P>
<P>Many thanks!</P>
<P>Khuong</P><p><br><hr size=1>
<a href="http://au.rd.yahoo.com/mail/tagline/?http://au.mobile.yahoo.com/sms/mail/index.html" target=_blank><b>Yahoo! Mobile</b></a><br>
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
--0-1099539574-1058939431=:64324--
