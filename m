Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g25F0x727447
	for linux-mips-outgoing; Tue, 5 Mar 2002 07:00:59 -0800
Received: from arianna.cineca.it (dns.cineca.it [130.186.1.53])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g25F0r927437
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 07:00:54 -0800
Received: from tin.it (andrea@nb-venturi.cineca.it [193.204.122.87])
	by arianna.cineca.it (8.12.1/8.12.1/CINECA 5.0-MILTER) with ESMTP id g25E0dtv011112;
	Tue, 5 Mar 2002 15:00:39 +0100 (MET)
Message-ID: <3C84CF8D.2050303@tin.it>
Date: Tue, 05 Mar 2002 15:00:45 +0100
From: "Andrea Venturi (personale)" <andrea.venturi@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: nsauzede@yahoo.com
CC: linux-mips@oss.sgi.com
Subject: Re: device support on indy WS !?
References: <3C84B611.5050103@cineca.it> <3C84D1FC.2273.520DA2@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Soeren Laursen wrote:
> http://www.linux-debian.de/howto/debian-mips-woody-install.html
> 
> 

two things, i believe should be useful to add to this woody-install:

1- i had some problem with the tftp "port over 32768" issue to make 
tftpboot.img downloadable to my indy, so had to type this on my linux 
tftp server:

  echo "2048 32767" > /proc/sys/net/ipv4/ip_local_port_range

2- fdisking my new 2GB scsi disk (the indy came with an unuseful 600MB 
disk, good only for irix..), i scratch my head against the "SGI 
disklabel" thing[*].. so remember to use the e(x)pert option in fdisk to 
find how to create a SGI-compatable partition scheme..



i just put up some notes about my beginnings on the indy here:

   http://marge.cineca.it/aventuri/public/indy.html

bye

[*] coming from just ia32-linux eXPerience, i was used to a PeCee 
mentality..
