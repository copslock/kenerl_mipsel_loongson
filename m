Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9VJLqu10703
	for linux-mips-outgoing; Wed, 31 Oct 2001 11:21:52 -0800
Received: from emma.patton.com (emma.patton.com [209.49.110.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9VJLe010699
	for <linux-mips@oss.sgi.com>; Wed, 31 Oct 2001 11:21:41 -0800
Received: from patton.com (decpc.patton.com [209.49.110.83])
	by emma.patton.com (8.9.0/8.9.0) with ESMTP id OAA01440;
	Wed, 31 Oct 2001 14:21:50 -0500 (EST)
Message-ID: <3BE04EF6.2B3766E4@patton.com>
Date: Wed, 31 Oct 2001 14:20:22 -0500
From: Paul Kasper <paul@patton.com>
Reply-To: paul@patton.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: RedHat 7.1/mips update
References: <20011024121646.A6520@lucon.org>
Content-Type: multipart/mixed;
 boundary="------------D34713B4C6E5904AC80D9E42"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------D34713B4C6E5904AC80D9E42
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"H . J . Lu" wrote:
> 
> I updated my RedHat 7.1/mips port. There are quite a few changes. Check it
> out.
> 
> H.J.
> -----
> My mini-port of RedHat 7.1 is at
> 
> ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/
> 
.....
>
> 
> H.J.

I am trying to install from a SuSE 7.2 workstation. In an effort to get
findrpm to work, I updated my RPMs with 2 of yours and 2 from RedHat:
------------------------------
scooby:/opt/rh71_oss/install # rpm -Uhv  
../RPMS/i386/rpm-python-4.0.2-8.6.i386.rpm
../RPMS/i386/rpm-4.0.2-8.6.i386.rpm
/opt/download/RPMS/db1-1.85-7.i386.rpm
/opt/download/RPMS/patch-2.5.4-9.i386.rpm 
Preparing...                ###########################################
[100%]
package rpm-python-4.0.2-8.6 is already installed
package rpm-4.0.2-8.6 is already installed
package db1-1.85-7 is already installed
package patch-2.5.4-9 is already installed
scooby:/opt/rh71_oss/install # rpm -qa |grep python
python-imaging-1.1-68
python-tk-2.0-90
python-2.0-90
python-doc-2.0-90
python-devel-2.0-90
python-nothreads-2.0-90
python-demo-2.0-90
rpm-python-4.0.2-8.6
scooby:/opt/rh71_oss/install # rpm -qa |grep rpm   
rpm2html-1.5-16
rpmfind-1.6-62
autorpm-1.9.9-14
xrpm-2.2-333
rpm-4.0.2-8.6
rpm-python-4.0.2-8.6
scooby:/opt/rh71_oss/install # ./findrpm gcc
Traceback (most recent call last):
  File "./findrpm", line 5, in ?
    import rpm
ImportError: No module named rpm        <----- ??? -----
scooby:/opt/rh71_oss/install # 

------------------------------

Not being much of a python person, does anybody have any suggestions? 
Should I upgrade more of the python packages even though there are no
complaints regarding depenencies?

Any suggestions welcomed.

--
Paul Kasper
-- 
 /"\ . . . . . . . . . . . . . . . /"\
 \ /   ASCII Ribbon Campaign       \ /     Paul R. Kasper
  X    - NO HTML/RTF in e-mail      X      Patton Electronics Co.
 / \   - NO MSWord docs in e-mail  / \     301-975-1000 x173
--------------D34713B4C6E5904AC80D9E42
Content-Type: text/x-vcard; charset=us-ascii;
 name="paul.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Paul Kasper
Content-Disposition: attachment;
 filename="paul.vcf"

begin:vcard 
n:Kasper;Paul
tel;fax:301-869-9293
tel;work:301-975-1000 x173
x-mozilla-html:FALSE
url:www.patton.com
org:Patton Electronics Co.;Central Office Products
adr:;;7622 Rickenbacker Drive;Gaithersburg;MD;20879;USA
version:2.1
email;internet:paul@patton.com
x-mozilla-cpt:;10912
fn:Paul Kasper
end:vcard

--------------D34713B4C6E5904AC80D9E42--
