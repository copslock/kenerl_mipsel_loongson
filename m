Received:  by oss.sgi.com id <S553899AbRAYOzP>;
	Thu, 25 Jan 2001 06:55:15 -0800
Received: from [206.207.108.63] ([206.207.108.63]:43094 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S553846AbRAYOzE>; Thu, 25 Jan 2001 06:55:04 -0800
Received: (qmail 30253 invoked from network); 25 Jan 2001 07:54:53 -0700
Received: from stevej-lx.ridgerun.cxm (HELO ridgerun.com) (stevej@192.168.1.4)
  by ridgerun-lx.ridgerun.cxm with SMTP; 25 Jan 2001 07:54:53 -0700
Message-ID: <3A703E3C.360FB4FF@ridgerun.com>
Date:   Thu, 25 Jan 2001 07:54:53 -0700
From:   Steve Johnson <stevej@ridgerun.com>
Organization: Ridgerun, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12-bigphys i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Pete Popov <ppopov@mvista.com>
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: floating point on Nevada cpu
References: <3A6F8F66.6258801@mvista.com> <0101241833281Q.00834@plugh.sibyte.com> <3A6F9814.3E39027@mvista.com> <0101241917341S.00834@plugh.sibyte.com>
Content-Type: multipart/mixed;
 boundary="------------37CC64B0724CA9D478CDE0C9"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------37CC64B0724CA9D478CDE0C9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Pete,

    We had a problem in user-space apps all showing 0 for floating-point
results because we hadn't set the ST0_FR bit to 0, and we had a mis-match
between user libraries (MIPS3k-compatible) and the floating point registers.
We noticed the problem when we couldn't run "ps" or "rm" correctly and tracked
it down from some old postings by Ralf and friends.  Maybe this is your
problem, too?

    I added this to our setup call:

    set_cp0_status(ST0_FR, 0);

    Steve


--------------37CC64B0724CA9D478CDE0C9
Content-Type: text/x-vcard; charset=us-ascii;
 name="stevej.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Steve Johnson
Content-Disposition: attachment;
 filename="stevej.vcf"

begin:vcard 
n:Johnson;Steve
tel;fax:208-331-2227
tel;work:208-331-2226x11
x-mozilla-html:TRUE
url:http://www.ridgerun.com
org:RidgeRun, Inc.
version:2.1
email;internet:stevej@ridgerun.com
title:Senior Kernel Developer
adr;quoted-printable:;;RidgeRun, Inc.=0D=0A200 N 4th St, Suite 101		;Boise;ID;83702;USA
x-mozilla-cpt:;27936
fn:Steve Johnson
end:vcard

--------------37CC64B0724CA9D478CDE0C9--
