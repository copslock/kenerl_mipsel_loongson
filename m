Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g28GG5600861
	for linux-mips-outgoing; Fri, 8 Mar 2002 08:16:05 -0800
Received: from dtwse201.detewe.de ([195.50.171.201])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g28GFw900858
	for <linux-mips@oss.sgi.com>; Fri, 8 Mar 2002 08:15:59 -0800
Received: from zinse043.detewe.de (unverified) by dtwse201.detewe.de
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T59832033c5c332abc9099@dtwse201.detewe.de> for <linux-mips@oss.sgi.com>;
 Fri, 8 Mar 2002 16:13:35 +0100
Received: from detewe.de ([172.30.204.40]) by zinse043.detewe.de
          (Netscape Messaging Server 3.6)  with ESMTP id AAA1443;
          Fri, 8 Mar 2002 16:12:48 +0100
Message-ID: <3C88D523.5BFE88AC@detewe.de>
Date: Fri, 08 Mar 2002 16:13:39 +0100
From: Carsten Lange <Carsten.Lange@detewe.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.0-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS <linux-mips@oss.sgi.com>
CC: Robert =?iso-8859-1?Q?Fr=E4nkel?= <robert.fraenkel@detewe.de>,
   Carsten  Lange <carsten.lange@detewe.de>
Subject: Linux for TI-Chip
Content-Type: multipart/mixed; boundary="------------3D671E59AD65DFD91A0D031F"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------3D671E59AD65DFD91A0D031F
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

I have a problem running linux on a TI-chip. The board and the linux is quite similar to the
MIPS-Malta-Board / Malta Linux port.
The chip sees physical RAM of 16 MB at 0x14000000. The kernel is loaded at address 0x14020000.
The pagetable created is incredably large (about 7MB).

In free_area_init_core() totalpages and realtotalpages are calculated. In our case totalpages is
approx. 86000 and realtotalpages is 1400. But allocation for the table is done with totalpages, not
with realtotalpages.

How do I reduce the pagetable to its really needed size?


Any hints, ideas or solutions ;-) are welcome
	Carsten
--------------3D671E59AD65DFD91A0D031F
Content-Type: text/x-vcard; charset=us-ascii;
 name="Carsten.Lange.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Carsten Lange
Content-Disposition: attachment;
 filename="Carsten.Lange.vcf"

begin:vcard 
n:Lange;Carsten
tel;fax:+49 6104 4234
tel;work:+49 30 6104 4228
x-mozilla-html:FALSE
url:http://www.detewe.de
org:Cordless Technology A/S Berlin
adr:;;Koepenicker Str. 180;10997 Berlin;;;
version:2.1
email;internet:Carsten.Lange@detewe.de
x-mozilla-cpt:;0
fn:Carsten Lange
end:vcard

--------------3D671E59AD65DFD91A0D031F--
