Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5ODQunC028394
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 06:26:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5ODQub3028393
	for linux-mips-outgoing; Mon, 24 Jun 2002 06:26:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dtwse201.detewe.de ([195.50.171.201])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5ODQlnC028384
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 06:26:48 -0700
Received: from zinse043.detewe.de (unverified) by dtwse201.detewe.de
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T5baf29d4cdc332abc90df@dtwse201.detewe.de> for <linux-mips@oss.sgi.com>;
 Mon, 24 Jun 2002 15:32:58 +0200
Received: from detewe.de ([172.30.201.153]) by zinse043.detewe.de
          (Netscape Messaging Server 3.6)  with ESMTP id AAA5A27;
          Mon, 24 Jun 2002 15:29:00 +0200
Message-ID: <3D171ECB.28F566C1@detewe.de>
Date: Mon, 24 Jun 2002 15:29:47 +0200
From: Carsten Lange <Carsten.Lange@detewe.de>
X-Mailer: Mozilla 4.5 [en] (X11; I; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: mipsel-linux-gdb(5.2): DW_FORM_strp pointing outside of .debug_str 
 section
Content-Type: multipart/mixed; boundary="------------5CF768D46FA92DC52A37C165"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------5CF768D46FA92DC52A37C165
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I get the above error from gdb 5.2 when using the <file> command.
...
(gdb) file iprbs
file iprbs
Reading symbols from iprbs...DW_FORM_strp pointing outside of .debug_str section
(gdb)                                                       
...

My mipsel-linux- toolchain consist of the following packages:
	binutils-2.12.1
	gcc-3.1
	glibc-2.2.5
	gdb-5.2

I have no idea what the problem might be.

Any hints (solutions/workaround) are welcome.

Best regards,
	Carsten
--------------5CF768D46FA92DC52A37C165
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

--------------5CF768D46FA92DC52A37C165--
