Received:  by oss.sgi.com id <S554020AbRAZNBo>;
	Fri, 26 Jan 2001 05:01:44 -0800
Received: from [206.207.108.63] ([206.207.108.63]:313 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S554011AbRAZNB3>; Fri, 26 Jan 2001 05:01:29 -0800
Received: (qmail 9671 invoked from network); 26 Jan 2001 06:01:13 -0700
Received: from stevej-lx.ridgerun.cxm (HELO ridgerun.com) (stevej@192.168.1.4)
  by ridgerun-lx.ridgerun.cxm with SMTP; 26 Jan 2001 06:01:13 -0700
Message-ID: <3A717518.B1CAFEDC@ridgerun.com>
Date:   Fri, 26 Jan 2001 06:01:12 -0700
From:   Steve Johnson <stevej@ridgerun.com>
Organization: Ridgerun, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12-bigphys i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     Pete Popov <ppopov@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: floating point on Nevada cpu
References: <3A6F8F66.6258801@mvista.com> <0101241833281Q.00834@plugh.sibyte.com> <3A6F9814.3E39027@mvista.com> <0101241917341S.00834@plugh.sibyte.com> <3A703E3C.360FB4FF@ridgerun.com> <3A706A22.6B760617@mvista.com> <010601c08780$d0b8a7a0$0deca8c0@Ulysses>
Content-Type: multipart/mixed;
 boundary="------------CEBE8AED354B347F4A816CD7"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------CEBE8AED354B347F4A816CD7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Kevin D. Kissell" wrote:

> I had essentially the same problem at MIPS a year or two ago,
> and I could have *sworn* that my fix, which ORed ST0_FR into
> the initial Status register value set in the startup assembly code,
> had made it into the standard distributions.  It's at about line 530
> of head.S, where a term is added to make the instruction
>
> li t1,~(ST0_CU1|ST0_CU2|ST0_CU3|ST0_KX|ST0_SX|ST0_FR)
>
> I spent days thinking it was a mipsel library problem,
> because it only turned up when I tried exercising a
> little-endian version of the same kernel that worked
> sell big-endian on the Indy.  But of course it was all
> due to the mipsel system having a boot-prom that
> cleverly enabled all the FP registers for me...
>
>             Kevin K.

Kevin,

    Your/Flo's/Ralf's thread in the MIPS Linux archives from last January was
what clued me into the ST0_FR setting in the first place.  Ralf gave arguments
why he wouldn't take your change at that time, which is why that line isn't in
the 2.4.x kernel.

    Steve


--------------CEBE8AED354B347F4A816CD7
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

--------------CEBE8AED354B347F4A816CD7--
