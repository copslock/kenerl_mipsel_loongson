Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7L4bC23110
	for linux-mips-outgoing; Fri, 7 Dec 2001 13:04:37 -0800
Received: from gw-nl5.philips.com (gw-nl5.philips.com [212.153.235.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7L4Vo23105
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 13:04:31 -0800
Received: from smtpscan-nl4.philips.com (localhost.philips.com [127.0.0.1])
          by gw-nl5.philips.com with ESMTP id VAA11437;
          Fri, 7 Dec 2001 21:04:27 +0100 (MET)
          (envelope-from balaji.ramalingam@philips.com)
From: balaji.ramalingam@philips.com
Received: from smtpscan-nl4.philips.com(130.139.36.24) by gw-nl5.philips.com via mwrap (4.0a)
	id xma011435; Fri, 7 Dec 01 21:04:27 +0100
Received: from smtprelay-us1.philips.com (localhost [127.0.0.1]) 
	by smtpscan-nl4.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id VAA09892; Fri, 7 Dec 2001 21:04:26 +0100 (MET)
Received: from arj001soh.diamond.philips.com (amsoh01.diamond.philips.com [161.88.79.212]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id OAA11781; Fri, 7 Dec 2001 14:04:24 -0600 (CST)
Subject: Re: not getting the kernel prompt
To: linux-mips@oss.sgi.com
Cc: jsimmons@transvirtual.com, jim@jtan.com
Date: Fri, 7 Dec 2001 12:05:09 -0800
Message-ID: <OF60F1F443.933DC857-ON88256B1B.006D7D46@diamond.philips.com>
X-MIMETrack: Serialize by Router on arj001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 07/12/2001 14:08:22
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hello Folks,

I do have a  /dev/console in the ramdisk.

################################################

[root@svlhp106 dev]# cd /mnt/ramdisk_raj/
[root@svlhp106 ramdisk_raj]# cd dev
[root@svlhp106 dev]# ll console
crw--w--w-    1 root     root       5,   1 Aug  9 15:16 console
[root@svlhp106 dev]# ll ttyS0
crw-rw-rw-    1 root     root       4,  64 Aug  9 15:16 ttyS0
[root@svlhp106 dev]#

####################################################


regards,
Balaji






Jim Paris <jim@jtan.com> on 12/07/2001 11:38:41 AM

Please respond to jim@jtan.com

To:     Balaji Ramalingam/SVL/SC/PHILIPS@AMEC
cc:     linux-mips@oss.sgi.com
Subject:  Re: not getting the kernel prompt
Classification:



> Warning:  unable to open an initial console.

Make sure you have a valid /dev/console (or just use devfs)

-jim
