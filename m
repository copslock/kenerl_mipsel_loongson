Received:  by oss.sgi.com id <S553736AbRAEItj>;
	Fri, 5 Jan 2001 00:49:39 -0800
Received: from router.isratech.ro ([193.226.114.69]:20238 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553712AbRAEIt0>;
	Fri, 5 Jan 2001 00:49:26 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id f058mNp28516;
	Fri, 5 Jan 2001 10:48:23 +0200
Message-ID: <3A55F882.4B693DE3@isratech.ro>
Date:   Fri, 05 Jan 2001 11:38:27 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Christoph Martin <martin@uni-mainz.de>
CC:     ralf@oss.sgi.com, Christoph.Martin@uni-mainz.de,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        debian-mips@lists.debian.org, Andreas Jaeger <aj@suse.de>
Subject: Re: glibc 2.2 on MIPS
References: <14932.57412.617757.439688@arthur.zdv.Uni-Mainz.DE>
Content-Type: multipart/mixed;
 boundary="------------9A6E0E45F076F1CC308E1BCA"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------9A6E0E45F076F1CC308E1BCA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello all,

My question is somehow related on the problems showed in this email. Sorry if this
will bother you.
I am trying to setup a cross toolchain for mips and  I have to use binutils 2.10
and gcc 2.95.2 and glibc2.1.3. Currently I am trying to setup binutils 2.10 with
egcs1.0.3a and with glibc.2.0.6 . Do you have any patches for binutils 2.10 or for
gcc2.95.2 for mips ? If you have and if you have some ideeas please tell me ..

Thank You
Nicu

Christoph Martin wrote:

> Hi Ralf,
>
> On Thu, 12 Oct 2000 04:04:44 +0200, Ralf Baechle wrote:
>
> > On Thu, Oct 12, 2000 at 12:24:21AM +0200, Florian Lohoff wrote:
>
> > > We are trying :) I am currently basing all my Debian-mips(el) things
> > > on glibc 2.0.6. It is the only stable solution right now. I am experimenting
> > > with the glibc 2.1.94-3 debian source package which i managed to get
> > > compiled with unmodified cvs binutils and gcc + the gcse patch.
> > >
> > > Ralf reported bugs in the ld where he send me a patch. With that patch
> > > i get a "Bus Error" from the ld.so within the glibc build.
>
> > There patch is ok; you get those bus errors because there are bugs in
> > both ld and binutils that in most cases compensate each other.  If you
> > fix only one of them you get all sorts of funnies ...
>
> I just tried to build glibc-2.2 (CVS-2000-12-28) for debian-mips and
> it still has the "Bus Error" problem. We are currently using binutils
> 2.10.1.0.2 and gcc 2.95.2 + CVS from 2.95 branch.
>
> Can you please post both patches, so that we can verify which one is
> missing in our build.
>
> > Even with the fixes ld is not yet perfect - for example emacs and X still
> > fail.
>
> The gcc/binutils combination seams to work correctly as far as I can
> see. I managed to compile xfree 4.0.2 linked agains 2.1.95-1.1. What
> problems did you have with X?
>
> Christoph

--------------9A6E0E45F076F1CC308E1BCA
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:POPOVICI;Nicolae Octavian 
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;Software
adr:;;;;;;
version:2.1
email;internet:octavp@isratech.ro
title:Software engineer
x-mozilla-cpt:;0
fn:Nicolae Octavian POPOVICI
end:vcard

--------------9A6E0E45F076F1CC308E1BCA--
