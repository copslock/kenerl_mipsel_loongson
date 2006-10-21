Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Oct 2006 20:59:28 +0100 (BST)
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:31124 "EHLO
	ch-smtp01.sth.basefarm.net") by ftp.linux-mips.org with ESMTP
	id S20037562AbWJUT7Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Oct 2006 20:59:25 +0100
Received: from c83-250-8-219.bredband.comhem.se ([83.250.8.219]:57009 helo=mail.ferretporn.se)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <creideiki+linux-mips@ferretporn.se>)
	id 1GbN06-0000hQ-5Y
	for linux-mips@linux-mips.org; Sat, 21 Oct 2006 21:59:23 +0200
Received: from peepoe.ferretporn.se (peepoe.ferretporn.se [192.168.0.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ferretporn.se (Postfix) with ESMTP id B35F82C57;
	Sat, 21 Oct 2006 21:59:08 +0200 (CEST)
From:	Karl-Johan Karlsson <creideiki+linux-mips@ferretporn.se>
To:	linux-mips@linux-mips.org
Subject: Extreme system overhead on large IP27
Date:	Sat, 21 Oct 2006 21:59:02 +0200
User-Agent: KMail/1.9.5
X-Eric-Conspiracy: There is no conspiracy
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610212159.04965.creideiki+linux-mips@ferretporn.se>
X-Scan-Result: No virus found in message 1GbN06-0000hQ-5Y.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1GbN06-0000hQ-5Y 6e2f02daad696d20670442dbb5528898
Return-Path: <creideiki+linux-mips@ferretporn.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: creideiki+linux-mips@ferretporn.se
Precedence: bulk
X-list: linux-mips

I have an Origin 2000 with 16 R12000 and 16 R10000 CPU:s, running a git 
snapshot kernel from 20060618 based on 2.6.17.10 (the latest available in 
Gentoo). Light loads run without problems, but as soon as the load average 
goes above 4-5 system overhead skyrockets and almost no useful work is being 
done (see top output below). OProfile is no help, since the daemon just 
throws away everything the kernel gives it (see output from strace of 
oprofiled below).

Does anyone know where this overhead is coming from, or how to get some data 
from OProfile so I can search for it myself? I'll try booting just the R12000 
part sometime soon to see if that helps with either problem.

----------

top - 14:00:40 up 6 days, 20:25,  3 users,  load average: 11.98, 11.58, 8.03
Tasks: 314 total,  11 running, 302 sleeping,   0 stopped,   1 zombie
Cpu0  :  0.0%us, 35.9%sy,  4.5%ni, 56.0%id,  0.0%wa,  0.0%hi,  3.6%si,  0.0%st
Cpu1  :  4.2%us, 37.4%sy,  3.9%ni, 50.0%id,  0.6%wa,  0.0%hi,  3.9%si,  0.0%st
Cpu2  :  0.0%us,  9.0%sy,  0.9%ni, 83.5%id,  0.0%wa,  0.0%hi,  6.6%si,  0.0%st
Cpu3  :  0.0%us,  3.3%sy,  0.3%ni, 89.7%id,  0.6%wa,  0.0%hi,  6.0%si,  0.0%st
Cpu4  :  0.0%us,  0.0%sy,  0.0%ni, 93.4%id,  0.0%wa,  0.0%hi,  6.6%si,  0.0%st
Cpu5  :  0.0%us,  0.0%sy,  0.0%ni, 93.4%id,  0.0%wa,  0.0%hi,  6.6%si,  0.0%st
Cpu6  :  0.0%us, 34.6%sy,  3.3%ni, 59.3%id,  0.0%wa,  0.0%hi,  2.7%si,  0.0%st
Cpu7  :  0.0%us, 40.5%sy,  3.0%ni, 52.9%id,  0.0%wa,  0.0%hi,  3.6%si,  0.0%st
Cpu8  :  0.0%us, 13.6%sy,  0.9%ni, 77.9%id,  0.0%wa,  0.0%hi,  7.6%si,  0.0%st
Cpu9  :  0.0%us, 18.5%sy,  2.4%ni, 70.8%id,  0.0%wa,  0.0%hi,  8.2%si,  0.0%st
Cpu10 :  0.0%us,  0.0%sy,  0.0%ni, 90.5%id,  0.0%wa,  0.0%hi,  9.5%si,  0.0%st
Cpu11 :  0.0%us, 15.6%sy,  2.1%ni, 73.3%id,  0.0%wa,  0.0%hi,  8.9%si,  0.0%st
Cpu12 :  0.0%us, 22.2%sy,  1.2%ni, 66.5%id,  0.0%wa,  0.0%hi, 10.2%si,  0.0%st
Cpu13 :  0.0%us,  0.0%sy,  0.0%ni, 87.5%id,  0.0%wa,  0.0%hi, 12.5%si,  0.0%st
Cpu14 :  0.0%us, 31.7%sy,  1.3%ni, 59.2%id,  0.0%wa,  0.0%hi,  7.8%si,  0.0%st
Cpu15 :  0.0%us, 53.9%sy,  0.6%ni, 34.7%id,  0.0%wa,  0.0%hi, 10.7%si,  0.0%st
Cpu16 :  0.0%us, 13.1%sy,  0.3%ni, 78.0%id,  0.3%wa,  0.0%hi,  8.3%si,  0.0%st
Cpu17 :  0.0%us, 59.5%sy,  2.4%ni, 31.1%id,  0.0%wa,  0.0%hi,  7.0%si,  0.0%st
Cpu18 :  0.0%us, 17.5%sy,  0.3%ni, 74.2%id,  0.0%wa,  0.0%hi,  8.0%si,  0.0%st
Cpu19 :  0.0%us, 45.8%sy,  0.3%ni, 45.8%id,  0.0%wa,  0.0%hi,  8.0%si,  0.0%st
Cpu20 :  0.0%us,  8.3%sy,  0.0%ni, 81.7%id,  0.0%wa,  0.0%hi,  9.9%si,  0.0%st
Cpu21 :  0.0%us, 78.3%sy,  0.3%ni, 12.8%id,  0.0%wa,  0.0%hi,  8.6%si,  0.0%st
Cpu22 :  0.0%us, 62.6%sy,  0.0%ni, 27.5%id,  0.0%wa,  0.0%hi,  9.9%si,  0.0%st
Cpu23 :  0.0%us, 30.9%sy,  0.0%ni, 59.0%id,  0.0%wa,  0.0%hi, 10.1%si,  0.0%st
Cpu24 :  0.0%us, 31.4%sy,  0.0%ni, 56.5%id,  0.0%wa,  0.0%hi, 12.1%si,  0.0%st
Cpu25 :  0.0%us, 56.6%sy,  0.0%ni, 30.9%id,  0.0%wa,  0.0%hi, 12.5%si,  0.0%st
Cpu26 :  0.0%us, 68.5%sy,  0.0%ni, 22.7%id,  0.0%wa,  0.0%hi,  8.8%si,  0.0%st
Cpu27 :  0.0%us,  8.7%sy,  0.0%ni, 81.9%id,  0.0%wa,  0.0%hi,  9.4%si,  0.0%st
Cpu28 :  0.9%us, 59.3%sy,  0.0%ni, 35.1%id,  0.0%wa,  0.0%hi,  4.7%si,  0.0%st
Cpu29 :  0.0%us, 36.3%sy,  0.0%ni, 59.6%id,  0.0%wa,  0.0%hi,  4.0%si,  0.0%st
Cpu30 :  0.0%us, 20.6%sy,  0.0%ni, 74.3%id,  0.0%wa,  0.0%hi,  5.1%si,  0.0%st
Cpu31 :  0.0%us, 75.3%sy,  0.3%ni, 19.9%id,  0.0%wa,  0.0%hi,  4.4%si,  0.0%st
Mem:  10975264k total,  1860404k used,  9114860k free,   486912k buffers
Swap:  2007992k total,        0k used,  2007992k free,   783448k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
19535 portage   28   3  4232 1076  124 R   97  0.0   0:04.08 sh
19524 portage   28   3  4232 1152  200 R   95  0.0   0:07.35 sh
19541 portage   28   3  2212  392  304 R   94  0.0   0:03.26 sed
19487 root      25   0  2200  424  340 R   91  0.0   0:18.38 find
19533 portage   28   3  4556 1116  148 R   91  0.0   0:04.46 sh
19543 portage   28   3  8900  944  676 R   79  0.0   0:02.62 cc1
19545 portage   28   3  6248  168  128 R   71  0.0   0:02.35 cc1
19491 portage   28   3  4232 1276  324 S   66  0.0   0:15.70 sh
19544 portage   21   3  5472 2676  824 S   41  0.0   0:01.37 as
19530 portage   28   3  2344  604  492 S   24  0.0   0:02.81 mips-unknown-li
19520 portage   28   3  2344  608  496 S   17  0.0   0:05.66 mips-unknown-li
19549 portage   23   3  4232 1264  312 R   11  0.0   0:00.36 sh
19518 creideik  16   0  4028 1400  976 R   10  0.0   0:04.35 top
19550 portage   22   3  4232 1220  268 R    9  0.0   0:00.31 sh
18578 portage   28   3  4556 2108 1140 S    8  0.0   0:44.73 sh
19059 portage   21   3  4232 2068 1116 S    8  0.0   0:15.94 sh
19551 portage   24   3  4232 1084  132 R    4  0.0   0:00.14 sh

----------

FD 3 = /dev/oprofile/buffer

1161459953.480231 lseek(3, 0, SEEK_SET) = 0 <0.001000>
1161459953.485233 
read(3, "\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\v\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\3\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\10\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\25\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\31\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\35\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\34\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\20\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\27\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\32\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\33\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\n\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\16\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\4\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\2\0\0\0\0\0\0\0\22\377\377\377\377\377\377\377\377\0\0\0\0\0\0"..., 
1048576) = 786456 <101.700285>
1161460055.353596 open("/var/lib/oprofile/complete_dump", O_WRONLY|O_CREAT|
O_TRUNC, 0666) = 4 <0.002001>
1161460055.357598 fstat64(4, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0 
<0.001000>
1161460055.361600 old_mmap(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|
MAP_ANONYMOUS, -1, 0) = 0x2aad6000 <0.001000>
1161460055.364601 write(4, "1\n", 2)    = 2 <0.002001>
1161460055.368603 close(4)              = 0 <0.002001>
1161460055.373605 munmap(0x2aad6000, 65536) = 0 <0.002001>
1161460055.379608 lseek(3, 0, SEEK_SET) = 0 <0.001001>
1161460055.383610 read(3,  <unfinished ...>

-- 
Karl-Johan Karlsson
