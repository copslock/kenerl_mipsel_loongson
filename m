Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QCqm514292
	for linux-mips-outgoing; Tue, 26 Feb 2002 04:52:48 -0800
Received: from scan2.fhg.de (scan2.fhg.de [153.96.1.37])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QCqf914285
	for <linux-mips@oss.sgi.com>; Tue, 26 Feb 2002 04:52:41 -0800
Received: from scan2.fhg.de (localhost [127.0.0.1])
	by scan2.fhg.de (8.11.1/8.11.1) with ESMTP id g1QBqUx06679;
	Tue, 26 Feb 2002 12:52:30 +0100 (MET)
Received: from esk.esk.fhg.de (esk.esk.fhg.de [153.96.161.2])
	by scan2.fhg.de (8.11.1/8.11.1) with ESMTP id g1QBqT606669;
	Tue, 26 Feb 2002 12:52:29 +0100 (MET)
Received: from esk.fhg.de (host4-40 [192.168.4.40])
	by esk.esk.fhg.de (8.9.3/8.9.3) with ESMTP id MAA12889;
	Tue, 26 Feb 2002 12:52:27 +0100 (MET)
Message-ID: <3C7B76C9.48B9D395@esk.fhg.de>
Date: Tue, 26 Feb 2002 12:51:37 +0100
From: Wolfgang Heidrich <wolfgang.heidrich@esk.fhg.de>
Organization: FhG - ESK
X-Mailer: Mozilla 4.7 [de] (WinNT; I)
X-Accept-Language: de
MIME-Version: 1.0
To: Samiran S <samiran13@hotmail.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Help about loading the kernel from host PC to board
References: <F107cS6xopZz8QMeGd100009da8@hotmail.com>
Content-Type: text/plain; charset=iso-8859-1
X-MIME-Autoconverted: from 8bit to quoted-printable by scan2.fhg.de id g1QBqUx06679
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g1QCqg914288
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Samiran,

Samiran S wrote:
> 
> Hi all ,
> 
> I had the whole set up of MIPS Malta board with its linux OS ,
> 
> 1) how can I start Linux on that board ?
> 
> I got that monitor program ( YEMMON)
> 
> I set the IP addrs. and related things. For loading the linux kernel I am
> using
> 
> load tftp://<ipaddrs of host pc>path of vmlinux
> 
> then it is not loading that kernel , it is giving some error it is given
> below
> 
> YAMON> load tftp://175.150.125.170/home/mipsel/vmlinux
> About to load tftp://175.150.125.170/home/mipsel/vmlinux

The slash separates the ip-address and the file. So you chose the file
 home/mipsel/vmlinux, but probably you want /home/mipsel/vmlinux
(because 
home is located in the root-directory).
So you have to type with two slashes:
YAMON> load tftp://175.150.125.170//home/mipsel/vmlinux

Greetings
-- 
Fraunhofer Einrichtung für Systeme der Kommunikationstechnik (ESK)

Wolfgang Heidrich        	  	Hansastraße 32
Dipl.-Ing.                      	80686 München / Germany
                                  	Phone :  +49(0)89-547088-376
E-Mail: wolfgang.heidrich@esk.fhg.de   	Fax   :  +49(0)89-547088-221
