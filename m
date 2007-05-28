Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2007 10:32:51 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.181]:15871 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022409AbXE1Jcq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 May 2007 10:32:46 +0100
Received: by py-out-1112.google.com with SMTP id f31so2734278pyh
        for <linux-mips@linux-mips.org>; Mon, 28 May 2007 02:31:44 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=o4feyY+4ncmPDogIjceJ9zOSzNdLz/GUtji7jmVf8rwZ3JaQX2xq/kHlZXerXljG2x4UuxSGdxQGBHrv3h9Dxr4rPpQHPBxWBGOkGkcKLolBZqPcyj2zUr7vuAijeAZ8RIXQiHLOgYSVm+qgqyk3Tr6sl0RiGJxgX33/x+fLssY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=TZdKvizFtMp4uFs6eBMoYhZPzyYcevNCRJpMiixroIpkX2rTPFjcTRy1F2sbnTp+kQzKP3Ecl39zqnpySMg0vameno87e2JDuSewgcSL9MmvsoVersPSrR240ZC5siXtKO9K1zuIgy0xPXDeU90WyFJY1a2iv4FaIolLwgV42a0=
Received: by 10.35.119.8 with SMTP id w8mr4681658pym.1180344704235;
        Mon, 28 May 2007 02:31:44 -0700 (PDT)
Received: from ?192.168.2.194? ( [218.22.26.90])
        by mx.google.com with ESMTP id c1sm6755892nzd.2007.05.28.02.31.41;
        Mon, 28 May 2007 02:31:43 -0700 (PDT)
Message-ID: <465AA16C.1020704@gmail.com>
Date:	Mon, 28 May 2007 17:31:24 +0800
From:	Changrui Zhang <ccdump@gmail.com>
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Q: au1200 RCSn signal
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <ccdump@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ccdump@gmail.com
Precedence: bulk
X-list: linux-mips

Hi!
I am learning ide driver based on AU1200 and the kernel is 2.6.11.The
CROSS_COMPILE I used is
gcc-3.3.5-glibc-2.3.2/mipsel-unknown-linux-gnu.When the ide driver used
RCS2 controller, it worked well.But when i change to use RCS1
controler,it didn't work.The both register MEM_STCFG and MEM_STTIME are
set same: MEM_STCFG 0xfe2401c6 MEM_STTIME 0x7f7ffc3f.I set the time to
max for testing.The RCS2 io_base is 0x18000000,the RCS1 io_base is
0x0c000000.So I set MEM_STADDR1 to 0x10c03f00.
I used the fallowing codes for testing:
while(1){
au_writeb(0xff,0xac000000);
}
I can't see any singal,such as CS,WE,DATA.But I added "udelay(4);" in
the while circle or just change au_writeb to au_readb(0xac000000),I
counld see all the signal is right(has signal).The testing codes as fallow:
while(1){
au_readb(0xac000000);
}
and
while(1){
udelay(4);
au_writeb(0xff,0xac000000)
}
In the testing,the IDE is not connected,as I just want to test the
signal is good or not.
Could someone tell me what wrong it is?Is there any different init
setting between RCS1 and RCS2?How I could make the RCS1 work?
I also come to the U-boot(U-boot1.1.4) to do the same testing after the
reset.The result is same.


reset:
#if 1
li t0, 0xb4001018 /*cs1 addr reg*/
li t1, 0x00
sw t1, 0(t0)

li t0, 0xb4001010/*cfg reg*/
li t1, 0xfe2401c6
sw t1, 0(t0)

li t0, 0xb4001014/*timer reg*/
li t1, 0x7f7ffc3f
sw t1, 0(t0)

li t0, 0xb4001018
li t1, 0x10c03f00
sw t1, 0(t0)

loop: li t0, 0xac000000
li t1, 0xff
sb t1, 0(t0)
b loop
#endif /*for test lzcx add*/
The test changing to CS2 control is good.

Thanks for your help in advance.


Mr.liang
