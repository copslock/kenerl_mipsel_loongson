Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 08:05:09 +0100 (BST)
Received: from web94311.mail.in2.yahoo.com ([203.104.16.221]:29551 "HELO
	web94311.mail.in2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022216AbXGLHFH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 08:05:07 +0100
Received: (qmail 94743 invoked by uid 60001); 12 Jul 2007 07:03:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=BhSMRRfuhqaNeHKnzkQlTZ1KEa7Klo7KhkU2jEzdRe0OilPzjbR87TppQMsYfqcZDTiVHEDl0cqfFdBRF8poh6D0oyN5nAVuvNbIoIZL+ZaxOS+HVV6M0aOoxZ463zvJvs+XIY+2PSGVhhRH3kfwHYMd/jz+zLRR/gWe5BrpJmY=;
X-YMail-OSG: HSy9l.sVM1mH6evU3ozbDHxuWRTnQvf.kFZsPvcY4dKQS325RzLzc6cistVFDG1o8g--
Received: from [59.92.36.37] by web94311.mail.in2.yahoo.com via HTTP; Thu, 12 Jul 2007 08:03:54 BST
Date:	Thu, 12 Jul 2007 08:03:54 +0100 (BST)
From:	saravanan <sar_van81@yahoo.co.in>
Subject: yamon on DBAU1200
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1935004644-1184223834=:94566"
Content-Transfer-Encoding: 8bit
Message-ID: <985016.94566.qm@web94311.mail.in2.yahoo.com>
Return-Path: <sar_van81@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sar_van81@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-1935004644-1184223834=:94566
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,

has anyone compiled yamon bootloader ? i tried to compile yamon bootloader (yamon-0227.zip) which came in along with my board -DBAU1200. but i was not successful. the following is the error :

suse:/home/alchemy/ALCHEMY/YAMON/02.27/yamon/bin # make
rm -f ./EL/comptime.o ./EB/comptime.o
mipsel-linux-uclibc-gcc -G 0 -mips32 -mno-abicalls -fno-pic -D_32_ -c -g -O2 -Wimplicit -Wformat '-D_REVMAJ_="02"' '-D_REVMIN_="27GDB1200"' -I./../include -I./../arch/include   -DDB1200_CONFIG=1 -D_ASSEMBLER_ -EL -DEL -o reset.o ./../init/reset/reset.S
mipsel-linux-uclibc-gcc: unrecognized option `-EL'
mipsel-linux-uclibc-ld -G 0 -T ./link/link.xn -o ./reset-02.27GDB1200.elf -Map ./reset-02.27GDB1200.map --oformat elf32-littlemips  reset.o
mipsel-linux-uclibc-ld: target elf32-littlemips not found
make: *** [reset-02.27GDB1200.elf] Error 1


does yamon have support for producing image in little endian format ?

can anyone provide me any suggestions or solutions for this ?

thanks in advance,

saravanan.

       
---------------------------------
 Unlimited freedom, unlimited storage. Get it now
--0-1935004644-1184223834=:94566
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,<br><br>has anyone compiled yamon bootloader ? i tried to compile yamon bootloader (yamon-0227.zip) which came in along with my board -DBAU1200. but i was not successful. the following is the error :<br><br>suse:/home/alchemy/ALCHEMY/YAMON/02.27/yamon/bin # make<br>rm -f ./EL/comptime.o ./EB/comptime.o<br>mipsel-linux-uclibc-gcc -G 0 -mips32 -mno-abicalls -fno-pic -D_32_ -c -g -O2 -Wimplicit -Wformat '-D_REVMAJ_="02"' '-D_REVMIN_="27GDB1200"' -I./../include -I./../arch/include&nbsp;&nbsp; -DDB1200_CONFIG=1 -D_ASSEMBLER_ -EL -DEL -o reset.o ./../init/reset/reset.S<br>mipsel-linux-uclibc-gcc: unrecognized option `-EL'<br>mipsel-linux-uclibc-ld -G 0 -T ./link/link.xn -o ./reset-02.27GDB1200.elf -Map ./reset-02.27GDB1200.map --oformat elf32-littlemips&nbsp; reset.o<br>mipsel-linux-uclibc-ld: target elf32-littlemips not found<br>make: *** [reset-02.27GDB1200.elf] Error 1<br><br><br>does yamon have support for producing image in little endian format ?<br><br>can anyone provide
 me any suggestions or solutions for this ?<br><br>thanks in advance,<br><br>saravanan.<br><p>&#32;


      <!--2--><hr size=1></hr> Unlimited freedom, unlimited storage. <a href="http://in.rd.yahoo.com/tagline_mail_2/*http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">Get it now</a>
--0-1935004644-1184223834=:94566--
