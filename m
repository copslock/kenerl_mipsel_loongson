Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2005 08:38:08 +0100 (BST)
Received: from web15807.mail.cnb.yahoo.com ([IPv6:::ffff:202.165.102.87]:21855
	"HELO web15807.mail.cnb.yahoo.com") by linux-mips.org with SMTP
	id <S8224953AbVC3Hhw>; Wed, 30 Mar 2005 08:37:52 +0100
Message-ID: <20050330073742.28983.qmail@web15807.mail.cnb.yahoo.com>
Received: from [210.76.108.109] by web15807.mail.cnb.yahoo.com via HTTP; Wed, 30 Mar 2005 15:37:42 CST
Date:	Wed, 30 Mar 2005 15:37:42 +0800 (CST)
From:	dfsd df <tomcs163@yahoo.com.cn>
Subject: Some questions about kernel tailoring
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1799187920-1112168262=:27399"
Content-Transfer-Encoding: 8bit
Return-Path: <tomcs163@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomcs163@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

--0-1799187920-1112168262=:27399
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello, everybody:
     Now, I participate to porting linux to MIPS platform. I'm a newbie.
 
     I met some questions, I hope somebody can tell me why or give me some hints! thanks!
 
The board is Malta, CPU is MIPS4kc. I downloaded kernel src from ftp.mips.com
 
    1. I use "make zImage" for kernel-2.4.3, everything is ok!
 But using "make zImage" for kernel-2.4.18, I failed, It could only build a vmlinux file. 
I  find it's because of no rules in arch/mips/boot/Makefile to build zImage. 
So I modified the arch/mips/boot/Makefile, It worked fine.
 but when excuted "./mkboot zImage.tmp zImage", It generated a very big zImage file. After noticing "file size exceed", the system delete the zImage file automatically!
 
what's wrong about it? It's ok for kernel-2.4.3. and I can make sure that the mkboot is no problem.
 
2. I only selectd board and cpu type when compiling the kernel-2.4.3. 
If using make ,the vmlinux size is about 780k. If using "make zImage", the zImage file is about 580k.
I think that's a minimun size by using "make menuconfig". 
but I use gzip to compress this two files, its size became only 1/3 of their original size.
 
So I'm puzzled why "make zImage" don't use gzip compress method? If so , we can get a more small kernel, isn't it?
 
thanks again!
 



---------------------------------
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
美女明星应有尽有，搜遍美图、艳图和酷图
1G就是1000兆，雅虎电邮自助扩容！
--0-1799187920-1112168262=:27399
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>Hello, everybody:</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; Now, I&nbsp;participate to porting linux to MIPS platform. I'm a newbie.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; I met some questions, I hope somebody can tell me why or give me some hints! thanks!</DIV>
<DIV>&nbsp;</DIV>
<DIV>The board is Malta, CPU is MIPS4kc. I downloaded kernel src from <A href="ftp://ftp.mips.com">ftp.mips.com</A></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; 1. I use "make zImage" for kernel-2.4.3, everything is ok!</DIV>
<DIV>&nbsp;But using&nbsp;"make zImage" for kernel-2.4.18, I failed, It could only build a&nbsp;vmlinux file. </DIV>
<DIV>I&nbsp;&nbsp;find it's because of no rules in arch/mips/boot/Makefile to build zImage. </DIV>
<DIV>So I&nbsp;modified the arch/mips/boot/Makefile, It worked fine.</DIV>
<DIV>&nbsp;but when excuted "./mkboot zImage.tmp zImage", It generated a&nbsp;very big zImage file. After noticing "file size exceed", the&nbsp;system delete the zImage file automatically!</DIV>
<DIV>&nbsp;</DIV>
<DIV>what's wrong about it? It's ok for kernel-2.4.3. and I can make sure that the mkboot is no problem.</DIV>
<DIV>&nbsp;</DIV>
<DIV>2. I only selectd board and cpu type when compiling the kernel-2.4.3. </DIV>
<DIV>If using make ,the vmlinux size is about&nbsp;780k.&nbsp;If using "make zImage", the zImage file is about 580k.</DIV>
<DIV>I think that's a minimun size by using "make menuconfig". </DIV>
<DIV>but I use gzip to compress this two files, its size became only 1/3 of their original size.</DIV>
<DIV>&nbsp;</DIV>
<DIV>So I'm puzzled why "make zImage" don't use gzip compress method? If so , we can get a more small kernel, isn't it?</DIV>
<DIV>&nbsp;</DIV>
<DIV>thanks again!</DIV>
<DIV>&nbsp;</DIV><p><br><hr size=1><b>Do You Yahoo!?</b><br>
<a href="http://music.yisou.com" target=blank>150万曲MP3疯狂搜，带您闯入音乐殿堂</a><br><a href="http://image.yisou.com" target=blank>美女明星应有尽有，搜遍美图、艳图和酷图</a><br>
<a href="http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/" target=blank>1G就是1000兆，雅虎电邮自助扩容！</a>
--0-1799187920-1112168262=:27399--
