Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Oct 2003 17:22:41 +0100 (BST)
Received: from savages.net ([IPv6:::ffff:12.154.202.18]:48024 "EHLO
	savages.net") by linux-mips.org with ESMTP id <S8225462AbTJRQWi>;
	Sat, 18 Oct 2003 17:22:38 +0100
Received: from redcellx.com (kerberos [::ffff:192.168.4.27])
  (TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by server with esmtp; Sat, 18 Oct 2003 02:16:14 -0700
Message-ID: <3F9168C4.7080807@redcellx.com>
Date: Sat, 18 Oct 2003 09:22:28 -0700
From: Shaun <shaun@redcellx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Troy Melquist <Troy@redcellx.com>,
	'Jerry Wheeler' <jerry@redcellx.com>,
	'Mary Burke' <mburke@redcellx.com>
Subject: HOWTO Cross devel system 
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shaun@redcellx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shaun@redcellx.com
Precedence: bulk
X-list: linux-mips


Hi All

I now can create a cross devel environment for the mipsel-linux 
platform.  This means that every one could have one with not many 
surprises :)
from 
ftp://ftp.mips.com/pub/tools/software/sde-for-linux/sdelinux-5.02.02-1.i386.rpm
or for a newer version
ftp://ftp.ds2.pg.gda.pl/pub/macro/RPMS/i386/ (binutils and gcc)

with that, you need a glibc
from
ftp://ftp.ds2.pg.gda.pl/pub/macro/RPMS/mipsel
get glibc, glibc-libs, glibc-devel and any other packages you want
This packages are mipsel native code
to extract the files you need to convert them to cpio then use cpio
 > rpm2cpio  file >outfile
 > cpio -i --make-directories <outfile

install the files in the directory /usr/local/mipsel-linux/ ( bin, lib, 
include)
edit $()/mipsel-linux/lib/libc.so   yes a text file
add the prefix /usr/local/mipsel-linux to the paths, you will see what I 
mean when you see the file

test compile hello world

I still need to test the execution on the "eb"

This will now allow us to document the tool chain. to create consistent 
development program.


To get NFS working, "portmap" and "mount" need to support nfs. I am 
checking busybox-1.0rc3 to see how to configure it to support nfs.


-- 
Shaun Savage
Linux Engineer,
RedCellX
333 SW 5th Ave
Portland, OR 97204
503-295-9680


  ****CONFIDENTIALITY NOTICE**** This e-mail message is confidential and 
may be privileged.  THIS EMAIL MAY NOT BE SHARED WITH ANY OTHER PERSON 
BUT THE RECEIVER.  If you believe that this e-mail has been sent to you 
in error please:  (1) notify the sender; and (2) delete this e-mail. 
Thank you.  Disclaimer of Electronic Transaction:  This communication 
does not reflect an intention by the sender or the sender's client to 
conduct a transaction or make any agreement by electronic means. 
Nothing contained herein shall constitute an electronic signature or a 
contract under any law, rule or regulation applicable to electronic 
transactions.
