Received:  by oss.sgi.com id <S553668AbQKGPYa>;
	Tue, 7 Nov 2000 07:24:30 -0800
Received: from boco.fee.vutbr.cz ([147.229.9.11]:64273 "EHLO boco.fee.vutbr.cz") convert rfc822-to-8bit
	by oss.sgi.com with ESMTP id <S553664AbQKGPYR>;
	Tue, 7 Nov 2000 07:24:17 -0800
Received: from fest.stud.fee.vutbr.cz (fest.stud.fee.vutbr.cz [147.229.9.16])
	by boco.fee.vutbr.cz (8.11.1/8.11.1) with ESMTP id eA7FO8f02044
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified OK);
	Tue, 7 Nov 2000 16:24:09 +0100 (CET)
Received: (from xmichl03@localhost)
	by fest.stud.fee.vutbr.cz (8.11.0/8.11.0) id eA7FO8a74658;
	Tue, 7 Nov 2000 16:24:08 +0100 (CET)
From:   Michl Ladislav <xmichl03@stud.fee.vutbr.cz>
Date:   Tue, 7 Nov 2000 16:24:08 +0100 (CET)
X-processed: pine.send
To:     Ian Chilton <ian@ichilton.co.uk>
cc:     linux-mips@oss.sgi.com
Subject: Re: mips dist?
In-Reply-To: <20001107150110.A8414@woody.ichilton.co.uk>
Message-ID: <Pine.BSF.4.05.10011071603260.72988-100000@fest.stud.fee.vutbr.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 7 Nov 2000, Ian Chilton wrote:

> uhmm...AFAIK, there are some Debian glibc 2.2 packages being uploaded
> now, but there is no full distro with installer for MIPS....
> 
> Correct me if i'm wrong though..

Imagine this situation: sgi Indy with clean HDD, no floppy, no CD-ROM. Can
you imagine any user friendly way to install linux? However, it's possible
to make package which sets up neccesary things on remote machine and then
simply boot mips :-)

You are right, Debian is not "full distro". BTW, what do you mean by this
term? 

You could do following: download kernel and base-files from
ftp://ftp.rfc822.org/pub/local/debian-mips/. install bootp, tftp and nfs
server on another machine (howto can be found in archives) and boot linux
from this remote computer. after that you can partition your harddisk,
create filesystems and copy kernel and base-files. instruction how to boot
linux directly from harddisk (for indy) can be found at:
http://honk.physik.uni-konstanz.de/linux-mips/indy-boot/indy-hd-boot-micro-howto.html
now, you have fully functional Debian/GNU Linux, just wait for new
packages :-)

if you are interested by this way of instalation, let me know i'll send
you neccessary configuration files.

Regards
Laïa.

ps. i'm sorry if i don't exactly understand what you want to do and sorry
for my weak english.
