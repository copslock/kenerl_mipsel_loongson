Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5Q56bnC027715
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 22:06:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5Q56bQi027714
	for linux-mips-outgoing; Tue, 25 Jun 2002 22:06:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dtwse201.detewe.de ([195.50.171.201])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5Q56TnC027710
	for <linux-mips@oss.sgi.com>; Tue, 25 Jun 2002 22:06:30 -0700
Received: from zinse043.detewe.de (unverified) by dtwse201.detewe.de
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T5bb7ac7f14c332abc90df@dtwse201.detewe.de> for <linux-mips@oss.sgi.com>;
 Wed, 26 Jun 2002 07:12:39 +0200
Received: from detewe.de ([172.30.201.153]) by zinse043.detewe.de
          (Netscape Messaging Server 3.6)  with ESMTP id AAA49D4;
          Wed, 26 Jun 2002 07:08:44 +0200
Message-ID: <3D194C8C.D1BB4DD5@detewe.de>
Date: Wed, 26 Jun 2002 07:09:32 +0200
From: Carsten Lange <Carsten.Lange@detewe.de>
X-Mailer: Mozilla 4.5 [en] (X11; I; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Daniel Jacobowitz <dan@debian.org>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: mipsel-linux-gdb(5.2): DW_FORM_strp pointing outside of .debug_str 
 section
References: <3D171ECB.28F566C1@detewe.de> <20020624150001.GA5373@branoic.them.org> <20020624081221.C30482@lucon.org> <3D184EAC.D8C8CBA6@detewe.de> <20020625083926.E18907@lucon.org>
Content-Type: multipart/mixed; boundary="------------CBEBCA7F3584359F85044C4C"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------CBEBCA7F3584359F85044C4C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Where and how do I get gcc3.1 from CVS?
Do you recommend getting glibc and gdb from CVS too? 
If yes what versions and where from?

Many thangs
	carsten

"H. J. Lu" wrote:
> 
> On Tue, Jun 25, 2002 at 01:06:20PM +0200, Carsten Lange wrote:
> > Hi,
> >
> > when I use binutils 2.12.90.0.12 gcc 3.1 will not compile anymore.
> >
> 
> You need gcc 3.1 from CVS. I may be able to provide a gcc 3.1.1 rpm for
> RedHat 7.3/mips with the java support. Is anyone interested?
> 
> H.J.
--------------CBEBCA7F3584359F85044C4C
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

--------------CBEBCA7F3584359F85044C4C--
